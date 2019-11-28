Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF98CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92199215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574906906;
	bh=bp45aXGFjLrhjBcmTTO7+khobR3wD855ApCRaekjeQ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ir5rv9IVd0OS7wY5KHL3jU1xQH/E3PzCxd9zvFYehU1Zi3G3RnjhSTKqWRLEcGR0O
	 TaNS1+4nAfKoZz0fmXg1rCbFBnSjL4q4aoZkg6APrehzpp5Re0pHBqaAaU33t+hj4j
	 34b/eniTHuc53xyDr/8RbzCFm9hgE1pQLNHmE2U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfK1CIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfK1CIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:08:24 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C902D2154A;
        Thu, 28 Nov 2019 02:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574906904;
        bh=bp45aXGFjLrhjBcmTTO7+khobR3wD855ApCRaekjeQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=Di5Maj68FHJk8SQ5s6VUDmLNANWgkwq0mu8yKX933PKNG844Jo2XWjqzKElVCLoq8
         7bnve5yw+bogztNHZcfW2Rv+HUQj6Iz+5zzz015XdZuqczFRgbIw3OjXdr/LGpuZgR
         rHEm9xuEN23tJSaLtihTO8sG1tWYm9EKuaIWA/XM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] checkpatch: Look for Kconfig indentation errors
Date:   Thu, 28 Nov 2019 03:06:40 +0100
Message-Id: <1574906800-19901-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig should be indented with one tab for first level and tab+2 spaces
for second level.  There are many mixups of this so add a checkpatch
rule.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e41f4adcc1be..875e862cf076 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3046,6 +3046,13 @@ sub process {
 			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
 		}
 
+# Kconfig has special indentation
+		if ($realfile =~ /Kconfig/ &&
+		    ($rawline =~ /^\+ +\t* *[a-zA-Z-]/) || ($rawline =~ /^\+\t( |   )[a-zA-Z-]/)) {
+			WARN("CONFIG_INDENTATION",
+			     "Kconfig uses one tab indentation, optionally followed by two spaces.\n" . $herecurr);
+		}
+
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
 		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
 			my $flag = $1;
-- 
2.7.4

