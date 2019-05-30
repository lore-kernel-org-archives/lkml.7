Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A76C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46325775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KoA5PlIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfE3H7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:59:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3H7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:59:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7xQ3a2900552
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:59:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7xQ3a2900552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203167;
        bh=nRyibxGEEQqTZ+E8biPQIDBXtM0IMf1ryXs2PiCFwWU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=KoA5PlIcXH5ADdKWhXH2nAcHL4QCwUM+vFNLvegjJDjdJw7hr1l4RacsAac3zGWRy
         1hjxr44TSR2taHX7q0mnOlcIWvVy5HIHwLxZuMym85nagHlBs8G0IvgiSxBJ5mu5XB
         DuUsdBRRDlYT24SYQPeWMeAkcjXtiJrL64EpJV6NCZZfxEu3Rx3l+wNCPX8fVsk9jd
         cf16YZDesSObCs8ptnL69b2uN1Nx0Wvq6Z09bPWQQyEcmLFNeEG5ygeG5Kv5JnYC3C
         IEMXc7968LGMCfLgYWhsMx5CRcH/nMeabLxLPi1TRTLqqwNOt4/npLodqqGZbf7mtN
         ShiTKAW1tv43g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7xQvS2900549;
        Thu, 30 May 2019 00:59:26 -0700
Date:   Thu, 30 May 2019 00:59:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8i16btocq1ax2u6542ya79t5@git.kernel.org>
Cc:     viro@zeniv.linux.org.uk, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, brendan.d.gregg@gmail.com,
        acme@redhat.com, dhowells@redhat.com, hpa@zytor.com,
        adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org
Reply-To: dhowells@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
          viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com, brendan.d.gregg@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for fspick's 'flags' arg
 values
Git-Commit-ID: a1c729a5f62c090ba3c510142a6685a1989cc24b
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

Commit-ID:  a1c729a5f62c090ba3c510142a6685a1989cc24b
Gitweb:     https://git.kernel.org/tip/a1c729a5f62c090ba3c510142a6685a1989cc24b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 16:17:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf beauty: Add generator for fspick's 'flags' arg values

  $ tools/perf/trace/beauty/fspick.sh
  static const char *fspick_flags[] = {
          [ilog2(0x00000001) + 1] = "CLOEXEC",
          [ilog2(0x00000002) + 1] = "SYMLINK_NOFOLLOW",
          [ilog2(0x00000004) + 1] = "NO_AUTOMOUNT",
          [ilog2(0x00000008) + 1] = "EMPTY_PATH",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8i16btocq1ax2u6542ya79t5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/{move_mount_flags.sh => fspick.sh} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/fspick.sh
similarity index 63%
copy from tools/perf/trace/beauty/move_mount_flags.sh
copy to tools/perf/trace/beauty/fspick.sh
index 55e59241daa4..b220e07ef452 100755
--- a/tools/perf/trace/beauty/move_mount_flags.sh
+++ b/tools/perf/trace/beauty/fspick.sh
@@ -9,8 +9,8 @@ fi
 
 linux_mount=${linux_header_dir}/mount.h
 
-printf "static const char *move_mount_flags[] = {\n"
-regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([FT]_[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+printf "static const char *fspick_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
 egrep $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
