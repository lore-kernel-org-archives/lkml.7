Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4772C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D4218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610851;
	bh=OY6E5iDXBC33Y/uLNNre8SXkSb+jKPJ3hr6jwr40KG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pldxRZpXLAiboXnY5JVdPgWfvIFH/pNe4Wn9BGpFx6jBZMtDUhW8ZxFDVgYAa6gyI
	 5A0hCUWsbJqXUc4T6BLQ223PC1Bt6orpttiqtmsDaV5yPnPdWZux2enIY6lWw+f3Ka
	 jqwnTPOGLBB2879r/xa6p4DbhCyIHwK5g6UrhJpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfDRSHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403766AbfDRSH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6CF206B6;
        Thu, 18 Apr 2019 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610847;
        bh=OY6E5iDXBC33Y/uLNNre8SXkSb+jKPJ3hr6jwr40KG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgaBiWRvT7e+s5ANxG5zmxcS/Q7dtFvi/M/yhgGvSyYYnE2hbJXY7vjdSon34R4Fy
         Ecm8BzLcDXu4rRkVrmRk48r0VGirHaWJ/hT5wP6864fmC7tFEAiWNdbkdvB52m/Vt3
         k06iEk27R3YliTjJhYN22k0NuIK8+vyRmXDXco7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/50] perf config: Fix a memory leak in collect_config()
Date:   Thu, 18 Apr 2019 19:57:25 +0200
Message-Id: <20190418160424.493476252@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 54569ba4b06d5baedae4614bde33a25a191473ba ]

Detected with gcc's ASan:

  Direct leak of 66 byte(s) in 5 object(s) allocated from:
      #0 0x7ff3b1f32070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x560c8761034d in collect_config util/config.c:597
      #2 0x560c8760d9cb in get_value util/config.c:169
      #3 0x560c8760dfd7 in perf_parse_file util/config.c:285
      #4 0x560c8760e0d2 in perf_config_from_file util/config.c:476
      #5 0x560c876108fd in perf_config_set__init util/config.c:661
      #6 0x560c87610c72 in perf_config_set__new util/config.c:709
      #7 0x560c87610d2f in perf_config__init util/config.c:718
      #8 0x560c87610e5d in perf_config util/config.c:730
      #9 0x560c875ddea0 in main /home/changbin/work/linux/tools/perf/perf.c:442
      #10 0x7ff3afb8609a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 20105ca1240c ("perf config: Introduce perf_config_set class")
Link: http://lkml.kernel.org/r/20190316080556.3075-6-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 18dae745034f..1d66f8eab9f9 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -595,11 +595,10 @@ static int collect_config(const char *var, const char *value,
 	}
 
 	ret = set_value(item, value);
-	return ret;
 
 out_free:
 	free(key);
-	return -1;
+	return ret;
 }
 
 static int perf_config_set__init(struct perf_config_set *set)
-- 
2.19.1



