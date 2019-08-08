Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453AC32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F121883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AXqELdRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404869AbfHHWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:34:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404581AbfHHWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:34:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14so7565555pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UaINewt1Z1ub53/fmkpLGlZdbeymE3MiNso4guK0Re4=;
        b=AXqELdRaeuAw4yCtxRvUBT10Nkboh4FKhBWUqSJc4Wg6avMX/RyV/MVVc+MyZeNPaW
         Rk+B4Gi77tKHuThWNMOXy3hrppnAVEdiqgB2nS7JuET3vvv1hRVMF4ltCMjzMM+F8al6
         5ogxHuOCdsJhSvnyHmtqJ5mKv5E2C5Eu3vwiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaINewt1Z1ub53/fmkpLGlZdbeymE3MiNso4guK0Re4=;
        b=D+57Vbjk6UxoQth3OIPXsH9B0mExd0ttDrZ9HHTLELtm7dwXH51Nvs+voH4FACaBff
         zMgKGmwz3hqaUgZr9ycz+ZOiGUs3d2om0ARWtBWufS98XEmc4k3FDRsda1TB4TswBH9m
         laAkqpnBydPehO1kVCDdb9YydvStOXRYYV+VBVq28GwQGWGz07ZKBga3IqNj19bgbtI7
         V1bNbrL8HowcW7ca7dScy8IjJjIxHOol4+6V86/tIQIMsmVnH7ePXu9QeHWhsDf24Lew
         QqXxymwoTEi9jSCxBLfqatw88H3mbXlqd+HnlQRqmBL1B4FCmexQw7IRrdJK/ho0PUV2
         LjeA==
X-Gm-Message-State: APjAAAWRQuFVpxzsyXkaA5praXRNn1V3z+JbjHSc2x30koVhOfhqzNnn
        e0DGXTP5wAgPE6qbSU7+MF9VdA==
X-Google-Smtp-Source: APXvYqwI67kPTUIu6gmXzf0s0DGFP1Y80kF3TBJs9NHXQzhinq6L4NJoifd0COhot62fYbqGRoLNUw==
X-Received: by 2002:a63:d002:: with SMTP id z2mr15092618pgf.364.1565303658035;
        Thu, 08 Aug 2019 15:34:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x128sm142523949pfd.17.2019.08.08.15.34.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:34:17 -0700 (PDT)
Date:   Thu, 8 Aug 2019 18:34:15 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808223415.GG261256@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190808102610.GA7227@X58A-UD3R>
 <20190808181112.GQ28441@linux.ibm.com>
 <20190808201333.GE261256@google.com>
 <20190808205129.GU28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808205129.GU28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 01:51:29PM -0700, Paul E. McKenney wrote:
[snip]
> > Also, I am thinking that whenever we do per-slab optimization, then the
> > kmem_cache_free_bulk() can be optimized further. If all pointers are on the
> > same slab, then we can just do virt_to_cache on the first pointer and avoid
> > repeated virt_to_cache() calls. That might also give a benefit -- but I could
> > be missing something.
> 
> A sort might be required to make that work nicely, which would add some
> overhead.  Probably not that much, though, the increased locality would
> have a fighting chance of overcoming the sort's overhead.
> 
> > Right now kmem_cache_free_bulk() just looks like a kmem_cache_free() in a
> > loop except the small benefit of not disabling/enabling IRQs across each
> > __cache_free, and the reduced cache miss benefit of using the array.
> 
> C'mon!  Show some respect for the awesome power of temporal locality!!!  ;-)

Good point. I will try to respect it more in the future ;-) After all, it is
quite a useful concept.

thanks,

 - Joel

