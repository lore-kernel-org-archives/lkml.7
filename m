Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE19C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD9214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356259;
	bh=2uihvhbYNTPwWXGqP31wRkXN0WtcFnzMbQOux+O6tP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iK2cCOt+7lHFtTTNxR6G3xrHjjn6PCBYlrMgKoey3FUfQZXNiIqcGE3xO/6U2qOLW
	 eP95U6uXAbAZY71ch+x2worjpOcD1ZRbdo7NLtgYHr+G72KWVsb9CUmXf78oRzF8jj
	 kDOnFAhmTHuwhH3/igVNN9PbayhpGFrcnZstgMBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfCLCER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfCLCEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:04:00 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD01217F5;
        Tue, 12 Mar 2019 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356239;
        bh=2uihvhbYNTPwWXGqP31wRkXN0WtcFnzMbQOux+O6tP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Arp+7csImoecbZg6PQIfqMawymcAU90AtS3P1DDTRBtfkCKNPeeHB7DQZPtUBBkK5
         Z/8nH1R7qVV6UiWAaVmqY2ota4a81DhUEAyZqZfzh1yfAQgv4m+WNBtVEPBnK25zIc
         4oYUwD6/CvTTujOd2LwVbaPfkxtR/X0HEZ1bgpw8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/30] perf script: Add array bound checking to list_scripts
Date:   Mon, 11 Mar 2019 23:02:02 -0300
Message-Id: <20190312020204.22092-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

