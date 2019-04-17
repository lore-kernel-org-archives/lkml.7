Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C289C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED68E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfDQNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:15:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfDQNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:15:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so31919928wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qLDJNT//sPtzyOjXzglGqlSQh1+GVGkkv9369Flk1M=;
        b=q9iq5H+DF+dJ6ytb735RgtCb0iqosPwMSKllpI9d5r3xL3uAB53LdWzJ3Bo7xhA0lz
         ss3gqKbC29QUuavvdIoGEL7dzQTN4msk9laB/Ilj+Kph9aKRjJK4lIO3USTPG+C5ZaXt
         q9REwwZucsFXaq3Dy9Pf8kMojpOK5Ot0X1SRP3I9ReBy5KUdgQTk6GPrdPUOnb+cjP4m
         Rh7tVPsujiNY88QKbBIhj5KP+6GEblNA9vwroQLWDL2lC7TetIxBWJEDUUDnsLx7VTGB
         LqlYUcxQ0aadxgJcUoNxl2k0v7oLQEuZptL2Qa92h3VyYffmoPpmVNfVqAdltifgKbb6
         gNbg==
X-Gm-Message-State: APjAAAVs/baMjgDYBLgJqrYLkwObxUmohmClO5TZrK5pNS0qy4LRbNX8
        9PypkZBH+kiaZCfHceaU8RO0qRr8WIssVQ==
X-Google-Smtp-Source: APXvYqwNkvpT44KcDh6WZk4f5WaqBKMeHzFtFGBmKyLym1KxvUnioUgJ4bwuwv5ugaratiUMf2HKQQ==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr38963894wrr.27.1555506934284;
        Wed, 17 Apr 2019 06:15:34 -0700 (PDT)
Received: from apu.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id t15sm3983801wmt.2.2019.04.17.06.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 06:15:32 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] proc/sysctl: add shared variables for range check
Date:   Wed, 17 Apr 2019 15:15:31 +0200
Message-Id: <20190417131531.9525-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the sysctl code the proc_dointvec_minmax() function is often used to
validate the user supplied value between an allowed range. This function
uses the extra1 and extra2 members from struct ctl_table as minimum and
maximum allowed value.

On sysctl handler declaration, in every source file there are some readonly
variables containing just an integer which address is assigned to the
extra1 and extra2 members, so the sysctl range is enforced.

The special values 0, 1 and INT_MAX are very often used as range boundary,
leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
different source files:

    $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
    245

