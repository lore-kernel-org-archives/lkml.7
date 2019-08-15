Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E52C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EAE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4SzC/FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfHOO5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:57:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UtWqCtB9PpyWQIYQ9Bi5TbzICHIqvshf8py52+rLl2U=; b=G4SzC/FI8VrUVgg7x5ogth9Nh
        eAj/6iV92t37KP0hcby0OvU4pn8r6qqwRQ+mDiAPDs4lpknfHrfHkvHqI9TSiRXds5/waTwwDGfHF
        meMxFAZEAl7Cf8B3VueEMtJ03PDeZzImMALQq+XqBrXv2Wh3O5SAROxdfXpLFnbEdDqoghvy+AKzz
        Aslj1+3wskB0Si6q83aZmd0wXVIj68QrgyZ0M7NabLUSPJ5Jun8mYQIMZueZUzaBuMtHc/Fm3Iw4v
        fgF6wXhvCpPTQdQMHPWud1FNTNvrq5cCkHtEImFxPIsqrSSwAHNS9ER9O9pSyPHqq6VmpUQ4hUGZ8
        KPH0cs0qg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyHCH-0003uM-LN; Thu, 15 Aug 2019 14:57:49 +0000
Date:   Thu, 15 Aug 2019 07:57:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 -rcu] workqueue: Convert for_each_wq to use built-in
 list check
Message-ID: <20190815145749.GA18474@bombadil.infradead.org>
References: <20190815141842.GB20599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815141842.GB20599@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:18:42AM -0400, Joel Fernandes (Google) wrote:
> list_for_each_entry_rcu now has support to check for RCU reader sections
> as well as lock. Just use the support in it, instead of explicitly
> checking in the caller.

...

>  #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
>  			 !lockdep_is_held(&wq->mutex) &&		\

Can't you also get rid of this macro?

It's used in one place:

static struct pool_workqueue *unbound_pwq_by_node(struct workqueue_struct *wq,
                                                  int node)
{
        assert_rcu_or_wq_mutex_or_pool_mutex(wq);

        /*
         * XXX: @node can be NUMA_NO_NODE if CPU goes offline while a
         * delayed item is pending.  The plan is to keep CPU -> NODE
         * mapping valid and stable across CPU on/offlines.  Once that
         * happens, this workaround can be removed.
         */
        if (unlikely(node == NUMA_NO_NODE))
                return wq->dfl_pwq;

        return rcu_dereference_raw(wq->numa_pwq_tbl[node]);
}

Shouldn't we delete that assert and use

+	return rcu_dereference_check(wq->numa_pwq_tbl[node],
+			lockdep_is_held(&wq->mutex) ||
+			lockdep_is_held(&wq_pool_mutex));

