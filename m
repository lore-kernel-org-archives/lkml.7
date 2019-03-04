Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8154C10F09
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B0D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCDUfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:35:14 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:35:12 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MyK9U-1hAkY524SK-00yii8; Mon, 04 Mar 2019 21:34:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] bpf: fix sysctl.c warning
Date:   Mon,  4 Mar 2019 21:34:12 +0100
Message-Id: <20190304203443.1992942-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lhdSW1MClS1OpT/SWuhIIv9Ek1tpe8udolndjPd+QDzE4nvOEE4
 VI7bNGQYGB7yiZvLnjw7IcBi0aAAGjcRT2euQFwRQ0yrJRhghqUUJnHCmBwsHseRgYOtjdq
 hEhhnNvgb759fnPkBNdCEc+b6u434vmPbw9O2Gi/x63fpZhbWBu4KhgpT1/gMX4IqX9UF6o
 rv12ftNNH/Ko1YjohTTcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HshwpxYVGpA=:WWCNSSTL2KpTZHzuwghHl7
 MnaEnbAiqK6dVJwcWhA/IjbiUF4KcQHwGS3VlBUH1fjshRRqE3aWfsn2d+5wvHK46s9mNZY+8
 45z/0WyENHrsG0ZL+/zeJ3YuReB8ucI2vZu+47eWYeYiJukSiEZmr8NxKCMFbZ+NrcYZUvJOJ
 +O1FAnsSpSFiZRhrSVLaYvwvwSLIb3HbsI/8OXCHJtHwE3Tcx/c2FBHIVxgmwu3GJYkX1X/DT
 3rDBbH8tpubU6L6YtYe95lRauw7tFde2TxbsZTSSEI4ySdWgS8c0ixpW/rB130BRFXmrsO2uv
 yCqZSgj1tilLNu7SNmOiTYAo9ZxSVW0gtnMv8s7fIP+n0/zg4umJdgr6eJess18i0+wgdwIZS
 bcf4R4pGkb32ODlZ/VfY/TblDRXAJnNvwLyCkjQNfv6kejAZur4RdREVDFNPLermLxX9iAXup
 mqRFjgYYxxkeJD5ptuW99iORYrswc8TpFEEwJyheTH9MG+PkTG/Sh9sb+n+kL22Im5yZVhYZy
 ZzyNEZl9nC8z+py8TJnXrQRXbIhC1vrz40aVC+4Bb8/GyY/DAJI6mf9VlBX/WDTBKuUrdnJhq
 pCIUHx8wYWYl6Pr7gtl79xdJXzBHGuhEihiBH49wzJ0OspvOmcZG8J5uRgocZTyfVPhD6yp6l
 DXRHbFsOagKedTB//mdOGStu0ZlYHSOqPbBAJDGRnwa+6z9OrVMn9Obww0wz2A0iwgXuZp7Df
 h/j98kKOAYv8o4LyomCigazFf3gY+VVBsHNMIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
a warning about an unused function:

kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined but not used [-Werror=unused-function]
 static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,

The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
is needed on top.

Fixes: 492ecee892c2 ("bpf: enable program stats")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 46a0d0a14a66..b3df3ab7ac28 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3330,7 +3330,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 
 #endif /* CONFIG_PROC_SYSCTL */
 
-#ifdef CONFIG_BPF_SYSCALL
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
 static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
 					  void __user *buffer, size_t *lenp,
 					  loff_t *ppos)
-- 
2.20.0

