Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49055CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCCB20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572887272;
	bh=Fgriju3JgvjjAT2rtP3Dx+qGRMZaCtKOPLxgWUqBGtk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fTdVwBtxOGnFq1BRiQ8lSCABphfjDaQDVbi8ABvn858hFslo/kVjSdSV8kMAL6j5N
	 arh2QbaRVxHuhj7XoujG8SgPGWwHnhmu0axUzJmHXjlm/W77mt3GXGWIHQX8+hc+Ip
	 bZLYMKycQOE/MAh+rHkSiZTyTE0wTv2sUNSyTx+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfKDRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfKDRHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:07:50 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E5FA2080F;
        Mon,  4 Nov 2019 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572887269;
        bh=Fgriju3JgvjjAT2rtP3Dx+qGRMZaCtKOPLxgWUqBGtk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Azf6yqEdQRwQzpxYWQWGCy2JKWzDrFqCBd7mYKo0ND65qaS+hFYvMC3HRgvBjD9hP
         FiaV789GVnMQ1f+N71DvTe96533kIoOBnScyps0ntfVIcxiLrTFa9itWgD3jeeXLYt
         tgx4qmj/4MLn4W8gLj/wfUO5smXGIOl6v0NX5p/I=
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191022092839.GD10833@kadam>
 <20191023071120.GA3061@localhost.localdomain> <20191024194500.GD23523@kadam>
 <ce76c90b-3431-9342-8b75-882d582c6366@kernel.org>
 <20191026034010.GA6411@localhost.localdomain>
 <fb62566f-632c-d0cd-e06c-5162c753a03f@kernel.org>
 <20191101143439.GA18757@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <82478914-2bed-d8d8-0ee2-0460081434db@kernel.org>
Date:   Mon, 4 Nov 2019 10:07:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101143439.GA18757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/19 8:34 AM, Suwan Kim wrote:
> On Tue, Oct 29, 2019 at 05:07:58AM -0600, shuah wrote:
>> On 10/25/19 9:40 PM, Suwan Kim wrote:

>> under this  check?
> 
> I understood. Moving this check after sgl_alloc() does not seem to
> require any additional checks on nents.
> 
> But I think we need to check for the case that Smatch reported that
> use_sg is true and buf_len is zero.
> 
> If there is no error check and an error condition occurs, the URB
> will be passed to the next step without a buffer.

Yes buf_len needs checking.

> 
> I attached the code. If you are okay, I will send a patch.
> 

This code looks good. Couple of comments.

> ---
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index 66edfeea68fe..0b6c4736ffd6 100644
> --- a/drivers/usb/usbip/stub_rx.c
> +++ b/drivers/usb/usbip/stub_rx.c
> @@ -476,12 +476,39 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> 
>          buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> 
> +       if (use_sg && !buf_len) {
> +               dev_err(&udev->dev, "sg buffer with zero length\n");
> +               goto err_malloc;

This is fine, what happens to the  priv allocated by stub_priv_alloc()?
Shouldn't that be released?

Can you add a comment above stub_priv_alloc() indicating that it adds
SDEV_EVENT_ERROR_MALLOC?

> +       }
> +
>          /* allocate urb transfer buffer, if needed */
>          if (buf_len) {
>                  if (use_sg) {
>                          sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
>                          if (!sgl)
>                                  goto err_malloc;
> +
> +                       /* Check if the server's HCD supports SG */
> +                       if (!udev->bus->sg_tablesize) {
> +                               /*
> +                                * If the server's HCD doesn't support SG, break
> +                                * a single SG request into several URBs and map
> +                                * each SG list entry to corresponding URB
> +                                * buffer. The previously allocated SG list is
> +                                * stored in priv->sgl (If the server's HCD
> +                                * support SG, SG list is stored only in
> +                                * urb->sg) and it is used as an indicator that
> +                                * the server split single SG request into
> +                                * several URBs. Later, priv->sgl is used by
> +                                * stub_complete() and stub_send_ret_submit() to
> +                                * reassemble the divied URBs.
> +                                */
> +                               support_sg = 0;
> +                               num_urbs = nents;
> +                               priv->completed_urbs = 0;
> +                               pdu->u.cmd_submit.transfer_flags &=
> +                                                               ~URB_DMA_MAP_SG;
> +                       }
>                  } else {
>                          buffer = kzalloc(buf_len, GFP_KERNEL);
>                          if (!buffer)
> @@ -489,24 +516,6 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>                  }
>          }
> 
> -       /* Check if the server's HCD supports SG */
> -       if (use_sg && !udev->bus->sg_tablesize) {
> -               /*
> -                * If the server's HCD doesn't support SG, break a single SG
> -                * request into several URBs and map each SG list entry to
> -                * corresponding URB buffer. The previously allocated SG
> -                * list is stored in priv->sgl (If the server's HCD support SG,
> -                * SG list is stored only in urb->sg) and it is used as an
> -                * indicator that the server split single SG request into
> -                * several URBs. Later, priv->sgl is used by stub_complete() and
> -                * stub_send_ret_submit() to reassemble the divied URBs.
> -                */
> -               support_sg = 0;
> -               num_urbs = nents;
> -               priv->completed_urbs = 0;
> -               pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
> -       }
> -
>          /* allocate urb array */
>          priv->num_urbs = num_urbs;
>          priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
> 

thanks,
-- Shuah
