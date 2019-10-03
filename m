Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A324C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ACB2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LBzbuYp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbfJCUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:07:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46554 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbfJCUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:07:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so5342578qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQmWIQvPWgrNmobP8k/c9JiWyI+S2EcWGo6gIPosUSA=;
        b=LBzbuYp0/QJLrp4ExrhBFdWOAllnGpXJcZfOrlKl4QTGizEUfZLmt5MUpqLcWH5B5I
         5GCUirJnwU7GJoiPEoDoMwiluzEa4LcRog3ISMkib8uRm/wyGwLMQ3Yc/S0NmRIxyu78
         fU7xUcQ+UgsSq+7BKmPhHpDCYX5s1hl8oSOdd1m2ZYQUyEbeQSnlSuMRfCWagNaOahSN
         VzX5fRahipdQ2R9669a4EwMZRaJBI9Iz8JeFBwM1VTrsDDo02iYuu5cUTSUJhX1h3cT3
         EzHav40TaYV+9PtVuDIG4FqlEAFABolaD3SHuT41vXZZSVtiLaY/SoWxTbEybJ7Uzgrz
         4ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQmWIQvPWgrNmobP8k/c9JiWyI+S2EcWGo6gIPosUSA=;
        b=YDOMlepsiQMUnmutO4iw7YzTJPUb38jwQVQQRPgsgbiI2zdGVHr8CRMVFdktdgZtFV
         El8yXj/0GimTJJ1vaKbh+iPI9SolEg19dpxbqQ3Vfun+1leK2E+mFzXMnFInqD7/+vhx
         SdU6CpVlErFili1RvzYx5RHJYUv28BB/kEqdG+zJ2Dz0DBwbmkT9LVQ46QCBpSQHypRu
         OWgKdRtlDywSv60J8IG5m5RWhtz6NbyqE4uF1krJOLlgNMGxQH2XycrYriGScO5V6/tq
         m48/lpp7X6yXSBObyiEGDJYyaPlKg4l9MkgYDZxR/PRD6CEEF32ppSAsPmu4rHphP2vC
         2tiQ==
X-Gm-Message-State: APjAAAXHmnzaZjWgVsmJ9IN+yJd3DcZwpsYO/zXD8pD0zDa/6VdAt15w
        gKAwJ0zm/IwRzSveGkDQQz5rcBFnAZI=
X-Google-Smtp-Source: APXvYqxz8n07C4LofXY2/+6/UAmUwa81QaKyjkEdj05B7YvXTklKuip3EMzmnZjhThdoqAftrSabzA==
X-Received: by 2002:ac8:641:: with SMTP id e1mr12194370qth.368.1570133269115;
        Thu, 03 Oct 2019 13:07:49 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i30sm2769086qte.27.2019.10.03.13.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:07:48 -0700 (PDT)
Message-ID: <1570133266.5576.268.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in show_slab_objects()
From:   Qian Cai <cai@lca.pw>
To:     David Rientjes <rientjes@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Oct 2019 16:07:46 -0400
In-Reply-To: <alpine.DEB.2.21.1910031255100.88296@chino.kir.corp.google.com>
References: <1570131869-2545-1-git-send-email-cai@lca.pw>
         <alpine.DEB.2.21.1910031255100.88296@chino.kir.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 12:56 -0700, David Rientjes wrote:
> On Thu, 3 Oct 2019, Qian Cai wrote:
> 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 42c1b3af3c98..922cdcf5758a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4838,7 +4838,15 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
> >  		}
> >  	}
> >  
> > -	get_online_mems();
> > +/*
> > + * It is not possible to take "mem_hotplug_lock" here, as it has already held
> > + * "kernfs_mutex" which could race with the lock order:
> > + *
> > + * mem_hotplug_lock->slab_mutex->kernfs_mutex
> > + *
> > + * In the worest case, it might be mis-calculated while doing NUMA node
> > + * hotplug, but it shall be corrected by later reads of the same files.
> > + */
> >  #ifdef CONFIG_SLUB_DEBUG
> >  	if (flags & SO_ALL) {
> >  		struct kmem_cache_node *n;
> 
> No objection to removing the {get,put}_online_mems() but the comment 
> doesn't match the kernel style.  I actually don't think we need the 
> comment at all, actually.

I am a bit worry about later someone comes to add the lock back as he/she
figures out that it could get more accurate statistics that way, but I agree it
is probably an overkill.

> 
> > @@ -4879,7 +4887,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
> >  			x += sprintf(buf + x, " N%d=%lu",
> >  					node, nodes[node]);
> >  #endif
> > -	put_online_mems();
> >  	kfree(nodes);
> >  	return x + sprintf(buf + x, "\n");
> >  }
