Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVAiIkmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKKCpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:45:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35041 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKCpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:45:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13so9664504pfq.2;
        Sun, 10 Nov 2019 18:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9yPK2EU4Y6olUQqyKYIXFSS0g7og8dn+NrGRRQnxjSM=;
        b=HVAiIkmM32cspgfFVwlouAsnUs1z+cUvA1cx681ljGb5uZsIt5CIgIR3CtKIcIC8ZR
         ZUpxVF3X/isKMBf9ejQHs7Om3DxjwIZKiy1BW8GAcMymOnv9Iz5Jeo6WbHuwpHelOn3s
         bhtRmGxfcASCtFYUDmLaWPQD1h6MqbPIO0HOQ+On7orBT1VAAew3h2DErKiw2AGu+0jr
         gt1rdw1yGACyujSAxtp35ysUVCc1xTom/WEJDzeNjilV5NZpQl7Nec5Dt+6+ba4eUqmT
         sMrRFpRZ9RdXzyuKUaT7jTYRkW+O3AkLFcmfl53hljq0GvrwebqIkyYAjHUJ8PwG+TEO
         b6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9yPK2EU4Y6olUQqyKYIXFSS0g7og8dn+NrGRRQnxjSM=;
        b=JcZgcmI2S0jDV+GTCzfy8HnNBCkkONtpN44E5QoLb44ZdL+Sal1jzgwA30ToaDV9Gr
         kVOjrCKhxe2i25VtMIaw/f/xDOoMkUNg7qGknCVVEl9aC4aRigLHV4IwQLoIKXogfkh9
         FWVk+FscMARuGlbLWAzRQLP+CBSbScCpEmEOjGcOf6OdXBMhbp1pXME5ZB62LAvA5GKS
         QI/yOHvlFixqPraaEQvxp2n5n2Jurm+rEpgEsSTJp/y8j3Cl6YaM60Mq7rbe3A/yMxAk
         XRSWpJDBPSdZB74LyxOReK8l8xVwYOCbMnujd1uKcZ3TqgVQ1CQWimVY2OZy5WTQA+pv
         o3fA==
X-Gm-Message-State: APjAAAU5n/OHH7x48ydJf236RPOZOR+v8kQf/uQFozxDjSoyMHPmVs+h
        wYqqkte1ZGoACsosarRcAGEuC+Hi
X-Google-Smtp-Source: APXvYqwt3YyvbxFc4wXXkbZsYQKFP3vvSSKelaTJm63wYpeNFnEthyoi/Z9hxM96+RetlcG811whDw==
X-Received: by 2002:a62:7847:: with SMTP id t68mr17720505pfc.140.1573440339337;
        Sun, 10 Nov 2019 18:45:39 -0800 (PST)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id f8sm13646492pgd.64.2019.11.10.18.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 18:45:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:45:32 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
Message-ID: <20191111024532.GA3424@localhost.localdomain>
References: <20191022092839.GD10833@kadam>
 <20191023071120.GA3061@localhost.localdomain>
 <20191024194500.GD23523@kadam>
 <ce76c90b-3431-9342-8b75-882d582c6366@kernel.org>
 <20191026034010.GA6411@localhost.localdomain>
 <fb62566f-632c-d0cd-e06c-5162c753a03f@kernel.org>
 <20191101143439.GA18757@localhost.localdomain>
 <82478914-2bed-d8d8-0ee2-0460081434db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82478914-2bed-d8d8-0ee2-0460081434db@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:07:28AM -0700, shuah wrote:
> On 11/1/19 8:34 AM, Suwan Kim wrote:
> > On Tue, Oct 29, 2019 at 05:07:58AM -0600, shuah wrote:
> > > On 10/25/19 9:40 PM, Suwan Kim wrote:
> 
> > > under this  check?
> > 
> > I understood. Moving this check after sgl_alloc() does not seem to
> > require any additional checks on nents.
> > 
> > But I think we need to check for the case that Smatch reported that
> > use_sg is true and buf_len is zero.
> > 
> > If there is no error check and an error condition occurs, the URB
> > will be passed to the next step without a buffer.
> 
> Yes buf_len needs checking.
> 
> > 
> > I attached the code. If you are okay, I will send a patch.
> > 
> 
> This code looks good. Couple of comments.
> 
> > ---
> > diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> > index 66edfeea68fe..0b6c4736ffd6 100644
> > --- a/drivers/usb/usbip/stub_rx.c
> > +++ b/drivers/usb/usbip/stub_rx.c
> > @@ -476,12 +476,39 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> > 
> >          buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> > 
> > +       if (use_sg && !buf_len) {
> > +               dev_err(&udev->dev, "sg buffer with zero length\n");
> > +               goto err_malloc;
> 
> This is fine, what happens to the  priv allocated by stub_priv_alloc()?
> Shouldn't that be released?

Hi, Shuah, sorry about the late reply.

We don't need to release stub_priv in this error path.
If the malloc error occurs and SDEV_EVENT_ERROR_MALLOC is inserted,
event handler is called and releases the priv list of stub_device.
And then, event handler shutdown the connection.
(stub_shutdown_connection)

> Can you add a comment above stub_priv_alloc() indicating that it adds
> SDEV_EVENT_ERROR_MALLOC?

Yes, I will.

Regards,
Suwan Kim

> > +       }
> > +
> >          /* allocate urb transfer buffer, if needed */
> >          if (buf_len) {
> >                  if (use_sg) {
> >                          sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> >                          if (!sgl)
> >                                  goto err_malloc;
> > +
> > +                       /* Check if the server's HCD supports SG */
> > +                       if (!udev->bus->sg_tablesize) {
> > +                               /*
> > +                                * If the server's HCD doesn't support SG, break
> > +                                * a single SG request into several URBs and map
> > +                                * each SG list entry to corresponding URB
> > +                                * buffer. The previously allocated SG list is
> > +                                * stored in priv->sgl (If the server's HCD
> > +                                * support SG, SG list is stored only in
> > +                                * urb->sg) and it is used as an indicator that
> > +                                * the server split single SG request into
> > +                                * several URBs. Later, priv->sgl is used by
> > +                                * stub_complete() and stub_send_ret_submit() to
> > +                                * reassemble the divied URBs.
> > +                                */
> > +                               support_sg = 0;
> > +                               num_urbs = nents;
> > +                               priv->completed_urbs = 0;
> > +                               pdu->u.cmd_submit.transfer_flags &=
> > +                                                               ~URB_DMA_MAP_SG;
> > +                       }
> >                  } else {
> >                          buffer = kzalloc(buf_len, GFP_KERNEL);
> >                          if (!buffer)
> > @@ -489,24 +516,6 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> >                  }
> >          }
> > 
> > -       /* Check if the server's HCD supports SG */
> > -       if (use_sg && !udev->bus->sg_tablesize) {
> > -               /*
> > -                * If the server's HCD doesn't support SG, break a single SG
> > -                * request into several URBs and map each SG list entry to
> > -                * corresponding URB buffer. The previously allocated SG
> > -                * list is stored in priv->sgl (If the server's HCD support SG,
> > -                * SG list is stored only in urb->sg) and it is used as an
> > -                * indicator that the server split single SG request into
> > -                * several URBs. Later, priv->sgl is used by stub_complete() and
> > -                * stub_send_ret_submit() to reassemble the divied URBs.
> > -                */
> > -               support_sg = 0;
> > -               num_urbs = nents;
> > -               priv->completed_urbs = 0;
> > -               pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
> > -       }
> > -
> >          /* allocate urb array */
> >          priv->num_urbs = num_urbs;
> >          priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
> > 
> 
> thanks,
> -- Shuah
