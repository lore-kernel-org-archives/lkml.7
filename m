Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63794C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AE020879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="FQ0it7Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfEWMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:09:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44362 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:09:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so4196823lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h6lj7XxfSxFYE4ZQJuSyQV2q9lHLkjeov5udj7sc3bk=;
        b=FQ0it7Ctgumei+b9BjeJKiqMgsDTpyHgII+IhNI3w+vYYg27ZDMhMP/uIB26p/Q++R
         IoXhK9dNk4Zk5iNUJPBqUJM4xxPTQjBkLnwx4od6a3pI8mbuMB2nwFogeJMxioXEm5to
         4xH7qVtkEQ1MWEdlRRAYrcEyQxC0492R4fpu87VYZAaM2FHbQOH5eQrssfZuSnu2+L6k
         sCf5fzP3YEuJhiwAJKml4VYoXhzermIUkUn6OeYiGEN0ZOZTvJtM3TFg/ymm5nUIHM9E
         uBqcjLdMiKIzl1asXdmj6LiYS1EFDOguetlg6OFcGBCsJnvhChvmlAHubp7Toir/Vlas
         Y8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h6lj7XxfSxFYE4ZQJuSyQV2q9lHLkjeov5udj7sc3bk=;
        b=U3Qd7uf5/1xCqUWeNeVwfRyXai69pke7cLbqUAxeGMHnYAqE2VBUQJuA8PO6lklVyz
         aRaxYCjpD/XymlZpnnozAGlEYmrrNL9F9M7EU9tPPVgCf4zr1VXOlqsvqJCe2rqkabsz
         hlF7wfJdUrOmN9gCnrC4cPmX07ytMpxcrcsHR5zXCfnU+NWdxSuuoubzrh1h88m5cRTr
         hlie+sTrXJXQfGe2dqiFNJl7o8zpZywGd6LU53XVprhdVuAlL1VrlGJSd9mbYqaNmrdM
         ivQRs2R5oNca/zIBhKGLx9Pd0wN4mphXUsGY2VOUercJ0Z60WO0vqxVmVd7G4XXdyg00
         BZzw==
X-Gm-Message-State: APjAAAUg//AKgvUk2+SuGS9O45JuIcbXjVF2jlhfOGOcgfs0N49grw0r
        t8i7Xgewto2+Cs34gtzsLzm+3g==
X-Google-Smtp-Source: APXvYqzlzNEFp/xZRKmB8JdxW6mESUynRvJK0HU3P3lAVOPrac7uvZrZTDwDKYyxkHSAd7eR/nxNVg==
X-Received: by 2002:ac2:4d0d:: with SMTP id r13mr21381889lfi.30.1558613380386;
        Thu, 23 May 2019 05:09:40 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id g15sm1226340ljk.83.2019.05.23.05.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 05:09:39 -0700 (PDT)
Date:   Thu, 23 May 2019 14:09:37 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 2/8] staging: kpc2000: use __func__ in debug messages
Message-ID: <20190523120937.zq6gif6amslfruna@dev.nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
 <20190523113613.28342-3-simon@nikanor.nu>
 <20190523115553.GA6953@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523115553.GA6953@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:55:53PM +0200, Greg KH wrote:
> On Thu, May 23, 2019 at 01:36:07PM +0200, Simon Sandström wrote:
> > Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
> > '<function name>', this function's name, in a string".
> > 
> > Signed-off-by: Simon Sandström <simon@nikanor.nu>
> > ---
> >  drivers/staging/kpc2000/kpc2000/cell_probe.c | 22 +++++++++++++-------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > index 95bfbe4aae4d..7b850f3e808b 100644
> > --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > @@ -299,7 +299,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
> >  
> >  	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
> >  	if (!kudev) {
> > -		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
> > +		dev_err(&pcard->pdev->dev, "%s: failed to kzalloc kpc_uio_device\n",
> > +			__func__);
> 
> kmalloc and friend error messages should just be deleted.  Didn't
> checkpatch say something about that?
> 
> thanks,
> 
> greg k-h

Yes sorry, it did. Should I delete this chunk from this patch and add
another patch to this series that just deletes the message, in v2?

- Simon
