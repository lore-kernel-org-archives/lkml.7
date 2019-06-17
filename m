Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC0C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CqvU74Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfFQTFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:05:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:05:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ4lK13556909
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:04:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ4lK13556909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798287;
        bh=Bhyh4t1aHK4kXDWtnoLXpFJA0caSpHxkZicLf55t41E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CqvU74KrNFtZzeIArlguVY/UIAhkxt7LyfuXEdkz0cHjnz/rnzK3jH4asAM8lNMua
         xipsrifbM/1SS+Yan6w9d4CEeWzRR1PwANseubQUN/kzkaVTCdU4g2R/uvskOxKhBX
         oS/J3uY4oJ/yoGvFfKF7ewyyHlxmy4kDnPBYR7B/U5TRuYpLu3O0iU3m5qAs96tOsP
         FgmKXKt7gMZE/4PfkAdGLuEc/+FgoM9rb3FtbQiX2++/sPiLKIcMl7Y3iSU/kxzez2
         gpy+HtPxzxjoxMSNDPRTAYGgkhFJHAFV7Iaf+I4cfVzN75ZaXHJvkqOsegF6nYTWG+
         jdhANsPY4ehmg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ4lYS3556906;
        Mon, 17 Jun 2019 12:04:47 -0700
Date:   Mon, 17 Jun 2019 12:04:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5db47f43ccbbdee8c48f76ace4c287187a28b87f@git.kernel.org>
Cc:     jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
          jolsa@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190520113728.14389-13-adrian.hunter@intel.com>
References: <20190520113728.14389-13-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Document IPC usage
Git-Commit-ID: 5db47f43ccbbdee8c48f76ace4c287187a28b87f
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

Commit-ID:  5db47f43ccbbdee8c48f76ace4c287187a28b87f
Gitweb:     https://git.kernel.org/tip/5db47f43ccbbdee8c48f76ace4c287187a28b87f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:18 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf intel-pt: Document IPC usage

Add brief documentation about instructions-per-cycle (IPC) information
derived from Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 60d99e5e7921..50c5b60101bd 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -103,6 +103,36 @@ The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
 in transaction, respectively.
 
+Another interesting field that is not printed by default is 'ipc' which can be
+displayed as follows:
+
+	perf script --itrace=be -F+ipc
+
+There are two ways that instructions-per-cycle (IPC) can be calculated depending
+on the recording.
+
+If the 'cyc' config term (see config terms section below) was used, then IPC is
+calculated using the cycle count from CYC packets, otherwise MTC packets are
+used - refer to the 'mtc' config term.  When MTC is used, however, the values
+are less accurate because the timing is less accurate.
+
+Because Intel PT does not update the cycle count on every branch or instruction,
+the values will often be zero.  When there are values, they will be the number
+of instructions and number of cycles since the last update, and thus represent
+the average IPC since the last IPC for that event type.  Note IPC for "branches"
+events is calculated separately from IPC for "instructions" events.
+
+Also note that the IPC instruction count may or may not include the current
+instruction.  If the cycle count is associated with an asynchronous branch
+(e.g. page fault or interrupt), then the instruction count does not include the
+current instruction, otherwise it does.  That is consistent with whether or not
+that instruction has retired when the cycle count is updated.
+
+Another note, in the case of "branches" events, non-taken branches are not
+presently sampled, so IPC values for them do not appear e.g. a CYC packet with a
+TNT packet that starts with a non-taken branch.  To see every possible IPC
+value, "instructions" events can be used e.g. --itrace=i0ns
+
 While it is possible to create scripts to analyze the data, an alternative
 approach is available to export the data to a sqlite or postgresql database.
 Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
