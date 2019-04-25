Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D99C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE32077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfDYUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:01:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:43874 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbfDYUBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:01:41 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id D345B2B7;
        Thu, 25 Apr 2019 20:01:40 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] RFC: Automatic :c:func: annotation in the sphinx build
Date:   Thu, 25 Apr 2019 14:01:23 -0600
Message-Id: <20190425200125.12302-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been (justified) complaints that writing function() as
:c:func:`function()` in RST documents is obnoxious for both writers and
readers.  The following patch adds an extension to the sphinx build to
add this annotation automatically instead.  As is always the case,
recognizing "function()" is easy; recognizing the places where we should
*not* mangle things is harder.

Patch #2 removes all of the :c:func: annotations from xarray.rst - over
150 of them - to highlight the difference.  The only change in the output
is cross references added for a couple of functions that were not annotated
in the original version.

This adds some processing during the docs build, but my attempts to
measure the slowdown showed that it is less than the noise between
builds.

The output from a full docs build with these patches applied can be
seen at https://static.lwn.net/kerneldoc/.

Jonathan Corbet (2):
  Docs: An initial automarkup extension for sphinx
  docs: remove :c:func: annotations from xarray.rst

 Documentation/conf.py              |   3 +-
 Documentation/core-api/xarray.rst  | 270 ++++++++++++++---------------
 Documentation/sphinx/automarkup.py |  90 ++++++++++
 3 files changed, 227 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/sphinx/automarkup.py

-- 
2.21.0

