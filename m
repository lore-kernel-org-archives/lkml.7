Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05CB21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P5ixH0El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfC2FEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:04:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41004 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfC2FEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:04:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so457437pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K+fXE3nC/D4jJXfV8N8hV2CYYuqRjfquUFVQdpA86FE=;
        b=P5ixH0Elavs4nmxY2Tnhnen3+SwWDR2up3kw1PoV46Ulk73Ac4GAe3vpQqb3VzMio0
         Fo9l6qAc9rcftO4w5TNr6ruekqM1nJXYewIwoQi9F/NFNZi3/KFtxXEJm4EOVTbDwem2
         Uu4hL7bwjy2KLPYAIf7eF3pX7aVB1ZYYAw+6YV5NSIQxTnXHu8UAuI736BsoAoK7kTA5
         hXZvevqss1Bm8k/u92Xi03UPECpsQaNRN1zfTUxDktyJwhXqZwbDOiGR8ZGm+cr2qaFd
         opupknyxVfxPgKZwLa6uZOsXT2ZYCFKRyQYuyz9pXJgrytxulkUaiSgGCUt9UZbsfoIE
         NBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K+fXE3nC/D4jJXfV8N8hV2CYYuqRjfquUFVQdpA86FE=;
        b=pb4Ru6rydZeSzh73843QbAX6Udz0EwoRCY/rH1Ofbf2IiZVxFoYtPnJr51wxvAGTl2
         +sO0uMZzZSbwzntiKPSDZZTZWUOK7lZuYlitm8rlN5WQQ2LFo9mEeOYuaX4IwlfnOE6D
         N0moD0s6MaBGSH1zEsk7yNGtD+WFt4XDXUehu6bn9z02UhOhE7shayAcH3KTmu+PG3ia
         ppdLy5XijwWLSDy4cAQGxgQmOsThuQHonHyGtobaLkw1f+AChndNS0Cus5rt6iuN8Omj
         +K0SgrpJOlcUBIs5QR9WucL16aHxWixWdRZIUFduA+oTAyWax/a61r3Oo160yGU/qgu3
         shZA==
X-Gm-Message-State: APjAAAXhXBDdDW0PusqhlZhppyF8/KD2xApAdIOV871fxl2KU2axoS2W
        UnqAu5Z1e1WCT5is6SufN8oI9Q==
X-Google-Smtp-Source: APXvYqx25PwAjqQt+KdgZC3k/hjKJVSGn61vOVJWPctuRg4c7wnF/Zws6XBqmGWGZRj3bs36c1baYg==
X-Received: by 2002:a65:5685:: with SMTP id v5mr42573716pgs.365.1553835891264;
        Thu, 28 Mar 2019 22:04:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m20sm1481475pfj.142.2019.03.28.22.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 22:04:50 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:04:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v2] RISC-V: Implement ASID allocator
In-Reply-To: <20190328063211.13052-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1903282158510.25278@viisi.sifive.com>
References: <20190328063211.13052-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Mar 2019, Anup Patel wrote:

> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v1:
> - We adapt good aspects from Gary Guo's ASID allocator implementation
>   and provide due credit to him by adding his SoB.

This isn't the right way to use Signed-off-by: lines in the kernel.  See

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst#n213

and

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n418

The only people who should be listed in Signed-off-by: lines are patch 
authors.

If your intention is to give Gary credit for changes in your patch, 
describe what ideas or code snippets you've taken in the patch description 
itself, above your Signed-off-by: lines so they would be included in the 
git commit description should your patch be merged.


- Paul
