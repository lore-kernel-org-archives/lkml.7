Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F6920700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfJCMLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfJCMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE33C3086E21;
        Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F5E55C22C;
        Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 2/7] intel-speed-select: Make process_command generic
Date:   Thu,  3 Oct 2019 08:11:07 -0400
Message-Id: <20191003121112.25870-3-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 03 Oct 2019 12:11:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the process_command take any help command and command list.  This
will make it easier to help commands and a command list for CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 1b2899706857..f4a23678416e 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1749,7 +1749,9 @@ static struct process_cmd_help_struct isst_help_cmds[] = {
 	{ NULL, NULL }
 };
 
-void process_command(int argc, char **argv)
+void process_command(int argc, char **argv,
+		     struct process_cmd_help_struct *help_cmds,
+		     struct process_cmd_struct *cmds)
 {
 	int i = 0, matched = 0;
 	char *feature = argv[optind];
@@ -1760,9 +1762,9 @@ void process_command(int argc, char **argv)
 
 	debug_printf("feature name [%s] command [%s]\n", feature, cmd);
 	if (!strcmp(cmd, "-h") || !strcmp(cmd, "--help")) {
-		while (isst_help_cmds[i].feature) {
-			if (!strcmp(isst_help_cmds[i].feature, feature)) {
-				isst_help_cmds[i].process_fn();
+		while (help_cmds[i].feature) {
+			if (!strcmp(help_cmds[i].feature, feature)) {
+				help_cmds[i].process_fn();
 				exit(0);
 			}
 			++i;
@@ -1772,11 +1774,11 @@ void process_command(int argc, char **argv)
 	create_cpu_map();
 
 	i = 0;
-	while (isst_cmds[i].feature) {
-		if (!strcmp(isst_cmds[i].feature, feature) &&
-		    !strcmp(isst_cmds[i].command, cmd)) {
+	while (cmds[i].feature) {
+		if (!strcmp(cmds[i].feature, feature) &&
+		    !strcmp(cmds[i].command, cmd)) {
 			parse_cmd_args(argc, optind + 1, argv);
-			isst_cmds[i].process_fn(isst_cmds[i].arg);
+			cmds[i].process_fn(cmds[i].arg);
 			matched = 1;
 			break;
 		}
@@ -1897,7 +1899,7 @@ static void cmdline(int argc, char **argv)
 	if (ret)
 		goto out;
 
-	process_command(argc, argv);
+	process_command(argc, argv, isst_help_cmds, isst_cmds);
 out:
 	free_cpu_set(present_cpumask);
 	free_cpu_set(target_cpumask);
-- 
2.18.1