This patch adds three const variables for the most commonly used values,
and use them instead of creating a local one for every object file.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/s390/appldata/appldata_base.c            |  15 +-
 arch/s390/kernel/topology.c                   |   6 +-
 arch/x86/entry/vdso/vdso32-setup.c            |   7 +-
 arch/x86/kernel/itmt.c                        |   6 +-
 drivers/base/firmware_loader/fallback_table.c |  11 +-
 drivers/gpu/drm/i915/i915_perf.c              |   8 +-
 drivers/hv/vmbus_drv.c                        |   6 +-
 drivers/s390/char/sclp_async.c                |   7 +-
 drivers/tty/tty_ldisc.c                       |   6 +-
 drivers/xen/balloon.c                         |   7 +-
 fs/eventpoll.c                                |   3 +-
 fs/notify/inotify/inotify_user.c              |   8 +-
 fs/proc/proc_sysctl.c                         |  10 +
 include/linux/sysctl.h                        |   4 +
 ipc/ipc_sysctl.c                              |  35 ++--
 kernel/pid_namespace.c                        |   3 +-
 kernel/sysctl.c                               | 193 +++++++++---------
 kernel/ucount.c                               |   6 +-
 net/core/neighbour.c                          |  20 +-
 net/core/sysctl_net_core.c                    |  34 ++-
 net/dccp/sysctl.c                             |  16 +-
 net/ipv4/sysctl_net_ipv4.c                    |  58 +++---
 net/ipv6/addrconf.c                           |   6 +-
 net/ipv6/route.c                              |   7 +-
 net/ipv6/sysctl_net_ipv6.c                    |   8 +-
 net/mpls/af_mpls.c                            |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c                |   3 +-
 net/rxrpc/sysctl.c                            |   9 +-
 net/sctp/sysctl.c                             |  35 ++--
 net/sunrpc/xprtrdma/transport.c               |   3 +-
 security/keys/sysctl.c                        |  26 ++-
 security/loadpin/loadpin.c                    |   6 +-
 security/yama/yama_lsm.c                      |   3 +-
 33 files changed, 266 insertions(+), 319 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index e4b58240ec53..82ae75b5ead6 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -220,15 +220,13 @@ appldata_timer_handler(struct ctl_table *ctl, int write,
 			   void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int timer_active = appldata_timer_active;
-	int zero = 0;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &timer_active,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -255,13 +253,12 @@ appldata_interval_handler(struct ctl_table *ctl, int write,
 			   void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int interval = appldata_interval;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &interval,
 		.maxlen		= sizeof(int),
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	};
 
 	rc = proc_dointvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
@@ -289,13 +286,11 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
 	struct list_head *lh;
 	int rc, found;
 	int active;
-	int zero = 0;
-	int one = 1;
 	struct ctl_table ctl_entry = {
 		.data		= &active,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	};
 
 	found = 0;
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 8964a3f60aad..347eb433c0a5 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -587,15 +587,13 @@ static int topology_ctl_handler(struct ctl_table *ctl, int write,
 {
 	int enabled = topology_is_enabled();
 	int new_mode;
-	int zero = 0;
-	int one = 1;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &enabled,
 		.maxlen		= sizeof(int),
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	};
 
 	rc = proc_douintvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 42d4c89f990e..c7cdd8bfa3e9 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -65,9 +65,6 @@ subsys_initcall(sysenter_setup);
 /* Register vsyscall32 into the ABI table */
 #include <linux/sysctl.h>
 
-static const int zero;
-static const int one = 1;
-
 static struct ctl_table abi_table2[] = {
 	{
 		.procname	= "vsyscall32",
@@ -75,8 +72,8 @@ static struct ctl_table abi_table2[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (int *)&zero,
-		.extra2		= (int *)&one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{}
 };
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index d177940aa090..54fc00adba00 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -69,8 +69,6 @@ static int sched_itmt_update_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static unsigned int zero;
-static unsigned int one = 1;
 static struct ctl_table itmt_kern_table[] = {
 	{
 		.procname	= "sched_itmt_enabled",
@@ -78,8 +76,8 @@ static struct ctl_table itmt_kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_itmt_update_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{}
 };
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 776dd69cf5be..5632c0a23a23 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -16,9 +16,6 @@
  * firmware fallback configuration table
  */
 
-static unsigned int zero;
-static unsigned int one = 1;
-
 struct firmware_fallback_config fw_fallback_config = {
 	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
 	.loading_timeout = 60,
@@ -33,8 +30,8 @@ struct ctl_table firmware_config_table[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "ignore_sysfs_fallback",
@@ -42,8 +39,8 @@ struct ctl_table firmware_config_table[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{ }
 };
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 9ebf99f3d8d3..dab38ad50804 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -271,8 +271,6 @@
 #define POLL_PERIOD (NSEC_PER_SEC / POLL_FREQUENCY)
 
 /* for sysctl proc_dointvec_minmax of dev.i915.perf_stream_paranoid */
-static int zero;
-static int one = 1;
 static u32 i915_perf_stream_paranoid = true;
 
 /* The maximum exponent the hardware accepts is 63 (essentially it selects one
@@ -3345,8 +3343,8 @@ static struct ctl_table oa_table[] = {
 	 .maxlen = sizeof(i915_perf_stream_paranoid),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = &zero,
-	 .extra2 = &one,
+	 .extra1 = (void *)&sysctl_zero,
+	 .extra2 = (void *)&sysctl_one,
 	 },
 	{
 	 .procname = "oa_max_sample_rate",
@@ -3354,7 +3352,7 @@ static struct ctl_table oa_table[] = {
 	 .maxlen = sizeof(i915_oa_max_sample_rate),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = &zero,
+	 .extra1 = (void *)&sysctl_zero,
 	 .extra2 = &oa_sample_rate_hard_limit,
 	 },
 	{}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 000b53e5a17a..53e11b7a7fff 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1190,8 +1190,6 @@ static struct kmsg_dumper hv_kmsg_dumper = {
 };
 
 static struct ctl_table_header *hv_ctl_table_hdr;
-static int zero;
-static int one = 1;
 
 /*
  * sysctl option to allow the user to control whether kmsg data should be
@@ -1204,8 +1202,8 @@ static struct ctl_table hv_ctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one
 	},
 	{}
 };
diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index e69b12a40636..1a04b064ad57 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -64,9 +64,6 @@ static struct notifier_block call_home_panic_nb = {
 	.priority = INT_MAX,
 };
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table callhome_table[] = {
 	{
 		.procname	= "callhome",
@@ -74,8 +71,8 @@ static struct ctl_table callhome_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{}
 };
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index e38f104db174..8ae085bf5587 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -855,8 +855,6 @@ void tty_ldisc_deinit(struct tty_struct *tty)
 	tty->ldisc = NULL;
 }
 
-static int zero;
-static int one = 1;
 static struct ctl_table tty_table[] = {
 	{
 		.procname	= "ldisc_autoload",
@@ -864,8 +862,8 @@ static struct ctl_table tty_table[] = {
 		.maxlen		= sizeof(tty_ldisc_autoload),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{ }
 };
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index d37dd5bb7a8f..915894b47136 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -77,9 +77,6 @@ static int xen_hotplug_unpopulated;
 
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table balloon_table[] = {
 	{
 		.procname	= "hotplug_unpopulated",
@@ -87,8 +84,8 @@ static struct ctl_table balloon_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &zero,
-		.extra2         = &one,
+		.extra1         = (void *)&sysctl_zero,
+		.extra2         = (void *)&sysctl_one,
 	},
 	{ }
 };
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a0e98d87fcc..c8391c574394 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -296,7 +296,6 @@ static LIST_HEAD(tfile_check_list);
 
 #include <linux/sysctl.h>
 
-static long zero;
 static long long_max = LONG_MAX;
 
 struct ctl_table epoll_table[] = {
@@ -306,7 +305,7 @@ struct ctl_table epoll_table[] = {
 		.maxlen		= sizeof(max_user_watches),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &long_max,
 	},
 	{ }
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 7b53598c8804..cc6164260c76 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -54,8 +54,6 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 #include <linux/sysctl.h>
 
-static int zero;
-
 struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
@@ -63,7 +61,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "max_user_watches",
@@ -71,7 +69,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "max_queued_events",
@@ -79,7 +77,7 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero
+		.extra1		= (void *)&sysctl_zero
 	},
 	{ }
 };
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d65390727541..e03ee672bf98 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -21,6 +21,16 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
+/* shared constants to be used in various sysctls */
+const int sysctl_zero;
+EXPORT_SYMBOL(sysctl_zero);
+
+const int sysctl_one = 1;
+EXPORT_SYMBOL(sysctl_one);
+
+const int sysctl_int_max = INT_MAX;
+EXPORT_SYMBOL(sysctl_int_max);
+
 /* Support for permanently empty directories */
 
 struct ctl_table sysctl_mount_point[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecfcc3bd..f3b191799747 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,6 +37,10 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
+extern const int sysctl_zero;
+extern const int sysctl_one;
+extern const int sysctl_int_max;
+
 typedef int proc_handler (struct ctl_table *ctl, int write,
 			  void __user *buffer, size_t *lenp, loff_t *ppos);
 
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 49f9bf4ffc7f..238f08235588 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -117,9 +117,6 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 #define proc_ipc_sem_dointvec	   NULL
 #endif
 
-static int zero;
-static int one = 1;
-static int int_max = INT_MAX;
 static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
@@ -143,7 +140,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &ipc_mni,
 	},
 	{
@@ -152,8 +149,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "msgmax",
@@ -161,8 +158,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "msgmni",
@@ -170,7 +167,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &ipc_mni,
 	},
 	{
@@ -179,8 +176,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_auto_msgmni,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	=  "msgmnb",
@@ -188,8 +185,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "sem",
@@ -205,8 +202,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "msg_next_id",
@@ -214,8 +211,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "shm_next_id",
@@ -223,8 +220,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 #endif
 	{}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index aa6e72fb7c08..ddbb51bc4968 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -290,14 +290,13 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 }
 
 extern int pid_max;
-static int zero = 0;
 static struct ctl_table pid_ns_ctl_table[] = {
 	{
 		.procname = "ns_last_pid",
 		.maxlen = sizeof(int),
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
-		.extra1 = &zero,
+		.extra1 = (void *)&sysctl_zero,
 		.extra2 = &pid_max,
 	},
 	{ }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9ec050bcf46..357f4ef1ed17 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -123,9 +123,6 @@ static int sixty = 60;
 #endif
 
 static int __maybe_unused neg_one = -1;
-
-static int zero;
-static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
@@ -388,8 +385,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_schedstats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SCHEDSTATS */
 #endif /* CONFIG_SMP */
@@ -421,7 +418,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "numa_balancing",
@@ -429,8 +426,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
@@ -462,8 +459,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -473,7 +470,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 #endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
@@ -483,8 +480,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_energy_aware_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_PROVE_LOCKING
@@ -549,7 +546,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
-		.extra2		= &one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_LATENCYTOP
@@ -683,8 +680,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_MODULES
@@ -702,8 +699,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_UEVENT_HELPER
@@ -862,7 +859,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &ten_thousand,
 	},
 	{
@@ -878,8 +875,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "kptr_restrict",
@@ -887,7 +884,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 #endif
@@ -912,8 +909,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "watchdog_thresh",
@@ -921,7 +918,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_thresh,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &sixty,
 	},
 	{
@@ -930,8 +927,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
 		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "watchdog_cpumask",
@@ -947,8 +944,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_soft_watchdog,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "softlockup_panic",
@@ -956,8 +953,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -966,8 +963,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -978,8 +975,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #ifdef CONFIG_SMP
 	{
@@ -988,8 +985,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif /* CONFIG_SMP */
 #endif
@@ -1102,8 +1099,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "hung_task_check_count",
@@ -1111,7 +1108,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "hung_task_timeout_secs",
@@ -1188,7 +1185,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
 		.proc_handler	= perf_proc_update_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "perf_cpu_time_max_percent",
@@ -1196,7 +1193,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1205,7 +1202,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &six_hundred_forty_kb,
 	},
 	{
@@ -1214,7 +1211,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_thousand,
 	},
 #endif
@@ -1224,8 +1221,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
@@ -1234,8 +1231,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= timer_migration_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_BPF_SYSCALL
@@ -1246,8 +1243,8 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		/* only handle a transition from default "0" to "1" */
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "bpf_stats_enabled",
@@ -1255,8 +1252,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_bpf_stats_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_stats,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
@@ -1266,8 +1263,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
@@ -1277,8 +1274,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= stack_erasing_sysctl,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{ }
@@ -1291,7 +1288,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1300,7 +1297,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_panic_on_oom),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1337,7 +1334,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "dirty_background_ratio",
@@ -1345,7 +1342,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_background_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_background_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1362,7 +1359,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_dirty_ratio),
 		.mode		= 0644,
 		.proc_handler	= dirty_ratio_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1386,7 +1383,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "dirtytime_expire_seconds",
@@ -1394,7 +1391,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirtytime_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= dirtytime_interval_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "swappiness",
@@ -1402,7 +1399,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_swappiness),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1427,8 +1424,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen			= sizeof(int),
 		.mode			= 0644,
 		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1			= &zero,
-		.extra2			= &one,
+		.extra1			= (void *)&sysctl_zero,
+		.extra2			= (void *)&sysctl_one,
 	},
 #endif
 	 {
@@ -1459,7 +1456,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &four,
 	},
 #ifdef CONFIG_COMPACTION
@@ -1485,8 +1482,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 
 #endif /* CONFIG_COMPACTION */
@@ -1496,7 +1493,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(min_free_kbytes),
 		.mode		= 0644,
 		.proc_handler	= min_free_kbytes_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "watermark_boost_factor",
@@ -1504,7 +1501,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_boost_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_boost_factor_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "watermark_scale_factor",
@@ -1512,7 +1509,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_scale_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &one_thousand,
 	},
 	{
@@ -1521,7 +1518,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(percpu_pagelist_fraction),
 		.mode		= 0644,
 		.proc_handler	= percpu_pagelist_fraction_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #ifdef CONFIG_MMU
 	{
@@ -1530,7 +1527,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_max_map_count),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #else
 	{
@@ -1539,7 +1536,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_nr_trim_pages),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 	{
@@ -1555,7 +1552,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(block_dump),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "vfs_cache_pressure",
@@ -1563,7 +1560,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 	{
@@ -1572,7 +1569,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_legacy_va_layout),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 #ifdef CONFIG_NUMA
@@ -1582,7 +1579,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(node_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "min_unmapped_ratio",
@@ -1590,7 +1587,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 	{
@@ -1599,7 +1596,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_min_slab_ratio),
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &one_hundred,
 	},
 #endif
@@ -1650,7 +1647,7 @@ static struct ctl_table vm_table[] = {
 #endif
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 #ifdef CONFIG_HIGHMEM
@@ -1660,8 +1657,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_highmem_is_dirtyable),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 #ifdef CONFIG_MEMORY_FAILURE
@@ -1671,8 +1668,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "memory_failure_recovery",
@@ -1680,8 +1677,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_memory_failure_recovery),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -1853,8 +1850,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "protected_hardlinks",
@@ -1862,8 +1859,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "protected_fifos",
@@ -1871,7 +1868,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1880,7 +1877,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -1889,7 +1886,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_coredump,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
@@ -1926,7 +1923,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{ }
 };
@@ -1948,8 +1945,8 @@ static struct ctl_table debug_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_kprobes_optimization_handler,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{ }
diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..ba7b8282d299 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -57,16 +57,14 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static int zero = 0;
-static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
 	{						\
 		.procname	= name,			\
 		.maxlen		= sizeof(int),		\
 		.mode		= 0644,			\
 		.proc_handler	= proc_dointvec_minmax,	\
-		.extra1		= &zero,		\
-		.extra2		= &int_max,		\
+		.extra1		= (void *)&sysctl_zero,		\
+		.extra2		= (void *)&sysctl_int_max,	\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 30f6fd8f68e0..495c30db57ca 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3352,8 +3352,6 @@ void neigh_app_ns(struct neighbour *n)
 EXPORT_SYMBOL(neigh_app_ns);
 
 #ifdef CONFIG_SYSCTL
-static int zero;
-static int int_max = INT_MAX;
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 
 static int proc_unres_qlen(struct ctl_table *ctl, int write,
@@ -3362,7 +3360,7 @@ static int proc_unres_qlen(struct ctl_table *ctl, int write,
 	int size, ret;
 	struct ctl_table tmp = *ctl;
 
-	tmp.extra1 = &zero;
+	tmp.extra1 = (void *)&sysctl_zero;
 	tmp.extra2 = &unres_qlen_max;
 	tmp.data = &size;
 
@@ -3427,8 +3425,8 @@ static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
 	struct ctl_table tmp = *ctl;
 	int ret;
 
-	tmp.extra1 = &zero;
-	tmp.extra2 = &int_max;
+	tmp.extra1 = (void *)&sysctl_zero;
+	tmp.extra2 = (void *)&sysctl_int_max;
 
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	neigh_proc_update(ctl, write);
@@ -3573,24 +3571,24 @@ static struct neigh_sysctl_table {
 			.procname	= "gc_thresh1",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= (void *)&sysctl_zero,
+			.extra2		= (void *)&sysctl_int_max,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH2] = {
 			.procname	= "gc_thresh2",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= (void *)&sysctl_zero,
+			.extra2		= (void *)&sysctl_int_max,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		[NEIGH_VAR_GC_THRESH3] = {
 			.procname	= "gc_thresh3",
 			.maxlen		= sizeof(int),
 			.mode		= 0644,
-			.extra1 	= &zero,
-			.extra2		= &int_max,
+			.extra1		= (void *)&sysctl_zero,
+			.extra2		= (void *)&sysctl_int_max,
 			.proc_handler	= proc_dointvec_minmax,
 		},
 		{},
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 84bf2861f45f..5b9b81bfaca4 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -22,8 +22,6 @@
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
 
-static int zero = 0;
-static int one = 1;
 static int two __maybe_unused = 2;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
@@ -390,10 +388,10 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
-		.extra1		= &one,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_one,
 # else
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 # endif
 	},
@@ -404,7 +402,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -413,8 +411,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 # endif
 	{
@@ -461,8 +459,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one
 	},
 #ifdef CONFIG_RPS
 	{
@@ -493,7 +491,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "busy_read",
@@ -501,7 +499,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #endif
 #ifdef CONFIG_NET_SCHED
@@ -533,7 +531,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &max_skb_frags,
 	},
 	{
@@ -542,7 +540,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
@@ -550,8 +548,8 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "devconf_inherit_init_net",
@@ -559,7 +557,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{ }
@@ -571,7 +569,7 @@ static struct ctl_table netns_core_table[] = {
 		.data		= &init_net.core.sysctl_somaxconn,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.proc_handler	= proc_dointvec_minmax
 	},
 	{ }
diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index 53731e45403c..2b3c427f4861 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -19,9 +19,7 @@
 #endif
 
 /* Boundary values */
-static int		zero     = 0,
-			one      = 1,
-			u8_max   = 0xFF;
+static int		u8_max   = 0xFF;
 static unsigned long	seqw_min = DCCPF_SEQ_WMIN,
 			seqw_max = 0xFFFFFFFF;		/* maximum on 32 bit */
 
@@ -41,7 +39,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_rx_ccid),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &u8_max,		/* RFC 4340, 10. */
 	},
 	{
@@ -50,7 +48,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_tx_ccid),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &u8_max,		/* RFC 4340, 10. */
 	},
 	{
@@ -59,7 +57,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_request_retries),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &u8_max,
 	},
 	{
@@ -68,7 +66,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_retries1),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &u8_max,
 	},
 	{
@@ -77,7 +75,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_retries2),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &u8_max,
 	},
 	{
@@ -86,7 +84,7 @@ static struct ctl_table dccp_default_table[] = {
 		.maxlen		= sizeof(sysctl_dccp_tx_qlen),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "sync_ratelimit",
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ba0fc4b18465..98bec909843d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -28,8 +28,6 @@
 #include <net/protocol.h>
 #include <net/netevent.h>
 
-static int zero;
-static int one = 1;
 static int two = 2;
 static int four = 4;
 static int thousand = 1000;
@@ -532,7 +530,7 @@ static struct ctl_table ipv4_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "icmp_msgs_burst",
@@ -540,7 +538,7 @@ static struct ctl_table ipv4_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 	{
 		.procname	= "udp_mem",
@@ -609,8 +607,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -698,8 +696,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = ipv4_fwd_update_priority,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "ip_nonlocal_bind",
@@ -729,8 +727,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -790,7 +788,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= (void *)&sysctl_one
 	},
 #endif
 	{
@@ -895,7 +893,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &two,
 	},
 	{
@@ -932,7 +930,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_tfo_blackhole_detect_timeout,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 	},
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	{
@@ -941,8 +939,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "fib_multipath_hash_policy",
@@ -950,8 +948,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_policy,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -968,8 +966,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 #endif
 	{
@@ -999,7 +997,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &four,
 	},
 	{
@@ -1143,7 +1141,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &gso_max_segs,
 	},
 	{
@@ -1159,8 +1157,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "tcp_invalid_ratelimit",
@@ -1175,7 +1173,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &thousand,
 	},
 	{
@@ -1184,7 +1182,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &thousand,
 	},
 	{
@@ -1193,7 +1191,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_wmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "tcp_rmem",
@@ -1201,7 +1199,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "tcp_comp_sack_delay_ns",
@@ -1216,7 +1214,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &comp_sack_nr_max,
 	},
 	{
@@ -1225,7 +1223,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_rmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= (void *)&sysctl_one
 	},
 	{
 		.procname	= "udp_wmem_min",
@@ -1233,7 +1231,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_udp_wmem_min),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= (void *)&sysctl_one
 	},
 	{ }
 };
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4ae17a966ae3..40f7125de64c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6417,8 +6417,6 @@ int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
 }
 
 static int minus_one = -1;
-static const int zero = 0;
-static const int one = 1;
 static const int two_five_five = 255;
 
 static const struct ctl_table addrconf_sysctl[] = {
@@ -6435,7 +6433,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)(void *)&sysctl_one,
 		.extra2		= (void *)&two_five_five,
 	},
 	{
@@ -6794,7 +6792,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&zero,
+		.extra1		= (void *)(void *)&sysctl_zero,
 		.extra2		= (void *)&two_five_five,
 	},
 	{
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0302e0eb07af..5d2e4d407dc0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5143,9 +5143,6 @@ int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 	return 0;
 }
 
