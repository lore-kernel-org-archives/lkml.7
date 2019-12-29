Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E555C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0274222C2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640296;
	bh=ZCMHAaOSkNrzJ6fpbCd+rm7Im/wppjlfjKJwI1hVsCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wk9NADhnTb/aFG5n7UzNjfuFaPs3S1jRvu+0w9vxpcV7On3klUVxvCJA3EkDbXPJH
	 5A3ZgceQUMrOYZTxJK0n2igOcxFE2KxoqKiHuLqBH8P/S9NfcrXXjeeOBNrqPjl0Wn
	 CprIFK2ZFBwti37tFp5IJaFp110j+eW8C8Q3ughU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfL2RY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfL2RYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:24:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF07D20722;
        Sun, 29 Dec 2019 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640291;
        bh=ZCMHAaOSkNrzJ6fpbCd+rm7Im/wppjlfjKJwI1hVsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3/8yAcfqZSCRqDU3srC/OJxhWgqSTARnLuyK+Lql21MwU2oZPMfPdWnV8JYu/vXY
         /PhCKo1LBItY3sHxSnzxP/Pdz03w3iAXLfdLcVJt59ez4zj/HhAfafhlbguv+GpWrU
         ec5Vc0jsgwjJ2BaFa7MC9zW/J3Bq1O4SrD1pCwjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, nd <nd@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 098/161] libsubcmd: Use -O0 with DEBUG=1
Date:   Sun, 29 Dec 2019 18:19:06 +0100
Message-Id: <20191229162426.732486117@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <James.Clark@arm.com>

[ Upstream commit 22bd8f1b5a1dd168ba4eba27cb17643a11012f5d ]

When a 'make DEBUG=1' build is done, the command parser is still built
with -O6 and is hard to step through, fix it making it use -O0 in that
case.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: nd <nd@arm.com>
Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..5dbb0dde208c 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -28,7 +28,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS += -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
-- 
2.20.1



