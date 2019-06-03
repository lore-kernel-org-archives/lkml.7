Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA3C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF15271C8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6Luh7lF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFCTTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:19:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41908 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCTTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:19:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so2009687pgg.8;
        Mon, 03 Jun 2019 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1POYuY5yv6TKMl+TVizfTG3p/FI2fRpGzaKg8qUjGU=;
        b=B6Luh7lFrEGKMS0YaCVBv8YPdG1mQ6kipZMlOOIWg7PtGkDH5BzB5dbwoj+XazEPrQ
         gW4udVF7MtZdA8ZcHF04cxCgpkQ1Bq+DjrhRoEue0Qwkffa0UKyhVn5PZvC7IVcn+W0q
         jqKBgtw0etiOYNrWWIaxWusHOxiXee9ERSe2jvi8PwAE8XbNewSlVh9Po8LFTzZu1W4g
         URBPlLPp80M14E+DSIZklLmwiFd9NcKnayxknqEJMYSwethFJ+YjK+IXhoO/vhD5bTaY
         MiuHszmiwHy9XAa3KIJdZDvcPAXfPUzPE7AqYAr8j2favgR6jg2YNM4ih6TJ08VXIxUL
         fEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1POYuY5yv6TKMl+TVizfTG3p/FI2fRpGzaKg8qUjGU=;
        b=Ee+QsZ7ks/J7M3BDK+749+UKFpzdR8aloGRM3LsshzqiF9TUMwSel2PEftz/f+iJSi
         jfIiljzmfH7KyTZBtNHpxTLinjDp6cYjACQGVja7Y0bO1WJqgTinISgblIEAZZb2fe3C
         pFAO5DoKgxpEqRZWBrfy0JtHb9wn4JYIQmHKwYCUfukTM3e+4smWUcGMRBfoVZ91RHDn
         KPpsnP8QoY6BLd/8XlojxkA0QPpU7ZJmvtu3OiT9hZqgJ58RbFKplQMDMeVJu8YycIMD
         R01HLeoyDfCR+OO8Ie4LipMdLYqW2vgwDmG7YDrGrSVSvjffVBYBATlrMad80FcB0oUF
         vDAw==
X-Gm-Message-State: APjAAAVNGmWKu4VG5QQIA4WQ6jp7UPxcywyrAiq2ob0caIvk0zdlg5CZ
        j9Oq6ROuhJw8Aby/qU21lhJ/axBnBqAeWrGp6S4=
X-Google-Smtp-Source: APXvYqyxiiO0bsYaQbImkXitEOhDYoQvgmXhCfueX9MbGIWAyuoj8TggJ5ZITYx8TlJOta8cZTfOSJeb38kdARJg9LI=
X-Received: by 2002:a63:81c6:: with SMTP id t189mr14722226pgd.293.1559589576950;
 Mon, 03 Jun 2019 12:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
 <20190603135939.e2mb7vkxp64qairr@pc636> <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
 <20190604003153.76f33dd2@canb.auug.org.au> <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
In-Reply-To: <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Mon, 3 Jun 2019 12:19:25 -0700
Message-ID: <CAA42JLZa4OgiEYk7d+gM9pu-gvVbOfQj3-VfEb8kvx538-atew@mail.gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, v-lide@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 7:37 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, 3 Jun 2019 at 16:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Krzysztof,
> >
> > On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Indeed it looks like effect of merge conflict resolution or applying.
> > > When I look at MMOTS, it is the same as yours:
> > > http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=b77b8cce67f246109f9d87417a32cd38f0398f2f
> > >
> > > However in linux-next it is different.
> > >
> > > Stephen, any thoughts?
> >
> > Have you had a look at today's linux-next?  It looks correct in
> > there.  Andrew updated his patch series over the weekend.
>
> Yes, I am looking at today's next. Both the source code and the commit
> 728e0fbf263e3ed359c10cb13623390564102881 have wrong "if (merged)" (put
> in wrong hunk).
>
> Best regards,
> Krzysztof

FYI, we also see the issue in our x86 VM running on Hyper-V.

Thanks,
Dexuan
