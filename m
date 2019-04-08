Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD720870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea72sH7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDHSLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:11:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44778 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:11:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so8072217pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCaZtAPIdoTmL89IrJBiBqajTRyKobTSTiuIO1WebTU=;
        b=Ea72sH7GwMqTkGBzJpLIvDEoenxfQLMSfNsp+dV90t0O4AWKpb+TGWDUCZz4smapDs
         7+HUVhdKUrRXCy2NN1mL5FIV07RduSMUKuVPvr3ipCFP4rAp9jNWjv1m2/pVq1/3yMDo
         mjTBhgRa3U6TGI6AVgsgsNPQQr5SVG+Z4ZgPwWkPgMIYw9IvOcV3YzcXdBTK+Oz8+PIM
         54+hKFeXxLfApDqzlDdHC84f4J4fhPNqfC+RY0bsCxw1onCp4+M+PsNKl+1HzCmTcbRJ
         Q+C8Hp/+e2FKwBLkr164WhtCN+dKBf4C3VTBK5xKESDBza8N97dw+XOjVZM4pm0uEI+g
         koRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCaZtAPIdoTmL89IrJBiBqajTRyKobTSTiuIO1WebTU=;
        b=TpzYG4sdJJkVUQd5xC7bjI9swIX7fcX90WjTn5TsuL3IlWvx8p85cPFqhHCYa/MWCr
         lJ+mo+JfHLmRdC2E3Rch3ObLKd9aZTrcCh9sCqEIWFC1983QyE5SXxoLgQHWMqc4QUwU
         FvvOSLYjHCyYRicwne2hXK+GaX23bpWJkl3jNEYhvGCSBuxj4dVPz2BF5CxLQfsT8a+3
         e0fMcufR4/UwJvHriAPTWmVvTea1JtACoHyUK+g+LmTnj0yel9xiIK1bAYDg08QGklK1
         s4sXKtACwWtMaGbNdS0f2w6xBaSN9woF7Wm38+rjCNAtLMsYuODIebW4GDa81fWdRtMw
         DKLw==
X-Gm-Message-State: APjAAAXNaUNYXCz7Vlg5T48W6N8IVLri87QVjuogMNjjdDAOg0FnCfX+
        +c/Az6LVFhn/LCx1cWoI7MXRccFAsEcap15G0rWXAg==
X-Google-Smtp-Source: APXvYqw1KOyWweoVDabIoS6R1icouwYLPX8itpFgLUPIcRsok/618g9DEhJmI63u7Y0AOJf0LVl+etRwICdDCAgvW0c=
X-Received: by 2002:a63:465b:: with SMTP id v27mr30350154pgk.165.1554747088946;
 Mon, 08 Apr 2019 11:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190407022558.65489-1-trong@android.com> <CAKwvOdmBa-Ckk4wnp4OEPNdxeYSxEhzddykuWWGG1Wi6JEGDwA@mail.gmail.com>
In-Reply-To: <CAKwvOdmBa-Ckk4wnp4OEPNdxeYSxEhzddykuWWGG1Wi6JEGDwA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Apr 2019 11:11:17 -0700
Message-ID: <CAKwvOdkCiS7bn68viW+TwDiwbvSq74zqc0B_xxBs-J0d5ieynQ@mail.gmail.com>
Subject: Re: [PATCH] module: add stub for within_module
To:     Tri Vo <trong@android.com>, Jessica Yu <jeyu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Apr 6, 2019 at 7:26 PM Tri Vo <trong@android.com> wrote:
> >
> > Provide a stub for within_module() when CONFIG_MODULES is not set. This
> > is needed to build CONFIG_GCOV_KERNEL.
> >
> > Fixes: 8c3d220cb6b5 ("gcov: clang support")
>
> The above commit got backed out of the -mm tree, due to the issue this
> patch addresses, so not sure it provides the correct context for the
> patch.  Maybe that line in the commit message should be dropped?

Maybe Jessica could drop that if/when applying?

>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> > Signed-off-by: Tri Vo <trong@android.com>
> > ---
> >  include/linux/module.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 5bf5dcd91009..47190ebb70bf 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
> >         return false;
> >  }
> >
> > +static inline bool within_module(unsigned long addr, const struct module *mod)
> > +{
> > +       return false;
> > +}
> > +
>
> Do folks think that similar stubs for within_module_core and
> within_module_init should be added, while we're here?
>

Otherwise, if the answer to the above is no,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