-static int zero;
-static int one = 1;
-
 static struct ctl_table ipv6_route_table_template[] = {
 	{
 		.procname	=	"flush",
@@ -5223,8 +5220,8 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
 		.proc_handler	=	proc_dointvec,
-		.extra1		=	&zero,
-		.extra2		=	&one,
+		.extra1		=	(void *)&sysctl_zero,
+		.extra2		=	(void *)&sysctl_one,
 	},
 	{ }
 };
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index e15cd37024fd..b1e51369bd07 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -21,8 +21,6 @@
 #include <net/calipso.h>
 #endif
 
-static int zero;
-static int one = 1;
 static int auto_flowlabels_min;
 static int auto_flowlabels_max = IP6_AUTO_FLOW_LABEL_MAX;
 
@@ -149,8 +147,8 @@ static struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_rt6_multipath_hash_policy,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "seg6_flowlabel",
@@ -176,7 +174,7 @@ static struct ctl_table ipv6_rotable[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one
+		.extra1		= (void *)&sysctl_one
 	},
 #ifdef CONFIG_NETLABEL
 	{
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index f7c544592ec8..4600a3176f49 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -36,8 +36,6 @@
 
 #define MPLS_NEIGH_TABLE_UNSPEC (NEIGH_LINK_TABLE + 1)
 
-static int zero = 0;
-static int one = 1;
 static int label_limit = (1 << 20) - 1;
 static int ttl_max = 255;
 
@@ -2604,7 +2602,7 @@ static int mpls_platform_labels(struct ctl_table *table, int write,
 		.data		= &platform_labels,
 		.maxlen		= sizeof(int),
 		.mode		= table->mode,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &label_limit,
 	};
 
@@ -2633,8 +2631,8 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_one,
 	},
 	{
 		.procname	= "default_ttl",
@@ -2642,7 +2640,7 @@ static const struct ctl_table mpls_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &ttl_max,
 	},
 	{ }
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 053cd96b9c76..f5dfdddaa6bc 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1655,7 +1655,6 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 
 #ifdef CONFIG_SYSCTL
 
