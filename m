Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D52085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCHMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:45:15 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:45:09 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBDSg-1hDlSw1ZF8-00Cg1k; Fri, 08 Mar 2019 13:44:56 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        info@metux.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 2/5] scripts: mkdebian: allow renaming generated debian/rules via env
Date:   Fri,  8 Mar 2019 13:44:21 +0100
Message-Id: <1552049064-32044-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:m9Rcq3BkE+/KvFJbr9DS66OIa5+IPcGvacRTbXUYkat4jkIKp67
 jFs28hFyLa8DfHhjYnAtUkfclhzCAsDp92ihbMhfnksFK/tTGWG3WIwpMxMdV+ezYSEc7ww
 Q9D/6Da5Rkk/8MqctcZMp6+JP0DfK593YmtEPj+pPkv20+eCznPU8wnmWdGSUTW4U7N9qoW
 hfsntRIN1y/m8dcbv1kIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:72OANdqF7Us=:Fn9cqmapZiB3bGwAR35+8F
 IHr+jgS30cSpuItHM4y0wvcNfJkfdRoDFkUdcP3jE+hjuUuX9kP3R/bTSMaYf5ESGO4CjduKi
 ENZyftorCeiw9+Zr5f+zLzLiLADsFPxY4R7wj3qYcJUvtXoAAhm0kWdVtMetiqPg0CluaLzyJ
 9Ly24m6PfxWD/tcTnHW6pYQ03YDQ78Jtr+ljXnK0pXQkrY8Jjann6MWmDeiC128e9sgzi45Vl
 acldZT27qlFYiCVC/hlEn2HTKOZRv+6GUDI9Thjbh55en0j/a5nmgbzjCbcLJaJNoPh8T4L71
 f4GaVVol2jrMvXA8wid4j9j+DPidN0CltitHI5UyAP5Er0PNqudMRcNPAH47+zhE92YsFxJ+9
 krnuM8zrkiYibjWixkZJgfVgQ3Cq/pSVGS9mdJRJgwhb+9K/UtkAghSeACeyk+BTwRL90bL1v
 QtQA1S+rI900paM4zHrpEPsgsjvnGgaPqkmbiyArZQ4CAgOF+nH0Fe845PjDaj5SECTtvtXni
 gNc8Ys8ZIV1bqG7lHtT0ThYFplkrWA/0g94oQ5QODtvE+E1hchju7lUS5nYnMhW6ANDNj9pTO
 pUzalEBM2JEclMKctevY42t7IuVcqXADqq7ypBG05ZdpyZZsQ/vrNFYgfIvMa1HCOYVEUlglc
 7lSnryzX7RZU0ozdk8r7k3HYFBMUXD3Wl0OPee9LMCRwQe4q5ggTn/hWSHMaqm+Pm8zFbC21m
 CVw9nQyCgjNp1fnji34IlBiEJqUFoFqD5Nt1tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new environment variable KDEB_RULES for controlling where the
generated debian rules are written to. By defaults, it's debian/rules,
but packagers might override it for providing their own rules file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/package/mkdebian | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index edcad61..ff226be 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -99,6 +99,9 @@ kernel_headers_packagename=linux-headers-$version
 dbg_packagename=$packagename-dbg
 debarch=
 set_debarch
+if [ -z "$KDEB_RULES" ]; then
+    KDEB_RULES=debian/rules
+fi
 
 if [ "$ARCH" = "um" ] ; then
 	packagename=user-mode-linux-$version
@@ -202,7 +205,7 @@ Description: Linux kernel debugging symbols for $version
  all the necessary debug symbols for the kernel and its modules.
 EOF
 
-cat <<EOF > debian/rules
+cat <<EOF > $KDEB_RULES
 #!$(command -v $MAKE) -f
 
 build:
-- 
1.9.1

