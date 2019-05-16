Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6146720833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yuAHpEc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEPSXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:23:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45319 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:23:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so3229734oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4xg0I4nHSIZDLwgdApekV9qe+c7BH2Awe3q1fKa6Io=;
        b=yuAHpEc/2FUp4yfXksMyV9luWP6huU5wiNXGn+NIlDFS9bbErRHNSxKlKkYr1GjFOo
         VQ/bYwSavyf7szedZRsCbovVVYpDm/cygkUfWHeQp7fuDa34VJ6SkAQHC1FVUgQiuUNm
         tqLbLsHyz7tHWMHdVPJIwK3cYNK21Yknj1tAUuhOgfD8JJmxEk7WU2ytUOSFd8txASrU
         4+4i06pABRZtWMLf1jaCA6NFasC4kCCUtKyaTopkzsSCcMfDFk0X5iXm43N9EJ/TriM5
         Rsv7MO7RVg+tG5j+WcR8IXZworhpQ5BKKBk9E93QtYjt1oauxG6cUk1KOgqWhCTLpLl1
         jEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4xg0I4nHSIZDLwgdApekV9qe+c7BH2Awe3q1fKa6Io=;
        b=ZHrPWcY72ZymTI85+d2zgVndaOlhwuAKWdz+kJVbvnWHP87YYKnEzY4j1tUo2Wn8wi
         3dKd3H8IrFPd9QYnBhJqMNuBRm5IfGjuLtk5nu89765vY8IVEXyKM1Ee2nouHwAOr6Be
         A0j0GTxgLj9mDcyknFOw3LrA2ttbfaveWIzJ0YiIXmJRcVOS0g2QSrcepDh2SApc3wfy
         I0iVnM4IrD/KnDC4fjmdJSlARR/f/SoNSNntNcE6PSy/Fjsp8c8hGCpImQUryeBy5hg/
         5wdkKOetA5SA8cJa0w9RROeHN3PuqvDsv5MeYWa61SgFHsEm0ZpkdvMDQP1MjKkm4bfc
         thyg==
X-Gm-Message-State: APjAAAU+GnBl8Nl6qRvcOxMQXjt30urvYENVCiT2kBvgpyD03oAuKjTf
        2Q3Z/UdaqMIsWFAo8SoHpHhIAoswG/kH6WIfE/g8qg==
X-Google-Smtp-Source: APXvYqwg9rOSNakUV6ntAHuPcrnmGPMNTHp9x75smlsew5RpVuQ939PYfxxwI+yczWaxBwHwk8lhj1yhUXwii4EAqnQ=
X-Received: by 2002:aca:4208:: with SMTP id p8mr12157546oia.105.1558030980537;
 Thu, 16 May 2019 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190516055422.16939-1-vaibhav@linux.ibm.com>
In-Reply-To: <20190516055422.16939-1-vaibhav@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 May 2019 11:22:49 -0700
Message-ID: <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix last_page check in __bdev_dax_supported()
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:55 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Presently __bdev_dax_supported() checks if first sector of last
> page ( last_page ) on the block device is aligned to page
> boundary. However the code to compute 'last_page' assumes that there
> are 8 sectors/page assuming a 4K page-size.
>
> This assumption breaks on architectures which use a different page
> size specifically PPC64 where page-size == 64K. Hence a warning is
> seen while trying to mount a xfs/ext4 file-system with dax enabled:
>
> $ sudo mount -o dax /dev/pmem0 /mnt/pmem
> XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> XFS (pmem0): DAX unsupported by block device. Turning off DAX.
>
> The patch fixes this issue by updating calculation of 'last_var' to
> take into account number-of-sectors/page instead of assuming it to be
> '8'.

Yes, I noticed this too and fixed it up in a wider change that also
allows device-mapper to validate each component device. Does this
patch work for you?

https://lore.kernel.org/lkml/155789172402.748145.11853718580748830476.stgit@dwillia2-desk3.amr.corp.intel.com/
