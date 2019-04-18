Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE79C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612058;
	bh=ZCvMKzLXxbZnvsiDsVEHm0Phwtf0R4SDPJ7KONIhiE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2eWQHlyi/6IrgS88X2cvlZk2RNqPwpWgL3Rv78glwKlTcSbVtSNeWxjdJ2vcu63D
	 SC2lMDllf+4ngPsc0KBt1PfvNRk09inOfos93L+9F7tH8ieCiv8jR3ebOG4hEnHkBw
	 AOl7AghppfX56QIO+ueOIdbeuANwNdnMuujPRvWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbfDRSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390994AbfDRSDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6D8218AF;
        Thu, 18 Apr 2019 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610631;
        bh=ZCvMKzLXxbZnvsiDsVEHm0Phwtf0R4SDPJ7KONIhiE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mp7/Fo46RDMmziePXpX1kamp1aXHZVD1wy+rULQJxZRx4Z8HQ0e298+Ctzr1htQW7
         Ry3wxPt07gUs3I3Mb3rC5vsp4EQZOZe0x/KzLj9xZPNWiYKMxyagNATOuUyhblpZ9r
         S6ZGiMZ887J3QTdsj2lnPpy+vw/Spq0BUU0QyWhM=
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/92] perf top: Fix error handling in cmd_top()
Date:   Thu, 18 Apr 2019 19:56:42 +0200
Message-Id: <20190418160432.590114288@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 70c819e4bf1c5f492768b399d898d458ccdad2b6 ]

We should go to the cleanup path, to avoid leaks, detected using gcc's
ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-9-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3103a33c13a8..133eb7949321 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1345,8 +1345,9 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
-	if (symbol__init(NULL) < 0)
-		return -1;
+	status = symbol__init(NULL);
+	if (status < 0)
+		goto out_delete_evlist;
 
 	sort__setup_elide(stdout);
 
-- 
2.19.1



