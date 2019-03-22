Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E31E21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfCVWQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:16:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:16:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMGUIc749608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:16:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMGT6Y749602;
        Fri, 22 Mar 2019 15:16:29 -0700
Date:   Fri, 22 Mar 2019 15:16:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-905e4aff31382c3f9b2014d1361f4a1be4479ba2@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, ak@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com
In-Reply-To: <20190311144502.15423-11-andi@firstfloor.org>
References: <20190311144502.15423-11-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Add array bound checking to
 list_scripts
Git-Commit-ID: 905e4aff31382c3f9b2014d1361f4a1be4479ba2
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

Commit-ID:  905e4aff31382c3f9b2014d1361f4a1be4479ba2
Gitweb:     https://git.kernel.org/tip/905e4aff31382c3f9b2014d1361f4a1be4479ba2
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:45:01 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:33:19 -0300

perf script: Add array bound checking to list_scripts

Don't overflow array when the scripts directory is too large, or the
script file name is too long.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index cdba58447b85..96e5cd3b0eee 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -97,7 +97,8 @@ static int list_scripts(char *script_name, bool *custom,
 		paths[i] = names[i] + SCRIPT_NAMELEN;
 	}
 
-	num = find_scripts(names + max_std, paths + max_std);
+	num = find_scripts(names + max_std, paths + max_std, SCRIPT_MAX_NO - max_std,
+			SCRIPT_FULLPATH_LEN);
 	if (num < 0)
 		num = 0;
 	choice = ui__popup_menu(num + max_std, (char * const *)names);
