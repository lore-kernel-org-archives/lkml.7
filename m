Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565812128;
	bh=1N5gU8uyH02TkxYY2pZ03RCyDmlcbzBaQYQ81LPTtfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HlbHOHGumSuE6VYHqEIuk2wUS+/FKu+g9iEz7ovnnxQG9ymrpT40hRHBnZz8h9nyz
	 6BVfgAINUrSV5vtYbd27xluZIEA9wj4kFeUo2owIqOjkttuOBN4Vj7N+HVvAMR2Bph
	 npYvObNrE85qxryLb6ashExA0OD55hly0D+LQ5c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHNTsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:48:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46347 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfHNTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:48:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so17893865qtl.13;
        Wed, 14 Aug 2019 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+NpxItK9aS/xYUHc19cIXbBjQsj9PCaTtwg1/PRguPs=;
        b=gp1xFFBgUBFZ4TYMm+kXV8JJTUS7iPmtY7W8+yxxpRtugK4nCkmGGDpXFVon1m8mVC
         bm+SOclA6mhsqCkQfQJ0ZdiAenWK8U4e5roAij9UjC/+6uN3jYskpqVkhWLPWjOfTlt0
         /X8lFgT/oBFKnKKOL88kfUvG06ZQg8rJsNpIO4/b75msNJgN4xG8EhyQWDE6qmuAorbx
         opdECp5aoXmmxWAJwNIO4xGoVnauLAFDKb3WIrJTi61GnRCsnVXPLadp/gyU9/NH4k5v
         QIrC8ygJEIUFUMZkxoGVwpVgf2HuV5UrDvom6DHtFO6ArsFDiyDSU3HrsMMPYQ3zNpdq
         5zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+NpxItK9aS/xYUHc19cIXbBjQsj9PCaTtwg1/PRguPs=;
        b=SeB82axSQB/WcXoWYP8b474ov9IyDAXVTARTwPsRo7890lLYu4DNFYs/+/RhBL5+Hr
         CZPISNiFtL6i5ROw2GrLzVNzRdZ5t2X6mhIG5ld4CqHWSR06ys5IRkFOwB71WfX+VRFF
         94k6dsA5VpgsWSp9LMNGTC+hR/0ICwC1DIS2yxU/iXOjEGOgrK/M1LWF7iuZekdioevC
         KZBo05zQZ2gdUTvu4LiAw2+ji2mmMPzFALuTVmeHBdZBy2p8vpOGp+6AS0QHACfFcVkv
         E1+SX1qK9+aPKmV34YK/BovSolQFlRNjkxokVeUKHIE6W/e+S/n5frFFse8UhNidmYU1
         +Y2A==
X-Gm-Message-State: APjAAAXwdLWW3bGfEjkkrK74dxOsjKcqvRexXntOsOf5E08uY1sh5RwP
        NTkDBTYvuZVYQeVQ2uux6B9dYngq
X-Google-Smtp-Source: APXvYqzzVTYsS5Mdbl96fJs/u3ynraECAWR+6GU9VUyKLvzpW5WpqGNNTGa+U16tVWRWgHpehff8Mg==
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr953161qtt.200.1565812125788;
        Wed, 14 Aug 2019 12:48:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::b706])
        by smtp.gmail.com with ESMTPSA id 131sm391045qkn.7.2019.08.14.12.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 12:48:43 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:48:41 -0700
From:   Tejun Heo <tj@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] workqueue: Convert for_each_wq to use built-in list
 check (v2)
Message-ID: <20190814194841.GA588936@devbig004.ftw2.facebook.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811221111.99401-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel.

On Sun, Aug 11, 2019 at 06:11:09PM -0400, Joel Fernandes (Google) wrote:
> list_for_each_entry_rcu now has support to check for RCU reader sections
> as well as lock. Just use the support in it, instead of explicitly
> checking in the caller.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Tejun Heo <tj@kernel.org>

>  #define for_each_pwq(pwq, wq)						\
> -	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
> -		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
> -		else
> +	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
> +				 lock_is_held(&(wq->mutex).dep_map))

Why not lockdep_is_held() tho?

Thanks.

-- 
tejun
