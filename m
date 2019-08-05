Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CCC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A425D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJaEB+8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfHEH1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:27:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33225 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:27:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so39179284pfq.0;
        Mon, 05 Aug 2019 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kexfm7iH3i/VSJOwC3FuVy5N6LFfHFxQSV+3oxaWZQ=;
        b=dJaEB+8qJn0QJtz/DJ3fkifzpjMhNhP7Ip6R3bWOUO5sV3RGwnD1HHdfHzlRGLPkZk
         xfof7rzNGH3bt9HfHe4EDHfDhT7wLwDoUwaVzW5JwCKbjKpQu8X/sHqheIPhMcdPC4hY
         2IgYzu3PmznaI1mecw3zg2x0M1sbXGXFPbyk9nxY2QqMz3OknkNaNGMTeK0rkd6dRgop
         UF6FXd1AkZLw0aZ7xdUppCbhP9rL9QwgHKQH2W9HDMnvbuJzCt/2t5SbzSGqNUFb1kZn
         kYk4GoLoCWK/PS0JN/JE1pIRvFSo+Np/FD4AdHM2uSLRtJk8Wps4WDwJq5LyYdZzMSF+
         iUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kexfm7iH3i/VSJOwC3FuVy5N6LFfHFxQSV+3oxaWZQ=;
        b=nn5X+5c8WGOlLbZU9Jij/FakT0JgEDRkhRh2dBcXQzDsyoa61zU+Q5blaTWJgIqyY1
         UAbg1S8cZUnqNzJToMc3K/iFvql8hy5fieR/8cxp5gmeUMJXZu26nY3u+Jn1X0M4kMSF
         fh6nyNP2ssLHrQHac67Vxa37XhLfL5IioZv0wWq/zm93UD0+Yjl1X9pSGnQDmfMr04BF
         inG+ZPaMInbQ1ouNTJP/K0m707lSH7Pqni3nopZlogztB6mqbmVXj4GE3TBCjWVcYKE3
         LFcRz8DDbEEdlIsYGjukQZfca/8Ey/LLi0VPtNRM+3oU7AA3g2vN37zkjSgS2s0jRcm0
         GKnw==
X-Gm-Message-State: APjAAAXuHGssKrTVtQ3UdDDAnt+JkPAa+G2dnuwZ6zCo9uV0QYrOVr1U
        TKW2URt7Tf7u3/ZKDWjVXF8=
X-Google-Smtp-Source: APXvYqwr8wyNYy9oYI9NOwS4OQLaD5zm0ijr5UzV59jmk+rn8vspVToRE09Z07ImmiAnY7uL2haDqw==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr18210606pgm.265.1564990026218;
        Mon, 05 Aug 2019 00:27:06 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e13sm102354383pff.45.2019.08.05.00.27.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 00:27:05 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] ia64: hp-sim: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 15:26:59 +0800
Message-Id: <20190805072659.32745-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone since the len is
easy to be wrong because of counting error or sizeof(const)
without - 1.

Use the newly introduced str_has_prefix() to substitute
it to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/ia64/hp/sim/boot/bootloader.c | 2 +-
 arch/ia64/hp/sim/simeth.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/hp/sim/boot/bootloader.c b/arch/ia64/hp/sim/boot/bootloader.c
index 6d804608dc81..bcb7af27466c 100644
--- a/arch/ia64/hp/sim/boot/bootloader.c
+++ b/arch/ia64/hp/sim/boot/bootloader.c
@@ -112,7 +112,7 @@ start_bootloader (void)
 	ssc((long) &stat, 0, 0, 0, SSC_WAIT_COMPLETION);
 
 	elf = (struct elfhdr *) mem;
-	if (elf->e_ident[0] == 0x7f && strncmp(elf->e_ident + 1, "ELF", 3) != 0) {
+	if (elf->e_ident[0] == 0x7f && !str_has_prefix(elf->e_ident + 1, "ELF", 3)) {
 		cons_write("not an ELF file\n");
 		return;
 	}
diff --git a/arch/ia64/hp/sim/simeth.c b/arch/ia64/hp/sim/simeth.c
index f39ef2b4ed72..9ad812cd8d0e 100644
--- a/arch/ia64/hp/sim/simeth.c
+++ b/arch/ia64/hp/sim/simeth.c
@@ -248,7 +248,7 @@ simeth_open(struct net_device *dev)
 /* copied from lapbether.c */
 static __inline__ int dev_is_ethdev(struct net_device *dev)
 {
-       return ( dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5));
+       return (dev->type == ARPHRD_ETHER && !str_has_prefix(dev->name, "dummy"));
 }
 
 
-- 
2.20.1

