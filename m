Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4462C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937C7233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494085;
	bh=cAGKbp3yMg0hERRPg2YNZCl7JyFl8IEGDe/FMwXLKGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqguBNftVLR2t76sYxFeHyjpYSZvx6ClYUbVxZ48nfDDo0oqoWbzXCjcqvEc0XBK0
	 4NZeSp8GBuaDrgYdtmXBPmYgRynmoGwv3WU3BuKf7CwmHLmEbiGPdnbXYIo2oadefL
	 LHZfM1llESkyzVw/sfWf5Y7+TRdL89dqN95fqvYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfHVROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390548AbfHVRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:51 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA05233FE;
        Thu, 22 Aug 2019 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493731;
        bh=cAGKbp3yMg0hERRPg2YNZCl7JyFl8IEGDe/FMwXLKGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lu0VXXUYQfT5kML5xpIo1PWQYpx5yIldPYw0TTXOtTSsGDncFuYYjZ6cJKO5vZlae
         Xvg6aSAnRI/E9bQ1s63HKpygx0vhKwf5TQtVKU4zcSdt/0y8hX2yYmXth+a/fd7D6H
         aytdr8OTNGE91rxzmdSeBXv3SnZfRtq3GbgZD58c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 068/135] kbuild: modpost: handle KBUILD_EXTRA_SYMBOLS only for external modules
Date:   Thu, 22 Aug 2019 13:07:04 -0400
Message-Id: <20190822170811.13303-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit cb4819934a7f9b87876f11ed05b8624c0114551b ]

KBUILD_EXTRA_SYMBOLS makes sense only when building external modules.
Moreover, the modpost sets 'external_module' if the -e option is given.

I replaced $(patsubst %, -e %,...) with simpler $(addprefix -e,...)
while I was here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 38d77353c66ab..cea276955147b 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -75,7 +75,7 @@ modpost = scripts/mod/modpost                    \
  $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)       \
  $(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile)   \
  $(if $(KBUILD_EXTMOD),-I $(modulesymfile))      \
- $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))) \
+ $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS))) \
  $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
  $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
  $(if $(KBUILD_MODPOST_WARN),-w)
-- 
2.20.1

