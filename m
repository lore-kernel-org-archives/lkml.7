Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1441FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6CF2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576556087;
	bh=8fEdlHpGfheUErliih1pX2Nob6i3d2Mc2E/aQtOVrgw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cLQwddx0ipseNyavuATnfEc9n1yEObo6U96MXteppLdG5tkW5ltr/mCwbw4m3J/0Z
	 DO0Fcn+oq1twaPV0AIIZmAat/uQJV29sWlmdlGe70RG14f4XB01AVahQ0ZJTbx7jBP
	 TcM3NFCJnhss7FgFBIFc8Q7ppgBo8IpkMCr4KtKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLQEOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:14:47 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49222 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfLQEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:14:44 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBH4EPAA024524;
        Tue, 17 Dec 2019 13:14:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBH4EPAA024524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576556066;
        bh=eP9ShD/yDvy5hVrgSRBr4aX7FLVinigwTiuG7tw/kNI=;
        h=From:To:Cc:Subject:Date:From;
        b=yg7oQspHYlCLAYiExY6+cSqq6vfwtKYdva/rgoNUWEiLMCFYaJ5h6AJ4ps1p0KjPx
         9GkmwqUZocziWQaw4dWSzCIbT4tYHZRvohA8qiO+ouBj+qKKQe3NpV+GC+pXMNCUOk
         z/E/VpgcLKuKc/FImWCpOhXKJcKfiD0yK5iZuY/gYgnCrDTy33A5l59bFvZA9JGoNS
         524KiYS8wP6HZ08esBGb7yxmyMwvh6NcoXzEZYgvkx5TdL0BN60IrqP9qnPRwCLfpd
         g1AjsWV6P0gt8hQDo7sTdhJbdxHh1qj4EoJGGxBQ7S3YWyU1eEy+mjBmIr+naRjL38
         SIFgNNnqxWWKw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] kconfig: misc cleanups
Date:   Tue, 17 Dec 2019 13:14:15 +0900
Message-Id: <20191217041424.29285-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro Yamada (8):
  kconfig: remove the rootmenu check in menu_add_prop()
  kconfig: use parent->dep as the parentdep of 'menu'
  kconfig: drop T_WORD from the RHS of 'prompt' symbol
  kconfig: remove 'prompt' symbol
  kconfig: move prompt handling to menu_add_prompt() from
    menu_add_prop()
  kconfig: remove 'prompt' argument from menu_add_prop()
  kconfig: remove sym from struct property
  kconfig: squash prop_alloc() into menu_add_prop()

 scripts/kconfig/expr.h   |   1 -
 scripts/kconfig/lkc.h    |   1 -
 scripts/kconfig/menu.c   | 103 ++++++++++++++++++++++-----------------
 scripts/kconfig/parser.y |  21 +++-----
 scripts/kconfig/symbol.c |  22 ---------
 5 files changed, 66 insertions(+), 82 deletions(-)

-- 
2.17.1

