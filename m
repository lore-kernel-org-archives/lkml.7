Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E97CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E48208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVAZyxTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfJ2PW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:22:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389174AbfJ2PW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:22:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so2859653wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=734NRPXgAYnnoaK0bvSdeqVDUGQF7yU76dpnnD5fv0Q=;
        b=tVAZyxTpjFjDlOz5gxjL+cD/NIZdzQ8iGZcBDftXC9WI/Ntnb+Ka/RGAL7slxUPV0e
         /2+oWcw0juA2F9d/FUXHnX6QHjk3qiIcBdpfBNzbid/UmtIqMliunrp9+oXi7tOwRJOW
         O7LEM3A3a9oP+8nl+oXRPVg967ViQGXIbBhPiC78JbMEBPTLDmuhQdxh2dldUOjs/lJA
         BMzWF/rRP/cUBIsAY4LGKrZnGU704+6LslLJuPHvnJxoW7/UHWxCqa/j88O9VF0sFfYe
         0iVMmRAGoViUICUog8v6uXjg3g93KvHMXUtBq7IYu+2UQS4WZ1zH+JGRCdtafKErta8L
         +uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=734NRPXgAYnnoaK0bvSdeqVDUGQF7yU76dpnnD5fv0Q=;
        b=QT3WYXX3zvIK/ZCe0SaetnI84f0UCj07XAKsnwL67G9YWA2IeWhmOTDYFKyPS8Ivht
         QzTmhoFS0AZp/buglc0TQLXV4H53rf6UNkxnnRTH7ZDLrgOb6GmA03pJcf9+y3HxDBC1
         PYnzttTiDgEnvUehJ8+xcr9T3hWWEF6fHKVgrC1vGfwwh82VRDlW2UcVOtt4Ngqs6l4L
         IAMGF2vTF+9OQBwjVEOEjFa5sITvXjYgBmustkPGDLv+H5SpD8fo9j1iKa8sjPKA2nHE
         roaPP7wDezxta3heQNpEMCK53D603tR7+pNJITk4ie4H2U8fiW75HinIroxGc4sBHe3K
         vOuA==
X-Gm-Message-State: APjAAAW89bdfO4MQQQhFN904rwE/qP8kRCUkP4Jy72f8b+oqOowbj59P
        MxFf58LgTYqYc/96FFvXydY=
X-Google-Smtp-Source: APXvYqyzYdTNlb3awoWZWSzAlm5z0ON3TRTPeYkLuzqe71IbLTdH1gtoM2nJuROYdVkInkZ4LI+5+g==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr4453131wmc.118.1572362546784;
        Tue, 29 Oct 2019 08:22:26 -0700 (PDT)
Received: from sivanov-pc ([92.247.20.94])
        by smtp.gmail.com with ESMTPSA id y128sm3474902wmg.10.2019.10.29.08.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:22:26 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:22:24 +0200
From:   Samuil Ivanov <samuil.ivanovbg@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        rspringer@google.com, toddpoynor@google.com, benchan@chromium.org
Subject: Re: [PATCH 1/2] Staging: gasket: implement apex_get_status() to
 check driver status
Message-ID: <20191029152224.GA9523@sivanov-pc>
References: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
 <20191028225926.8951-2-samuil.ivanovbg@gmail.com>
 <20191029081007.GA520581@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029081007.GA520581@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 09:10:07AM +0100, Greg KH wrote:
> On Tue, Oct 29, 2019 at 12:59:25AM +0200, Samuil Ivanov wrote:
> > >From the TODO:
> > - apex_get_status() should actually check status
> > 
> > The function now checkes the status of the driver
> > 
> > Signed-off-by: Samuil Ivanov <samuil.ivanovbg@gmail.com>
> > ---
> >  drivers/staging/gasket/apex_driver.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> > index 46199c8ca441..a5dd6f3c367d 100644
> > --- a/drivers/staging/gasket/apex_driver.c
> > +++ b/drivers/staging/gasket/apex_driver.c
> > @@ -247,6 +247,9 @@ module_param(bypass_top_level, int, 0644);
> >  static int apex_get_status(struct gasket_dev *gasket_dev)
> >  {
> >  	/* TODO: Check device status. */
> > +	if (gasket_dev->status == GASKET_STATUS_DEAD)
> > +		return GASKET_STATUS_DEAD;
> > +
> 
> Have you tested this to verify that this is what is needed here?
> 
> thanks,
> 
> greg k-h

Hello Greg,

After going through the code again, I am sure this not what is needed here.

I thought that gasket_dev->status is already set to either
GASKET_STATUS_ALIVE of GASKET_STATUS_DEAD,
and all I needed to do is check it. It turns out that status
has to be set before that.

So what I found is that function gasket_get_hw_status()
in file gasket_core.c is used to determine the health of the Gasket device,
and other function use it to set gasket_dev->status and then check
the device status.

I think it should be something like this.
...
gasket_dev->status = gasket_get_hw_status(gasket_dev);
if (gasket_dev->status == GASKET_STATUS_DEAD) {
        dev_dbg(gasket_dev->dev, "Device reported as dead.\n");
        return -EINVAL;
}
return GASKET_STATUS_ALIVE;
...

I can try this, but I have no means of testing it.

Grt,
Samuil
