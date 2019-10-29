Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913B821721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NkQ6ITl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfJ2MjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:39:23 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:34505 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfJ2MjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:39:07 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x9TCcFU5026616;
        Tue, 29 Oct 2019 21:38:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x9TCcFU5026616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572352697;
        bh=p+l5kEOxCnI9qNu/vD0lE+dtxx0BPeHEj15iP8RI9iE=;
        h=From:To:Cc:Subject:Date:From;
        b=NkQ6ITl9jZ4NCLEwMQ9/m9XlWPFv2ZegXrmI9cXQdHZqHTuFuqk+76coJHHVrTOMO
         O04/4HUDzov4djfYWzs9ilLUklw3N0d+ER7r1mY+Q49axQa2kA3ohaXDiz4DnwPcG4
         JMqdsREFsW3uGeXKdePPReCWJyJbIlIDxpIfGYKwMo6baf09zFJIaDd/bLCqpnw2Hy
         wN+xwxixs9TB8BAHbmccZxL58gmqLlwqjEAZoVJ1F4uyS2aB2MW6u7PDmUEcMX9OP0
         1P1MYP+Ep1FgYf49PGNSzpZ/6SjkFKJupwbwOBykurHduB4V057onr+E4dSLYWcz3k
         r1o52RGB2tnew==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] More nsdeps improvements
Date:   Tue, 29 Oct 2019 21:38:05 +0900
Message-Id: <20191029123809.29301-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves nsdeps more by addressing the root problem.

Based on linux-next.

This series does NOT apply to the Linus tree because
I updates modpost from my Kbuild tree.

I can pick up this series to kbuild tree if there is no objection.
If it goes to the module tree, we need to discuss how to deal with
the conflicts.

The modpost is actively touched these days
from both kbuild and module trees.



Masahiro Yamada (4):
  modpost: do not invoke extra modpost for nsdeps
  modpost: dump missing namespaces into a single modules.nsdeps file
  scripts/nsdeps: support nsdeps for external module builds
  mospost: remove unneeded local variable in contains_namespace()

 .gitignore                                   |  2 +-
 Documentation/core-api/symbol-namespaces.rst |  3 ++
 Documentation/dontdiff                       |  1 +
 Makefile                                     | 10 ++--
 scripts/Makefile.modpost                     |  8 ++-
 scripts/mod/modpost.c                        | 55 ++++++++------------
 scripts/mod/modpost.h                        |  4 +-
 scripts/nsdeps                               | 29 ++++++-----
 8 files changed, 53 insertions(+), 59 deletions(-)

-- 
2.17.1

