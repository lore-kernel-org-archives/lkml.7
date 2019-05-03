Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D275C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D304F2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843160;
	bh=b9eEv8tb5ZmIOQ5hHJc/agdjrTf1d6CDQxXFTHvdeEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0/37AvZx8pU8fk7yoVXCF6kfdQLnNIfgWhfzqYv3V2Nbhb5OBbY5OmcZXlcBCRp/
	 rwlCRRAD1MGAIenSwUDeBE3uKJS82HwUxPO98bU8n7ZuXfcvkmzdKiymlPFY0gB/Bx
	 broGSamnASEFANWglTQo1z4sNw1YHtZuZQWoeALU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfECA0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfECAZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:25:58 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227532087F;
        Fri,  3 May 2019 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843157;
        bh=b9eEv8tb5ZmIOQ5hHJc/agdjrTf1d6CDQxXFTHvdeEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F58Gc31W2vzq9TLvIuE6mODrjbkuFmfb1/mbpI3p8s6Os6yxI4LjnCvoQZxRs/vHp
         fs7o6BDzVAG3gRzUCbJhIBYRp4N5c+MOAquXds5GNe+R1xPnJYIqbJO+Vk5Bl2+pUW
         2XejJ+tEXbfp8lCyPdkhRwQx37EM5FIRVon6ESYc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/11] tools lib traceevent: Change tag string for error
Date:   Thu,  2 May 2019 20:25:26 -0400
Message-Id: <20190503002533.29359-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The traceevent lib is used by the perf tool, and when executing

  perf test -v 6

it outputs error log on the ARM64 platform:

  running test 33 '*:*'trace-cmd: No such file or directory

  [...]

  trace-cmd: Invalid argument

The trace event parsing code originally came from trace-cmd so it keeps
the tag string "trace-cmd" for errors, this easily introduces the
impression that the perf tool launches trace-cmd command for trace event
parsing, but in fact the related parsing is accomplished by the
traceevent lib.

This patch changes the tag string to "libtraceevent" so that we can
avoid confusion and let users to more easily connect the error with
traceevent lib.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190424013802.27569-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index 77e4ec6402dd..e99867111387 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -14,7 +14,7 @@
 void __vwarning(const char *fmt, va_list ap)
 {
 	if (errno)
-		perror("trace-cmd");
+		perror("libtraceevent");
 	errno = 0;
 
 	fprintf(stderr, "  ");
-- 
2.20.1

