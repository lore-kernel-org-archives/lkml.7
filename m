Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A329C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092AE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TowDe05q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfLLL61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:58:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36525 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:58:27 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so1799930iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0oJIoiBw1HAy8IVFrtDmR1/QvgDH0c+i1iG0jotMWY=;
        b=TowDe05qaCE8skMSSOiYaLK3n4N615X+XiAblLD7alPmNfNN/4tfvWd7nRHBH+FG/r
         wti1+aF7E/uCM6SrmXX+b2ovBxdxnn7M2I2kt/gpqKKZwT0OtyxXBhO5CNUf7pnGyMJR
         KXLMeo9snaPYjH44eJnKrRUWILzlZqSq1guNPyVggaIozy5TW37bXd55Ez41VngO9tVc
         fXfdagD8fvPkUll6GuxNc5wvfGRgMdHjxf4jp1HOzaQapNgRRepplgK2Fwnh8bRnm7L1
         /4USD6DTwJBF6LcrLSIoIwiKclDQRtW0TfrBQzKaPyr2j5bEuht+3f02IDMYc8TqhVpS
         YqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0oJIoiBw1HAy8IVFrtDmR1/QvgDH0c+i1iG0jotMWY=;
        b=SLw7vg6IChWhlkKaLyT7vjFfnFnkmHOWg4cRiSJfpy0tpvWd0eqfjN8cX5aXY0SUmc
         XG3ssB7ENo5mrhdkIruBQqyJHCNngqc5NUvJUZm6XNy+u/Pyx82tKfCXiCt1c0uwrR4h
         UskSoSmUPlO1OLE5eXl0pOffgUktEng4+QgAzOY44g/ZPR32MI4GhU46iGKzY8Wnyu4O
         2LAB9lZN95/XJksKIkdixLexWCnDGWpYj1hwA84sNJrwkouO3umWxrEah7jHtePu8rES
         aYcBoPfpbHsoa1WUFvUyNxv2wri0xo6GmofxR0boyvilzQQC75q0qdqbu67oI3/6ILsb
         irzw==
X-Gm-Message-State: APjAAAXh/MuDSOhwdZ5g6eNU0195rIPAVe8MyBepn3ETJ4cIZq7pRBUq
        ZOThOTG8EwRYQLqktXB5xuMvBO/n5yKqIq1xerM=
X-Google-Smtp-Source: APXvYqz897cj9YRi1yaShZpy9SD2wD+JI3Pofe4iEWPAas1jSR36EGCK0DmowuZgQ6CRcsw/F1lXQAg4f/7L6FoNGQk=
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr7995684ilq.300.1576151906685;
 Thu, 12 Dec 2019 03:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20191208041318.3702-1-cai@lca.pw> <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
 <C9061BAA-DF55-402D-967C-33CF332B10EE@lca.pw>
In-Reply-To: <C9061BAA-DF55-402D-967C-33CF332B10EE@lca.pw>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 12 Dec 2019 19:58:15 +0800
Message-ID: <CADjb_WS=9KrtY1H1xLDTMjGXmxJkAyQuy-xiEktCiSv7Q6GXxw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 2:06 AM Qian Cai <cai@lca.pw> wrote:
>
> Here it only check L3, so it will skip correctly for L3DATA and L3CODE
> to not call cancel_delayed_work(). Recalled the above that only L3 will
> have r->capable set.
>
> if (r == &rdt_resources_all[RDT_RESOURCE_L3]) {
>         if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>                 cancel_delayed_work(&d->mbm_over);
>
> Hence, r->mon_capable check seems redundant here.
>
I see. Thanks for explaining.

-- 
thanks,
Ryan
