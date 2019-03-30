Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4156C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC31218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfC3RZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:25:07 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:43643 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730669AbfC3RZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:25:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 70824180D539E;
        Sat, 30 Mar 2019 17:25:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flesh37_66851c21bce11
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Mar 2019 17:25:04 +0000 (UTC)
Message-ID: <5d7229de06286b4ec06daee3411e39e9b638d66c.camel@perches.com>
Subject: [PATCH] coding-style.rst: Generic alloc functions do not need OOM
 logging
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Nick Crews <ncrews@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Date:   Sat, 30 Mar 2019 10:25:03 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic allocation functions already emit a dump_stack()
so additional error logging isn't useful.

Document it as such and add a reference to the allocation
API.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/coding-style.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 8ea913e99fa1..fa864a51e6ea 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -843,7 +843,8 @@ used.
 The kernel provides the following general purpose memory allocators:
 kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc(), and
 vzalloc().  Please refer to the API documentation for further information
-about them.
+about them.  :ref:`Documentation/core-api/memory-allocation.rst
+<memory_allocation>`
 
 The preferred form for passing a size of a struct is the following:
 
@@ -874,6 +875,9 @@ The preferred form for allocating a zeroed array is the following:
 Both forms check for overflow on the allocation size n * sizeof(...),
 and return NULL if that occurred.
 
+These generic allocation functions all emit a stack dump on failure when used
+without __GFP_NOWARN so there is no use in emitting an additional failure
+message when NULL is returned.
 
 15) The inline disease
 ----------------------

