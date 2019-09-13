Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4462EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1007F20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381344;
	bh=x2PMCglwmaK0ap6b7PlhPMCKz/1TSrb7sn8m7dX5dIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRa46nvfDV6HX9AuugYFWA3b1eONzKIki2ovNO7fU8AmjSbeHNtrlLPRyC9nxxd36
	 cUM+3BQPQBC2/HuNIi9YiXT6GBmxejaLhwJqktMLbgI1AY7NoPl/0jBtNGZXHRv2gq
	 00l0RElQpKfCRUcmVl1dJa3eFBj1+A3/v7EH/ya8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfIMNYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390620AbfIMNYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBCFA3086202;
        Fri, 13 Sep 2019 13:24:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32B245C1D4;
        Fri, 13 Sep 2019 13:24:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 01/73] tools: Add missing stdio.h include to asm/bug.h header
Date:   Fri, 13 Sep 2019 15:22:43 +0200
Message-Id: <20190913132355.21634-2-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 13:24:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have direct fprintf call in the header, so we need
stdio.h include, otherwise it could fail compilation
if there's no prior stdio.h include.

Link: http://lkml.kernel.org/n/tip-8hvjgh24olfsa4non0a3ohnq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/asm/bug.h b/tools/include/asm/bug.h
index bbd75ac8b202..550223f0a6e6 100644
--- a/tools/include/asm/bug.h
+++ b/tools/include/asm/bug.h
@@ -3,6 +3,7 @@
 #define _TOOLS_ASM_BUG_H
 
 #include <linux/compiler.h>
+#include <stdio.h>
 
 #define __WARN_printf(arg...)	do { fprintf(stderr, arg); } while (0)
 
-- 
2.21.0

