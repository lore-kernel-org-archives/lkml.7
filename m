Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3DFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AD22077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555414423;
	bh=MlxSTPGFW2Tay5rjzFaS6Q9MzzskYlaWLTny8l5AxMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jzzweZ1HHP9k+4sbMeZ8VGoEBu/xruBdLJrJEXQInCagA2o+M4RluwRlc9Y4qnKHi
	 uVF0BchBzxBqL6CkAn5eLv991OvRcaVZfRVQS5YdHKCVznuc8Q9PfqhFqPdlAIhL3k
	 VUBVSrxO6QpH5vhXrLItoalyOxk0wO3RY/90VLok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfDPLdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:33:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45050 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:33:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so15705301lfj.11;
        Tue, 16 Apr 2019 04:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CS4NO5XoAVBszCZuPPtAOq5Inz9Vw8UIugRH0CNHl4U=;
        b=HZ0Nrt0xLDPlRsgOCTljC+9yQG+yxnmA8T7Ne8326nVzMGYRwar1HgtBzR8jY5gA66
         xuGlv2WCtDfn0j3MixA1SFPAT7szUF6NLNM8Ifm9CTnqEohvx6lGmmMs94CWkZBSVRI9
         olf65RPO7Nd723Xc/rf6bG7inkwZh37vErCXJa/Num1bcw2OOTWWuW7Vx9vd03M9Hv0r
         BEyMx2MTGqbAsTON7am4EvW/NKNQeRyVlFT/cCBYT1yjtVICHM4bgsBP7LaoT8Bu3lEd
         ztyXapMrOEDWWq2zrz0j0beuvaBeRxnBRzYMyYVnz+L/+sYrmCx+cD7+XGtZD27LW8Vo
         Z2Qg==
X-Gm-Message-State: APjAAAXXcvWMRC0WBygHn1Y4Sw/teKgHz0BhJKPyiqW9pxKS6KDQhYGt
        L29n+Ip3lqhP1aBHVQJiUCs=
X-Google-Smtp-Source: APXvYqzMgAu7ahq6a5UL4Ej/0GSD4KNsUnU7Oh6tPqpMpoRSWSp8qhp5QPpgx1xfCnPV9l69APKFqQ==
X-Received: by 2002:ac2:5088:: with SMTP id f8mr19541978lfm.107.1555414419069;
        Tue, 16 Apr 2019 04:33:39 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z16sm820265lfi.9.2019.04.16.04.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 04:33:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hGMLP-0006z4-Oe; Tue, 16 Apr 2019 13:33:43 +0200
Date:   Tue, 16 Apr 2019 13:33:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, mchehab@kernel.org,
        keescook@chromium.org, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB
 descriptors
Message-ID: <20190416113343.GJ775@localhost>
References: <1554958452-29794-1-git-send-email-92siuyang@gmail.com>
 <20190416112645.GI775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416112645.GI775@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:26:45PM +0200, Johan Hovold wrote:
> On Thu, Apr 11, 2019 at 12:54:12PM +0800, Young Xiao wrote:
> > From: Young Xiao <YangX92@hotmail.com>
> > 
> > The driver expects at least one valid endpoint. If given
> > malicious descriptors that specify 0 for the number of endpoints,
> > it will crash in the probe function.  Ensure there is at least
> > one endpoint on the interface before using it.
> 
> Why do claim it will crash?

Ok, I see now that Björn already pointed this out to you in your
updated version of this patch.

> > This vulnerability is same as CVE-2016-2188.
> 
> Note that the "fix" for this CVE that you're now copying was incomplete.
> Here's the proper fix:
> 
> 	b7321e81fc36 ("USB: iowarrior: fix NULL-deref at probe")
> 
> > Signed-off-by: Young Xiao <YangX92@hotmail.com>
> > ---
> >  drivers/media/usb/s2255/s2255drv.c       | 7 +++++++
> >  drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
> > index 5b3e54b..7fdf159 100644
> > --- a/drivers/media/usb/s2255/s2255drv.c
> > +++ b/drivers/media/usb/s2255/s2255drv.c
> > @@ -2263,6 +2263,13 @@ static int s2255_probe(struct usb_interface *interface,
> >  	iface_desc = interface->cur_altsetting;
> >  	dev_dbg(&interface->dev, "num EP: %d\n",
> >  		iface_desc->desc.bNumEndpoints);
> > +
> > +	if (iface_desc->desc.bNumEndpoints < 1) {
> > +		dev_err(&interface->dev, "Invalid number of endpoints\n");
> > +		retval = -EINVAL;
> > +		goto error;
> > +	}
> > +
> >  	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> 
> Besides that you didn't even bother compile-testing this, there is no
> bug here to fix to begin with.
> 
> If bNumEndpoints is zero this loop will execute and the driver bails out
> just after since dev->read_endpoint is NULL.

That was meant to read "will never execute".

Johan
