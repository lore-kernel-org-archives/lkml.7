Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC84C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2F92147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iyGBERBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDHQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:21:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:32867 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:21:22 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so384767itf.0;
        Mon, 08 Apr 2019 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+ALvzkw2MlVDdVtF7B/3XBzAdAmSRxZaOAezn8/f0A=;
        b=iyGBERBHOT/R298RzohGko7w7fQKNP00f1hDBFJM/gS4CU1XcZ27v4JFzg5dy1lA5k
         BNWfUhEpGervaxx8mQDHDHBEFMU0lJs9js0xYWKF+OiRPvffY9MfqGDPen3InCTBR/hr
         On1ocwD3rig6XLmPrnDuTbCk0X+whbqI1pGC1bkkLjTELqvKUdKvnYmWVHZ4F4tF9Qmb
         2OvubAZPN8Toosx6oLfBbdXE6fwot7kalbu08dlXNia4i7AEiHiEopPaUo4H854r5IFD
         oCA+XGQ9qhcbA7Xj70ry2boRdMkQGTZ2fvoPzjUGZNqE4mix/oXL3TJ/sSQNW7n6GOWZ
         QFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+ALvzkw2MlVDdVtF7B/3XBzAdAmSRxZaOAezn8/f0A=;
        b=YZ1mdfN32Mlug7jbry/A++RbmPWqlrzrt/paZTSI1ZfiU/G06mDl58x0hbn7um82/R
         bm0ZciT6T/tajYojd7onh4AB5Fy9hAkMXqx+3cwQcTyDuAgfVUwFacyrm1+/l/HRTWo7
         m/2yCRadJgQp7fbLk/Jj0Y8zF/svkNt/EMhDnYLnoGFqRxWeiCx/fO18Yep2cpCIkAAq
         zpcix0/mtrxX3gf/Ahgb4M3e9n1QbIUTA1g4oycnQgrFegV8YSCLru8kwvhMxm+dIW9S
         KmR2KXLl2QTxdK7NCQsVfWHRWaB+GDC5rBImv6O0TPKwZIMDRChZHErHenM77GkuI0sk
         ql8w==
X-Gm-Message-State: APjAAAVsV8w/GybzsHneaf2Rc9g/He9zJ4qLE0RcToChAB649Mos0bdn
        V3C6/3KxjVkD/C+2d1nQJVmh8SHK+HjrDjDURgo=
X-Google-Smtp-Source: APXvYqzY2eS5L9/JEabSQilfuMukwFPgFXioQ6ZsmH+hQf0tKiWhm8tWwpxT4FFy+0bLn1wM8w9gjiWiNSgJ4ixsCEA=
X-Received: by 2002:a24:56c7:: with SMTP id o190mr21890168itb.120.1554740481013;
 Mon, 08 Apr 2019 09:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190329115544.GA27351@linux.intel.com> <alpine.LRH.2.21.1903300540530.2240@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903300540530.2240@namei.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Apr 2019 09:21:09 -0700
Message-ID: <CAA9_cmdyERPGwz-S3XuyJXnYrHM5V1fb_BCf_NS_kgQdN-YS=A@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.1
To:     James Morris <jmorris@namei.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:42 AM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 29 Mar 2019, Jarkko Sakkinen wrote:
>
> > Hi James,
> >
> > These are critical fixes for v5.1. Contains also couple of new selftests for
> > v5.1 features (partial reads in /dev/tpm0). I hope these could still reach
> > the release. Thanks.
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

Hi James,

Friendly ping on when might this go to Linus?

I was hoping that 3d0b1a381f6e ("KEYS: trusted: allow trusted.ko to
initialize w/o a TPM") would have hit -rc4. The NVDIMM subsystem has
been broken since -rc1.
