Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B989621A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:38:34 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKMHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:38:34 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N2m7Q-1hlbYi1CaC-0137fL; Wed, 13 Nov 2019 08:38:32 +0100
Received: by mail-qk1-f179.google.com with SMTP id 205so932969qkk.1;
        Tue, 12 Nov 2019 23:38:31 -0800 (PST)
X-Gm-Message-State: APjAAAXGQYi04OOQNCrBGvn2xoysEPQnFSxIE/CFAZkUilJ01zgCeokZ
        7afjgaI9TdCm1mlYRUi/aVdWxEHjH7v4EVSi828=
X-Google-Smtp-Source: APXvYqwcv3J/m3EiKMnljDoadHXNfb1emGEfcNt/Ep/L32JdSlabgCsOT3L46pVsDG+wtjusUmekE0tuUmfRXOb/k7g=
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr1350982qke.352.1573630711029;
 Tue, 12 Nov 2019 23:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20191111192258.2234502-1-arnd@arndb.de> <20191112105507.GA7122@lst.de>
 <CAKMK7uEEz1n+zuTs29rbPHU74Dspaib=prpMge63L_-rUk_o4A@mail.gmail.com>
 <20191112140631.GA10922@lst.de> <CAKMK7uFaA607rOS6x_FWjXQ2+Qdm8dQ1dQ+Oi-9if_Qh_wHWPg@mail.gmail.com>
 <20191112222423.GO11244@42.do-not-panic.com> <20191113072708.GA3213@lst.de>
In-Reply-To: <20191113072708.GA3213@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 08:38:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3OpiWAep86tOiN1Fj2W7ud5hQ1OLTkBR8ueAKsMHk-dA@mail.gmail.com>
Message-ID: <CAK8P3a3OpiWAep86tOiN1Fj2W7ud5hQ1OLTkBR8ueAKsMHk-dA@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Juergen Gross <jgross@suse.com>,
        Tuowen Zhao <ztuowen@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Roman Gilg <subdiff@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Do/PBleJlliJ44JByLFQnpZN2MQGaavDxduA2RSMxk2d9XUxsDz
 MhNR5O+o1KT6lT83QyJAmtDSKFlm/ce6UmbkAMg+XBt9e/OhZEKqo7QKIngpZLrFB/z5PTA
 uOUWPFC59rpiPD5SF82eIySRIxXNu8s+jrZv4J9IUmR+sha1wqGaUJeGPl3auuBcqLyeOGO
 JwaLXFIsVd84PLj3vk5mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PVVKeHkrBOg=:GISnJR2636PIoqlQ6oiTK4
 LUiw2rVMbscaedCzhdvuDn2f7jVxQVbHR1SNVaYrIVLfw9AgiAMW/bDd75IcTNb+X/G1WysFe
 jPf3tkjKMdBj+QGL8vavmpLQfLz9UVth2BTqShUsf1WzKHJE3QDmc45AnnWQsM14X8nU7yafo
 7z9Wh/8Jq7McfnOqcOtepb/onoAUwnJ6URZ7NXOAfqcT4rWaxwdAOT35xPGim5zomJChhHwvn
 uwQy+FMT/tx+Rhqo+eaUzpsWTwUVUTPqM56P4BXyqhUgamrwTobnE5gnPg51EzvXqyyk/nRIF
 IhNrFYRxzOs80y3pxllQ4FkrBtXFYAczozVNuRRKrEN0UK4zdnvIFt8Ln0K1/b+0CBMl0+iQy
 hQgu7ERZrgiZNnsqE7KdFdq447lc/+J+R2LcA9WFXAZ5MI7nHF1Ox4b6H5BcqwPMb4af/WC70
 VTLqjPllVv8f4j5o+m4AYrxEXubEc5YVrx5xtFpeRrrncT4oOs0lIGCiYIh7yvviSKKoJTACF
 H8wzErg/JhbdI9xQ1VpwDEQuNWf9k6ExpdNzVmJisfiHjqiVCWXdXR3oShJ1SPBF6q+oTxV86
 bq1rcsMCdUCO0ZOmGihaGBfk3L3Msh54gpSluu2Yduz/NDjDF57df+szP0Z2Da/SoC6nuqdxl
 iWIbPnPqYf7pTzymhxcuvU7lyKfZR+OCe7JIICF/MsPAiNZKqgTR/JieNb1e/Hx41CHL+/jGF
 pGeiiCXyMUzn1iCpYHEaj1k5jPNb7pD9Gk4i0umKYXCm5cXQUwH19N+w2sv59HqnMkFlUd94Z
 n8fa5jhdn2tMjwgV5wA4cDVTh2XNulT9pFsP2K7secTs7odLobr/aiDSWC+SSVUVMyme+7NjE
 BODK4Sg9piOzxbtIiPhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 8:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 12, 2019 at 10:24:23PM +0000, Luis Chamberlain wrote:
> > I think this would be possible if we could flop ioremap_nocache() to UC
> > instead of UC- on x86. Otherwise, I can't see how we can remove this by
> > still not allowing direct MTRR calls.
>
> If everything goes well ioremap_nocache will be gone as of 5.5.

As ioremap_nocache() just an alias for ioremap(), I suppose the idea would
then be to make x86 ioremap be UC instead of UC-, again matching what the
other architectures do already.

      Arnd
