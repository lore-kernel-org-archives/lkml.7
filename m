Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58754C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E72621D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZg/pcZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfJCU1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:27:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfJCU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so2037037plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3cFri6KVLIQj5EYoYgPownlzc5LktQs3mtDCkT6lDwg=;
        b=ZZg/pcZkrAn18xs44NRqTsfTOgRc8tDeRn6GXpfnV5RfV1IDJncidXWJ36mhRDrrvG
         wLghcIFfEbv3CJDMKBi2IMFUkPq0eog7BRNcePIby+w+C3H/mFNR5I0xk0Wrgl8kEetO
         ZcH/J7hVauOnYbV54wlo47uYcBky65U2yW1XjvH/ivgnlTFw7p+d3f2yoAyA0WDNGoh8
         FxRxlMW54QXIsGFg3aKxj+pjVYaNgkQn6TjM+Zm3uYAgZ7WTxPZ3I5cEibwd5Klm01xN
         9aYDkVVPOz1qMyTR+5QoXSxGQTtgVVHHGwoZqaP7jXxkekFTVpJ0Xb2E0i0+JIztUPx6
         P2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3cFri6KVLIQj5EYoYgPownlzc5LktQs3mtDCkT6lDwg=;
        b=YGKXok3nQv6basmrYhXLnVCk1IlHhX+L9bCf8BNzOF3MNHYBICApaGYqmwdF3syjFr
         GkWtn9ZkuRz6DencxdWsBoXf3eBItlBL7H9iiKnVJDZJaqZuHJqR0EYhq7xMzgMPvCwM
         4/yygnPKUtAvcCC1ng1Qx1zsSFl8EFPSKOXPcw13tsZpYL8MWWgXgMbnaVc71Muq/A5f
         otTijCK9elh1IFeco3NZ9AN7zax94mGj1j3jzCDhpFQ/34yFkZfxb+CQ6JxwjfSXv4wy
         b+NFJIa3XR6Bwmv1gQDyu+JtMe5ZQTCWcDFh6KE+S5ZqTjrM6dkVq4GoV2iYwDyw773f
         gJQg==
X-Gm-Message-State: APjAAAWIhjTO1f8hoSmh2uURokn47ic0cf7/94+gDjiMeyxHQZlqc5cm
        DBfXytKkB/IXI/NNnVosfjSuyw==
X-Google-Smtp-Source: APXvYqzOECKLDrd4zEtu7lIKga+pne3GfsvhH/PKAKecsYmJFZX/rLNcQbkhgtroS2kUWeV2LhKb0A==
X-Received: by 2002:a17:902:6bcc:: with SMTP id m12mr770333plt.280.1570134430571;
        Thu, 03 Oct 2019 13:27:10 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 195sm4812630pfz.103.2019.10.03.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 13:27:09 -0700 (PDT)
Date:   Thu, 3 Oct 2019 13:27:09 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in show_slab_objects()
In-Reply-To: <1570133266.5576.268.camel@lca.pw>
Message-ID: <alpine.DEB.2.21.1910031326410.95315@chino.kir.corp.google.com>
References: <1570131869-2545-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1910031255100.88296@chino.kir.corp.google.com> <1570133266.5576.268.camel@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019, Qian Cai wrote:

> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 42c1b3af3c98..922cdcf5758a 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -4838,7 +4838,15 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
> > >  		}
> > >  	}
> > >  
> > > -	get_online_mems();
> > > +/*
> > > + * It is not possible to take "mem_hotplug_lock" here, as it has already held
> > > + * "kernfs_mutex" which could race with the lock order:
> > > + *
> > > + * mem_hotplug_lock->slab_mutex->kernfs_mutex
> > > + *
> > > + * In the worest case, it might be mis-calculated while doing NUMA node
> > > + * hotplug, but it shall be corrected by later reads of the same files.
> > > + */
> > >  #ifdef CONFIG_SLUB_DEBUG
> > >  	if (flags & SO_ALL) {
> > >  		struct kmem_cache_node *n;
> > 
> > No objection to removing the {get,put}_online_mems() but the comment 
> > doesn't match the kernel style.  I actually don't think we need the 
> > comment at all, actually.
> 
> I am a bit worry about later someone comes to add the lock back as he/she
> figures out that it could get more accurate statistics that way, but I agree it
> is probably an overkill.
> 

Maybe just a small comment that follows the kernel coding style?
