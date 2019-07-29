Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49724C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C2206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4n/Ve2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfG2KPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:15:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46373 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:15:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so37372125lfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPIyo6ZhaERCGc0M1gIeXkN33V/RF6TWr9mdkcqr3fg=;
        b=j4n/Ve2qs9zUX8m9pn+L+V/qKo4VL5aMWpGISKBtLjm3O+avmqdzU3595eE0Ms4mKK
         o+4woUNBQyoC7gDWlNVb821q2Tx3/GdfmRCvLybdkLwUnUy9q6nhcxRTopvmPsJo9L9Z
         ptIROmTc8FKqF8YglLVX5XM2wSkKI64wbZjUi7W2RM0XjFtMT8ufy1ZxvHgb9YEK1Us+
         L+a0Txhg7gnhNaHoGuPqOnLALfhx7g4ExRFWehKgnNvMgWkiN0zF1e7bcQxIJXPaA0N2
         t8NjiNMKi965YgjRyB8t3RlNCHuUFYg6SyoFyLN1RmOTylxDiyd6Fgq6PzugkAkQGZtV
         GV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPIyo6ZhaERCGc0M1gIeXkN33V/RF6TWr9mdkcqr3fg=;
        b=qxCAL9IPmgK7+Gib1xxTKGOA8Nai51NoBDViM8w/cJ9gfc8YR4RKeWaFz7uPvynyRg
         wZb6oQGU1rxfDL0piYHxy9BWStccdNlZTUrr3KxDGapDIJLkjhOgAdj2Dyb0nt8bPmq0
         EbBz3/0EnlDqwc47IjyD5NE5aeuexSoolONEmBHSMDHLWg2Yxxoe5ac5iXozlT8bbWuo
         x9vqfYBvdQaO7vV0cKiy8bGBWunwygrQX+qQ7lRU9qgZGiDBdv/juO5fQEZnwbchRAAR
         6TN2Pw857yl2p+cbrmI8IzoSd4abcoyOBN+LB2c5WloZU4pew9REZE6hDT4NRcP3jRfy
         Z9Fg==
X-Gm-Message-State: APjAAAUBfcRYXSeM1HMcfjKWduc2saMlCQSFmK1AVT+CO1sj775UA+o9
        ntMAOAFd392eQK9nOIqbQnnoecjOCRMpdA==
X-Google-Smtp-Source: APXvYqyvpwW6fjtgFZFln0JtjqHzl0ezFCTCDBdJF/peJVsuEKJ0QYFLoAtYLzS6TJpWMByPex9Vdg==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr51731544lfm.143.1564395311059;
        Mon, 29 Jul 2019 03:15:11 -0700 (PDT)
Received: from pc636 ([37.212.210.176])
        by smtp.gmail.com with ESMTPSA id m5sm10500543lfa.47.2019.07.29.03.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 03:15:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 29 Jul 2019 12:14:54 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190729101454.jd6ej2nrlyigjqs4@pc636>
References: <20190703040156.56953-1-walken@google.com>
 <20190703040156.56953-3-walken@google.com>
 <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
 <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> --- a/lib/rbtree_test.c~augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fix-2
> +++ a/lib/rbtree_test.c
> @@ -220,10 +220,6 @@ static void check_augmented(int nr_nodes
>  	struct rb_node *rb;
>  
>  	check(nr_nodes);
> -	for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
> -		struct test_node *node = rb_entry(rb, struct test_node, rb);
> -		WARN_ON_ONCE(node->augmented != augment_recompute(node));
> -	}
>  }
>  
I have a question here it is a bit out of this topic but still related :)

Can we move "check augmented" functionality to the rbtree_augmented.h 
header file making it public?

I am asking because many users might need it, i mean to check that the
tree is correctly augmented and is correctly maintained. For example
in vmalloc i have my own implementation:

<snip>
#if DEBUG_AUGMENT_PROPAGATE_CHECK
static void
augment_tree_propagate_check(struct rb_node *n)
{
...
}
<snip>

in order to debug and check that nodes are augmented correctly across
the tree.

Thank you.

--
Vlad Rezki
