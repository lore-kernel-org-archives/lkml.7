Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE687216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434928;
	bh=ABDAsX+wURRlOyp3g0NFQdou0yU3JPaYlh7SYpsQsFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1lTtBY4K15OeDs1YE/Me24wgb72ycvBktyoO0ug4JYx2I1FHej3Lz5IQSff+lW0g
	 0WMKcqZr7Fz6PTfD5NQ61xYPT3+eLeL8BAGNhRVifZSzVaQ77PkyQH7CauHS2BlbAP
	 LBO0OOKuy8DjUcApgzBYpLmQtdde4OCIgowlVx0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbfG2VP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbfG2VPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248BD2073F;
        Mon, 29 Jul 2019 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434922;
        bh=ABDAsX+wURRlOyp3g0NFQdou0yU3JPaYlh7SYpsQsFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fY5BQkgpRKt5Igv2Iiz+VdsEobSvX7IKfS/JGpPDTigc6L6091JzVva0R2PkUa9i/
         rX33MYoanIyrCiEO1W8C05snRn5wEKsKSMXZLR643M83c8OmqK9bsyEsMSpIscchBv
         xyucvruYeXLgjBmjb74nfhrTy2AZwXpiICHU0PTY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 05/12] tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC()
Date:   Mon, 29 Jul 2019 18:14:52 -0300
Message-Id: <20190729211456.6380-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

