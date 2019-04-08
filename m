Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37EAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfDHV2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:18 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDHV2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MxV4T-1gxqBH3pft-00xtsD; Mon, 08 Apr 2019 23:28:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Franzki <ifranzki@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] s390: zcrypt: initialize variables before_use
Date:   Mon,  8 Apr 2019 23:26:18 +0200
Message-Id: <20190408212648.2407234-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f7LYLS+shNTGQVOERcPHnDGdSyHXSpqaZPjOyXA7Bymy6uFk7aK
 OfEMbohlPk5WJKMM/7rr/lnt6Go6uMTSPTZCyjmQK2Bq+5Xlxii9i9IvWKtXKZnA3KkEpxj
 XB0/O0gL+9+iJHwKIfutZmt6gpQO4eGg1gB64BrlSSQtRlmY/ENad/BLupkSCP2g9IhC+bd
 UjEjs2Lm7XJp7RFcufpKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hjuBKaVOxqE=:x7bWz60bcMTXae27O36o06
 trXP0naJKX1dcVR4d8qwgf1OEtZ3k3Ltk0acPLc+nnq0sKpTNbX3/k2rOkU2Xzndh3hcGUqFC
 tD9pVIg3leSqcCADBhnk5QW0hdeHPb1RIrIzODsKmi59OTD4MpfWumzJuDYgiCKWobVE5H7zd
 eHdizh17HYrsRjW8bA0BB7US1KJzBYImTqLs1lQbz3J3vxvdnrvddpM0GG4q39/nFDOLVqSvv
 8iOqggPCGrdcBRaYfSevvrOt2BE6lHo12ivDRjn16MXI4kHJ+X26SYmFdZcV/hZhPJtKmFsec
 VaAe0ySv5jZFcoyUWcz5Z87zQm1Q6WhkS3hq5uH7/9UUZayTNeoFtN+90CcaiLR9jRXOFF7Gc
 3Nzku9B85LVccwrj/4NklgMEUa/+qGLee8gGgf/wh6WaTlMZzdYCLDCvvJSmcfmo6XPydop7L
 VxFdVsDCmBOlidoU/VulYzHM3kWWdWUOU2ll4PV5atFhYWEL6RwP4N+eFHuk1ZDCupwl81MP1
 g0Ge8NtC50LiCuZOX5Aem22TMQdzmyjKiqowM0aX4R4k/dESVWdjTvUSBGPOHzlk/iqEHc3qm
 fHVkDddUKIY4HSKI7fmzhU6URA3N0QjgJdT2JWpk1AgToj48lsmO/BCFEF2yFKotsZ7CpYA+h
 TKThu3mZ/+xi3qGWJ+pRcDjlZeUqQ0ea2Y1//RwSmKzfmpJogYHGmsGvNL1Aj07QoouJ5yti0
 FGNaSjBhhpx6I9IlsQEd5GlU/xrG9205lyEUKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'func_code' variable gets printed in debug statements without
a prior initialization in multiple functions, as reported when building
with clang:

drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
      [-Wsometimes-uninitialized]
        if (mex->outputdatalength < mex->inputdatalength) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
        trace_s390_zcrypt_rep(mex, func_code, rc,
                                   ^~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
        if (mex->outputdatalength < mex->inputdatalength) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
        unsigned int func_code;
                              ^

Add initializations to all affected code paths to shut up the warning
and make the warning output consistent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/crypto/zcrypt_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index eb93c2d27d0a..23472063d9a8 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
 	if (mex->outputdatalength < mex->inputdatalength) {
+		func_code = -1;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
 	if (crt->outputdatalength < crt->inputdatalength) {
+		func_code = -1;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 
 		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
 		if (!targets) {
+			func_code = -1;
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
 		if (copy_from_user(targets, uptr,
 				   target_num * sizeof(*targets))) {
+			func_code = -1;
 			rc = -EFAULT;
 			goto out_free;
 		}
-- 
2.20.0

