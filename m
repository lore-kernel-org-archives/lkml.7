Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F5AC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA8720656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N0iuR5o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfHOJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:36:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbfHOJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:36:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9aiar2275415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:36:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9aiar2275415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861805;
        bh=3HKRKHGqClWBjEMXGAW44Wa6JdPTStv+aPbdtbpPGbg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=N0iuR5o0qX6P0zMsgY6s1Dqedn/AoIGlo6+c02Rbb6Xqj7dAz7xog/YuJQC9+XtaE
         Qpuh8N8dUDHQ5h5rqHooN0OaHMJSFjZWBr4uLGMwtQHxMVu2JVEgWnNNtUIR3OAv+C
         LsKVJzqnkkQunueFYE4ancerLbhdVsoIs4LehRl+6kZonGueyvbCtP9mmD+Eg7A53v
         JydYtt3srv9M1/ZL0p3AzsM4c5ou/K7aqiWbspYhztC+ml40qePbIW1mCydrQvNTP3
         Z963IcKUJsROSlWeGYF6RVIJOic+dLLlZch7aDv5jnoFisXKKhKA2hq2oPLuFrg9Oe
         jZpD8eoj0+EzA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9aiMn2275411;
        Thu, 15 Aug 2019 02:36:44 -0700
Date:   Thu, 15 Aug 2019 02:36:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dda0acxqef1k72n9z4myjbjt@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com
Reply-To: acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ui: No need to set ui_browser to 1 twice
Git-Commit-ID: 1cd8fa288eb83c1fe0dfa492b09d228a8d802fbf
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

Commit-ID:  1cd8fa288eb83c1fe0dfa492b09d228a8d802fbf
Gitweb:     https://git.kernel.org/tip/1cd8fa288eb83c1fe0dfa492b09d228a8d802fbf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 13 Aug 2019 12:07:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 11:00:00 -0300

perf ui: No need to set ui_browser to 1 twice

We need to do it only when fallbacking from GTK to the TUI.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dda0acxqef1k72n9z4myjbjt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 44fe824e96cd..3bc7c9a6fae9 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -89,9 +89,9 @@ void setup_browser(bool fallback_to_pager)
 		printf("GTK browser requested but could not find %s\n",
 		       PERF_GTK_DSO);
 		sleep(1);
+		use_browser = 1;
 		/* fall through */
 	case 1:
-		use_browser = 1;
 		if (ui__init() == 0)
 			break;
 		/* fall through */
