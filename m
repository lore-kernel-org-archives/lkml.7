Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4254FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E3214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239230;
	bh=FESUteCjHCIC3OUGqfhK24bZ1hYjA2REQ8WFzkI7KM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M34NBzFjzGxKBi+hB+OtXBXAMyIBQa7OxxSg5jhxoch5ip84aPPYCPdxWGbYqfMm8
	 D1wOpSno0OU9SD+mRK+lw/aYjXEOFfcwf5gIzD0J/hMHVm4KO8O0SN5uVBmpMlZDc9
	 HCNwn6oGZnbCsLjRv0LK7YXMEJIYSpeWQeGdZmjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfKHSxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbfKHSxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC56218AE;
        Fri,  8 Nov 2019 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239225;
        bh=FESUteCjHCIC3OUGqfhK24bZ1hYjA2REQ8WFzkI7KM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beS23Z4k9SivVP40Oux4uHFhvWYovT9SIVBgvyFE6Hd4YfWFxxNFm9/OM0KzeWPiO
         vWQIuPFjufHegrY0jvLzymK+Yc6XBUs94JiTrHAD/T1L6YzWWTKj79kOOykvAdRayr
         grijDad40JIP6Co0reoeMwuHrqYMy7U18rlA2DAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 09/75] perf kmem: Fix memory leak in compact_gfp_flags()
Date:   Fri,  8 Nov 2019 19:49:26 +0100
Message-Id: <20191108174716.453428412@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit 1abecfcaa7bba21c9985e0136fa49836164dd8fd ]

The memory @orig_flags is allocated by strdup(), it is freed on the
normal path, but leak to free on the error path.

Fix this by adding free(orig_flags) on the error path.

Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-kmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 93ce665f976f6..b62f2f139edf2 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -664,6 +664,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 			new = realloc(new_flags, len + strlen(cpt) + 2);
 			if (new == NULL) {
 				free(new_flags);
+				free(orig_flags);
 				return NULL;
 			}
 
-- 
2.20.1



