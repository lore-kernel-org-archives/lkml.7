Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A746206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576744479;
	bh=tDmI+TvIvU1J60hZmWlEs/xIg0YTMcvbR4m1REXxryc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2V+5N96IfnBU+9qJUgtI7nT0OIbPPw4M0DpvosfEDlWGgT7WZb0yXsKNu45uIQMuE
	 cgWSxiAU7ipSPNkDYqsTwEFVd3GbG7RQFERfnvfo9dD9+zrVtPHTjk+3tW6F0vOntO
	 2jr6fRox+wY9VVllFlOON8BBCFyTqSbU2NBKNi6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:34:38 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:36831 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:34:36 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBJ8XVeB026051;
        Thu, 19 Dec 2019 17:33:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBJ8XVeB026051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576744412;
        bh=qI5mMd1cAwycq3B8kLudFXZgwvG5Ji5YZpa3DkyTil0=;
        h=From:To:Cc:Subject:Date:From;
        b=G53E+sLqx0KukWN7HDXX4hwLlfe5erHOz4O8LADMWlDcIYtkBmHrrWEk2J/JTd500
         fzEaMzqAtjfXuv4Ipq57ovnkCU3opY/rmKde7nfKtF3KAJ5f7LQSuCWxui3kjAFFEq
         dfeNIJ5g+6KNgWs7xgxUrM7t42TGCgAPm2prs9XZvUC7GFazrm+2KQFiKsbc9tWLPU
         212tZIiRia5zCDhV/kPtatDoZ2jGFnvUgGetoiaoKoqoQMEN/71wYDENpJkchbusPW
         axlHcBgpUJIN4S9ofRUcFrCIrVQAoMMe7aD3kEgI9X+jJqkR1OPqCsL+dHIHwkL8oB
         dHuZel67E0BvQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kbuild: generate modules.builtin without Makefile.modbuiltin or tristate.conf
Date:   Thu, 19 Dec 2019 17:33:26 +0900
Message-Id: <20191219083329.5926-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series re-implements the way of generating modules.builtin

Current approach:
   Collect all CONFIG options with 'tristate' type into tristate.conf,
   and parse Makefiles to get the list of builtin modules.

New approach:
   Use MODULE_LICENSE() tags that compiled into vmlinux.
   This information appears in modules.builtin.info,
   but trimmed from vmlinux itself. So the image size does
   not change.

This slightly speeds up builds because Kbuild no longer needs
to traverse the source tree twice.

Also, the code diff is appealing:
 8 files changed, 35 insertions(+), 135 deletions(-)

I think this is OK, but I hope module people can check it.



Masahiro Yamada (3):
  kbuild: add stringify helper to quote a string passed to C files
  kbuild: pass KBUILD_MODFILE when compiling builtin objects
  kbuild: create modules.builtin without Makefile.modbuiltin or
    tristate.conf

 Documentation/kbuild/kconfig.rst |  5 ---
 Makefile                         | 21 +++---------
 include/linux/module.h           | 12 ++++++-
 scripts/Kbuild.include           | 10 +++---
 scripts/Makefile.lib             | 17 ++++++----
 scripts/Makefile.modbuiltin      | 57 --------------------------------
 scripts/kconfig/confdata.c       | 45 ++-----------------------
 scripts/link-vmlinux.sh          |  4 +++
 8 files changed, 36 insertions(+), 135 deletions(-)
 delete mode 100644 scripts/Makefile.modbuiltin

-- 
2.17.1

