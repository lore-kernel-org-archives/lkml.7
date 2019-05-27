Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4829C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECBB21744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfE0Iet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:34:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Ies (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:34:48 -0400
Received: from ip-37-201-4-247.hsi13.unitymediagroup.de ([37.201.4.247] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <manut@linutronix.de>)
        id 1hVB5h-0006Ee-VL; Mon, 27 May 2019 10:34:46 +0200
From:   Manuel Traut <manut@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, marc.zyngier@arm.com,
        khlebnikov@yandex-team.ru, Manuel Traut <manut@linutronix.de>
Subject: [PATCH] scripts/decode_stacktrace.sh: prefix addr2line with $CROSS_COMPILE
Date:   Mon, 27 May 2019 10:34:25 +0200
Message-Id: <20190527083425.3763-1-manut@linutronix.de>
X-Mailer: git-send-email 2.20.1
Reply-To: manut@mecka.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least for ARM64 kernels compiled with the crosstoolchain from
Debian/stretch or with the toolchain from kernel.org the line number is not
decoded correctly by 'decode_stacktrace.sh':

$ echo "[  136.513051]  f1+0x0/0xc [kcrash]" | \
  CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux- \
 ./scripts/decode_stacktrace.sh /scratch/linux-arm64/vmlinux \
                                /scratch/linux-arm64 \
                                /nfs/debian/lib/modules/4.20.0-devel
[  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:68) kcrash

If addr2line from the toolchain is used the decoded line number is correct:

[  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:57) kcrash

Signed-off-by: Manuel Traut <manut@linutronix.de>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index bcdd45df3f51..a7a36209a193 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -73,7 +73,7 @@ parse_symbol() {
 	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(addr2line -i -e "$objfile" "$address")
+		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address")
 		cache[$module,$address]=$code
 	fi
 
-- 
2.20.1

