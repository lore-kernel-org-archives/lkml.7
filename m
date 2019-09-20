Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55982C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37924207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437816AbfITIog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:44:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48932 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405234AbfITIof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:44:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94BDF1A0097;
        Fri, 20 Sep 2019 10:44:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2ED431A004C;
        Fri, 20 Sep 2019 10:44:28 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A35B6402E6;
        Fri, 20 Sep 2019 16:44:23 +0800 (SGT)
From:   Lei Xu <lei.xu@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Lei Xu <lei.xu@nxp.com>
Subject: [PATCH] powerpc:mark expected switch fall-throughs
Date:   Fri, 20 Sep 2019 16:45:40 +0800
Message-Id: <20190920084540.3449-1-lei.xu@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernel with -Wimplicit-fallthrough and -Werror, it
reported the follwoing errors:

arch/powerpc/kernel/align.c: In function ‘emulate_spe’:
arch/powerpc/kernel/align.c:178:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
    ret |= __get_user_inatomic(temp.v[3], p++);
        ^~
arch/powerpc/kernel/align.c:179:3: note: here
   case 4:
   ^~~~
arch/powerpc/kernel/align.c:181:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
    ret |= __get_user_inatomic(temp.v[5], p++);
        ^~
arch/powerpc/kernel/align.c:182:3: note: here
   case 2:
   ^~~~
arch/powerpc/kernel/align.c:261:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
    ret |= __put_user_inatomic(data.v[3], p++);
        ^~
arch/powerpc/kernel/align.c:262:3: note: here
   case 4:
   ^~~~
arch/powerpc/kernel/align.c:264:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
    ret |= __put_user_inatomic(data.v[5], p++);
        ^~
arch/powerpc/kernel/align.c:265:3: note: here
   case 2:
   ^~~~
cc1: all warnings being treated as errors

This patch fixs the above errors.

Signed-off-by: Lei Xu <lei.xu@nxp.com>
---
 arch/powerpc/kernel/align.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 7107ad8..92045ed 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -176,9 +176,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __get_user_inatomic(temp.v[1], p++);
 			ret |= __get_user_inatomic(temp.v[2], p++);
 			ret |= __get_user_inatomic(temp.v[3], p++);
+			/* fall through */
 		case 4:
 			ret |= __get_user_inatomic(temp.v[4], p++);
 			ret |= __get_user_inatomic(temp.v[5], p++);
+			/* fall through */
 		case 2:
 			ret |= __get_user_inatomic(temp.v[6], p++);
 			ret |= __get_user_inatomic(temp.v[7], p++);
@@ -259,9 +261,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __put_user_inatomic(data.v[1], p++);
 			ret |= __put_user_inatomic(data.v[2], p++);
 			ret |= __put_user_inatomic(data.v[3], p++);
+			/* fall through */
 		case 4:
 			ret |= __put_user_inatomic(data.v[4], p++);
 			ret |= __put_user_inatomic(data.v[5], p++);
+			/* fall through */
 		case 2:
 			ret |= __put_user_inatomic(data.v[6], p++);
 			ret |= __put_user_inatomic(data.v[7], p++);
-- 
2.9.3

