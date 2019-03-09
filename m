Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E57FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3620815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCITrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:47:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCITrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:47:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Jl6Fv3200300
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:47:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Jl6hP3200297;
        Sat, 9 Mar 2019 11:47:06 -0800
Date:   Sat, 9 Mar 2019 11:47:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-q4njvk9mshra00jacqjbzfn5@git.kernel.org>
Cc:     acme@redhat.com, mleitner@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mhiramat@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, namhyung@kernel.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de, mhiramat@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mleitner@redhat.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe: Clarify error message about not
 finding kernel modules debuginfo
Git-Commit-ID: 4d6101f5fd5d996060eb59f7a01d3d1f842407c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4d6101f5fd5d996060eb59f7a01d3d1f842407c1
Gitweb:     https://git.kernel.org/tip/4d6101f5fd5d996060eb59f7a01d3d1f842407c1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 28 Feb 2019 11:22:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Feb 2019 14:20:35 -0300

perf probe: Clarify error message about not finding kernel modules debuginfo

'perf probe' supports using just the kernel module name, but that will
work only when the module is loaded, or using the full pathname to the
file with the DWARF debug info, but the warning was cryptic:

Before:

  # perf probe -m cls_flower -L fl_change
  Failed to find the path for cls_flower: No such file or directory
    Error: Failed to show lines.
  #

After:

  # perf probe -m cls_flower -L fl_change
  Module cls_flower is not loaded, please specify its full path name.
    Error: Failed to show lines.
  # perf probe -m /lib/modules/5.0.0-rc7+/kernel/net/sched/cls_flower.ko -L fl_change | head -7
  <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
        0  static int fl_change(struct net *net, struct sk_buff *in_skb,
         		       struct tcf_proto *tp, unsigned long base,
         		       u32 handle, struct nlattr **tca,
         		       void **arg, bool ovr, struct netlink_ext_ack *extack)
        4  {
        5  	struct cls_fl_head *head = rtnl_dereference(tp->root);
  #

The behaviour doesn't change when the module is loaded:

  # modprobe cls_flower
  # perf probe -m cls_flower -L fl_change | head -7
  <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
        0  static int fl_change(struct net *net, struct sk_buff *in_skb,
                               struct tcf_proto *tp, unsigned long base,
                               u32 handle, struct nlattr **tca,
                               void **arg, bool ovr, struct netlink_ext_ack *extack)
        4  {
        5         struct cls_fl_head *head = rtnl_dereference(tp->root);
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q4njvk9mshra00jacqjbzfn5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0030f9b9bf7e..a1b8d9649ca7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -472,9 +472,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 					strcpy(reason, "(unknown)");
 			} else
 				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
-			if (!silent)
-				pr_err("Failed to find the path for %s: %s\n",
-					module ?: "kernel", reason);
+			if (!silent) {
+				if (module)
+					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
+				else
+					pr_err("Failed to find the path for the kernel: %s\n", reason);
+			}
 			return NULL;
 		}
 		path = dso->long_name;
