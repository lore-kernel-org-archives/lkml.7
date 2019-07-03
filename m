Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC1BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D903218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wNUY8V/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGCRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:01:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37874 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:01:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so3112467otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
        b=wNUY8V/mhFuU37yp/ZiCDNP/H5W230TbjZb/97Elz40NFzQaPClxobNSgEuk/f3fsc
         KAsS1YqM5g5FH4s1vA63O4LG1jBHrjJk4+vd6uDPabBVuDZihDUD9S0urvnYPszj/0V7
         K3GtQXRnQlXcSKL2AyAP/XyoqqAcN/eugW+0Q5+IDzc1779CIDToxE4AjArrBzIAjzzq
         Q/pmhuRmYDByH0oTkD8u1Po/Dr97GukMF3RPS45sTrwZMCPuUPVZ7/af6ttu3XmQfaUC
         k9omAOSsVODfgBm0uvi0QAClbSTpv8GcLOOgeFCzj/fCCrb3D7mDtnKte0e0X0QHsNvy
         4Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
        b=lvn/hGFVmqGlFVIzeNZlKYtKwPUNmYZW5wn7m/RS2GdDa3IubyCyT722OJIjsiVs5h
         /AD4hE6Z/ALRY3mfJBOhs/IIeoSrx7OHtn3oR2QCpjdvcqxZQV1GH1hk2ScNLgRxauN7
         wNVHSowGSwfUMkl8mBD6RAVbQi8GLBD4FMP+tr693YDLhoKenVqtfz9/QgFPDinqK7WJ
         A9nTMBJ2VkK/G2ChJMo885cIC3V7lr9B9/pIK3OtbiryhQbBdNSyZU80Ep90nxkc8RsT
         WtG2+XzGeo076qk0gviIpoFF3pcsdpKOmZM3zIvTvOiOWFd2jIX//fQ+IrKG8McOvrTb
         llYg==
X-Gm-Message-State: APjAAAWixU0YZitLKzsb8p+Aa58NbI9vfdiGwBt3EKykhM0nNELeag+W
        9ZAPqS0rqNgeVCVHUmgmwdKaPkXSvMeVpvoUoLLsjA==
X-Google-Smtp-Source: APXvYqzUjYaojSiF9PThGytBdcW3gjnOn4fcnoQwduNIvsAmCsZm45nhyVZ2Fow2YVOBy+g16od/O247MvqVqqVrRTo=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr29298148oto.207.1562173309283;
 Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
In-Reply-To: <20190703121743.GH1729@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Jul 2019 10:01:37 -0700
Message-ID: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > This fix may increase waitqueue contention, but a fix for that is saved
> > for a larger rework. In the meantime this fix is suitable for -stable
> > backports.
>
> I think this is too big for what it is; just the two-line patch to stop
> incorporating the low bits of the PTE would be more appropriate.

Sufficient, yes, "appropriate", not so sure. All those comments about
pmd entry size are stale after this change.
