Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571071275;
	bh=tVSREjl7zWiwZimzj25OZhFaKiTY+C7HLY8A+4kmgcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1m5xdYkYG90XxcmFjvW2SmZVlj3AevC2OuJGSqN4E50RLdoJ/wIHQodODk5sul9St
	 aqXzgAjHW/vvA0cUDSsT3lxCkt9146/Ux68DDtmA/DmdL75IzE3ij1t0QSXpOk7/Cu
	 K3X3txKxdL59zTbzNNIZ8XTfnvv26TkPmNDLi8RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfJNQlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:41:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39715 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfJNQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:41:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so8245374plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGcjVdTMGCzNncU46yGhvMqxXtCQHqNYV1cWFlBhCFE=;
        b=UTqEumcJsYD/xtVqbGC9RIRyR9f5F7HVeG27AzE/kHX7uxepU/UGPH1Iu+JVIWcsei
         4M2VZGEmn0hHVoY+oy6AmYFrzZ6dl2qMeOe+hQR3mTShX2yHKbl0Xkpz0pxpr5YIZbtc
         mQz8RiLjsH2xQiWN9ruFSYFM8X8Mf8ocSN/XQEPxZU4Rn5ehyLIHJeoMnjIAX5OBZfAe
         sWJvJ/2XoujpgHXAEnX3o0DyiBq0FNMCuCS2i9vb31T68NwVpCUrZ4E4KSkHJhPGz1En
         bSuffD4986jCMaIRgfQhiXgVN/uBCfAs1FuA1dUhwuOXzke2xJ5SlitPeuy74f0Ke867
         epdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGcjVdTMGCzNncU46yGhvMqxXtCQHqNYV1cWFlBhCFE=;
        b=Pys2qSGiFHgBeuZyQSZwv5n6ST2J6kg171ij5LhKZR5y7jsBhYmqYKie80eyKon6Ze
         ipEIqseijRRKVuuVBvUafxcuM75V3ZKiLg7gKXwPaPQFvtxF5wIZILnKTm2Q/gr484tn
         yfVd/VyROWg4POtbxwXsw9c+WtEciRkXKRSzoyMxv5aZM3K6FysNRGE2NDuwbv2bj0SA
         MGWzakHRjQ17s9U6OdDLR5lT96Vh2/4zg3Wwi9+fGnYzwn/JVSzypNwGW4Ac+prKQigs
         3u7QiJYXn70lgIwMST4O+6H2HThL3C3dN68PTH6v9fvtayKkxs+zBfXS4gHznuNW0dFP
         whuw==
X-Gm-Message-State: APjAAAWCiJchpcsfBEa2aqlPTCAnM3FP9ItIw0QdVFmMWkss0+zIFnUr
        cTMM0sKjC0vh869l1446H8Glduvw
X-Google-Smtp-Source: APXvYqzd5KWmsmAG9EcWFiPBH8wBDtIyUECS1hjioVNCNm8B+KDP95qS2EwbmjkQZ+MrWSZfA0u1qw==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr31672319plc.169.1571071273533;
        Mon, 14 Oct 2019 09:41:13 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id m22sm18841635pgj.29.2019.10.14.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:41:12 -0700 (PDT)
Date:   Mon, 14 Oct 2019 09:41:10 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
Message-ID: <20191014164110.GA58307@google.com>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010230414.647c29f34665ca26103879c4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:04:14PM +0300, Vitaly Wool wrote:
> The coming patchset is a new take on the old issue: ZRAM can currently be used only with zsmalloc even though this may not be the optimal combination for some configurations. The previous (unsuccessful) attempt dates back to 2015 [1] and is notable for the heated discussions it has caused.
> 
> The patchset in [1] had basically the only goal of enabling ZRAM/zbud combo which had a very narrow use case. Things have changed substantially since then, and now, with z3fold used widely as a zswap backend, I, as the z3fold maintainer, am getting requests to re-interate on making it possible to use ZRAM with any zpool-compatible backend, first of all z3fold.
> 
> The preliminary results for this work have been delivered at Linux Plumbers this year [2]. The talk at LPC, though having attracted limited interest, ended in a consensus to continue the work and pursue the goal of decoupling ZRAM from zsmalloc.
> 
> The current patchset has been stress tested on arm64 and x86_64 devices, including the Dell laptop I'm writing this message on now, not to mention several QEmu confugirations.
> 
> [1] https://lkml.org/lkml/2015/9/14/356
> [2] https://linuxplumbersconf.org/event/4/contributions/551/

Please describe what's the usecase in real world, what's the benefit zsmalloc
cannot fulfill by desgin and how it's significant.
I really don't want to make fragmentaion of allocator so we should really see
how zsmalloc cannot achieve things if you are claiming.
Please tell us how to test it so that we could investigate what's the root
cause.
