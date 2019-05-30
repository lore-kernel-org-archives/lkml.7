Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC652C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E1225925
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WphGl1Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3NB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:01:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37027 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3NB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:01:29 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so9189525ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k26iPE69aDeRJ/TfJMi2xpp92kbi0U4xCxUWiVs7as=;
        b=WphGl1Sf6fzQ5jmCKxG+7grtN+HSI+I2CbYW3nTKyyRsxXivZY3CbJstwRN2lW1Hpg
         Q1euynYgPCjNhWdkiFlZMHJCbIvQK+nuZMSl6u14Ua/WM1W32n89KbzpA3Ji/bKS0WVx
         pS8bh9XPnx90axfb1lbtb+/Rh4qC1QLre71ZMO/JpT1OscgelytRHiKDNwLTnclG7iB8
         CPsDxnl/ZQuNrRm8bCEzRTC3mi0h/gfUMzKyOWBBK19ArcgQaoC3wb/YrZan7+arWkhB
         9vtBDJsnoo3Bz8xs5JDGvrnvbd9KXs7sprcxdh6aiQJAJP4rJ5O5uFtiwn8Q6oVK72fL
         UNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k26iPE69aDeRJ/TfJMi2xpp92kbi0U4xCxUWiVs7as=;
        b=EsKPmhlJoGrkYBnAE2jUYRM2OQ7BKXaG8HLLHTurEEWrQYTyIQTdvDci6CxENrfuYC
         3awfrGf8fgyJihT/Urx/9voI8rL63PxM3XhbLsFuSDr0Ato6uTI7g3jRykuOmW1z6ze/
         C2SFPp2TUUD5TzqmjWBge7pKBJWZSDwqQObL+OwL94oz6o0joZ7b0kVNQ+2IXzTT6v0m
         JoRel5qBAc0sKCJa6UiqG3fYhC6T98t9vZiblF4TWlLl+kWOvyse6eWL8iPV1s7xGPIR
         Hzar3KjyTAm/FsX8tdblw8HQrSAZZm2KlO4SoNxa5B3B+tlA55gLO+ImBfwy3S1XGBkM
         RNjw==
X-Gm-Message-State: APjAAAUUq6/MBBZUI161DgLWBQPNodqbJLuTXkIXbWd4BmtHuyhpDWfy
        Tu3T++To3zUyxTNf0ktChi7o5nAV9c6w74jRSA==
X-Google-Smtp-Source: APXvYqyrXRL7AXGoD/ei/cr9ondS6PAG0j2w5hheO9H6XuZGbphAwizf1ReoGOh5ZnhOWsEZ1sVstzZSDvcfJ7z40js=
X-Received: by 2002:a24:5095:: with SMTP id m143mr2653331itb.68.1559221287791;
 Thu, 30 May 2019 06:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190512054829.11899-1-cai@lca.pw> <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw> <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw> <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz> <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com> <20190528182132.GH1658@dhcp22.suse.cz>
In-Reply-To: <20190528182132.GH1658@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 30 May 2019 21:01:16 +0800
Message-ID: <CAFgQCTsJgVjB-Bf22tZOM2fzKEdd0W0vmMdnZE5FxEYfV0p4Mg@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 2:21 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 23-05-19 12:00:46, Pingfan Liu wrote:
> [...]
> > > Yes, but maybe it will pay great effort on it.
> > >
> > And as a first step, we can find a way to fix the bug reported by me
> > and the one reported by Barret
>
> Can we try http://lkml.kernel.org/r/20190513140448.GJ24036@dhcp22.suse.cz
> for starter?
If it turns out that the changing of for_each_online_node() will not
break functions in scheduler like task_numa_migrate(), I think it will
be a good starter. On the other hand, if it does, then I think it only
requires a slight adjustment of your patch to meet the aim.

Thanks,
  Pingfan
> --
> Michal Hocko
> SUSE Labs
