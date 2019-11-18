Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A722063A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CFzGLpEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRTEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:04:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42526 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:04:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so10054828pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g7UeeAiDpLXIZyawULy9LChbDuT/bywV3sjowK/21oA=;
        b=CFzGLpEvo9h0wavIJ3BvGjj0jIxdJfl3uvMW6e/3/t2n6cMtudA+A4GFwZADhoL3E7
         z2YU0QkdAvSVsIByFtEpc8VmgrPBUyOtNkkWDXcSgqDMLrgm/16SLQ6Qy2wg++nqoQ8u
         voZe3/N/5SNSh94yGyJbvTZV/kWNwLyQMNDC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g7UeeAiDpLXIZyawULy9LChbDuT/bywV3sjowK/21oA=;
        b=WXhaYu67EJhXO+lX1Cx1m3ctdSxOYVD0Mv7yvg4hN6ePzRvqjN3cHNW6w+kq8HHb5r
         3waHu0Fj2KR1RriwhM4shra6UqBtIulpoqTCgztV5/F1F+cmV4euasutx72KmZeki5gL
         mLu/3GTs5OY62hrUd1HQ+DSbN0YwI1LodF8JbgmWV4iMNQJr5HZM2Igx8g0aZH0zwmD4
         8MK5KmP/D7ezXl/KVo2WFCOE9seVtBzugLJEaXNtHxGisoFiMDaopk48h/xvfi3wW1z9
         ykkUIJHTHpjg2q4Emm18SzS251xprL4NUPNYRG5GgPc/oAz93uM7YmeHDJVkZcVMKIZZ
         E4hw==
X-Gm-Message-State: APjAAAUeeV6lHcY+pI/QIR4mfWv6qmEcjuo2epN2wJpz8xX0Y3c+AymH
        F5iF65DcG2qV/2ZGRRBqkJpMNGtGMhc=
X-Google-Smtp-Source: APXvYqyN61GhWD0e4l8K0o5t6WK1hRFpzORALbbg2skfjaUQSNQ00893/Ae5TjNzrzgd5tHXUVwy3A==
X-Received: by 2002:a63:1b4e:: with SMTP id b14mr927755pgm.280.1574103872977;
        Mon, 18 Nov 2019 11:04:32 -0800 (PST)
Received: from cork ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id d187sm5272521pgc.1.2019.11.18.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:04:32 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:04:30 -0800
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     vitaly.wool@konsulko.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ddstreet@ieee.org, akpm@linux-foundation.org, sjenning@redhat.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH] zswap: use B-tree for search
Message-ID: <20191118190430.GA16134@cork>
References: <20191117185332.18998-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191117185332.18998-1-vitaly.wool@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 08:53:32PM +0200, vitaly.wool@konsulko.com wrote:
> From: Vitaly Wool <vitaly.wool@konsulko.com>
> 
> The current zswap implementation uses red-black trees to store
> entries and to perform lookups. Although this algorithm obviously
> has complexity of O(log N) it still takes a while to complete
> lookup (or, even more for replacement) of an entry, when the amount
> of entries is huge (100K+).
> 
> B-trees are known to handle such cases more efficiently (i. e. also
> with O(log N) complexity but with way lower coefficient) so trying
> zswap with B-trees was worth a shot.
> 
> The implementation of B-trees that is currently present in Linux
> kernel isn't really doing things in the best possible way (i. e. it
> has recursion) but the testing I've run still shows a very
> significant performance increase.
> 
> The usage pattern of B-tree here is not exactly following the
> guidelines but it is due to the fact that pgoff_t may be both 32
> and 64 bits long.
> 
> Tested on qemu-kvm (-smp 2 -m 1024) with zswap in the following
> configuration:
> * zpool: z3fold
> * max_pool_percent: 100
> and the swap size of 1G.
> 
> Test command:
> $ stress-ng --io 4 --vm 4 --vm-bytes 1000M --timeout 300s --metrics
> 
> This, averaged over 20 runs on qemu-kvm (-smp 2 -m 1024) gives the
> following io bogo ops:
> * original: 73778.8
> * btree: 393999

Impressive results.  Was your test done with a 32bit guest?  If yes, I
would assume results for a 64bit guess to drop to about 330k.

> +	if (sizeof(pgoff_t) == 8)
> +		btree_pgofft_geo = &btree_geo64;
> +	else
> +		btree_pgofft_geo = &btree_geo32;
> +

You could abuse the fact that pgoff_t is the same size as unsigned long
and use the "l" suffix variant.  But apart from the obvious abuse, the
"l" variant hasn't been used before and the implementation appears to be
buggy.

So no complaints about your use of the interface.

Jörn

--
Cryptographic protocols should not be designed by a committee.
-- Niels Ferguson & Bruce Schneier
