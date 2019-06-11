Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4820645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFSFsDJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbfFKQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:18:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43055 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405509AbfFKQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:18:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so2015843qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1SAE7tWdGhmdsrz6sQXRqUecRMhwxMSHwAZhuBAtXg=;
        b=bFSFsDJzi9mHgZQuY5qWb/gxxf3dMTj5XGvQCKP33AAfY36RiLkLnTwiMSp/IeIzcb
         6pgii91lqJ6KkqLuHoyLRDDIwm99XiV2QekrWc9csrrlsnRDoT8NVNS8cI1/bBzUQDVx
         wvhIgcv7o7bnHBXBdBmxANdQrjs7fU0bqUrTU5xaQpfknxPerLb85FcTxYt85BhE4q5Q
         hkWQeTGQK+j2s7Erdsd3Kpf/BLxb3mO0RQ5bXb3BHiTzz60W2RuAGFPiExJVy8vPat/7
         oYngr8juK5d6c0R+zrTbmB7S9H8OGUWPRftLvQHiL4WeUpvgvCJai6xea81A53K7lefU
         FB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1SAE7tWdGhmdsrz6sQXRqUecRMhwxMSHwAZhuBAtXg=;
        b=IVSztfEf723MAlEkLFElT4CO1qXzXz+nv1wwSufv2JquIuandst41/EcfXg/xmwqFE
         7o6wLDDyidEghEMXFlCnVEYKUcoyEhfq1JkhT5vHelfRiJ/0QsffWd5HL9zW7LJ4PfFJ
         g9tMnPFHa4iI6KGzEs9BQX0LcW8uRgNhU8Dd3KKN90GIQOYWg+qf0+29YiiK6HOG+OHm
         P9tIYTN4mv1T/GAB9yvbVfAaXfDuvLy4gxdPrZLdZ60Nd11ZJ6BOKAywSEzCHUnbdmYt
         QWbK9SrvnSsWH8yQgn2w+rUOb6RUUp3CmFZJEmbF5nLDTvaprkZwNqMfMVc6r1hwCsqg
         HZEQ==
X-Gm-Message-State: APjAAAUl+BRnvTgYIDe79ju74QESxO4Lmd+0qavnBAonQAhkKlMyNnY4
        Xt/+RtGOae4+zxa+ew9pYRvHOn0=
X-Google-Smtp-Source: APXvYqy24BIzsBLMyJ9NPKf3YzSRzJhcWKbUEkuQGCNmFqzdIs0iPEm7cRIP9JF1ucYMWegtDfLXjA==
X-Received: by 2002:a0c:c586:: with SMTP id a6mr4745347qvj.177.1560269915539;
        Tue, 11 Jun 2019 09:18:35 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o38sm7911744qto.96.2019.06.11.09.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 09:18:35 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:18:29 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH 2/2] arm64/mm: show TAINT_CPU_OUT_OF_SPEC warning if the
 cache size is over the spec.
Message-ID: <20190611161828.kffrfqah2qtffahd@gabell>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
 <20190611151731.6135-3-msys.mizuma@gmail.com>
 <20190611154105.GE10165@c02tf0j2hf1t.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611154105.GE10165@c02tf0j2hf1t.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:41:06PM +0100, Catalin Marinas wrote:
> On Tue, Jun 11, 2019 at 11:17:31AM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Show the warning and taints as TAINT_CPU_OUT_OF_SPEC if the cache line
> > size is greater than the maximum.
> 
> In general the "out of spec" part is a misnomer, we tend to apply it to
> CPU features that are not supported by the kernel rather than some CPU
> feature not compliant with the architecture (we call the latter errata).
> 
> I suggest you drop this patch.

Thank you for your comments. I agree with you, so I drop this
patch.

Thanks,
Masa
