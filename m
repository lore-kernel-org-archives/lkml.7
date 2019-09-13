Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0036C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6729208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568353341;
	bh=zLeU3SJpF4cwPfzjc1+r4U4dp9oGpkrefaSILL1XmLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E0gN8Hj3I81o53hRL6ib68dfUYbGxqmkKtWShsR2ikVehiCU1vHnCNV4cZcOeKVKR
	 tiTPXxC+ECSA+UXQYRFjR2BsINmdhSbp5ZZXZfCLZ9XE534wlDaoHcp6mJh1uantVM
	 0EfNGUf3b7s2wL0ZiOrGKO2GisvXZ/hhP+fdJ4Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfIMFmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 01:42:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40776 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfIMFmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 01:42:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so1271944wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppV5KcUiF1CGYToYGdU0wfK/H3e+utN032f5iiPzYJI=;
        b=f3szeRJXJ3wJoTpbV2bf+5DwUxTMNlZ1KtkL8aOHMBwt6sQRnv0Axno86oGWlQMOBS
         za8ZxC5kq1+GdnSDV238IgFg3JY9vzwcahSgRPGHG6qf2p4IlzKIjjMl6BlJHwCrmlCF
         NjdpDOPj+K4I88b5IDhidX4Cza7WOvTdeXMWehdqDHL9TE+zI5XuYOPCZpXEWbF+CzZ0
         RvpMCS5taR8au6bzOGJQAOS/NA5W4EQTUdkM26zJ7T6DYqymkArOFNfP3aZgpy06n+yn
         mQioWPJm/Wm4+6hJT2Nsu0/mFFlh1RMADuWS0/IYTRG9gRVt+KvumVwXNYUMBbFe8bD+
         Wpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppV5KcUiF1CGYToYGdU0wfK/H3e+utN032f5iiPzYJI=;
        b=H3CUGQfrpTBX91vpZtsCMudr8h1vlAxG32j3qh0mGvmux5RDx6nceBKEnKbJx6wuh2
         5AtCbI3KOihaWtYcZyVH1RUo46kbs+7d4KWXiOR+0WRZ409NfJqgmeJNDTWRS+1w6VpA
         qqY2IReiQXvcXMpVU4OXEC9p9l3ORIzdbb4GI8Po9TDNum1nS3u0YspLM5vRaP0iNaCk
         9w6xML8hqLCYsXKwJfBeG3PJnB/3rXPJm+4NUU94SFaTI1OOXK4TpSzq97bbY3yrmrRf
         0r+0lZxyZbAzGzIFN2UcKzw7M0cVlPYVcmfeGDbXu+XVc+YsRDGqyw8tpfEtp4//fAXq
         PJzQ==
X-Gm-Message-State: APjAAAWSXtPu67A/NlMKvE/hpOOhvbBoFQPPgAZZvbX80RYFbKRzJJ7r
        2lAM9ocfs6nbh9V+K9lILLk=
X-Google-Smtp-Source: APXvYqwbqS4T1d9NzD8JRMvOyeV+4zFbVtxUI/9498o6wGeH1bxIUEXZ6VLn6hv9JtUqzLd58veL/w==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr1661963wma.165.1568353318563;
        Thu, 12 Sep 2019 22:41:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t6sm2097971wmf.8.2019.09.12.22.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 22:41:57 -0700 (PDT)
Date:   Fri, 13 Sep 2019 07:41:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 5/6] x86: alternative.h: use asm_inline for all
 alternative variants
Message-ID: <20190913054155.GA118828@gmail.com>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-6-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912221927.18641-6-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Most, if not all, uses of the alternative* family just provide one or
> two instructions in .text, but the string literal can be quite large,
> causing gcc to overestimate the size of the generated code. That in
> turn affects its decisions about inlining of the function containing
> the alternative() asm statement.
> 
> New enough versions of gcc allow one to overrule the estimated size by
> using "asm inline" instead of just "asm". So replace asm by the helper
> asm_inline, which for older gccs just expands to asm.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
