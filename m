Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4042147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnAq9wWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfF1DiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:38:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43280 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfF1DiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:38:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so2947409lfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFAR1VyfRz8u+8JtXBWHxsN9qbzCO9vgXJys4jNPevE=;
        b=DnAq9wWeUF4/tJ3xd3/E9iDEp59E1DKVpfYYqcNoRE5ld6ONQQVSXKRfVv8MwTIztr
         pPKNz/8t16wutRg1tu9CGKqaTYhkfLeZbJQ3bd79Z32xN8k+MblNR37mKCk4OutG7fRr
         23GdKdtowzQcjVaKAHLqU3KZ2UrpmnLSAtCH7ubUagYI1/yuOcw6IjNQAjb+ksr1tMrT
         SmvrYAemTbPAKMKM3x3S9NFI//CpXPF6AnmQybzEoLJmFdOEyKR1K9kQepsLBUNc/DJN
         weCD9AuNxwE9DoKFa9ZVOt/s8+oeDOdkMlQjZAdy6nkwsSf7EEvSQFbkCQb1XaOOmhEb
         Sdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFAR1VyfRz8u+8JtXBWHxsN9qbzCO9vgXJys4jNPevE=;
        b=apfRcuXev9e/6pLSqlIBj3verQMJaypaJJitFnMVfKweZ8QKnO0PBMdQe5iNy9dpF6
         dCfF+lqsfwa4GhtK/XpLPQMJ7uy6K7MOxhNuSPhGTvq1mvxdxfjOAE7tuZmuwWNGEhOO
         JybEaX1u8JudonNExlny/Mkl7H1Aycd6hOpalGpHcnqFk6wBE+dWebrP6k38OQshCh85
         2G1AgaclPqL9nZnqdMRSCrosLUBGEeXZ7C8pXEXJ41eA4FNqz2fwngZZPkDb3tYJa03T
         1LOPJ76hHYXbip9qU5I0g+iWd1o1sM42+Cyfk+Bn62qW6mbyZMTGlh5/0DihAywKzjsH
         uWoA==
X-Gm-Message-State: APjAAAUIq2f2w4syujrlGmL1Hcxg4C8AYEG+0CVwBpDNmnagoMt34wiA
        nKwrEOdyyR0y1fFKr0i9GcqrJJCDQinDan87i1tKyQ==
X-Google-Smtp-Source: APXvYqzx4zeAdw9gJozkJfqZ8idmtP4uO628k0/UGSICcNueyN6ahlH9h046vJEG/h4JYKM/NJ/Oulviun3B640f9P0=
X-Received: by 2002:a19:ed07:: with SMTP id y7mr3996030lfy.56.1561693089958;
 Thu, 27 Jun 2019 20:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190508173403.6088d0db@canb.auug.org.au> <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
 <CAHp75Veq2=XA124rG8urt3eVE3pcaUm0VdsV7Mxr9zjMpa7mjg@mail.gmail.com>
 <CACK8Z6F2v8nyUYcnOrkp81WfK2D2NEmK=pcWybn1annrtqRwew@mail.gmail.com> <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
In-Reply-To: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Jun 2019 20:37:33 -0700
Message-ID: <CACK8Z6FN62e041-dwri6S+-34wSOxSsTAPjRmSw44uVJhtRz-A@mail.gmail.com>
Subject: Re: linux-next: Tree for May 8 (drivers/platform/x86/intel_pmc_core_plat_drv.c)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 11, 2019 at 12:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 9, 2019 at 2:15 AM Rajat Jain <rajatja@google.com> wrote:
>
> > OK, NP. Just to be sure I understand,
> >
> > 1) Please let me know if I should send in a fix (it would be
> > #include/linux/module.h and also add MODULE_LICENSE() I believe)?
> > 2) Would this be lined up for next version though?
>
> Resend a complete series based on the latest stuff we have in our
> for-next branch.

My apologies for the delay in resending. I just sent a v7 of the patch
that was dropped:
https://lkml.org/lkml/2019/6/27/1264

Only 2 changes from the v6:

#include <linux/module.h>

and

MODULE_LICENSE()

Thanks & Best Regards,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
