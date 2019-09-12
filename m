Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347EC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B889120830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I+g5chcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfILHds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 03:33:48 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:43163 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:33:47 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x8C7XbgA018895;
        Thu, 12 Sep 2019 16:33:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x8C7XbgA018895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568273620;
        bh=pv44XTP6ZfWgIUysfDsiZqGnj8xj7NDBDRlFeIGA84g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+g5chcLlIDpARKarWd1h8kPMPDRdX2ak4F2bhQSgK5RIhxJYxvrrNcqOwtELDXQ+
         r7dx6z4/ump7yNMjRmBHVR8uucYqp/65wbDtjAslwvDglc4ErPRFF0VrlQg4PHBZg5
         yzQjalhq6rNYKH6Dqzxx32lHsdWVoAMNGc3Cr7bovxP94tnj8qsfzMV6o2HWQVD5kd
         eFnUcKgs5jqcLg0voqGtoKtX26PTl5eYWMrdNIKXzvlMxViUqRzqZ/qzJyENEKOEM/
         4DgeqAbsf7iew2We9AULrjjgdxWuZEbBi4oNo2QuMz2XifMbDHX9UWNw2RGOHuVUKG
         5/+TDvqKvXTUw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: change need-modorder implementation slightly
Date:   Thu, 12 Sep 2019 16:33:35 +0900
Message-Id: <20190912073336.7036-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912073336.7036-1-yamada.masahiro@socionext.com>
References: <20190912073336.7036-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align with the need-builtin implementation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 +-
 scripts/Makefile.lib   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d30b04707fec..91617b9d7a34 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -528,7 +528,7 @@ $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
 	$(if $(filter $@/, $(KBUILD_SINGLE_TARGETS)),single-build=) \
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-obj-y)),1) \
-	need-modorder=$(if $(need-modorder),$(if $(filter $@/modules.order, $(modorder)),1))
+	need-modorder=$(if $(filter $@/modules.order, $(modorder)),1)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 07095d3789a1..034e92ea72c6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -23,7 +23,9 @@ lib-y := $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))
 # Determine modorder.
 # Unfortunately, we don't have information about ordering between -y
 # and -m subdirs.  Just put -y's first.
+ifdef need-modorder
 modorder	:= $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m:.o=.ko))
+endif
 
 # Handle objects in subdirs
 # ---------------------------------------------------------------------------
-- 
2.17.1

