Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B112075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370895;
	bh=Lb/09WLMkm8hXsn/XC1v8cxaeG4t1iNgIvHqeTG2oVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAw3paaekNBgmCr5/RJCO7EYCZHGoOskhDXpOcnnj8JKk0GtiI7kPXMyqi58dbSUY
	 +VjVgFYIVwstDyWkFhawXzT9SYC804HuwEWgm78T2eYPE3iuIl6izUykYI96ZUESbR
	 BG1W4Ay+6+JqB8uYGeTShr2mpsAWGtuaaivUPdts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDDJCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbfDDJCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3250921741;
        Thu,  4 Apr 2019 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368523;
        bh=Lb/09WLMkm8hXsn/XC1v8cxaeG4t1iNgIvHqeTG2oVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up+O2ZMMLgGIHE4cB8U3Dd0qmEbIO702NcOva1Xt7/6AxN0lCn8DYaIHnsTd9UbYz
         XuH+lbXrnLbatL6LiTysKSqXTwtT5MTOkRZU+d5oTQpE5V91pdue8n7B/QYHgcqzyo
         hc8DSGF7Nyf0UgdP7+3e+rC4ZISKY0ZyU5cOfy/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/187] kbuild: invoke syncconfig if include/config/auto.conf.cmd is missing
Date:   Thu,  4 Apr 2019 10:46:32 +0200
Message-Id: <20190404084605.679987126@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9390dff66a52d1a60c6e517d8fa6cdbdffc83cb1 ]

If include/config/auto.conf.cmd is lost for some reasons, it is not
self-healing, so the top Makefile misses to run syncconfig.
Move include/config/auto.conf.cmd to the target side.

I used a pattern rule instead of a normal rule here although it is
a bit gross.

If the rule were written with a normal rule like this,

  include/config/auto.conf \
  include/config/auto.conf.cmd \
  include/config/tristate.conf: $(KCONFIG_CONFIG)
          $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig

... syncconfig would be executed per target.

Using a pattern rule makes sure that syncconfig is executed just once
because Make assumes the recipe will create all of the targets.

Here is a quote from the GNU Make manual [1]:

"Pattern rules may have more than one target. Unlike normal rules,
this does not act as many different rules with the same prerequisites
and recipe. If a pattern rule has multiple targets, make knows that
the rule's recipe is responsible for making all of the targets. The
recipe is executed only once to make all the targets. When searching
for a pattern rule to match a target, the target patterns of a rule
other than the one that matches the target in need of a rule are
incidental: make worries only about giving a recipe and prerequisites
to the file presently in question. However, when this file's recipe is
run, the other targets are marked as having been updated themselves."

[1]: https://www.gnu.org/software/make/manual/html_node/Pattern-Intro.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8de5fab711d8..f1a5d7deaf5f 100644
--- a/Makefile
+++ b/Makefile
@@ -626,12 +626,15 @@ ifeq ($(may-sync-config),1)
 -include include/config/auto.conf.cmd
 
 # To avoid any implicit rule to kick in, define an empty command
-$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
+$(KCONFIG_CONFIG): ;
 
 # The actual configuration files used during the build are stored in
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
-include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
+#
+# This exploits the 'multi-target pattern rule' trick.
+# The syncconfig should be executed only once to make all the targets.
+%/auto.conf %/auto.conf.cmd %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
 # External modules and some install targets need include/generated/autoconf.h
-- 
2.19.1



