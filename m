Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25461206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCWrWFpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbfIMRji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:39:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfIMRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:39:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id t3so3643607wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbdt8DMuaPHekJf0RQCDEBN2zI9VHU/ceA7ZqRfGDhY=;
        b=XCWrWFpOwytN6fNry1tv4OjtVKdxGfxrREb2Wa9Y95soJfcCx/vfndJZcMnvwMFsBb
         Uh9JiyTv8ZSoRjOYTeF7caSQWMKDuLeQdNgrD+KpFSvZyp76aLGA8w7ahPkrDHRFsYK1
         aZQD8aUOg99uAToMv4By0BkX3t+mmQlKZRg+aQyk0HTG0qIjoq7HBO3/V6/Q9vRYNhPq
         TLtUuiwio5ZR4PsJxJdM0cyxEucgRuow6eA+3ikXKBGfpy6H3dNST9pvCUWvNYJEztx5
         CJ21DL0C5rSkMBBAutdxzgQ24HHvyHxRzwqsn8pnuR6HLHJOKkWsI2fPYNsF7sxpaWRf
         v20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbdt8DMuaPHekJf0RQCDEBN2zI9VHU/ceA7ZqRfGDhY=;
        b=kw5Oxg2zVGbkEkqd0ahMyDMI0yS9O1D3naKLRIWKMQaHhty0mAVNJyvEd0i9AuB72Y
         Dtnx74tR8kEH2X4cgrSyKjAZwgsxtytYD3j9hnCnvWslTBFs3DE4bBOvzy6C0+b3xJeq
         BhbT0nZCipbeAkXFCR0T7tgY88Dan0chIww/cpwzehqqEVXe6/SpiC5V3j5cSgkyIQkl
         KITSwovKtARNIY5wWMmw4ekN5FNOuecdFdbF8c2ykmL8VzQuZ9TgF2Nwe1pjbeSYNH4u
         +dzTHaTaiHXAFx8zgOBO8XNOHIgGSX3iMZeuSMq+/OAjgMk0LalDrjVJJgEx4dNMRgVG
         +F9w==
X-Gm-Message-State: APjAAAWQa9EWwiMYLkFOofjji+6OXLgLwALDpqhqsBvKRp8nRJD7jLNC
        YFteoGN962ul46ijfRPfjsr0KKqAinuaCCd7lxPk0A==
X-Google-Smtp-Source: APXvYqwZe1afAeq+1FbxIrzjzP/GZNh2yHs1/HCK3GXpHwPL1dKVW9Vr27GG4tWONkRjWLoL0QJMgD9gRyazDq9iqRk=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr4075220wma.136.1568396376147;
 Fri, 13 Sep 2019 10:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995890.1616117.10724047366038926477.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8OOeLyuNwgG1eXM2FGDNrLvigMfR63uWwUB-Jg+WXM7A@mail.gmail.com>
 <CAPcyv4hrEsQ0t1hTT1A5WKFqYhANq15n0ru67SLDfGf1ZG-XWA@mail.gmail.com>
 <CAKv+Gu9ofzdrn8AJkXVkiWM+x8=2_ixnC68Y=Gk5KhEi0X35GA@mail.gmail.com> <CAPcyv4jn1UrxodWR77ut9LBGTHa45Q_98kdAhL6wdaHL9V9RsA@mail.gmail.com>
In-Reply-To: <CAPcyv4jn1UrxodWR77ut9LBGTHa45Q_98kdAhL6wdaHL9V9RsA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 18:39:13 +0100
Message-ID: <CAKv+Gu9MMt6FuW+ZuLFMMcA6ku173u4D9g66WaoEafY4i8j2TA@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 at 17:39, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Sep 13, 2019 at 9:29 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 13 Sep 2019 at 17:22, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Sep 13, 2019 at 6:00 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
...
> > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > > index 363bb9d00fa5..6d54d5c74347 100644
> > > > > --- a/drivers/firmware/efi/efi.c
> > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > @@ -52,6 +52,9 @@ struct efi __read_mostly efi = {
> > > > >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> > > > >         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> > > > >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > > > > +#ifdef CONFIG_EFI_SOFT_RESERVE
> > > > > +       .flags                  = 1UL << EFI_MEM_SOFT_RESERVE,
> > > > > +#endif
> > > > >  };
> > > > >  EXPORT_SYMBOL(efi);
> > > > >
> > > >
> > > > I'd prefer it if we could call this EFI_MEM_NO_SOFT_RESERVE instead,
> > > > and invert the meaning of the bit.
> > >
> > > ...but that would mean repeat occurrences of
> > > "!efi_enabled(EFI_MEM_NO_SOFT_RESERVE)", doesn't the double negative
> > > seem less readable to you?
> > >
> >
> > One the one hand, yes. On the other hand, it is the only flag whose
> > default is 'enabled' which is also less than ideal.
>
> Ok, I can get on board with "default 0" being the non exception state
> of the flags.
>

In fact, let's just add something like

static inline bool efi_soft_reserve_enabled(void)
{
    return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
           !efi_enabled(EFI_MEM_NO_SOFT_RESERVE);
}

to linux/efi.h and use that in the code?
