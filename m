Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD9ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E221835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570813518;
	bh=wQr9Xw1bo34AcsQZottMZdr1xDK0NOPvZ+QopSy8uTE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CW/oGb3tc5KEoyNq6Q/W0cIxz/mZ0yaLw61Xdl7QeGGlRLVQ0UQhGr28M5amWxEuV
	 0Sby5HRH770tIC698seoMAyCn63/i0R/hApRZ/uznbYQ9IU+hME5+rbFeQionjqzw2
	 W0xNaIu0yXsZfSGkkY0Ru6lorN2xhBcEkLJUB+gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfJKRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfJKRFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:05:16 -0400
Received: from linux-8ccs (ip5f5adbed.dynamic.kabel-deutschland.de [95.90.219.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB14B2054F;
        Fri, 11 Oct 2019 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570813516;
        bh=wQr9Xw1bo34AcsQZottMZdr1xDK0NOPvZ+QopSy8uTE=;
        h=Date:From:To:Cc:Subject:From;
        b=UdFLX1G7OocXQprUHRZk3ow7pupXx1gjGEmrVvCfIvBG0joH28HVFJuO7s4ZM6ypx
         qH0yXlcVMaajpL6FKgKtHgzO8NAvS0ETRq/Q/nVES5cTun0hCQ5yNqo1yXqlTWEaDY
         j4AZOnjrnmNBwOOrDWmycSztkbP0/4yOyVILyS+Y=
Date:   Fri, 11 Oct 2019 19:05:06 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v5.4-rc3
Message-ID: <20191011170506.GA19908@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this set of fixes for v5.4-rc3, consisting of code
cleanups and kbuild/namespace related fixups from Masahiro. Most
importantly, it fixed a namespace-related modpost issue for external
module builds. Details can be found in the signed tag.

Thanks,

Jessica

-----

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc3

for you to fetch changes up to fcfacb9f83745d9fa97937b8bc94a73bb0607912:

  doc: move namespaces.rst from kbuild/ to core-api/ (2019-10-08 17:40:01 +0200)

----------------------------------------------------------------
Modules fixes for v5.4-rc3

- Fix broken external module builds due to a modpost bug in read_dump(),
  where the namespace was not being strdup'd and sym->namespace would be
  set to bogus data.
- Various namespace-related kbuild fixes and cleanups thanks to
  Masahiro Yamada.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Masahiro Yamada (7):
      module: swap the order of symbol.namespace
      modpost: fix broken sym->namespace for external module builds
      module: rename __kstrtab_ns_* to __kstrtabns_* to avoid symbol conflict
      kbuild: fix build error of 'make nsdeps' in clean tree
      nsdeps: fix hashbang of scripts/nsdeps
      nsdeps: make generated patches independent of locale
      doc: move namespaces.rst from kbuild/ to core-api/

YueHaibing (1):
      scripts: add_namespace: Fix coccicheck failed

 Documentation/core-api/index.rst                   |  1 +
 .../symbol-namespaces.rst}                         |  0
 MAINTAINERS                                        |  1 +
 Makefile                                           |  2 +-
 include/linux/export.h                             | 10 ++++----
 scripts/coccinelle/misc/add_namespace.cocci        |  2 ++
 scripts/mod/modpost.c                              | 29 +++++++++++-----------
 scripts/nsdeps                                     |  4 +--
 8 files changed, 27 insertions(+), 22 deletions(-)
 rename Documentation/{kbuild/namespaces.rst => core-api/symbol-namespaces.rst} (100%)
