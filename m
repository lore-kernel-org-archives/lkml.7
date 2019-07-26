Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFAA22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148448;
	bh=w/KW5ObIhciXvw3i0+grY7jHEW6Jfw7aZ9qTvrIzwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OuR704+++i4IAM5yQsvsUtAFeXyn3tI9GnS1JUtLQDfUa2VQprHxOrdVeF8k5KV8L
	 YSfpsmubWocKF+FWAqrDi7P3tziKNW3nkNr4rwwqAUAdTwhVo6haM5ZjswQRLFkVNW
	 jdyZKQ96N2lwIDsE2viPjoMlnYQ2n4WFAkuq6ois=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfGZNkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387567AbfGZNkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C92922BE8;
        Fri, 26 Jul 2019 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148444;
        bh=w/KW5ObIhciXvw3i0+grY7jHEW6Jfw7aZ9qTvrIzwAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZ7Bmqo1Wo0esvXPfMTwtVAGCtZ9pQ51NwO34p77JMXcQsiXj/kPCyPZl4rkpVAdk
         mP5RkHyFX52ZZNT/fihgcrCvuXYCM1m1UXkwPE0dsRKrhLwubj32jbU+XVuAzphdkq
         T7rz//YPxdG+gnvv3PjWCk7u1+kbi7/bUkNNGP0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 42/85] perf version: Fix segfault due to missing OPT_END()
Date:   Fri, 26 Jul 2019 09:38:52 -0400
Message-Id: <20190726133936.11177-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

[ Upstream commit 916c31fff946fae0e05862f9b2435fdb29fd5090 ]

'perf version' on powerpc segfaults when used with non-supported
option:
  # perf version -a
  Segmentation fault (core dumped)

Fix this.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Tested-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190611030109.20228-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index f470144d1a70..bf114ca9ca87 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -19,6 +19,7 @@ static struct version version;
 static struct option version_options[] = {
 	OPT_BOOLEAN(0, "build-options", &version.build_options,
 		    "display the build options"),
+	OPT_END(),
 };
 
 static const char * const version_usage[] = {
-- 
2.20.1

