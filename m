Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE0AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191120872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b5zgI136"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFEUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:53:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39369 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:53:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so121756qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3I/eXWvJhwSVDdh8Zk+3yhEvGDlVYSksXxQUYrEAKJw=;
        b=b5zgI136ZoyI71YdMfYjvCeo5DwkFy5O06xRkDqWtHFpDCDlQYZFrU/aNE4MRqNRZH
         zbmWl0Loxa7+GSwkOReA/hGFD+nlccreU6RgEYTE/O81s8p161pXoFBHTDuxIHwdCbTy
         ZmrZkMRtXTGrcKPX3EtQ93T3UfG2N1zPciRGHef1AjUef5xSizA6hwqGwRw6Bd/7svO9
         afyd9X+/PH2pN4nIYEqGWP2Vawxp/0TJ1N9PjaK2cJqC/esj8Wp4ItEmIAqWddnj6ZJs
         WtEIXdo0KpExjAAPrQfncDOVEXlKxkJ91WKnmx0YvV9ZEPre4LockN/vCtlYv/iea0bI
         5eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3I/eXWvJhwSVDdh8Zk+3yhEvGDlVYSksXxQUYrEAKJw=;
        b=CXxd9MkfKgEf2PfYWYi307KnZjdinfMutBzQ7jpYSdFxofsLt28d75TVx8kwpNjxgk
         BG+kUvaOYV4z7EQ2LFumtb1GvXEDNr8nQdH9I8IzC4gG/gcQvqJ5BR2aMaFliyUL8Qay
         42N7Cgjxial/nRVCcDHLssRXjKd1LLxvlpoKt6l07x7FubrjHRzfuA+EjnagE9GoQiH3
         t80Z0s0wMHLain2/EO+ddC5FfsOcnABBTv4uoA59SCmUHLlEURGtcXa3Zb5Z7CXkwBkH
         n6vCizb0D3esaeZ2PW91rT/gjWcTdEu/btJ3eVFyfUnlMm+nE79fhLzWASpx7WL3cqJq
         HI8w==
X-Gm-Message-State: APjAAAUOqsN6UjIo/5FYUuimjBd0s724TiqdEk0wkdhdzmnRZ02a7qgY
        bXTIoVZ10xsCsGCJwkVwSFvC3Q==
X-Google-Smtp-Source: APXvYqzUFHqsZZVYvNweCNBlnJ0lRHg417FNWY7bLMP+8s2MUhv7xbWQsQnjU5bAxZa8edaaKSE+6w==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr35279575qkl.173.1559768037237;
        Wed, 05 Jun 2019 13:53:57 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n67sm12149368qte.42.2019.06.05.13.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:53:56 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] powerpc/setup_64: fix -Wempty-body warnings
Date:   Wed,  5 Jun 2019 16:53:38 -0400
Message-Id: <1559768018-7665-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of setup_64.c, it has,

  #ifdef DEBUG
  #define DBG(fmt...) udbg_printf(fmt)
  #else
  #define DBG(fmt...)
  #endif

where DBG() could be compiled away, and generate warnings,

arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find dcache properties !\n");
                                                 ^
arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
empty body in an 'if' statement [-Wempty-body]
    DBG("Argh, can't find icache properties !\n");

Suggested-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: fix it by using a NOP while loop.

 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..bed4ae8d338c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -71,7 +71,7 @@
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...)
+#define DBG(fmt...) do { } while (0)
 #endif
 
 int spinning_secondaries;
-- 
1.8.3.1

