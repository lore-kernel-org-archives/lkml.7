Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E19620692
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xhvs6Ahg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgABQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:52:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34811 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgABQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:52:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so13146719oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njeWI+KAXYGUA6SsOkGlHRQz/PusOL22Pz6zm9pBi9Y=;
        b=Xhvs6AhgXjGPRJsGfLuOFsppL+pozXfXVOU94GdDcR+GCLskgSifoDz6bhAyaf3vGO
         DTjfr6X1g4RPDJDWE50mJzNFZuvnK/PLp6pRtnbCtiZ4HMO9xY8D930q/NXrz5qJcoyx
         LwNnmJlxvzfsDBeydPVcy9fsp4QPUfQ2ZVQ2GyG0IcPQc8XT4YSEGOQ6B6yTcU73XawV
         A0XAjH+JbCqVSIgrUU62QilwC80dKWbtPOJHYGS/1qX9gNeKMZmv9nirN37wvJzlQWmI
         tYEjl56qUTM8ZTxvtN5BxDQUmEQGQCGiy7uxKzkWnBXxhUA8Byu8aCb90J92OBoSPHic
         XN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njeWI+KAXYGUA6SsOkGlHRQz/PusOL22Pz6zm9pBi9Y=;
        b=qUDGWoLb2CK02sh+kOrOB473iP/ILqV9FZ7RMI0EkyG1ITa7Lg9Krq8n/+6fPL8GDE
         rrAlWfjDewswz4bxVrfH6uL+lmLTxykczqM7qzTqAzGlGjZkfJGDKttf/mjXKk1+LeqS
         Y6lH5YSWGPSFxD3+2rgZNbvrbYcgUw2LRpgWISED7W/Kgws5L7CORatgaLbFHunZ3SSU
         vbYho5HLy7cYe5B70vhJECQYCY5P0Ta8/nYUm9isot/DNWWtmtZNnaMymQyh/QnNn0LY
         8zXHYvaOnB9fDIGZTBWKirJJ19tNN7362+9DEmaeGyxvPyuP7MAzHhZenAQ2LvrhmpLB
         dnlA==
X-Gm-Message-State: APjAAAWQcbtYXu1AwD+Vs4iphXsyctXIGuZzi87yMFXzHJOIB/0Lb2o1
        Q8M5FhLNOciFWCRlAqtWjpGlsPmE/BIqXWqm4ZxnNg==
X-Google-Smtp-Source: APXvYqxkHVXPzwBP5FjB7HOCG9yhSpwOndx0XG+99ptP3w5zdLYdS9SZYSTw7ERXDIyHGV4uDOuSYOuaRKiTw6Tmdjw=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr2382287oie.144.1577983952440;
 Thu, 02 Jan 2020 08:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20191220164358.177202-1-shakeelb@google.com> <20200101101708.GA14315@zn.tnic>
In-Reply-To: <20200101101708.GA14315@zn.tnic>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Jan 2020 08:52:21 -0800
Message-ID: <CALvZod6Tt=-8QsXy1qR-xEnitF4peWhRsUN9n1EkPpSvBXdy9g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/resctrl: Fix potential memory leak
To:     Borislav Petkov <bp@alien8.de>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 1, 2020 at 2:17 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 20, 2019 at 08:43:58AM -0800, Shakeel Butt wrote:
> > The set_cache_qos_cfg() is leaking memory when the given level is not
> > RDT_RESOURCE_L3 or RDT_RESOURCE_L2. However at the moment, this function
> > is called with only valid levels but to make it more robust and future
> > proof, we should be handling the error path gracefully.
> >
> > Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> > Changes since v1:
> > - Updated the commit message
> >
> >
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 2e3b06d6bbc6..a0c279c7f4b9 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1748,8 +1748,10 @@ static int set_cache_qos_cfg(int level, bool enable)
> >               update = l3_qos_cfg_update;
> >       else if (level == RDT_RESOURCE_L2)
> >               update = l2_qos_cfg_update;
> > -     else
> > +     else {
> > +             free_cpumask_var(cpu_mask);
> >               return -EINVAL;
> > +     }
>
> And why can't the level check happen first and the allocation second,
> thus needing to allocate the cpu mask only when the level is valid?
>

We definitely can. Will send the v3 patch.

Shakeel
