Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABEECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682D220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKE/qWvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfJNKf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:35:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44035 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbfJNKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:35:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so7823346pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBxhSOhGoBq865LLyCQ9HRQenV+KPGNi6KV33B0fJwk=;
        b=hKE/qWvVJ+nBCGXp08FZ1EhL0d/2DPj/AgqTRDupb+P51bWIiyZU/69pZfcptrERTc
         vScq0gMH/PVrKAIJsdH9B69bFNH0j5EWNQk+hKVy3H6ipxIyv0yKReMhi8a2H/OJOX5D
         cyHXukI+kjUhp0cAgZEnT39S06eg/3ZQS5WzNW+TNa6u3avSgTUUkbAl930dxBp4Bl0i
         QKxaKJg4QKHqK4KsN2cmo1wXYDZT4uthupXa0werf9bJCleNMbKPQ+zlWGNUIEYghwxm
         anxreqA+qVO5s7VXERhGj6XiFspq7IIso5zKAGb/9FrSacDrLjA6zr8lZUiC0b725X1Z
         e0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBxhSOhGoBq865LLyCQ9HRQenV+KPGNi6KV33B0fJwk=;
        b=eNFo/xdeO9v0iTotzaniHv0Ll9RsAXQ4uGtbdCDrwp2cFTQKypXpl0gsEjxfoSKjLZ
         yqhny3r36f+YDB/9BjO1d5GG/FFItHVcu7dwooxYX2i/lCu1y9IsEpTvmKyESlwDteSx
         nH4kGLqvRFUYJaKLtCDl+MSM4CeIWZJuZN39nnCBd3iAZjGg0LJV2HcgWifTdyHLJUXK
         xQXj4fha+omd7Oo9ePTlCbSrjImSET90c8jlbgGqWxhcoCc30KN/RT9nA5XY0GwFxzhs
         8cAxPl/uAUBtI14sfVrksPUDcsoemcdT7HEbsFdgc682PTqHElJN8xYnil9hhOphSMBr
         Vfqw==
X-Gm-Message-State: APjAAAXJ45DTTY0pYCB89YTaCos56xc5/dmlzNUyRmveaXCwUTqkMSPy
        EaJUqDES2u+16NnvIQET23M=
X-Google-Smtp-Source: APXvYqxwFQ5rWEaHyO1+CQZGJqSJ7RaE3hT+S5ikE/d9iGfP2L08synqCGkRUuyXAhI2gMzWb5KLKA==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr29484930plp.221.1571049357916;
        Mon, 14 Oct 2019 03:35:57 -0700 (PDT)
Received: from localhost ([211.246.68.186])
        by smtp.gmail.com with ESMTPSA id k95sm17287237pje.10.2019.10.14.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:35:57 -0700 (PDT)
Date:   Mon, 14 Oct 2019 19:33:41 +0900
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
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
Message-ID: <20191014103341.GA36860@jagdpanzerIV>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010230414.647c29f34665ca26103879c4@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (10/10/19 23:04), Vitaly Wool wrote:
[..]
> The coming patchset is a new take on the old issue: ZRAM can
> currently be used only with zsmalloc even though this may not
> be the optimal combination for some configurations. The previous
> (unsuccessful) attempt dates back to 2015 [1] and is notable for
> the heated discussions it has caused.

Oh, right, I do recall it.

> The patchset in [1] had basically the only goal of enabling
> ZRAM/zbud combo which had a very narrow use case. Things have
> changed substantially since then, and now, with z3fold used
> widely as a zswap backend, I, as the z3fold maintainer, am
> getting requests to re-interate on making it possible to use
> ZRAM with any zpool-compatible backend, first of all z3fold.

A quick question, what are the technical reasons to prefer
allocator X over zsmalloc? Some data would help, I guess.

> The preliminary results for this work have been delivered at
> Linux Plumbers this year [2]. The talk at LPC, though having
> attracted limited interest, ended in a consensus to continue
> the work and pursue the goal of decoupling ZRAM from zsmalloc.

[..]

> [1] https://lkml.org/lkml/2015/9/14/356

I need to re-read it, thanks for the link. IIRC, but maybe
I'm wrong, one of the things Minchan was not happy with was
increased maintenance cost. So, perhaps, this also should
be discuss/addressed (and maybe even in the first place).

	-ss
