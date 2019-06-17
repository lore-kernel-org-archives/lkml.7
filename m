Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lsCotGah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFQObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:31:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42041 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFQObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:31:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so16447915edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IwVUj5pq5OLDmAp1JSdo4io4ScU2qonTZKXdPbrw8s4=;
        b=lsCotGah4wxzar9WXO4RtmCa+T7f4GXU99eahIhtZD7KLG/+lrSWGWkpbWmpqYMiWx
         rEhKP6GXc/bYy1LSwzR2zoJTkscTE/cghCzcYfX6ln66PUXJeu1J9cCa6eYYsAKMA+R3
         pnWoJ40fDo7f6h5oIVARQWweERWfeE1BIZ+neqv7nOS+7Gqnly1EhGMPAwq8y1EMj7pv
         J7c0GRCEuY1clsyBdt0eQUYfbtyzE28uh84Ctc3CZRbpXXkQap8ZDgx7tC1RT4QsURUH
         0ySdr2yxQ9nrU6F0ONwfhHu++z8sFOwJoQVyy1EZK4ggmHuUPiIGSn/3nMk8gz0uAFP+
         YMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IwVUj5pq5OLDmAp1JSdo4io4ScU2qonTZKXdPbrw8s4=;
        b=PNfYCSHlzS6VBSFMWpHQeXaH1pagCbulkvhh9X+T/MRO3TgdRQTPgORGw5cSkTWzjK
         swhKgMzoeyg00iJaTtoBOUm/F3e3y67RyDO30NWmS3yUCijm6PKwLQwfCK67ZtMK/6PR
         TXqY76rA1n91qrRP3HxZ5TgS/Z8Y8+RegWXwytz6AJBV4FK6hi1ne9BbMUpsKZon4VET
         m8lvV2jnojO5zCZeHzCRApjSfRDH8zbrZqrkX1Txyqnfa27V72od2dF4cdfLbN5VHc14
         /swBZgzcjOZROr1ugDnW7niR1LP+xd8pcvXQ4VRl2UXM8PhVO5Mh3T+ZzxEPiEhPZHXb
         j4eg==
X-Gm-Message-State: APjAAAWRz5vjtXFC0BVemOgdnfF21uaQut1WZnUgIc6v6DA601+hdN2F
        rJhsKJgCVEMAZsNFg9tTAj5bjA==
X-Google-Smtp-Source: APXvYqzpHrWrEAzx/7/mqTJhA435fEbLhaRoVdoz6kugESqq6Se6Vl5OTNNtskT2DjaSsd+cQI7MSg==
X-Received: by 2002:a17:906:27d9:: with SMTP id k25mr54021062ejc.194.1560781872048;
        Mon, 17 Jun 2019 07:31:12 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id 93sm3738242edk.84.2019.06.17.07.31.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:31:11 -0700 (PDT)
Date:   Mon, 17 Jun 2019 07:31:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rolf Eike Beer <eb@emlix.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: riscv: remove unused barrier defines
In-Reply-To: <1862877.fiP6YxjBP5@devpool35>
Message-ID: <alpine.DEB.2.21.9999.1906170724240.32654@viisi.sifive.com>
References: <1862877.fiP6YxjBP5@devpool35>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Rolf Eike Beer wrote:

> From 947f9fe483dc6561e31f0d2294eb6fedc1d6d9bb Mon Sep 17 00:00:00 2001
> From: Rolf Eike Beer <eb@emlix.com>
> Date: Mon, 17 Jun 2019 14:22:37 +0200
> Subject: [PATCH] riscv: remove unused barrier defines
> 
> They were introduced in fab957c11efe2f405e08b9f0d080524bc2631428 long after
> 2e39465abc4b7856a0ea6fcf4f6b4668bb5db877 removed the remnants of all previous
> instances from the tree.
> 
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Thanks for the patch.  checkpatch.pl flags an error on the format of the 
commit IDs in the patch description.  And there is also the spurious mbox 
header.  These have been fixed these up here, and the patch below has been 
queued for v5.2-rc.  It would help to run "checkpatch.pl --strict" on 
future patches.


thanks again,

- Paul


From: Rolf Eike Beer <eb@emlix.com>
Date: Mon, 17 Jun 2019 14:25:59 +0200
Subject: [PATCH] riscv: remove unused barrier defines

They were introduced in commit fab957c11efe ("RISC-V: Atomic and
Locking Code") long after commit 2e39465abc4b ("locking: Remove
deprecated smp_mb__() barriers") removed the remnants of all previous
instances from the tree.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
[paul.walmsley@sifive.com: stripped spurious mbox header from patch
 description; fixed commit references in patch header]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/bitops.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index f30daf26f08f..01db98dfd043 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -23,11 +23,6 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-#ifndef smp_mb__before_clear_bit
-#define smp_mb__before_clear_bit()  smp_mb()
-#define smp_mb__after_clear_bit()   smp_mb()
-#endif /* smp_mb__before_clear_bit */
-
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls.h>
-- 
2.20.1

