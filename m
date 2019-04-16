Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C1C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35520663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfDPUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:21:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfDPUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:44 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MkEdF-1gb4231FYv-00kccp; Tue, 16 Apr 2019 22:21:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Paul Mackerras <paulus@samba.org>,
        Guillaume Nault <g.nault@alphalink.fr>,
        Eric Biggers <ebiggers@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: [PATCH v3 06/26] compat_ioctl: handle PPPIOCGIDLE for 64-bit time_t
Date:   Tue, 16 Apr 2019 22:19:44 +0200
Message-Id: <20190416202013.4034148-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z80sGlQ66gRm2J3CTo2uN9CB8g+68RhpTNesaNMqEHaMegdINz6
 4NDVDUKLJNtguoaI43IdlVTGqdA1j2BqpjMgVueMZu4HbXK0HEtb6AdMqtE3FVxZ1xcBOIt
 P0QmpFnVi5ez8MNsAZHnm5E+eCcZpQzCUMYGUf1G9q9iaC7ADGup2duzt6tUAIarmn0BXwJ
 4pKH/nSVo9gncltdrqc/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6F4NwBI/CM0=:FNMhySh9Wa2sfvB+2nXXn8
 R5ye0JtPLNWGgQml3Fu/a5MXEJP4meYjjeArlYU3nNRmVPB5yf3E0c1eJJYCg0gnPiq/j5h/F
 hBGWY50cQpeWpiW8Hn8rf/epymotTvICFTV7G0QQPLJNGpJwq6KQWwKaGVItyjUXrjYxMgJiU
 C0ptKrCNTcAyNTacqYaHPy72P3KF28p4j9U5N71hQbKfR7oqM1wfXhniMbO6lJ9XA1P3Do284
 vu3XJnkhhn3fZUZT9kYXvvewgVdxtpEuhzrprD4YanCu4s5wWD0PY5SytISsHLPu5x8c1FDDZ
 3InpnQ7G8nHu27yj5I0kN1eT24mIy4EvwSHEQFuzZMGbwrD77IjpGJP4vF2rHBOaioVKDPmXW
 swyRiOGL7xb8exqv2RdTIMuvc1AStgkjomejP3yicyY08gUtcEiOLBvKAMx7/LeFitLJbV/19
 0jpYePVpy6bPbo1gFELWo8ueefqC1QhXEuVYqoUNPWoEwP2iAvll2SSZP3z2gDqtlb42ifqLe
 bVEmP0Nk6tm5g4MuDszbNbPo8ehiFuKi1sY1Y2a1MZjPUFh2g1e22BTM9I0TIsQep3jKvcbGg
 fncc6d6/I7LWKBn27oaJZxWJB1r/aQgKmRFUeEeYJs4mnVTMTEARa7Zj5MQavUlJf6ADo9A8k
 WoYGYCiXjI3U9vYcuuX0n/p0W8olm1Rxi0g6uWKsPOFKpOBKxI1DXITeFn2U1rDMqG9TQMgh8
 NYiUTgkdIh2Wz8ukYHPdf06J/621/zeMY5KuJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ppp_idle structure is defined in terms of __kernel_time_t, which is
defined as 'long' on all architectures, and this usage is not affected
by the y2038 problem since it transports a time interval rather than an
absolute time.

However, the ppp user space defines the same structure as time_t, which
may be 64-bit wide on new libc versions even on 32-bit architectures.

It's easy enough to just handle both possible structure layouts on
all architectures, to deal with the possibility that a user space ppp
implementation comes with its own ppp_idle structure definition, as well
as to document the fact that the driver is y2038-safe.

Doing this also avoids the need for a special compat mode translation,
since 32-bit and 64-bit kernels now support the same interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/ppp_generic.txt |  2 ++
 drivers/isdn/i4l/isdn_ppp.c              | 14 ++++++++---
 drivers/net/ppp/ppp_generic.c            | 19 +++++++++++----
 fs/compat_ioctl.c                        | 31 ------------------------
 include/uapi/linux/ppp-ioctl.h           |  2 ++
 include/uapi/linux/ppp_defs.h            | 14 +++++++++++
 6 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/ppp_generic.txt b/Documentation/networking/ppp_generic.txt
