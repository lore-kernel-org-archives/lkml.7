Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5855C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfFQMbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:31:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:31:44 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlbM-1iGKPA0jWS-00djt7; Mon, 17 Jun 2019 14:31:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        akpm@linux-foundation.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org
Subject: [PATCH] ubsan: mark ubsan_type_mismatch_common inline
Date:   Mon, 17 Jun 2019 14:31:09 +0200
Message-Id: <20190617123109.667090-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RdrPG7YYozPOO4moFcrupalm1fFjUIeD1Q8rHF6IwUGNo79JcXH
 miKAhPNzei6GuU9U1bsgDZ8kG1jVk32osA4MHetoIE5ZsIYqMyTgCvnG+vMgAlYviqXB8aN
 a9wfzrI6f8gpze1TZWcSRXEgaozaMk4T3JwjusG3CMr7ZP2P8xxhrSDPn+Hjdzc0nXiljhb
 gAQj1zphITg1lfCVb1zlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OtOLG0VadSQ=:XsrhptSTyA02Et1uaEtCuI
 BLtI2n1fQrB7hHBYUluxjNkET7dy8P1RWzr6u8ltKIroe8fL3tMp5BOhzyD6oWF5sC62a1IKp
 NVnjSaTn/KQN1TCXTF04NJBMGUzH2E1KS9tapWvGMgEsL+Xn5kSFBI6uQrkp9Em2V4Kt5Mczd
 8121xcgyrMya6GNS+xexw6fU2mfymI6X47yQefgyFsH64DN2ugUfEs2gyu/nYBYWt2C56Kp2o
 rhhsZo5VIwK2Bug5WrzOWLr8ZNLkn27J55n0Hycluj6h5UNogfQv3rQDPd8aE5oMn6Lry/Nqs
 SIDyZUuv3doxaFGfEY+xwB3ekAFtU/ZXk1biWw6OgvwZhj+CIbrZ09+1/9R1YoJLexrOM6ihz
 ZauPN9BevksogYmUc5whKUqg4hLSolBCEZereObQRocrz6deopDGt7xJtcetvv91eYIRAXXLS
 oUmmPVdFOgH2tuE7kjqOTO8gqrK34qrv7+40BwbH74izvdaKiM01Xs+p5t8KEQZFyvFgoscJY
 E3KLyEzZkKU65G25+4A0G46Hx6m+zr1afShcfYNo5jsNIv1Oom057fImFi8zbm8z+hLAUj7nA
 bV1uI8nRN4yZf9/KQuusEdi7XHXmLXnbcp1i8COCDZkIeNRLl9EKbADF6MFtcLqeC08RG85Hs
 ekBZKOpRFi5YTyTKqTX7PCFsIyYHX1AdIfPQ8qpCz0cUxDNdsu1ni5GzxKHrXXzvIpa0q9WKj
 Bhp8Ec+4/uFOookVQleHJ4RTlsMu3Nz/ieF8RQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool points out a condition that it does not like:

lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x4a: call to stackleak_track_stack() with UACCESS enabled
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x4a: call to stackleak_track_stack() with UACCESS enabled

I guess this is related to the call ubsan_type_mismatch_common()
not being inline before it calls user_access_restore(), though
I don't fully understand why that is a problem.

Marking the function inline shuts up the warning and might be
the right thing to do. The patch that caused this is marked
for stable backports, so this one should probably be backported
as well.

Fixes: 42440c1f9911 ("lib/ubsan: add type mismatch handler for new GCC/Clang")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/ubsan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index ecc179338094..3d8836f0fc5c 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -309,7 +309,7 @@ static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 	ubsan_epilogue(&flags);
 }
 
-static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
+static __always_inline void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
 	unsigned long flags = user_access_save();
-- 
2.20.0

