Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038B2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKKXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:17:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47234 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:17:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUIvb-0006lL-JH; Mon, 11 Nov 2019 23:16:59 +0000
Date:   Mon, 11 Nov 2019 23:16:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Boqun.Feng@microsoft.com
Subject: Re: [PATCH] staging: wfx: add gcc extension __force cast
Message-ID: <20191111231659.GA22837@ZenIV.linux.org.uk>
References: <20191108233837.33378-1-jbi.octave@gmail.com>
 <20191109091913.GV26530@ZenIV.linux.org.uk>
 <alpine.LFD.2.21.1911111347380.226731@ninjahub.org>
 <20191111202852.GX26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111202852.GX26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 08:28:52PM +0000, Al Viro wrote:

> So it smells like a remote buffer overrun, little-endian or not.
> And at that point I would start looking for driver original authors with
> some rather pointed questions about the validation of data and lack
> thereof.
> 
> BTW, if incoming packets are fixed-endian, I would expect more bugs on
> big-endian hosts - wfx_tx_confirm_cb() does things like
>                 tx_info->status.tx_time =
>                 arg->media_delay - arg->tx_queue_delay;
> with media_delay and tx_queue_delay both being 32bit fields in the
> incoming packet.  So another question to the authors (or documentation,
> or direct experiments) is what endianness do various fields in the incoming
> data have.  We can try and guess, but...

More fun:
int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val, size_t val_len)
{
        int ret;
        struct hif_msg *hif;
        int buf_len = sizeof(struct hif_cnf_read_mib) + val_len;
        struct hif_req_read_mib *body = wfx_alloc_hif(sizeof(*body), &hif);
        struct hif_cnf_read_mib *reply = kmalloc(buf_len, GFP_KERNEL);

OK, allocated request and reply buffers, by the look of it; request one
being struct hif_msg with struct hif_req_read_mib for payload
and reply - struct hif_cnf_read_mib {
        uint32_t   status;
        uint16_t   mib_id;
        uint16_t   length;
        uint8_t    mib_data[];
} with val_len bytes in mib_data.

        body->mib_id = cpu_to_le16(mib_id);
        wfx_fill_header(hif, vif_id, HIF_REQ_ID_READ_MIB, sizeof(*body));

Filled request, {.len = cpu_to_le16(4 + 4),
		 .id = HIF_REQ_ID_READ_MIB,
		 .interface = vif_id,
		 .body = {
			.mib_id = cpu_to_le16(mib_id)
		}
	}
Note that mib_id is host-endian here; what we send is little-endian.

        ret = wfx_cmd_send(wdev, hif, reply, buf_len, false);
send it, get reply

        if (!ret && mib_id != reply->mib_id) {
Wha...?  Now we are comparing two bytes at offset 4 into reply with a host-endian
value?  Oh, well...

                dev_warn(wdev->dev, "%s: confirmation mismatch request\n", __func__);
                ret = -EIO;
        }
        if (ret == -ENOMEM)
                dev_err(wdev->dev, "buffer is too small to receive %s (%zu < %d)\n",
                        get_mib_name(mib_id), val_len, reply->length);
        if (!ret)
                memcpy(val, &reply->mib_data, reply->length);
What.  The.  Hell?

We are copying data from the reply.  Into caller-supplied object.
With length taken from the same reply and no validation even
attempted?  Not even "um, maybe we shouldn't copy more than the caller
told us to copy, especially since that's as much as there is in the
source of that memcpy"?

And that's besides the endianness questions.  Note that getting the
endianness wrong here is just about certain to blow up - small value
will be misinterpreted by factor of 256.

In any case, even if this is talking to firmware on a card, that's
an unhealthy degree of trust, especially since the same function
does consider the possibility of bogus replies.
