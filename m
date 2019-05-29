Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA52C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D823C7E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfE2PyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:54:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:42274 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfE2PyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:54:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2851560C;
        Wed, 29 May 2019 15:54:09 +0000 (UTC)
Date:   Wed, 29 May 2019 09:54:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Fixes for sphinx 2.0 docs build failures
Message-ID: <20190529095408.1429a5ab@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
a65fd4f0def56f59822b2c49522d36319bc8da8b:

  Documentation: kdump: fix minor typo (2019-05-21 09:31:28 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.2-fixes2

for you to fetch changes up to 551bd3368a7b3cfef01edaade8970948d178d40a:

  drm/i915: Maintain consistent documentation subsection ordering (2019-05-24 09:15:45 -0600)

----------------------------------------------------------------
The Sphinx 2.0 release contained a few incompatible API changes that broke
our extensions and, thus, the documentation build in general.  Who knew
that those deprecation warnings it was outputting actually meant we should
change something?  This set of fixes makes the build work again with
Sphinx 2.0 and eliminates the warnings for 1.8.  As part of that, we also
need a few fixes to the docs for places where the new Sphinx is more
strict.

It is a bit late in the cycle for this kind of change, but it does fix
problems that people are experiencing now.

There has been some talk of raising the minimum version of Sphinx we
support.  I don't want to do that abruptly, though, so these changes add
some glue to continue to support versions back to 1.3.  We will be adding
some infrastructure soon to nudge users of old versions forward, with the
idea of maybe increasing our minimum version (and removing this glue)
sometime in the future.

----------------------------------------------------------------
Jonathan Corbet (7):
      doc: Cope with Sphinx logging deprecations
      doc: Cope with the deprecation of AutoReporter
      docs: fix numaperf.rst and add it to the doc tree
      lib/list_sort: fix kerneldoc build error
      docs: fix multiple doc build warnings in enumeration.rst
      docs: Fix conf.py for Sphinx 2.0
      drm/i915: Maintain consistent documentation subsection ordering

Mauro Carvalho Chehab (1):
      scripts/sphinx-pre-install: make it handle Sphinx versions

 Documentation/admin-guide/mm/index.rst            |  1 +
 Documentation/admin-guide/mm/numaperf.rst         |  2 +-
 Documentation/conf.py                             |  2 +-
 Documentation/firmware-guide/acpi/enumeration.rst |  2 +-
 Documentation/sphinx/kerneldoc.py                 | 44 +++++++++---
 Documentation/sphinx/kernellog.py                 | 28 ++++++++
 Documentation/sphinx/kfigure.py                   | 40 ++++++-----
 drivers/gpu/drm/i915/i915_reg.h                   |  6 +-
 drivers/gpu/drm/i915/intel_workarounds.c          |  2 +-
 lib/list_sort.c                                   |  3 +-
 scripts/sphinx-pre-install                        | 86 +++++++++++++++++++++--
 11 files changed, 173 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/sphinx/kernellog.py
