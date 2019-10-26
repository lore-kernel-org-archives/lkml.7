Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91F214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE/kmQOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJZCls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 22:41:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfJZCls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:41:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so2947201pfb.0;
        Fri, 25 Oct 2019 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=djftLTI6SR5uMqaa99UH/gv0dadwEjva6NX8TGWdKiM=;
        b=DE/kmQODrwVaCK6qad2QXWWq0B+tL8G8hH5iPvdZUnSz7HsLjv64uhGi5YS8HSSntx
         vebaKCcJYE/BCZwkWKnxRP4emMi+6e2sVftGH14rBJwt8QOCi8LkY6jkNmoBrRkN0zSC
         NMuacsR2RK4SosvgHkyIAkbSMrcCtln1RyLL/5NUsrqHlZwbfEQecSuBHCozFKU1upWU
         4LF3qQmE56LbpXwFPnVIgYm9dV2SEdfb+BNh/TkXPW3bGNn3/5QsfbLNv6nJjoiz1eNy
         b1fDQU1gHmgy36+0092U2eilf/2Mn4GKMC5jhAT+Cg8PbmMTBC7MRUWCJT2YWua8zT0Y
         4R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=djftLTI6SR5uMqaa99UH/gv0dadwEjva6NX8TGWdKiM=;
        b=n3Nk4i47f3uBILN7oqb4yOJk20Zs04U7cjU6OMi1OMmWCvHTRh1Oo6hvKFrjlw5Hyu
         uEXFvYRzOY0CcOee+oMUrZWwKu8JOU1HOrPLeIls3D0WwlmKUR32Lip7BYU76+EqCf7f
         kmlowe+0H103fRMzMhxpvVqvpsSQkeFbTFn+tbzypmvHTxEcTCFf6DecMo0Rm+Xm5C5Y
         2AjfHsyg0MpbXdKaXPaqbhE5UEsDTlNUgrT5zSM8VWgd8sj6OpFSZOX0KNUEJN8IIpZU
         ReFbxaL5S4HA6vRU3paIGtTHX4dEtw1U7uRMP1ywNFvwBrSCRoaHXc3HbL9WZ0PA7RCY
         RyHw==
X-Gm-Message-State: APjAAAWHMBR9ARmTXJfWNO0GVEysBWxirdnQImIXe4dWfavH5xzL2DST
        GuVx000HEEyYVDMwOyjkNlw=
X-Google-Smtp-Source: APXvYqxO7pDGnVczJQjopLSupQIquaCeOh8F2CjyTf9Y1YWv8SETT/2CfniI+qr1y0mp70WLCjq4rQ==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr7770342pjt.84.1572057707252;
        Fri, 25 Oct 2019 19:41:47 -0700 (PDT)
Received: from localhost.localdomain ([221.155.202.134])
        by smtp.gmail.com with ESMTPSA id e16sm3724083pgt.68.2019.10.25.19.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 19:41:46 -0700 (PDT)
Date:   Sat, 26 Oct 2019 11:41:41 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
Message-ID: <20191026024141.GA3339@localhost.localdomain>
References: <20191022092839.GD10833@kadam>
 <20191023071120.GA3061@localhost.localdomain>
 <20191024194500.GD23523@kadam>
 <ce76c90b-3431-9342-8b75-882d582c6366@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce76c90b-3431-9342-8b75-882d582c6366@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 04:52:52PM -0600, shuah wrote:
> On 10/24/19 1:45 PM, Dan Carpenter wrote:
> > On Wed, Oct 23, 2019 at 04:11:20PM +0900, Suwan Kim wrote:
> > > On Tue, Oct 22, 2019 at 12:28:39PM +0300, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   7d194c2100ad2a6dded545887d02754948ca5241
> > > > commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
> > > > date:   7 weeks ago
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > 
> > > > New smatch warnings:
> > > > drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error: uninitialized symbol 'nents'.
> > > > 
> > > > Old smatch warnings:
> > > > drivers/usb/usbip/stub_rx.c:450 stub_recv_xbuff() error: uninitialized symbol 'ret'.

Here, ret is not initialized, meaning priv->num_urbs is 0.
priv->urbs must be greater than zero.
priv->num_urbs = 0 means nents is 0 (line 505)

Dan, What is the relationship between old and new warnings?
priv->num_urbs is set as value of "num_urbs" at stub_recv_cmd_submit()
and "num_urbs" is initialized as 1 first. "num_urbs" will be reset
only at the place where smatch new warnings happened (line 505).

So, In my opinion, old smatch warnings should occur after the new
smatch warnings. Does this look right to you?

> > > > # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea44d190764b4422af4d1c29eaeb9e69e353b406
> > > > git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > git remote update linus
> > > > git checkout ea44d190764b4422af4d1c29eaeb9e69e353b406
> > > > vim +/nents +505 drivers/usb/usbip/stub_rx.c
> > > > 
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  453  static void stub_recv_cmd_submit(struct stub_device *sdev,
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  454  				 struct usbip_header *pdu)
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  455  {
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  456  	struct stub_priv *priv;
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  457  	struct usbip_device *ud = &sdev->ud;
> > > > 2d8f4595d1f275 drivers/staging/usbip/stub_rx.c Max Vozeler        2011-01-12  458  	struct usb_device *udev = sdev->udev;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  459  	struct scatterlist *sgl = NULL, *sg;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  460  	void *buffer = NULL;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  461  	unsigned long long buf_len;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  462  	int nents;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  463  	int num_urbs = 1;
> > > > c6688ef9f29762 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  464  	int pipe = get_pipe(sdev, pdu);
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  465  	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  466  	int support_sg = 1;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  467  	int np = 0;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  468  	int ret, i;
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  469
> > > > 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  470  	if (pipe == -1)
> > > > 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  471  		return;
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  472
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  473  	priv = stub_priv_alloc(sdev, pdu);
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  474  	if (!priv)
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  475  		return;
> > > > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  476
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  477  	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  478
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  479  	/* allocate urb transfer buffer, if needed */
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  480  	if (buf_len) {
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  481  		if (use_sg) {
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  482  			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  483  			if (!sgl)
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  484  				goto err_malloc;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  485  		} else {
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  486  			buffer = kzalloc(buf_len, GFP_KERNEL);
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  487  			if (!buffer)
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  488  				goto err_malloc;
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  489  		}
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  490  	}
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  491
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  492  	/* Check if the server's HCD supports SG */
> > > > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  493  	if (use_sg && !udev->bus->sg_tablesize) {
> > > > 
> > > > Smatch thinks "use_sg" can be true when "buf_len" is zero.  It's hard
> > > > to tell if Smatch is right or wrong without more context...
> > > 
> > > This is a bit strange. The meaning of "use_sg" is that client will
> > > use scatter-gather and client's urb->num_sgs is not zero. And buffer
> > > length should not be zero.
> > > 
> > > usb_sg and buf_len are both client-dependent variables, so I think
> > > if they have wrong value in the server side, the client must have
> > > sent use_sg and buf_len with incorrect values.
> > > 
> > > Did this error occur when compiling?
> > 
> > Smatch is doing static analysis, yes.
> > 
> > > If then, Did Smatch also consider vhci tx side?
> > 
> > I'm not really sure...  I can't reproduce the warning because on my
> > system Smatch doesn't parse usbip_recv() correctly so it ends up
> > silencing that warning.  :/
> > 
> 
> Hi Suwan,
> 
> This is a problem that needs fixing. nents
> 
>        /* allocate urb transfer buffer, if needed */
>         if (buf_len) {
>                 if (use_sg) {
>                         sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> 
> nents gets initialized here by sgl_alloc()
> 
>                         if (!sgl)
>                                 goto err_malloc;
>                 } else {
>                         buffer = kzalloc(buf_len, GFP_KERNEL);
>                         if (!buffer)
>                                 goto err_malloc;
>                 }
>         }
> 
>         /* Check if the server's HCD supports SG */
>         if (use_sg && !udev->bus->sg_tablesize) {
>                 /*
>                  * If the server's HCD doesn't support SG, break a single SG
>                  * request into several URBs and map each SG list entry to
>                  * corresponding URB buffer. The previously allocated SG
>                  * list is stored in priv->sgl (If the server's HCD support
> SG,
>                  * SG list is stored only in urb->sg) and it is used as an
>                  * indicator that the server split single SG request into
>                  * several URBs. Later, priv->sgl is used by stub_complete()
> and
>                  * stub_send_ret_submit() to reassemble the divied URBs.
>                  */
>                 support_sg = 0;
>                 num_urbs = nents;
> 
> I think nents will be valid here. Is there need for this additional
> check here? You can fold this into the previous use_sg check, right
> after the sg_alloc() success, I would think.
> 
>                 priv->completed_urbs = 0;
>                 pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
>         }
> 
> 
> thanks,
> -- Shuah

I agree with you. Is it your intention to check as follows?

	/* Check if the server's HCD supports SG */
	if (use_sg && !nents &&  !udev->bus->sg_tablesize) {
                     ^ Additinal check in here?

In my opinion, it would be nice to initialize nents to zero first,
and then check in the above if statement to see if nents was set
in sgl_free().

Regards,
Suwan Kim
