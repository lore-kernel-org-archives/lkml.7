Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B5DC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515B1205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414257;
	bh=TFRIsLVic/O+RLsMhA7fZpDXFpBlFWSv6DFH+9le0Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CF0jr0JkrW+AjmB1HsS8OvUoxfGPvNNidDl2GfqBkwg3s2E8Y15IDEJ1L1qOGYcd8
	 xY8FL3hDCDXwvOqyADDeXPrbHxw6LTDQ/LL1Y4CkojkbhivyboN/j04dkydaexX7zC
	 SfeRE1MJl3Cc45iGUV1I7bLINEUhB6xAVce5H5/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfCLSKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfCLRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7475721741;
        Tue, 12 Mar 2019 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410709;
        bh=TFRIsLVic/O+RLsMhA7fZpDXFpBlFWSv6DFH+9le0Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfN7pKaxOIFwOuHgqMFepGEQOzApUz0/tMdvF1djppLFXWnl7v71IzYUeo6FOZxPZ
         lvb5D6xxxrbqUHRJpkXlfB9powYqPM3uAX/ALDuDXcT2uu6i6t2jSTxuAUz6mCEoOX
         rck5xzTBJ7pURlGWgY+JGAotR/dS2jE+RrnVWe4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 009/171] perf python: Remove -fstack-clash-protection when building with some clang versions
Date:   Tue, 12 Mar 2019 10:06:29 -0700
Message-Id: <20190312170348.683796579@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 94ec1eb711db69be1414b56b3160b816e86a5c5b ]

These options are not present in some (all?) clang versions, so when we
build for a distro that has a gcc new enough to have these options and
that the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora rawhide (now gearing towards f30), so check
if clang has the  and remove the missing ones from CFLAGS.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thiago Macieira <thiago.macieira@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5q50q9w458yawgxf9ez54jbp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 63f758c655d5..64d1f36dee99 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-mcet", "", vars[var])
         if not clang_has_option("-fcf-protection"):
             vars[var] = sub("-fcf-protection", "", vars[var])
+        if not clang_has_option("-fstack-clash-protection"):
+            vars[var] = sub("-fstack-clash-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.19.1