-static int zero;
 static int three = 3;
 
 static int
@@ -1864,7 +1863,7 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &three,
 	},
 	{
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index d75bd15151e6..d3deb5e90ab3 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -15,7 +15,6 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int one = 1;
 static const unsigned int four = 4;
 static const unsigned int thirtytwo = 32;
 static const unsigned int n_65535 = 65535;
@@ -101,7 +100,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)(void *)&sysctl_one,
 		.extra2		= (void *)&rxrpc_max_client_connections,
 	},
 	{
@@ -119,7 +118,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)(void *)&sysctl_one,
 		.extra2		= (void *)&n_max_acks,
 	},
 	{
@@ -128,7 +127,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)(void *)&sysctl_one,
 		.extra2		= (void *)&n_65535,
 	},
 	{
@@ -137,7 +136,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&one,
+		.extra1		= (void *)(void *)&sysctl_one,
 		.extra2		= (void *)&four,
 	},
 
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 33ca5b73cdb3..f2734d904c2e 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -40,10 +40,7 @@
 #include <net/sctp/sctp.h>
 #include <linux/sysctl.h>
 
-static int zero = 0;
-static int one = 1;
 static int timer_max = 86400000; /* ms in one day */
-static int int_max = INT_MAX;
 static int sack_timer_min = 1;
 static int sack_timer_max = 500;
 static int addr_scope_max = SCTP_SCOPE_POLICY_MAX;
