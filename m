Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D29EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E21D206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfCFIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46040 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:48:37 -0500
Received: by mail-io1-f68.google.com with SMTP id x9so9529751iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fibil/KEyEKV/Pe+AJj8sCtv+MwHqn2+YsaCLrYWmhg=;
        b=TTYZaE5T9x4eIZ6uitS/pLhCjOIRH7q6Waw8HP3YCk6CeE2NajYVZweRndakhODxqN
         6hHicGDPEEO9kdJLxrnho2AKoz6cW6No5WTue95Vkq5V5HfC1pyTDyDOwIRwb8nxsX0u
         1XKzofDQdtDeK+SBdISNUB3cpZKxD/MiV2bUTokQuESca0XzXs2W0wuiitbXG/pPsWBG
         Cj3MuuoQWMiIswA6ITM3vt+n+TB+Gg+5NXr2PsW2XgkOwPKDzX4LeKqa6MzLchvUAoRR
         xCd2eCRzTslIPtOReCNXa35wa1sv0gMPra4OJL1nDbc383JkOUess1/7T429KzAWUwbo
         JhAQ==
X-Gm-Message-State: APjAAAWXaIjA2pk6uln2CJQUiimpDzA92SE7iDC20t3DJIIVvlLnuWsq
        xwDqkCD2EcqOyV9SDWqy1+k6N6tDXI9K7Y/APC2aDg==
X-Google-Smtp-Source: APXvYqwVPwAF5ieZD0XlNWK5odDhKXDWA7gOX81N8+XfDnGOB410VQD+I6JYm3uLfWU7sha9EHLqBoX2JwMmE77pmt4=
X-Received: by 2002:a6b:f70a:: with SMTP id k10mr2711599iog.68.1551862116185;
 Wed, 06 Mar 2019 00:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20190102105408.7124-1-kasong@redhat.com> <20190123141432.GA19177@MiWiFi-R3L-srv>
 <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com>
 <20190124021744.GB19177@MiWiFi-R3L-srv> <CACPcB9cL_YfwORAhZEzz-C0QdVfXD6UrJ1Dc-eLQjDTJ8zP60A@mail.gmail.com>
In-Reply-To: <CACPcB9cL_YfwORAhZEzz-C0QdVfXD6UrJ1Dc-eLQjDTJ8zP60A@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 6 Mar 2019 16:48:25 +0800
Message-ID: <CACPcB9e5+-3TrZ-nQc37-0nayU0RSMo-T4V+h4nEaHJ8Mqryqw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Bohac <jbohac@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:00 PM Kairui Song <kasong@redhat.com> wrote:
>
> On Thu, Jan 24, 2019 at 10:17 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 01/23/19 at 10:50pm, Kairui Song wrote:
> > > > >  int fix_aperture __initdata = 1;
> > > > >
> > > > > -#ifdef CONFIG_PROC_VMCORE
> > > > > +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
> > > > >  /*
> > > > >   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
> > > > >   * use the same range because it will remain configured in the northbridge.
> > > > > @@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
> > > > >   */
> > > > >  static unsigned long aperture_pfn_start, aperture_page_count;
> > > > >
> > > > > -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> > > > > +static int gart_mem_pfn_is_ram(unsigned long pfn)
> > > > >  {
> > > > >       return likely((pfn < aperture_pfn_start) ||
> > > > >                     (pfn >= aperture_pfn_start + aperture_page_count));
> > > > > @@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> > > >
> > > > Shouldn't this function name be changed? It's not only handling vmcore
> > > > stuff any more, but also kcore. And this function is not excluding, but
> > > > resgistering.
> > > >
> > > > Other than this, it looks good to me.
> > > >
> > > > Thanks
> > > > Baoquan
> > > >
> > >
> > > Good suggestion, it's good to change this function name too to avoid
> > > any misleading. This patch hasn't got any other reviews recently, I'll
> > > update it shortly.
> >
> > There's more.
> >
> > These two are doing the same thing:
> >   register_mem_pfn_is_ram
> >   register_oldmem_pfn_is_ram
> >
> > Need remove one of them and put it in a right place. Furthermore, may
> > need see if there's existing function which is used to register a
> > function to a hook.
> >
> > Secondly, exclude_from_vmcore() is not excluding anthing, it's only
> > registering a function which is used to judge if oldmem/pfn is ram. Need
> > rename it.
> >
> > Thanks
> > Baoquan
>

Hi Baoquan, after second thought, vmcore and kcore are doing similar
thing but still quite independent of each, didn't see any simple way
to share the logic.
And for the following naming issue I think considering the context
there is no problem, "exclude_from_vmcore(aper_alloc, aper_order)" is
clearly doing what it literally means, excluding the aperture from
vmcore.

Let me know if anything is wrong, will send V4 later reuse this approach.

--
Best Regards,
Kairui Song
