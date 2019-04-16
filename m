Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B81C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfDPUVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:21:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfDPUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4vFE-1gpAeR0OEW-010u3O; Tue, 16 Apr 2019 22:21:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 05/26] compat_ioctl: move PPPIOCSPASS32/PPPIOCSACTIVE32 to ppp_generic.c
Date:   Tue, 16 Apr 2019 22:19:43 +0200
Message-Id: <20190416202013.4034148-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YZll/HYd2PBBirD2WAneXHxjnDz0Qclzh9yWR6cwSc0S/ka168l
 BbIqPfFFCokI8vHo2tkBeJNklutpx4Mtr6ry7peHfgLTJdKAzuPawoX7enBP10k391FSpM4
 pibKmK54jo/CXQt9hpK11CqPuSm8rqHNxMouP8fVVw4d9/e7K8SIZ5Gf5xvXHU/WzzcAarp
 KiE8Foh+eE9mMLSZm6KMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1m44palrgtU=:pAXvx4wyYGRZzechT2jopg
 iokOYRH5R400LVbTezGQNjVZ+d4BnLO2elypM0mW4gVbMgjkTpBZcMlDPJvxWGReJdxt14DKu
 fkBlN/YdcYvLdM2qFN2nJZeTxbLZpK2P0kNN5Sfig8/BBXuQ0T+4imaFVNw0BU7tDdLMlWVWo
 ikFtxJENwHpp17IRcBvEONSUVPjXwi9oJR9uPCH+vseTJW7k+Bx9WIJP07X3RnGvPBtDPXQ4k
 HJvdsgdYyedtdUCnRhmApfMfOMUPSruKezZkH/IvCW0jvDrJ7/dZH8C3v6u3QTog4DKGCpucB
 XNjtLLKM+e4eqI+n1ueSjtxPsNnMAgUNPBImiB+Wlpof2cMreVVSlf7+uMcjGYC6uL3vMVhn/
 bIkW5JEHHJTHNhdjZhDmUYD+bGB53+xg6iP3ot4sbIXFK4yrK/ILoegdwTI6JRFVK9kep3JPr
 PHLwYCALw2/mN7NSPHRP4v0FR3SUJMdoTegaeWFw66eNxI5Jv4lpdvQ8PqVI4zdpdBnQH5dqp
 VxmTkmt9wyMvELn5bL1N5G9VM5x/Yj8semzybh1h5q8816GPdF4/3+WRaj//ZofPweYMEWs6p
 Y/T+0RRihz1TPnl9pnI5UTYru+Dy8ryK4S48Ld/P5IX8tHlJTCtye9zOtN80a4awh9CO7Tdt9
 Gc1lUz1ko6qnlQkVDEE/5PlrmhB1R33oomVBZ7RL3mQfXGMsU1ekDTAvzLRwtjdDOXCPUSLj/
 tFbLhnz3fGEzcsIHm/x/2h79jXrhc39DWYS+LA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPPIOCSPASS and PPPIOCSACTIVE are implemented in ppp_generic and isdn_ppp,
but the latter one doesn't work for compat mode in general, so we can
move these two into the generic code.

Again, the best implementation I could come up with was to merge
the compat handling into the regular ppp_ioctl() function and
treating all ioctl commands as compatible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_generic.c | 39 ++++++++++++++++++++++++++++++-----
 fs/compat_ioctl.c             | 37 ---------------------------------
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 8d211c9c2e4e..b8a867fdd5ad 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -22,6 +22,7 @@
  * ==FILEVERSION 20041108==
  */
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -567,14 +568,36 @@ struct ppp_option_data32 {
 #endif
 
 #ifdef CONFIG_PPP_FILTER
-static int get_filter(void __user *arg, struct sock_filter **p)
+#ifdef CONFIG_COMPAT
+struct sock_fprog32 {
+	unsigned short	len;
+	compat_caddr_t	filter;
+};
+#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
+#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
+#endif
+
+static int get_filter(void __user *arg, struct sock_filter **p, bool compat)
 {
 	struct sock_fprog uprog;
 	struct sock_filter *code = NULL;
 	int len;
 
-	if (copy_from_user(&uprog, arg, sizeof(uprog)))
-		return -EFAULT;
+#ifdef CONFIG_COMPAT
+	if (compat) {
+		struct sock_fprog32 uprog32;
+
+		if (copy_from_user(&uprog32, arg, sizeof(uprog32)))
+			return -EFAULT;
+
+		uprog.len = uprog32.len;
+		uprog.filter = compat_ptr(uprog32.filter);
+	} else
+#endif
+	{
+		if (copy_from_user(&uprog, arg, sizeof(uprog)))
+			return -EFAULT;
+	}
 
 	if (!uprog.len) {
 		*p = NULL;
@@ -772,10 +795,13 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #ifdef CONFIG_PPP_FILTER
 	case PPPIOCSPASS:
+#ifdef CONFIG_COMPAT
+	case PPPIOCSPASS32:
+#endif
 	{
 		struct sock_filter *code;
 
-		err = get_filter(argp, &code);
+		err = get_filter(argp, &code, cmd != PPPIOCSPASS);
 		if (err >= 0) {
 			struct bpf_prog *pass_filter = NULL;
 			struct sock_fprog_kern fprog = {
@@ -798,10 +824,13 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case PPPIOCSACTIVE:
+#ifdef CONFIG_COMPAT
+	case PPPIOCSACTIVE32:
+#endif
 	{
 		struct sock_filter *code;
 
-		err = get_filter(argp, &code);
+		err = get_filter(argp, &code, cmd != PPPIOCSACTIVE);
 		if (err >= 0) {
 			struct bpf_prog *active_filter = NULL;
 			struct sock_fprog_kern fprog = {
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a7cea8f9c771..d507b7189958 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -271,40 +271,6 @@ static int sg_grt_trans(struct file *file,
 }
 #endif /* CONFIG_BLOCK */
 
-struct sock_fprog32 {
-	unsigned short	len;
-	compat_caddr_t	filter;
-};
-
-#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
-#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
-
-static int ppp_sock_fprog_ioctl_trans(struct file *file,
-		unsigned int cmd, struct sock_fprog32 __user *u_fprog32)
-{
-	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
-	void __user *fptr64;
-	u32 fptr32;
-	u16 flen;
-
-	if (get_user(flen, &u_fprog32->len) ||
-	    get_user(fptr32, &u_fprog32->filter))
-		return -EFAULT;
-
-	fptr64 = compat_ptr(fptr32);
-
-	if (put_user(flen, &u_fprog64->len) ||
-	    put_user(fptr64, &u_fprog64->filter))
-		return -EFAULT;
-
-	if (cmd == PPPIOCSPASS32)
-		cmd = PPPIOCSPASS;
-	else
-		cmd = PPPIOCSACTIVE;
-
-	return do_ioctl(file, cmd, (unsigned long) u_fprog64);
-}
-
 struct ppp_idle32 {
 	compat_time_t xmit_idle;
 	compat_time_t recv_idle;
@@ -874,9 +840,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	switch (cmd) {
 	case PPPIOCGIDLE32:
 		return ppp_gidle(file, cmd, argp);
-	case PPPIOCSPASS32:
-	case PPPIOCSACTIVE32:
-		return ppp_sock_fprog_ioctl_trans(file, cmd, argp);
 #ifdef CONFIG_BLOCK
 	case SG_IO:
 		return sg_ioctl_trans(file, cmd, argp);
-- 
2.20.0

