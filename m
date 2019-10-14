Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38788C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A620663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKh6mdXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJNKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:40:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32786 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfJNKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:40:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so7857820pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=az0lr6W/XdF3ZKiV6v82Lso/sJPweeXPsw4tU1pOQhI=;
        b=LKh6mdXOmk1Rk/e+bErnSvIAIOp6qKXlfI3C1lJEoII64qJ7jqNokHlM0G8VjXu74V
         mZCe/pqp9WBormsTHQZiC4uYpPdrK5cBjz50YtFMud+JuZ7+4aXK9xu4v/Mnia4MC8Lr
         cKj0pPnkI/ylBVB9VYN4uSshawnA/I8X/dNUi6t72mG2gQ5lLGx0iEBeVs818pkyzDH8
         oTn+WyW69mZUxGHiJjwYAvovZ3dcicMToVUdPGjNBtP/kb5YS1SWgPV8r50taCkHhihh
         ZvjP7TZNh8zEiR2s0xdMd1fqupur7Oxn1PPf+bJqm+g9sA3bcChuc3MlYeC0mteqNOQ3
         oWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=az0lr6W/XdF3ZKiV6v82Lso/sJPweeXPsw4tU1pOQhI=;
        b=Qtz9OrPH+5vV95R8bTDA0Ht0xMpuwegQldiHVcdVeKBvAF5PkwdkYpZdJdbkc2Im+U
         T3rE1t5ZfKL1DuaS5XImkMcKuTlNTUV4j4N1Z7ccziP6L//In/QVm0Yuw3JOoQd2SV8b
         vXW5OIiZThErqJ3L9Ma6Fdoip2/EyPVEcnISbRZpsa+82kdV1tx1653qUS70SaITemZv
         +Ns9zZFtdnd+z6gZPtrBe/t+3PB9hO3ncEhCI6m60UPeFugj3IIyEoVUxEy00RcsP3lB
         0QLpg/F+upGKemZxChATONC9yb3x216VC2MdpRqQkk4NPwdmQU3JSgWBELwLz40gOhd1
         eu/w==
X-Gm-Message-State: APjAAAXcKRK5TSOrylda3kDb1Xv9T8huFk+c0n4E+7Jfl5BCltT2VXcy
        M2pRCDKHRaqNExk+6kjvgr8=
X-Google-Smtp-Source: APXvYqzQlvN4pCU/tNGo0Hma+zMlPZmGaof3tEUp/C2Za0kqSzcWnTuZod3/66dhDh9AsC6eUIBXqg==
X-Received: by 2002:a17:902:465:: with SMTP id 92mr29494485ple.85.1571049640018;
        Mon, 14 Oct 2019 03:40:40 -0700 (PDT)
Received: from localhost ([211.246.68.186])
        by smtp.gmail.com with ESMTPSA id u68sm1119231pfu.39.2019.10.14.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:40:39 -0700 (PDT)
Date:   Mon, 14 Oct 2019 19:38:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 2/3] zsmalloc: add compaction and huge class callbacks
Message-ID: <20191014103823.GA42921@jagdpanzerIV>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191010231143.09e4a2bd52f331efd0c4baf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010231143.09e4a2bd52f331efd0c4baf9@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/19 23:11), Vitaly Wool wrote:
[..]
> +static unsigned long zs_zpool_get_compacted(void *pool)
> +{
> +	struct zs_pool_stats stats;
> +
> +	zs_pool_stats(pool, &stats);
> +	return stats.pages_compacted;
> +}

So zs_pool_stats() can become static?

	-ss
