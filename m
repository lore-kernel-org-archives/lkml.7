Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0FC2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901697;
	bh=1sWrHCNmxVfJI95nB5UKrV6LdQp8oio9h65LtjMIrKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vG+HP2Y3gmhU52pzPnAHxAl8WA0tGh8DWP7yGqsD5qPOkMt+PRVUBWLAjNIwPFEPr
	 R+WMXot6Xn9enaGGUus5fQ5+TUOR8jNnzRgbreGbnr9d/WDlbU7WGsl/6b5+Q51XeI
	 JXObkE79yzGImbLqNF3LWIrsfACPwL9c3ykAEx7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfCRJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfCRJex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1571F214AF;
        Mon, 18 Mar 2019 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901692;
        bh=1sWrHCNmxVfJI95nB5UKrV6LdQp8oio9h65LtjMIrKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja1M798NgffMqfSgS9LX0hPxu4EtSCtYzwBhGtxL4eneJgTxktFnMXbF+YjwAzL5Y
         /crrZi9RukP/iqu/TtAr3q072GzJ8G2wOxYmd0Jg24mDCJzhxgZm85egVMTlUz6hFh
         jJRzxl9ZNLc85nLmOzslGzQFvh6iGiMT8ftHlaLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
Subject: [PATCH 4.14 02/34] perf tools: Fix compile error with libunwind x86
Date:   Mon, 18 Mar 2019 10:25:26 +0100
Message-Id: <20190318084144.978483715@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Nan <wangnan0@huawei.com>

commit 44df1afdb174fd6038e419f80efd914c0b5f2f85 upstream.

Fix a compile error:

 ...
   CC       util/libunwind/x86_32.o
 In file included from util/libunwind/x86_32.c:33:0:
 util/libunwind/../../arch/x86/util/unwind-libunwind.c: In function 'libunwind__x86_reg_id':
 util/libunwind/../../arch/x86/util/unwind-libunwind.c:110:11: error: 'EINVAL' undeclared (first use in this function)
    return -EINVAL;
            ^
 util/libunwind/../../arch/x86/util/unwind-libunwind.c:110:11: note: each undeclared identifier is reported only once for each function it appears in
 mv: cannot stat 'util/libunwind/.x86_32.o.tmp': No such file or directory
 make[4]: *** [util/libunwind/x86_32.o] Error 1
 make[3]: *** [util] Error 2
 make[2]: *** [libperf-in.o] Error 2
 make[1]: *** [sub-make] Error 2
 make: *** [all] Error 2

It happens when libunwind-x86 feature is detected.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20171206015040.114574-1-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Díaz <daniel.diaz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/x86/util/unwind-libunwind.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/arch/x86/util/unwind-libunwind.c
+++ b/tools/perf/arch/x86/util/unwind-libunwind.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifndef REMOTE_UNWIND_LIBUNWIND
 #include <errno.h>
+#ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"


