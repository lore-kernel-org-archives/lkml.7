Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C4220881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AKnEDntf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfEWUOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:14:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387778AbfEWUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:14:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so3190070plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5G1ZPvgTrdgyW2PxGOXC6vH5P8E8ivAkNJzVwGirtqo=;
        b=AKnEDntflvnhyaBSvVK099GiNRlWgGmribqV0Gw/VdWTjwxzjpNafTbPuqKigoe2V5
         FttiilstLFzz13VHtqQ9Ow5qJWcSTmkZod1V/o67Oz7JpP4zndSuIOsjZEnzgLgC45Dg
         1OBKSki/z8keLPmKvajpOynSqHY7geZI+K/YsdtLyEKBdPCcZVy7j/HKpK1eqApnmVRU
         B6d9wKjRuRWn4waIsXQHcEJCqUAi1LCpXsW0bGQxXG81fDN09MqYT2dprU1jScxQcw8k
         jZAoSGnyRTN6nFsLblRD2D74d6EvdPLSc5r6ch8s3TeUUG7GD2LjrY8535TP8yf89ZX9
         Yk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5G1ZPvgTrdgyW2PxGOXC6vH5P8E8ivAkNJzVwGirtqo=;
        b=Rkr7C8iLJUVMq0AdnHi4tn3lwl8cuBtyzic6F6sLLDtXsJSNY7jA/o71gUIY+Mxynv
         Z/LCk6hR3SUUNv2CpqDMle6KQ4AjIfsNqNgYyydEt9fSWJHddXMHT3fhsteiqZj1UpOn
         rW7OavPH4VI3y/TS/BOhJ8YNmLfveesjqT3SgBkXvBY9db3rYl9zYH5MmRv1lp/cJ0H8
         9gFt4cAvo3g8CDsdJC3rAGXUhW2Q0EmqG8fJj8qbvesc2Q1oqYwgOiNG10hsy4UfQdyf
         Im/suqTc/RiD/zHGyBcgSJwOj+dGpj1AdkA6BjMfvXtetRWqklDhWrjiWJT5u8M70Rsc
         Pq9A==
X-Gm-Message-State: APjAAAWDku1h7vkMod1UY9TXzdIx9+h1SYXfu9I/DpX+RRBcYsMHDunM
        T+octIqn5JtqI3rOzzs8oPgeig==
X-Google-Smtp-Source: APXvYqyocPUBK+x86to4bFHTsugKXVdIxgBB30akfZUKLbQ4YlaRtHksF4iUavWEP335zXjgDmppXQ==
X-Received: by 2002:a17:902:59c3:: with SMTP id d3mr29255894plj.273.1558642490753;
        Thu, 23 May 2019 13:14:50 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id i12sm180839pgb.61.2019.05.23.13.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 13:14:50 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH 2/2] tools: PCI: Fix compiler warning in pcitest
Date:   Thu, 23 May 2019 13:14:24 -0700
Message-Id: <1558642464-9946-3-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Fixes: fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")

Fix the following compiler warning in pcitest:

pcitest.c: In function main:
pcitest.c:214:4: warning: too many arguments for
format [-Wformat-extra-args]
    "usage: %s [options]\n"

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 6dce894667f6..6f1303104d84 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -223,7 +223,7 @@ int main(int argc, char **argv)
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			"\t-s <size>		Size of buffer {default: 100KB}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.7.4

