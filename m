Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4DB205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCGF6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:58:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55631 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfCGF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:58:53 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so13452230itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 21:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMjg7ogefe0uiNE//Pw98CIf7/11cpcOHCw9qyKqmfc=;
        b=BZwxrl3hGcaALrw6VPn/yL18jMZrZCTFtXBoWfcsxNzY4+Uw0Jrqq1cR9oNTLqCGSE
         rXzT0/wgcGQwxVVaqQHsMTXpn7JP4LKCtt7pDb/es0eMC9YQOJ5Y0xSmKZfsr0fUllVD
         pPh3KeWCu5IwUmg6kMVrSwVwH2yGeHhMgA56bIGGD6wtLmnlIGO008HO1HBIs8KPm2Wx
         XdYaezwKSNzV0yQ6OXnr4YdoXRHpsEUiiov9f6tS1dvr5smeX04/sAIRvb2Om6VlLXcO
         RsUgEWKZNUai61fZTosa0pKPO/oRLFjlCBjWCQyQFFJWMobH2PKHtclOFRlcO/fz2gRn
         6ZQQ==
X-Gm-Message-State: APjAAAW+Lc4KVXAR4ELIv7fYQJBOMWHgarxk04/SprM0WmShQBG2WfEU
        0DdAT/iB0Us7pOnfUypiJxh8jlqhVCS+DDLFK8EcUg==
X-Google-Smtp-Source: APXvYqyJFnK92tHYME0O1FA8D0SPCr27GL0lPrwtleaD23y1Q53uksfh8omEaUor+M+gcV/lGYbpv0RPvO5JQknjMJs=
X-Received: by 2002:a24:789:: with SMTP id f131mr4960128itf.19.1551938332852;
 Wed, 06 Mar 2019 21:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20190306113859.19263-1-kasong@redhat.com> <20190306170346.zs6orsyu327c6m2p@dwarf.suse.cz>
In-Reply-To: <20190306170346.zs6orsyu327c6m2p@dwarf.suse.cz>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 7 Mar 2019 13:58:41 +0800
Message-ID: <CACPcB9fWiEcHZ3j2t9++HWe6a_0y2tvO3MbcvB8hDaFXgOmuwA@mail.gmail.com>
Subject: Re: [PATCH v4] x86/gart/kcore: Exclude GART aperture from kcore
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:03 AM Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi,
>
> On Wed, Mar 06, 2019 at 07:38:59PM +0800, Kairui Song wrote:
> > +int register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
> > +{
> > +     if (mem_pfn_is_ram)
> > +             return -EBUSY;
> > +     mem_pfn_is_ram = fn;
> > +     return 0;
> > +}
> > +
> > +void unregister_mem_pfn_is_ram(void)
> > +{
> > +     mem_pfn_is_ram = NULL;
> > +}
> > +
> > +static int pfn_is_ram(unsigned long pfn)
> > +{
> > +     if (mem_pfn_is_ram)
> > +             return mem_pfn_is_ram(pfn);
> > +     else
> > +             return 1;
> > +}
> > +
>
> If anyone were ever to use unregister_mem_pfn_is_ram(),
> pfn_is_ram() would become racy.
>
> In V2 you had this:
>         +       fn = mem_pfn_is_ram;
>         +       if (fn)
>         +               ret = fn(pfn);
>
> I agree it's unnecessary since nothing uses
> unregister_mem_pfn_is_ram(). But then I think it would be best to
> just drop the unregister function.
>
> Otherwise the patch looks good to me.
>

Good catch, let me remove the unregister function.
Also, I'd like to have an __init prefix for register_mem_pfn_is_ram,
will update in V5.

--
Best Regards,
Kairui Song