index 61daf4b39600..fd563aff5fc9 100644
--- a/Documentation/networking/ppp_generic.txt
+++ b/Documentation/networking/ppp_generic.txt
@@ -378,6 +378,8 @@ an interface unit are:
   CONFIG_PPP_FILTER option is enabled, the set of packets which reset
   the transmit and receive idle timers is restricted to those which
   pass the `active' packet filter.
+  Two versions of this command exist, to deal with user space
+  expecting times as either 32-bit or 64-bit time_t seconds.
 
 * PPPIOCSMAXCID sets the maximum connection-ID parameter (and thus the
   number of connection slots) for the TCP header compressor and
diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index a7b275ea5de1..1f17126c5fa4 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -543,11 +543,19 @@ isdn_ppp_ioctl(int min, struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		is->pppcfg = val;
 		break;
-	case PPPIOCGIDLE:	/* get idle time information */
+	case PPPIOCGIDLE32:	/* get idle time information */
 		if (lp) {
-			struct ppp_idle pidle;
+			struct ppp_idle32 pidle;
 			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
-			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle))))
+			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle32))))
+				return r;
+		}
+		break;
+	case PPPIOCGIDLE64:	/* get idle time information */
+		if (lp) {
+			struct ppp_idle64 pidle;
+			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
+			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle64))))
 				return r;
 		}
 		break;
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b8a867fdd5ad..712fa94650fe 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -619,7 +619,8 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct ppp_file *pf;
 	struct ppp *ppp;
 	int err = -EFAULT, val, val2, i;
-	struct ppp_idle idle;
+	struct ppp_idle32 idle32;
+	struct ppp_idle64 idle64;
 	struct npioctl npi;
 	int unit, cflags;
 	struct slcompress *vj;
@@ -743,10 +744,18 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		err = 0;
 		break;
 
-	case PPPIOCGIDLE:
-		idle.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
-		idle.recv_idle = (jiffies - ppp->last_recv) / HZ;
-		if (copy_to_user(argp, &idle, sizeof(idle)))
+	case PPPIOCGIDLE32:
+                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
+                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
+                if (copy_to_user(argp, &idle32, sizeof(idle32)))
+			break;
+		err = 0;
+		break;
+
+	case PPPIOCGIDLE64:
+		idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
+		idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
+		if (copy_to_user(argp, &idle64, sizeof(idle64)))
 			break;
 		err = 0;
 		break;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index d507b7189958..e6dbd956cf66 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -269,36 +269,7 @@ static int sg_grt_trans(struct file *file,
 	}
 	return err;
 }
-#endif /* CONFIG_BLOCK */
-
-struct ppp_idle32 {
-	compat_time_t xmit_idle;
-	compat_time_t recv_idle;
-};
-#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
-
-static int ppp_gidle(struct file *file, unsigned int cmd,
-		struct ppp_idle32 __user *idle32)
-{
-	struct ppp_idle __user *idle;
-	__kernel_time_t xmit, recv;
-	int err;
-
-	idle = compat_alloc_user_space(sizeof(*idle));
 
-	err = do_ioctl(file, PPPIOCGIDLE, (unsigned long) idle);
-
-	if (!err) {
-		if (get_user(xmit, &idle->xmit_idle) ||
-		    get_user(recv, &idle->recv_idle) ||
-		    put_user(xmit, &idle32->xmit_idle) ||
-		    put_user(recv, &idle32->recv_idle))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-#ifdef CONFIG_BLOCK
 struct mtget32 {
 	compat_long_t	mt_type;
 	compat_long_t	mt_resid;
@@ -838,8 +809,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	void __user *argp = compat_ptr(arg);
 
 	switch (cmd) {
-	case PPPIOCGIDLE32:
-		return ppp_gidle(file, cmd, argp);
 #ifdef CONFIG_BLOCK
 	case SG_IO:
 		return sg_ioctl_trans(file, cmd, argp);
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index 88b5f9990320..7bd2a5a75348 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -104,6 +104,8 @@ struct pppol2tp_ioc_stats {
 #define PPPIOCGDEBUG	_IOR('t', 65, int)	/* Read debug level */
 #define PPPIOCSDEBUG	_IOW('t', 64, int)	/* Set debug level */
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
+#define PPPIOCGIDLE32	_IOR('t', 63, struct ppp_idle32) /* 32-bit times */
+#define PPPIOCGIDLE64	_IOR('t', 63, struct ppp_idle64) /* 64-bit times */
 #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
 #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
 #define PPPIOCDETACH	_IOW('t', 60, int)	/* obsolete, do not use */
diff --git a/include/uapi/linux/ppp_defs.h b/include/uapi/linux/ppp_defs.h
index fff51b91b409..0039fa39a358 100644
--- a/include/uapi/linux/ppp_defs.h
+++ b/include/uapi/linux/ppp_defs.h
@@ -142,10 +142,24 @@ struct ppp_comp_stats {
 /*
  * The following structure records the time in seconds since
  * the last NP packet was sent or received.
+ *
+ * Linux implements both 32-bit and 64-bit time_t versions
+ * for compatibility with user space that defines ppp_idle
+ * based on the libc time_t.
  */
 struct ppp_idle {
     __kernel_time_t xmit_idle;	/* time since last NP packet sent */
     __kernel_time_t recv_idle;	/* time since last NP packet received */
 };
 
+struct ppp_idle32 {
+    __s32 xmit_idle;		/* time since last NP packet sent */
+    __s32 recv_idle;		/* time since last NP packet received */
+};
+
+struct ppp_idle64 {
+    __s64 xmit_idle;		/* time since last NP packet sent */
+    __s64 recv_idle;		/* time since last NP packet received */
+};
+
 #endif /* _UAPI_PPP_DEFS_H_ */
-- 
2.20.0

