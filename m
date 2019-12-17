Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0417C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21ED20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfLQMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:09:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:39944 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:09:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 04:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="389803981"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.129])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2019 04:09:16 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com, allison@lohutok.net,
        jacob.jun.pan@linux.intel.com
Cc:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        andriy.shevchenko@intel.com, sumeet.r.pawnikar@intel.com
Subject: [PATCH v3] tools/thermal: tmon: replace error message SIGINT with SIGTERM
Date:   Tue, 17 Dec 2019 17:45:31 +0530
Message-Id: <1576584931-2063-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong error message reporting by replacing SIGINT with SIGTERM.
Fix multiple checkpatch errors and warnings.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 tools/thermal/tmon/tmon.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 83ec6e482f12..7eb3216a27f4 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -46,7 +46,7 @@ static void	start_daemon_mode(void);
 
 pthread_t event_tid;
 pthread_mutex_t input_lock;
-void usage()
+void usage(void)
 {
 	printf("Usage: tmon [OPTION...]\n");
 	printf("  -c, --control         cooling device in control\n");
@@ -62,7 +62,7 @@ void usage()
 	exit(0);
 }
 
-void version()
+void version(void)
 {
 	printf("TMON version %s\n", VERSION);
 	exit(EXIT_SUCCESS);
@@ -70,7 +70,6 @@ void version()
 
 static void tmon_cleanup(void)
 {
-
 	syslog(LOG_INFO, "TMON exit cleanup\n");
 	fflush(stdout);
 	refresh();
@@ -96,7 +95,6 @@ static void tmon_cleanup(void)
 	exit(1);
 }
 
-
 static void tmon_sig_handler(int sig)
 {
 	syslog(LOG_INFO, "TMON caught signal %d\n", sig);
@@ -120,7 +118,6 @@ static void tmon_sig_handler(int sig)
 	tmon_exit = true;
 }
 
-
 static void start_syslog(void)
 {
 	if (debug_on)
@@ -167,7 +164,6 @@ static void prepare_logging(void)
 		return;
 	}
 
-
 	fprintf(tmon_log, "#----------- THERMAL SYSTEM CONFIG -------------\n");
 	for (i = 0; i < ptdata.nr_tz_sensor; i++) {
 		char binding_str[33]; /* size of long + 1 */
@@ -175,7 +171,7 @@ static void prepare_logging(void)
 
 		memset(binding_str, 0, sizeof(binding_str));
 		for (j = 0; j < 32; j++)
-			binding_str[j] = (ptdata.tzi[i].cdev_binding & 1<<j) ?
+			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1 << j)) ?
 				'1' : '0';
 
 		fprintf(tmon_log, "#thermal zone %s%02d cdevs binding: %32s\n",
@@ -187,7 +183,6 @@ static void prepare_logging(void)
 				trip_type_name[ptdata.tzi[i].tp[j].type],
 				ptdata.tzi[i].tp[j].temp);
 		}
-
 	}
 
 	for (i = 0; i <	ptdata.nr_cooling_dev; i++)
@@ -219,7 +214,6 @@ static struct option opts[] = {
 	{ 0, 0, NULL, 0 }
 };
 
-
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -283,7 +277,7 @@ int main(int argc, char **argv)
 	if (signal(SIGINT, tmon_sig_handler) == SIG_ERR)
 		syslog(LOG_DEBUG, "Cannot handle SIGINT\n");
 	if (signal(SIGTERM, tmon_sig_handler) == SIG_ERR)
-		syslog(LOG_DEBUG, "Cannot handle SIGINT\n");
+		syslog(LOG_DEBUG, "Cannot handle SIGTERM\n");
 
 	if (probe_thermal_sysfs()) {
 		pthread_mutex_destroy(&input_lock);
@@ -328,8 +322,7 @@ int main(int argc, char **argv)
 			show_cooling_device();
 		}
 		time_elapsed += ticktime;
-		controller_handler(trec[0].temp[target_tz_index] / 1000,
-				&yk);
+		controller_handler(trec[0].temp[target_tz_index] / 1000, &yk);
 		trec[0].pid_out_pct = yk;
 		if (!dialogue_on)
 			show_control_w();
@@ -340,14 +333,15 @@ int main(int argc, char **argv)
 	return 0;
 }
 
-static void start_daemon_mode()
+static void start_daemon_mode(void)
 {
 	daemon_mode = 1;
 	/* fork */
 	pid_t	sid, pid = fork();
-	if (pid < 0) {
+
+	if (pid < 0)
 		exit(EXIT_FAILURE);
-	} else if (pid > 0)
+	else if (pid > 0)
 		/* kill parent */
 		exit(EXIT_SUCCESS);
 
@@ -366,11 +360,9 @@ static void start_daemon_mode()
 	if ((chdir("/")) < 0)
 		exit(EXIT_FAILURE);
 
-
 	sleep(10);
 
 	close(STDIN_FILENO);
 	close(STDOUT_FILENO);
 	close(STDERR_FILENO);
-
 }
-- 
2.17.1

