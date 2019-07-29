Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4033BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116DE206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4EoeX5A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfG2Vbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:31:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbfG2Vbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:31:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLVarB2940954
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:31:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLVarB2940954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435897;
        bh=HtnNMozDRxlUeuSMOyvRtTrAm3PMgQ9U0Z73vfRsYkI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=4EoeX5A3QdXltF/+3V7MRA0BWLxM8yFSvBhPKLUH2lJu5wNE8PAdEDawH5N3bNIGU
         wot4Lf8tEKn4UeiMly4/0x6NSSXk4T1DkdxEv0Y5Qku7zlBRx3SxqFINdqyR7VLqTR
         HBYspyTVkFbmDFIN2lSiH/EFmsuh0IZW8GJ0gan0w/g2S99HZnT0CxekvKZX663RBk
         dQfiQowRj7dbcSQ6z+5v00oEZDkJse8bZepyZNU3NSRdVFQ1XxDXMMb855HbWhNWkE
         U47Wj73kI9+EhnEgKhEKcGYXT9NjvGfWNPyZgdX/d68tK3Im0sGe1rxd9M6ymapaB4
         oQMeEe2PkhhYA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLVaNj2940951;
        Mon, 29 Jul 2019 14:31:36 -0700
Date:   Mon, 29 Jul 2019 14:31:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3br5e4t64e4lp0goo84che3s@git.kernel.org>
Cc:     lclaudio@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: lclaudio@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools perf beauty: Fix usbdevfs_ioctl table
 generator to handle _IOC()
Git-Commit-ID: 7ee526152db7a75d7b8713346dac76ffc3662b29
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

Commit-ID:  7ee526152db7a75d7b8713346dac76ffc3662b29
Gitweb:     https://git.kernel.org/tip/7ee526152db7a75d7b8713346dac76ffc3662b29
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 15:29:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:42 -0300

tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC()

In addition to _IOW() and _IOR(), to handle this case:

  #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)

That will happen in the next sync of this header file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3br5e4t64e4lp0goo84che3s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/usbdevfs_ioctl.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
index 930b80f422e8..aa597ae53747 100755
--- a/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -3,10 +3,13 @@
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
+# also as:
+# #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
+
 printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
-regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
-	sed -r "s/$regex/\2 \1/g"	| \
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep "$regex" ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\4 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
 printf "#if 0\n"
