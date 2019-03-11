Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C9C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCKOpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:45:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:29004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfCKOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="150619563"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4D594301ADF; Mon, 11 Mar 2019 07:45:10 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 10/11] perf tools script: Add array bound checking to list_scripts
Date:   Mon, 11 Mar 2019 07:45:01 -0700
Message-Id: <20190311144502.15423-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311144502.15423-1-andi@firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Don't overflow array when the scripts directory is too large,
or the script file name is too long.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c      | 8 ++++++--
 tools/perf/builtin.h             | 3 ++-
 tools/perf/ui/browsers/scripts.c | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b695b20ffc8a..2f93d60c5a17 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2982,7 +2982,8 @@ static int check_ev_match(char *dir_name, char *scriptname,
  * will list all statically runnable scripts, select one, execute it and
  * show the output in a perf browser.
  */
-int find_scripts(char **scripts_array, char **scripts_path_array)
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen)
 {
 	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
@@ -3027,7 +3028,10 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 			/* Skip those real time scripts: xxxtop.p[yl] */
 			if (strstr(script_dirent->d_name, "top."))
 				continue;
-			sprintf(scripts_path_array[i], "%s/%s", lang_path,
+			if (i >= num)
+				break;
+			snprintf(scripts_path_array[i], pathlen, "%s/%s",
+				lang_path,
 				script_dirent->d_name);
 			temp = strchr(script_dirent->d_name, '.');
 			snprintf(scripts_array[i],
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3ce912..999fe9170122 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -40,5 +40,6 @@ int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
 
-int find_scripts(char **scripts_array, char **scripts_path_array);
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen);
 #endif
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 5d407ab834b5..6759d6657e1a 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -117,7 +117,8 @@ static int list_scripts(char *script_name, bool *custom,
 		paths[i] = names[i] + SCRIPT_NAMELEN;
 	}
 
-	num = find_scripts(names + max_std, paths + max_std);
+	num = find_scripts(names + max_std, paths + max_std, SCRIPT_MAX_NO - max_std,
+			SCRIPT_FULLPATH_LEN);
 	if (num < 0)
 		num = 0;
 	choice = ui__popup_menu(num + max_std, (char * const *)names);
-- 
2.20.1

