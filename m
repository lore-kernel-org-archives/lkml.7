Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020A0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE732089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFUXwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:52:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:55280 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFUXwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:52:11 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 71E202C9;
        Fri, 21 Jun 2019 23:52:10 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3 v2] docs: function automarkup, now with 80% fewer regexes!
Date:   Fri, 21 Jun 2019 17:51:56 -0600
Message-Id: <20190621235159.6992-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took me a loooong time to get back to this, but here's another crack at
automatically marking up "function()" so we can get rid of all that
unsightly :c:func: gunk in our docs.  This time, it's implemented as a pass
over the doctree after everything's read and the references resolved, and
the result is certainly far more robust than my first attempt.

Jonathan Corbet (3):
  Docs: An initial automarkup extension for sphinx
  docs: remove :c:func: annotations from xarray.rst
  kernel-doc: Don't try to mark up function names

 Documentation/conf.py              |   3 +-
 Documentation/core-api/xarray.rst  | 270 ++++++++++++++---------------
 Documentation/sphinx/automarkup.py |  80 +++++++++
 scripts/kernel-doc                 |   2 +-
 4 files changed, 218 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/sphinx/automarkup.py

-- 
2.21.0

