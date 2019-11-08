Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94357FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BDD215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfKHVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:34:48 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfKHVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:48 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mt7Ll-1he6UG37Rx-00tSYX; Fri, 08 Nov 2019 22:34:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/16] xtensa: ISS: avoid struct timeval
Date:   Fri,  8 Nov 2019 22:32:43 +0100
Message-Id: <20191108213257.3097633-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bIxykHQtSe97eNRKLWHHi2P7ZpF4kFV26LIaUxopMvMff0Y6TwS
 EHpMHJbnqxFRE8Lm5mODfRoD+r3eac3XJ0c2PcWDZciqhG0ddLpIau+NTbR+edYv8nKhw4c
 x4o34A3GVlLMI4yZ3Ma/1hhqFfNBaWeZIjAeJ37oPMTD+TXbHKYAq6eu7I8i9slW930BcPK
 uhy384Y8WEvKnM/Tfn7NA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lglGieAmDc8=:3SS5HATOoJTa0ueQh98NLR
 Txq527OJbLubazTSr+uZbynA65G8JKR8FiyGu6CNvP0AQ32h7g+xGSpr8KDkgjg6Ph960bVun
 ri/dCTTEQHWtfX6vfF++BnXPBMt2QpLEs8w5KGiRvroySsmvXQmcbV+wc7xDMIuH+cn1qZHzL
 CPeNZkgShvd+R/OkvTA8qME4QJiIfM1AqQgOwgn2jd5M7Z6E+47pk7FqrYJAbA9yoGo0ZhDbB
 Yc4J6nLzSqtbccBN1wvVGMgx4qBsJWdnA6ZZj0b7nNJ6hKvNGIn2qGzKh/eXQ7Khbo0TC1o60
 HahpmBei2f6Ju7rWmM/Fy66k473y7VhiRgBI6vmRJSu5BtcS35JReSDDVeBEbmWWqK1c6Byu0
 fZHcfeu0a4UuTijAKQvBXiDX6dcGPb7gOfPq9xCgEY9G2QyPBg4Ob6L24lFxO+bJL1dRnK9Xu
 sLeNB980MVhsnNP2zMLm+bRUSlunldL+oXLle4T1UkEf+arXhxLduDNjJEOz374eWKw7VlTtG
 T9OyLt2wqJseNFgNDd6xPu7Ub7jEASZ0k18yZxD6XTUo0BVVAy4ZgD22x5F5MkZnkYIzeDITN
 IxyZ7hiMFPnSQSPWDzxwRSu26Sf0Lk+xqOfuHxg2Z2kCn0Tb3ny49wvlFUuAQLik+3o3bPUHR
 Chfejv9lBsD9zZCeU+njQadrcMbzdweuiX7UlWBYTp2FAKgFs6EssCzXKuXLNE4DA0zV/X8Z5
 0OtdBvZ6j7Sp/25taXA+vU7QaGjufxoDIR7QUh74aFmFBHAh5baLWAZ6cQG6wmWUpA5Qv8Rkf
 misaXsiy87/On/4iHib79b4GzF3K3vcELrp1Cg9qkAnKZTQMWgA5ri9eaF6RecZ1hG3JSwyQg
 5lu1Uf1n9ZMLp209ZYTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct timeval' will get removed from the kernel, change the one
user in arch/xtensa to avoid referencing it, by using a fixed-length
array instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/platforms/iss/include/platform/simcall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/include/platform/simcall.h b/arch/xtensa/platforms/iss/include/platform/simcall.h
index 2ba45858e50a..4e2a48380dbf 100644
--- a/arch/xtensa/platforms/iss/include/platform/simcall.h
+++ b/arch/xtensa/platforms/iss/include/platform/simcall.h
@@ -113,9 +113,9 @@ static inline int simc_write(int fd, const void *buf, size_t count)
 
 static inline int simc_poll(int fd)
 {
-	struct timeval tv = { .tv_sec = 0, .tv_usec = 0 };
+	long timeval[2] = { 0, 0 };
 
-	return __simc(SYS_select_one, fd, XTISS_SELECT_ONE_READ, (int)&tv);
+	return __simc(SYS_select_one, fd, XTISS_SELECT_ONE_READ, (int)&timeval);
 }
 
 static inline int simc_lseek(int fd, uint32_t off, int whence)
-- 
2.20.0

