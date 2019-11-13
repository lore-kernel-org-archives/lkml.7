Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69523C33C8C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8EC206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573670710;
	bh=2mHktS8n2bykBf/7+ImIIlHIEX0Wb12mo7wQ2MjiLBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0tz2NN/eIcrizzi415DpbHYtazFAsP+BcxRusgi8gXUit+Ut2XWOuXBzNPnsj1h7
	 SHRqUoAWnTSb0xCHukFwWT7ZD7iXjLiiXqOywdl1+XehyDzvEWhXgHd11ivSgya7K5
	 /aRcQvEwuTFlyTt3UVTUWCp8DduQMqlUJN6fB+Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfKMSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:45:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfKMSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:45:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id q13so2242802pff.2;
        Wed, 13 Nov 2019 10:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytOa/TRpYZHcXnwihJ6zpPIzYpkWSN253EE1mDAjXKo=;
        b=sQyexlwAOOOOJjs6JytY1RmDs1L97RiDZ4+TprM0G9qxAsmXXJ/vdBH953oW7QdsDx
         nCNQhPIy6ef6r+JRrQqFjaUYwxnXf8Dum7BAYt/z7spYKiqP1l8vIOQ40FpcAKiJ7RL4
         /DU38NeMr6Q8p0nLWTzRk80RmpLfp55SvVHVRx/TwN92Bip/AD5XNVE1MV86gN3BJg17
         uILcZ45cavMR9WAeTwbbedH2I+9dCNrcrXa0BLGhgLiUer6RF3/1ZfYK+0dPlAbgDqDx
         xNwlWKSUf4vn4K4I6DDAhtkuOaLuG48ttn5w+ukMyUG76VgW6uxfdSLsWs/vRVulqF3f
         313Q==
X-Gm-Message-State: APjAAAWwZTnuWB4yOxVq/N5lKqLhof9JpeJP6Y6pcoAlkj9QJ5ndUIEX
        XGlMa/wt/ZIQTH6fOkVbxTY=
X-Google-Smtp-Source: APXvYqw6X5AwWUNGodgFhZ6+c75EuWASAsRsHY14mdl8no689akd+8+9HvchuIg7nCAOCno/VfHAOg==
X-Received: by 2002:aa7:9d8b:: with SMTP id f11mr6212536pfq.20.1573670707173;
        Wed, 13 Nov 2019 10:45:07 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 21sm4273627pfa.170.2019.11.13.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:45:06 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 68732403DC; Wed, 13 Nov 2019 18:45:05 +0000 (UTC)
Date:   Wed, 13 Nov 2019 18:45:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Juergen Gross <jgross@suse.com>,
        Tuowen Zhao <ztuowen@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Subject: Re: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and
 ia64
Message-ID: <20191113184505.GW11244@42.do-not-panic.com>
References: <20191111192258.2234502-1-arnd@arndb.de>
 <20191112105507.GA7122@lst.de>
 <CAKMK7uEEz1n+zuTs29rbPHU74Dspaib=prpMge63L_-rUk_o4A@mail.gmail.com>
 <20191112140631.GA10922@lst.de>
 <CAKMK7uFaA607rOS6x_FWjXQ2+Qdm8dQ1dQ+Oi-9if_Qh_wHWPg@mail.gmail.com>
 <20191112222423.GO11244@42.do-not-panic.com>
 <20191113072708.GA3213@lst.de>
 <CAK8P3a3OpiWAep86tOiN1Fj2W7ud5hQ1OLTkBR8ueAKsMHk-dA@mail.gmail.com>
 <20191113093154.GB32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113093154.GB32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:31:54AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 13, 2019 at 08:38:15AM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2019 at 8:27 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Nov 12, 2019 at 10:24:23PM +0000, Luis Chamberlain wrote:
> > > > I think this would be possible if we could flop ioremap_nocache() to UC
> > > > instead of UC- on x86. Otherwise, I can't see how we can remove this by
> > > > still not allowing direct MTRR calls.
> > >
> > > If everything goes well ioremap_nocache will be gone as of 5.5.
> > 
> > As ioremap_nocache() just an alias for ioremap(), I suppose the idea would
> > then be to make x86 ioremap be UC instead of UC-, again matching what the
> > other architectures do already.
> 
> I think it's right thing to do, i.e. assume that ioremap() always does strong
> UC independently on MTRR settings.

Agreed wholeheartedly. What are the blockers from making that happen? Do
we have any left?

  Luis
