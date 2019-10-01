Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82B2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfJARfJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:35:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:38408 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfJARfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:35:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDC3B491;
        Tue,  1 Oct 2019 17:35:07 +0000 (UTC)
Date:   Tue, 1 Oct 2019 11:35:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <20191001113506.12720205@lwn.net>
In-Reply-To: <20191001120930.5d388839@coco.lan>
References: <20190924230208.12414-1-keescook@chromium.org>
        <20191001083147.3a1b513f@lwn.net>
        <20191001120930.5d388839@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 12:09:30 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> >   Sphinx parallel build error:
> >   UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 8: ordinal not in range(128)
> > 
> > For extra fun, the build process simply hangs, requiring a ^C to blow it
> > away.  You've managed to get new behavior out of Sphinx that I've not seen
> > before, congratulations :)
> > 
> > This almost certainly has to do with the fact that I'm (intentionally)
> > running the Python2 Sphinx build here.  Something's not doing unicode that
> > should be.
> > 
> > I would suggest that we might just want to repair this before merging this
> > feature.  Either that, or we bite the bullet and deprecate the use of
> > Python 2 entirely - something that's probably not too far into our future
> > regardless.  Anybody have thoughts on that matter?  
> 
> I'm almost sure we got this already. If I'm not mistaken, the solution
> is to add the encoding line after shebang.

As mentioned before, that's not it.  The problem is that we're feeding
UTF8 into Sphinx as an ordinary str, then sphinx is trying to decode it
as ASCII. The attached hack makes things work.

Kees, I can either just keep this fix (breaking bisectability of the docs
build :) or you can send a new version - up to you.

Thanks,

jon

From c32bfbb07a7840662ba3b367c61b7f2946028b27 Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 1 Oct 2019 11:26:20 -0600
Subject: [PATCH] docs: make maintainers_include work with Python 2

The MAINTAINERS file contains UTF-8 data, so Python 2 code has to be
explicit about moving it into the Unicode realm.  Explicitly decode all
data from the file as soon as we read it.

This hack can go away once we deprecate Python 2 support.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/maintainers_include.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index de62dd3dabd5..705ba9fd5336 100755
--- a/Documentation/sphinx/maintainers_include.py
+++ b/Documentation/sphinx/maintainers_include.py
@@ -19,6 +19,7 @@ u"""
 
 import re
 import os.path
+import sys
 
 from docutils import statemachine
 from docutils.utils.error_reporting import ErrorString
@@ -60,6 +61,8 @@ class MaintainersInclude(Include):
         field_content = ""
 
         for line in open(path):
+            if sys.version_info.major == 2:
+                line = unicode(line, 'utf-8')
             # Have we reached the end of the preformatted Descriptions text?
             if descriptions and line.startswith('Maintainers'):
                 descriptions = False
-- 
2.21.0