@@ -107,7 +104,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = (void *)&sysctl_one,
 		.extra2         = &timer_max
 	},
 	{
@@ -116,7 +113,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_rto_min,
-		.extra1         = &one,
+		.extra1         = (void *)&sysctl_one,
 		.extra2         = &init_net.sctp.rto_max
 	},
 	{
@@ -152,8 +149,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "cookie_preserve_enable",
@@ -175,7 +172,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = (void *)&sysctl_one,
 		.extra2         = &timer_max
 	},
 	{
@@ -193,7 +190,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &one,
+		.extra1         = (void *)&sysctl_one,
 		.extra2         = &timer_max
 	},
 	{
@@ -202,8 +199,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "path_max_retrans",
@@ -211,8 +208,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "max_init_retransmits",
@@ -220,8 +217,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &int_max
+		.extra1		= (void *)&sysctl_one,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "pf_retrans",
@@ -229,8 +226,8 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &int_max
+		.extra1		= (void *)&sysctl_zero,
+		.extra2		= (void *)&sysctl_int_max,
 	},
 	{
 		.procname	= "sndbuf_policy",
@@ -301,7 +298,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &addr_scope_max,
 	},
 	{
@@ -310,7 +307,7 @@ static struct ctl_table sctp_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
-		.extra1		= &one,
+		.extra1		= (void *)&sysctl_one,
 		.extra2		= &rwnd_scale_max,
 	},
 	{
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 5d261353bd90..f8632ff19659 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -80,7 +80,6 @@ static unsigned int min_slot_table_size = RPCRDMA_MIN_SLOT_TABLE;
 static unsigned int max_slot_table_size = RPCRDMA_MAX_SLOT_TABLE;
 static unsigned int min_inline_size = RPCRDMA_MIN_INLINE;
 static unsigned int max_inline_size = RPCRDMA_MAX_INLINE;
-static unsigned int zero;
 static unsigned int max_padding = PAGE_SIZE;
 static unsigned int min_memreg = RPCRDMA_BOUNCEBUFFERS;
 static unsigned int max_memreg = RPCRDMA_LAST - 1;
@@ -122,7 +121,7 @@ static struct ctl_table xr_tunables_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.extra1		= (void *)&sysctl_zero,
 		.extra2		= &max_padding,
 	},
 	{
diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b68faa1a5cfd..366dde373a04 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -13,8 +13,6 @@
 #include <linux/sysctl.h>
 #include "internal.h"
 
-static const int zero, one = 1, max = INT_MAX;
-
 struct ctl_table key_sysctls[] = {
 	{
 		.procname = "maxkeys",
@@ -22,8 +20,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_one,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 	{
 		.procname = "maxbytes",
@@ -31,8 +29,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_one,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 	{
 		.procname = "root_maxkeys",
@@ -40,8 +38,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_one,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 	{
 		.procname = "root_maxbytes",
@@ -49,8 +47,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &one,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_one,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 	{
 		.procname = "gc_delay",
@@ -58,8 +56,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &zero,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_zero,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	{
@@ -68,8 +66,8 @@ struct ctl_table key_sysctls[] = {
 		.maxlen = sizeof(unsigned),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (void *) &zero,
-		.extra2 = (void *) &max,
+		.extra1 = (void *) &sysctl_zero,
+		.extra2 = (void *) &sysctl_int_max,
 	},
 #endif
 	{ }
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 055fb0a64169..e5cb1fcae497 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -49,8 +49,6 @@ static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 #ifdef CONFIG_SYSCTL
-static int zero;
-static int one = 1;
 
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
@@ -65,8 +63,8 @@ static struct ctl_table loadpin_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = &zero,
-		.extra2         = &one,
+		.extra1         = (void *)&sysctl_zero,
+		.extra2         = (void *)&sysctl_one,
 	},
 	{ }
 };
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index efac68556b45..036125ecbaad 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -449,7 +449,6 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
 }
 
-static int zero;
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 static struct ctl_path yama_sysctl_path[] = {
@@ -465,7 +464,7 @@ static struct ctl_table yama_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = yama_dointvec_minmax,
-		.extra1         = &zero,
+		.extra1         = (void *)&sysctl_zero,
 		.extra2         = &max_scope,
 	},
 	{ }
-- 
2.20.1

