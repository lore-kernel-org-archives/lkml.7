Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E7DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2482177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710401;
	bh=8TAwaKG1VvgoFcR6NMI8mzJ0+bwY/i1GL2QnJsrG6Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIdSgC2WgHBBQwsezxh/JN1Xhf6CxeB1w0dfukBnoeV3Pkjmijgsf+1Cjd8rx+wr9
	 ErdPjXwObtoXQUBvmk/1zdtWLssZ9R1lElCia653jpH7SfQv+6c5EZiUeTmkYM0WMc
	 d+hicGpD0Mx/xvBqACJR7k6/DVwVOTxZC02UtbLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfC0SNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfC0SNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E112147C;
        Wed, 27 Mar 2019 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710395;
        bh=8TAwaKG1VvgoFcR6NMI8mzJ0+bwY/i1GL2QnJsrG6Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfCFz6VJYFVts45UVUj+uaVEoHx7XPNCo+JhJYJyXgCGpKIp2epTG2XhfiiQ+bGwG
         bwXhCeYQWFn4EZqvWXg6JFu280LNTqxzVmHUjorEjK7SDVYkevguC3zCsTaWph6bgf
         WxGfsscybTHMEP3JxbJqDF+toIxr3Jn5AEm4pS3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 099/192] perf report: Add s390 diagnosic sampling descriptor size
Date:   Wed, 27 Mar 2019 14:08:51 -0400
Message-Id: <20190327181025.13507-99-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 2187d87eacd46f6214ce3dc9cfd7a558375a4153 ]

On IBM z13 machine types 2964 and 2965 the descriptor
sizes for sampling and diagnostic sampling entries
might be missing in the trailer entry and are set to zero.

This leads to a perf report failure when processing diagnostic
sampling entries.

This patch adds missing descriptor sizes when the trailer entry
contains zero for these fields.

Output before:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  0xabbf0 [0x8]: failed to process type: 68
  Error:
  failed to process sample
  [root@s38lp82 perf]#

Output after:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  # Total Lost Samples: 0
  # Samples: 3K of event 'SF_CYCLES_BASIC_DIAG'
  # Samples: 162  of event 'CF_DIAG'
  [root@s38lp82 perf]#

Fixes: 2b1444f2e28b ("perf report: Add raw report support for s390 auxiliary trace")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190211100627.85714-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/s390-cpumsf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index aa7f8c11fbb7..910f2621d211 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -294,6 +294,11 @@ static bool s390_cpumsf_validate(int machine_type,
 			*dsdes = 85;
 			*bsdes = 32;
 			break;
+		case 2964:
+		case 2965:
+			*dsdes = 112;
+			*bsdes = 32;
+			break;
 		default:
 			/* Illegal trailer entry */
 			return false;
-- 
2.19.1

