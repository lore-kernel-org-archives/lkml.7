Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4795C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF1D21D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QTOhXzxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfJCH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:59:17 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:59233 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfJCH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:59:17 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x937wTkS007720;
        Thu, 3 Oct 2019 16:58:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x937wTkS007720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570089510;
        bh=TZoLwyjxs1rXiGeMqo09vs0+qyomHTfJ9kkNpI3atWE=;
        h=From:To:Cc:Subject:Date:From;
        b=QTOhXzxRFqojlugFQQXkgfK4eY6knGqfGmtO+3jaw+JSuwQDEa2SKu21G8D3y0BIH
         1MIfmAu3r31cxSB2CZ+D/O+6hxCr6km6uWH+pZRyWdpZcDJlpuTSLjhJIJSZC+2pab
         tM0cLk5fkB57hHNG7OmMqrHVPlhiEBsOnxC80vLEEElwzX+CMs/3K/6+aEi+eT9H3h
         WiqSmw9j1bGYjXZB6hHgjwQPZ6qfbccFOeT/WejV6VIL9+ZRuCzG9tIwkM9DBCIGtn
         aK6BVO2MOQHM56OtL6krvb31yCSJSKvk7/Cf8HV2j0lm/vcId9zmc2kh+pzKWQlnV6
         P5F0MA4MZ9VdA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shaun Ruffell <sruffell@sruffell.net>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] module: various bug-fixes and clean-ups for module namespace
Date:   Thu,  3 Oct 2019 16:58:20 +0900
Message-Id: <20191003075826.7478-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I was hit by some problems caused by the module namespace feature
that was merged recently. At least, the breakage of
external module builds is a fatal one. I just took a look at the code
closer, and I noticed some more issues (some are nit-picking).

V2:
 - I dropped "module: avoid code duplication in include/linux/export.h"
   because Matthias offered to refactor the code by himself.

 - V1 missed the problem when a symbol is preloaded before
  sym_add_exported() is called.  I fixed it too.



Masahiro Yamada (6):
  module: swap the order of symbol.namespace
  modpost: fix broken sym->namespace for external module builds
  module: rename __kstrtab_ns_* to __kstrtabns_* to avoid symbol
    conflict
  kbuild: fix build error of 'make nsdeps' in clean tree
  nsdeps: fix hashbang of scripts/nsdeps
  nsdeps: make generated patches independent of locale

 Makefile               |  2 +-
 include/linux/export.h | 10 +++++-----
 scripts/mod/modpost.c  | 29 +++++++++++++++--------------
 scripts/nsdeps         |  4 ++--
 4 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.17.1

