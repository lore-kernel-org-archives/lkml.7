Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA743CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8634B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VMqvLhOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfJaUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 16:49:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39893 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfJaUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:49:52 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so8362515ion.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eZuTkF9gdxwYS0tvbddGae71Rmh5FP+LUK5dUhOI+v0=;
        b=VMqvLhOg8S4c0re6Dw2GImFmJC01f3MugeR8IlfEe6/fiiz97FrlNkmiQkKQoXFWUP
         xneZvMpjiF23urBUD+OTfkXqHs1CqzR5tZ0rMSpBeOYpjmGxNfil/7RMBgEO9PukcgC1
         PnKtRI4StJo3cYG9YcUJXsCMRkp0AxyCo4SEy5N+BK2lRiDnDlkPn0s0MnQ5iWgDHCWZ
         mauGK2FnUvcuSU3ju2pnszWXoIkX++t7XV78ikoIbirCe25Qqy9YKWzcSFXOVFI9mbgD
         /jMQ+bbthEOShvS8jtAjHuUL8G6Mp/JFqzcZZgoAJdIR/1QG5lI8BUPlT5z/BNmBu0Ee
         EmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eZuTkF9gdxwYS0tvbddGae71Rmh5FP+LUK5dUhOI+v0=;
        b=OuCj6EYkek8AkiX4GeH/hXAa9xlGrN/daCIQO0oTnycgeWG9FRpgERq518U2VOnRFb
         qLwnCYrT9YDiFRKzuqWIdWo/Nw8AqFX6ApFH/bRnzqvZ7LePqFDjUv6HM2y62HB5ZGi4
         ubB1z9IXogTobKso7y10/uZN7NfpxzEqRN0XM2W6y0nD37DnDlE16zZOVecVxNi3FFP2
         WHKBLBKasdh2rKZ764WfvmMjL5kJhvYHoQp+4LTbnvRxiUBtTEesDG5CcLowtHfGS6Xo
         oGo4ZefEopwuNmUV9Q8XZo1uz5RZMloIobFkx1MlWQoG+Z1GV/WnO0dvqUQiyEuLTi1g
         mChw==
X-Gm-Message-State: APjAAAXt3ulgouKfo5C4QOw9X0V7/k6uKtAGbgsXoDy9XqrDHlMLhuNR
        3N3KZTe6e5SQmcy67MJ/dF8f4A==
X-Google-Smtp-Source: APXvYqxCL8rKb+KK9mH6oo8lGPy4DgHa+6+xjM+cFqcKN9RRZY5eVYNe8c9q/wCIIsbXCQOYaKcT/w==
X-Received: by 2002:a6b:f415:: with SMTP id i21mr7169015iog.109.1572554989604;
        Thu, 31 Oct 2019 13:49:49 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id e4sm708090ilg.33.2019.10.31.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 13:49:49 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:49:47 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 04/12] riscv: cleanup the default power off
 implementation
In-Reply-To: <20191028121043.22934-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910311348350.25874@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-5-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> Move the sbi poweroff to a separate function and file that is only
> compiled if CONFIG_SBI is set.  Provide a new default fallback
> power off that just sits in a wfi loop to save some power.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Thanks, I've split the WFI optimization out into a separate patch (below) 
and queued it for v5.5-rc1.


- Paul

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 30 Oct 2019 16:11:47 -0700
Subject: [PATCH] riscv: enter WFI in default_power_off() if SBI does not
 shutdown

Provide a new default fallback power off that just sits in a wfi loop
to save some power.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
[paul.walmsley@sifive.com: split the WFI improvement apart from the
 nommu-related default_power_off() changes; wrote commit summary]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/reset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index aa56bb135ec4..485be426d9b1 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -10,7 +10,8 @@
 static void default_power_off(void)
 {
 	sbi_shutdown();
-	while (1);
+	while (1)
+		wait_for_interrupt();
 }
 
 void (*pm_power_off)(void) = default_power_off;
-- 
2.24.0.rc0

