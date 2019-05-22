Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE33C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FED4217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfEVUu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:50:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:49310 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfEVUu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:56 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 02180AAB;
        Wed, 22 May 2019 20:50:55 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Date:   Wed, 22 May 2019 14:50:26 -0600
Message-Id: <20190522205034.25724-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sphinx folks deprecated some interfaces in the 2.0 release; one
immediate result of that is a bunch of warnings that show up when building
with 1.8.  These two patches make those warnings go away, but at a cost:

 - It introduces a couple of Sphinx version checks, which are always
   ugly, but the alternative would be to stop supporting versions
   before 1.7.  For now, I think we can carry that cruft.

 - The second patch causes the build to fail horribly on newer
   Sphinx installations.  The change to switch_source_input() seems
   to make the parser much more finicky, increasing warnings and
   eventually failing the build altogether.  In particular, it will
   scream about problems in .rst files that are not included in the
   TOC tree at all.

This version of the patch set fixes up the worst problems (the i915 error
in particular, which breaks the build hard).  I've tested it with versions
1.4, 1.8, and 2.0.

Given that these problems are already breaking builds on some systems, I
think I may try to sell these changes to Linus for 5.2 still.

Changes since v1:
  - Fix up a couple of logging changes I somehow missed
  - Don't save state when using switch_source_input()
  - Fix a few build errors
  - Add Mauro's sphinx-pre-install improvements

Jonathan Corbet (7):
  doc: Cope with Sphinx logging deprecations
  doc: Cope with the deprecation of AutoReporter
  docs: fix numaperf.rst and add it to the doc tree
  lib/list_sort: fix kerneldoc build error
  docs: fix multiple doc build warnings in enumeration.rst
  docs/gpu: fix a documentation build break in i915.rst
  docs: Fix conf.py for Sphinx 2.0

Mauro Carvalho Chehab (1):
  scripts/sphinx-pre-install: make it handle Sphinx versions

 Documentation/admin-guide/mm/index.rst        |  1 +
 Documentation/admin-guide/mm/numaperf.rst     |  2 +-
 Documentation/conf.py                         |  2 +-
 .../firmware-guide/acpi/enumeration.rst       |  2 +-
 Documentation/gpu/i915.rst                    |  4 +-
 Documentation/sphinx/kerneldoc.py             | 44 +++++++---
 Documentation/sphinx/kernellog.py             | 28 +++++++
 Documentation/sphinx/kfigure.py               | 40 +++++----
 lib/list_sort.c                               |  3 +-
 scripts/sphinx-pre-install                    | 81 +++++++++++++++++--
 10 files changed, 166 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/sphinx/kernellog.py

-- 
2.21.0

