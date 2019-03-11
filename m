Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430ADC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12860205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="m+QpA48G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfCKRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:17:51 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35280 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:17:50 -0400
Received: by mail-yw1-f68.google.com with SMTP id s204so4527924ywg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=coypjIdy1AhrlMMPmLcrE133h5i+xJ7VOPTW+kFU1II=;
        b=m+QpA48GMQIe1hT9fTznaJRkf3YbE8aOm/OOlEg2dVAcY/KWKLhrNJpy/aWney039N
         qDjBNNH9fkjedCBvxSKRUca9GoV1Ip6SIJ0j6lgOCN+nW0Uni6wl4ukR9ATuTEQX+7C+
         hjx1tEKy2bhfp6DSkOiegI9EFQZPn9Mc7btFHTquFFoa1U0DBfIPDA9mDDBr03Pc+/AW
         7EKklnSR2t+Y4HjbQkE0wRYsm+fLx2ywt9P7B+kmDnzqIvB92JERjJ2Z2VvYdHECNhri
         i+s4JB46px05c6oIiZI1wzjitv0h+ZVq6h5pYiycMaWG4UaWYmdmHz/b4aF3WVZYJhhi
         66QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coypjIdy1AhrlMMPmLcrE133h5i+xJ7VOPTW+kFU1II=;
        b=Wawji9sO96+AJ9VfCPA/4RKWo9UNy3bKSNejLT4R/fIXFC9Zc2UgtJEHczd6IDUqLd
         hbCCdBytBHr9XiRkPTIX/j9W+/WqVIQ8jOqao8nTltzb9lOYFwiXqRqBOzVL80tEBfvD
         fnO6eFa7tpUFzdgkR2Aw6oByyi5sH1Do6SexUyoZqat5LfEKRa5LbHmCyTa5fchp8afs
         SzIqqhDepCQw6tkpZX6MHXb/VM9KlM86x8POBUShyyLReA7+sn7GS0WJlpCtNopuVauD
         Obef5o6xdbfnTvPbZzV3DIyj3QS64dxzeOsYivNUQo+YXjX+zXPPHMrQ5WHbLMJA9hzn
         aUew==
X-Gm-Message-State: APjAAAW86mRvtSZtn6aah03IluXs/v33tPBBJxI5QY7trpmU9XGRjvz1
        jyVBpOCYq2L9aPkfQZCidodrTAsO5rY=
X-Google-Smtp-Source: APXvYqzdSvWmEohVstdTHunGgf8/GkwwFsOaHjn4qRw+SGWZ56Y0Yk/SdJ2gfe7XAxj0V7d5Qz7SrA==
X-Received: by 2002:a81:12d6:: with SMTP id 205mr27213496yws.338.1552324669939;
        Mon, 11 Mar 2019 10:17:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:3c60])
        by smtp.gmail.com with ESMTPSA id f131sm3096720ywf.93.2019.03.11.10.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:17:49 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:17:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 2/5] mm: prepare to premature release of per-node
 lruvec_stat_cpu
Message-ID: <20190311171748.GB10823@cmpxchg.org>
References: <20190307230033.31975-1-guro@fb.com>
 <20190307230033.31975-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307230033.31975-3-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:00:30PM -0800, Roman Gushchin wrote:
> Similar to the memcg's vmstats_percpu, per-memcg per-node stats
> consists of percpu- and atomic counterparts, and we do expect
> that both coexist during the whole life-cycle of the memcg.
> 
> To prepare for a premature release of percpu per-node data,
> let's pretend that lruvec_stat_cpu is a rcu-protected pointer,
> which can be NULL. This patch adds corresponding checks whenever
> required.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -4430,7 +4436,8 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return 1;
>  
> -	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
> +	rcu_assign_pointer(pn->lruvec_stat_cpu,
> +			   alloc_percpu(struct lruvec_stat));
>  	if (!pn->lruvec_stat_cpu) {

Nitpick: wouldn't this have to use rcu_dereference()? Might be cleaner
to use an intermediate variable and only assign after the NULL check.
