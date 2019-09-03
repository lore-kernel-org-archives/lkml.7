Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C34C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3292173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMEcCRDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfICFCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:02:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44701 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfICFCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:02:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so4971491pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/XFYjbQfFP5x0DF9Qiwr9ncORMF1Jj8/HTtQ1v/Yi4=;
        b=pMEcCRDvv3iUpNrnyTmlREY9J4bbkQdpcQduoRHI6B2nA2MCK4maxSlD1kRaIYDRL8
         kNq475LYtyniC/mM1vBCMCed1xtdKd4/mBitl1hXgPNBkT8B64/Z9UiDO7Yurz4N5hhl
         12BB/IjNsulBlioZeTLzTkyLsAkn0rY10naYykqYOSjRO0RAy3IEwAxZ+/SX2ScLijEt
         0yChUxXqBrfFCGTNdgj4il/oBKOMsH2Pws6rlp8ME/2bm6dH4k04t9CWexOZX/Bdzta/
         wyGmQPmgju9DjwuLvziyqUHo3UiOb7ArqYwPBMkd9nZNM9ikU/vCpWN0BM5CM98gD3b8
         NiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/XFYjbQfFP5x0DF9Qiwr9ncORMF1Jj8/HTtQ1v/Yi4=;
        b=rhaZ2eh5E/Dp95hQ8hYfFAt5mVCvLbvnCz0806MWBRQyZg9/1zi23DG+JKbT51A3a6
         1zdwOG5o21eIwAKSQcxh4YU6tyNCcxSoJHaxIdSpG9dhZDfxE4nP9Acey+xc7ze5p6Sh
         NDgHkFqupaidzozBVLKY48bp9mOW5ZJ5pZi0pwd8WhFXdC2pt4/X0ndIn95v6wLvyO1K
         SQDw5Hy/Eb6k4A1sM33OOa3/XJvxRchhWz3FYWMoji3OvOQRSVZ4cAQIf1aS9EUBSxOY
         BCz9UzzQFKudN0nxOvLMLXUAYUXRkEQpr8rqWYghSe8hkSKP/z3XTsPV9nk4OwQ395qw
         8NkA==
X-Gm-Message-State: APjAAAWaN+NNETEfXPqEFsncGD0CyMrFLzzUzpl9pzdbpPy7L5B/d64v
        RDT6Yx6u7L9sD2r3QPst2A4=
X-Google-Smtp-Source: APXvYqx2LqOE/JZ+pFr3rcvl9oJcjMZhtdB9rWps67FavH+XmYFIgKiB7VyNdR3KFHE1JINKu7M+4Q==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr28211445pgq.320.1567486944711;
        Mon, 02 Sep 2019 22:02:24 -0700 (PDT)
Received: from localhost ([175.223.38.155])
        by smtp.gmail.com with ESMTPSA id w13sm3685940pfi.30.2019.09.02.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 22:02:24 -0700 (PDT)
Date:   Tue, 3 Sep 2019 14:02:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     James Byrne <james.byrne@origamienergy.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ABI: Update dev-kmsg documentation to match current
 kernel behaviour
Message-ID: <20190903050220.GB3978@jagdpanzerIV>
References: <0102016cf1b26630-8e9b337b-da49-43c6-b028-4250c2fac3ef-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102016cf1b26630-8e9b337b-da49-43c6-b028-4250c2fac3ef-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/02/19 11:18), James Byrne wrote:
> Commit 5aa068ea4082 ("printk: remove games with previous record flags")
> abolished the practice of setting the log flag to 'c' for the first
> continuation line and '+' for subsequent lines. Now all continuation
> lines are flagged with 'c' and '+' is never used.
>
> Update the 'dev-kmsg' documentation to remove the reference to the
> obsolete '+' flag. In addition, state explicitly that only 8 bits of the
> <N> syslog prefix are used for the facility number when writing to
> /dev/kmsg.
>
> Signed-off-by: James Byrne <james.byrne@origamienergy.com>

Looks good to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
