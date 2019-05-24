Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588CEC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A3E20665
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp7Smd3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbfEXOOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:14:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42040 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403921AbfEXOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:14:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id 188so8782579ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0JaSGWsUOOsyTjzNatwSpIa5L1qUcHPrgbNW+8vGCc=;
        b=gp7Smd3Jd+5pX7F9omsqf2JIeSGIoHCIahJb/dMVIE7rwXs9sUZAuqwyNhVtcZr0Ue
         c5UISRf0crmCFgg3vO8t61ECMxFCbtuVUxL0/mUL2LIrXVPpMDCyYO3lozQ5Yujba8qM
         12WOyekDu7ziSihEYxVTT7BtM6CBDEk1BxA879HbqUDGCifHz+/mwdl6ynerrw5hxork
         wdCJF3HYv/iGYnXj9Ijg1jE5BqEvTFijN1+Qhx3VX/eT95/ElOVrCudNNF/VWM3hBgAr
         H1OsLRDwy6QK9TWuHIzDJCDtvo65s2cIwwMaggHm1ZnwZYLQSdCDwQppSkmNean937tb
         aEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0JaSGWsUOOsyTjzNatwSpIa5L1qUcHPrgbNW+8vGCc=;
        b=hTclPDnAWuM4bXuip0DVZy+NTiKoW+FLHLDhfEaRO7zHfZQVxhgeR3K6ihSY8Jd8pI
         0uLfV1ncvzL/D2eTNXgxmSTUiLXFNdM51DsKpQuHszPNlFG4yJmPgOh/jwzhmTUsDotG
         rFel/GYvjN5FIAL2txyxNbidjcmwy3TjzzP4R2I/yMiZax4zOiIaKA3tuM2me0nZqQWa
         HOQfVrSetngayew/7epOL3KxJcBXfewIU6Vq3xgOSiNjp02p9P1YL/VBzbwsHQiyy7aE
         XU5mI3eqWZ1WJOsmrbXVOG9m285uxL6nJlHDzLO5+P1Z9NbOHLh+Jax3SGXRUr6xLiBz
         6Atw==
X-Gm-Message-State: APjAAAXSkVJ9M/EwO6rOyBRJS25hSbqSlNwo9rsDPzKzCIBucgZFs1Bm
        0ek6JGX8N/Q1c1URqE0eKu0=
X-Google-Smtp-Source: APXvYqwFkQzvO6hWW6ullJJyh+NG3eaQN2NeozeQUBII+qBWXm7fvPmjm1WpPzUVrDmnBipLdflo4Q==
X-Received: by 2002:a2e:8796:: with SMTP id n22mr42220465lji.75.1558707292823;
        Fri, 24 May 2019 07:14:52 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id w27sm645388lfn.19.2019.05.24.07.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 07:14:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 24 May 2019 16:14:44 +0200
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Message-ID: <20190524141444.hrkp5eizlemx4dd5@pc636>
References: <20190522150939.24605-1-urezki@gmail.com>
 <20190524103316.1352-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524103316.1352-1-hdanton@sina.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 06:33:16PM +0800, Hillf Danton wrote:
> 
> On Wed, 22 May 2019 17:09:37 +0200 Uladzislau Rezki (Sony) wrote:
> >  /*
> > + * Preload this CPU with one extra vmap_area object to ensure
> > + * that we have it available when fit type of free area is
> > + * NE_FIT_TYPE.
> > + *
> > + * The preload is done in non-atomic context thus, it allows us
> > + * to use more permissive allocation masks, therefore to be more
> > + * stable under low memory condition and high memory pressure.
> > + *
> > + * If success, it returns zero with preemption disabled. In case
> > + * of error, (-ENOMEM) is returned with preemption not disabled.
> > + * Note it has to be paired with alloc_vmap_area_preload_end().
> > + */
> > +static void
> > +ne_fit_preload(int *preloaded)
> > +{
> > +	preempt_disable();
> > +
> > +	if (!__this_cpu_read(ne_fit_preload_node)) {
> > +		struct vmap_area *node;
> > +
> > +		preempt_enable();
> > +		node = kmem_cache_alloc(vmap_area_cachep, GFP_KERNEL);
> 
> Alternatively, can you please take another look at the upside to use
> the memory node parameter in alloc_vmap_area() for allocating va slab,
> given that this preload, unlike adjust_va_to_fit_type() is invoked
> with the vmap_area_lock not aquired?
> 
Agree. That makes sense. I will upload the v2 where fix all comments.

Thank you!

--
Vlad Rezki
