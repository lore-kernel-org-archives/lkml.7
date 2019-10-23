Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E32214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh2o/p3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfJWHLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:11:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33851 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389090AbfJWHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:11:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so11601158pgi.1;
        Wed, 23 Oct 2019 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iltHa19LVeDZzcl0wNaWMRkM42PjAxviyO6MFl6S3K4=;
        b=Hh2o/p3t2bh0XN7oJwBdTkTsDrvbpp3jOGYwgqv3LViFb7itT48dydl0eo/1YqSGCa
         nM4Wajwhi9GrbyCZ3zIZLmo3+P6D6oHDX1UosSc1MQx1a/QNEAcILjP0OqQAM9YVCRCY
         dIvhKjGVfNcejATthvQo0Y/3TuKKRnDmru130Grh+k8eotj6+gPTAeGKkRQTIFCzV3Vo
         7t0g/Yh0wEDsNS3IFYhFJK8r1BILlzqn8KmKPHofteZkXAG2rASld0CtUSP3fnI08kkz
         R+aUNtTpcEWvzvt1+b+k4EB5UesigiW4Ridp1TzRnp5xZZb70zpmUK6ojhS7ZRlY46lZ
         WCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iltHa19LVeDZzcl0wNaWMRkM42PjAxviyO6MFl6S3K4=;
        b=C7cak+vuvyoYi4mCOAnkmWaG0HXAwre8YhFZdV/gv8M3mEktSKNuAhpmURtvI1YO0+
         upt6cc1Xrh9iiaphilJoNU/+Mf2RwGB/jD0eGKY8qfUSF95fkJw1mzFE8k14luZjpLDI
         jTDk+r+5Pxonxz3TvZxrda6oTluDsPIoqQ2zY5CODmoJhwite5ck6oyIQBo05rh03aIv
         GCPFHAeF9YCAIoDjv42C4j+gSqGHr1/VL4+mskGqAWuxhf/4uDgLWTo5PcBJCApxMIEd
         rHev7DhTphK3rEFmTXEQc9cvhTfoy6dItfJX0HoKluD7jhgzSPI07KCAKmwPT5JGrNvD
         f36Q==
X-Gm-Message-State: APjAAAWU5h0VeDnfqEoyMPGv4jEwoMIjGpDCH28rAq0cYETC4q5ZR2Kj
        5jG9PypGH0xp5LsqMdmJ/co=
X-Google-Smtp-Source: APXvYqyKs1u4d4VWZBjTql/N+o1pjecgE4dwaGG9dnTOYl68ZDzGW73eGsiAftjIrBbD9sbvuTqO6Q==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr9083608pfm.189.1571814688312;
        Wed, 23 Oct 2019 00:11:28 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id v19sm23524678pff.46.2019.10.23.00.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 00:11:26 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:11:20 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
Message-ID: <20191023071120.GA3061@localhost.localdomain>
References: <20191022092839.GD10833@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022092839.GD10833@kadam>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:28:39PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7d194c2100ad2a6dded545887d02754948ca5241
> commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
> date:   7 weeks ago
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error: uninitialized symbol 'nents'.
> 
> Old smatch warnings:
> drivers/usb/usbip/stub_rx.c:450 stub_recv_xbuff() error: uninitialized symbol 'ret'.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea44d190764b4422af4d1c29eaeb9e69e353b406
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout ea44d190764b4422af4d1c29eaeb9e69e353b406
> vim +/nents +505 drivers/usb/usbip/stub_rx.c
> 
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  453  static void stub_recv_cmd_submit(struct stub_device *sdev,
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  454  				 struct usbip_header *pdu)
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  455  {
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  456  	struct stub_priv *priv;
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  457  	struct usbip_device *ud = &sdev->ud;
> 2d8f4595d1f275 drivers/staging/usbip/stub_rx.c Max Vozeler        2011-01-12  458  	struct usb_device *udev = sdev->udev;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  459  	struct scatterlist *sgl = NULL, *sg;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  460  	void *buffer = NULL;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  461  	unsigned long long buf_len;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  462  	int nents;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  463  	int num_urbs = 1;
> c6688ef9f29762 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  464  	int pipe = get_pipe(sdev, pdu);
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  465  	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  466  	int support_sg = 1;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  467  	int np = 0;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  468  	int ret, i;
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  469  
> 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  470  	if (pipe == -1)
> 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  471  		return;
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  472  
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  473  	priv = stub_priv_alloc(sdev, pdu);
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  474  	if (!priv)
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  475  		return;
> 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  476  
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  477  	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  478  
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  479  	/* allocate urb transfer buffer, if needed */
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  480  	if (buf_len) {
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  481  		if (use_sg) {
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  482  			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  483  			if (!sgl)
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  484  				goto err_malloc;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  485  		} else {
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  486  			buffer = kzalloc(buf_len, GFP_KERNEL);
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  487  			if (!buffer)
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  488  				goto err_malloc;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  489  		}
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  490  	}
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  491  
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  492  	/* Check if the server's HCD supports SG */
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  493  	if (use_sg && !udev->bus->sg_tablesize) {
> 
> Smatch thinks "use_sg" can be true when "buf_len" is zero.  It's hard
> to tell if Smatch is right or wrong without more context...

This is a bit strange. The meaning of "use_sg" is that client will
use scatter-gather and client's urb->num_sgs is not zero. And buffer
length should not be zero.

usb_sg and buf_len are both client-dependent variables, so I think
if they have wrong value in the server side, the client must have
sent use_sg and buf_len with incorrect values.

Did this error occur when compiling? If then, Did Smatch also
consider vhci tx side?

Regards
Suwan Kim

> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  494  		/*
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  495  		 * If the server's HCD doesn't support SG, break a single SG
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  496  		 * request into several URBs and map each SG list entry to
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  497  		 * corresponding URB buffer. The previously allocated SG
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  498  		 * list is stored in priv->sgl (If the server's HCD support SG,
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  499  		 * SG list is stored only in urb->sg) and it is used as an
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  500  		 * indicator that the server split single SG request into
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  501  		 * several URBs. Later, priv->sgl is used by stub_complete() and
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  502  		 * stub_send_ret_submit() to reassemble the divied URBs.
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  503  		 */
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  504  		support_sg = 0;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28 @505  		num_urbs = nents;
>                                                                                                 ^^^^^^^^^^^^^^^^
> 
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  506  		priv->completed_urbs = 0;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  507  		pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
> ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  508  	}
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
