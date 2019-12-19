Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D99D21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576744465;
	bh=nXBcbdavfQlBqussgPEqGhS57h0gmrMabpD9I0AI+Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmhzMm7F+viWn0stiSk6ntilF8RlHm+dKzuRZ1kEvkrPEESTJjojhw1VonrkTnoUI
	 oSfrOtBXCBRAls6o5RVkAmdRkRSCCvOa3/JvGfIR1WyROEKQkA+/LsrMqryAvtvga4
	 Xucoy6DPhQzdzPJfT7iygwHO3qG5SW3GYghgu+Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSIeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:34:24 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:36429 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:34:23 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBJ8XVeC026051;
        Thu, 19 Dec 2019 17:33:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBJ8XVeC026051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576744413;
        bh=WpNGRRL3ApeUZCXR7WsToJcw8YyXRXseP3cXmGw9qws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbrhxn9egqRanIe7sydf7vNaB/QOc6l3r/TWEuh+6O/0KF9+PbkLILeq3FW2mZp5r
         jUIWodXtxjbD40N1N0byHL+BLSPvns5r6BULArr+4AUbOjlQjcvPFOaiXgcy/k4PFf
         7U8Kw+Q3CxB+/nz8vO/ppsQKiar5vDL7VKWdz9Zbvh3/ygCWXdxjDr3L3FrZPnvAAl
         p2BDZzld1yBfd0WPRE+lzvjDQvEvlM3EGkEpMXJsqp1pDEXtxEEAk7AT54IFHqhCYN
         DFmzAh6VPgtZId/CEbzTX+kvW58y2QfHx3HVhggaAEMCqWLLQhXYxEqo/ugm6voapr
         b11KyHgKGDNDg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: add stringify helper to quote a string passed to C files
Date:   Thu, 19 Dec 2019 17:33:27 +0900
Message-Id: <20191219083329.5926-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219083329.5926-1-masahiroy@kernel.org>
References: <20191219083329.5926-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make $(squote)$(quote)...$(quote)$(squote) a helper macro.
I will reuse it in the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include | 4 ++++
 scripts/Makefile.lib   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index bc5f25763c1b..88c144787e57 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -32,6 +32,10 @@ real-prereqs = $(filter-out $(PHONY), $^)
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
+###
+# Quote a string to pass it to C files. foo => '"foo"'
+stringify = $(squote)$(quote)$1$(quote)$(squote)
+
 ###
 # Easy method for doing a status message
        kecho := :
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fa32f83b2d7..e4c47ad2899d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -93,7 +93,7 @@ target-stem = $(basename $(patsubst $(obj)/%,%,$@))
 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
-name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
+name-fix = $(call stringify,$(subst $(comma),_,$(subst -,_,$1)))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
 
-- 
2.17.1

