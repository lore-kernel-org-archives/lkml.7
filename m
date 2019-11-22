Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EEE20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKVRek convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:34:40 -0500
Received: from ms.lwn.net ([45.79.88.28]:41496 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:34:40 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D05F337B;
        Fri, 22 Nov 2019 17:34:38 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:34:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: fix reference to core-api/namespaces.rst
Message-ID: <20191122103437.59fda273@lwn.net>
In-Reply-To: <20191122115337.1541-1-federico.vaga@vaga.pv.it>
References: <20191122115337.1541-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 12:53:37 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> This patch:
> 
> commit fcfacb9f8374 ("doc: move namespaces.rst from kbuild/ to core-api/")
> 
> forgot to update the document kernel-hacking/hacking.rst.
> 
> In addition to the fix the path now is a cross-reference to the document.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/core-api/symbol-namespaces.rst | 2 ++
>  Documentation/kernel-hacking/hacking.rst     | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> index 982ed7b568ac..6791f8a5d726 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -1,3 +1,5 @@
> +.. _core-api-namespace:
> +

So I've been wondering for a bit why we don't use section headers as
targets more often rather than adding all these tags.  Perhaps it's because
we never enabled that extension? What do you think of this as an
alternative fix? (Probably before committing this I would split into two,
since enabling the extension merits its own patch).

Thanks,

jon

From b5ca7304e1a7f67717acff2a7bf50f56d387afdd Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 22 Nov 2019 10:30:30 -0700
Subject: [PATCH] docs: fix reference to core-api/namespaces.rst

Fix a couple of dangling links to core-api/namespaces.rst by turning them
into proper references.  Enable the autosection extension (available since
Sphinx 1.4) to make this work.

Co-developed-by: Federico Vaga <federico.vaga@vaga.pv.it>
Fixes: fcfacb9f8374 ("doc: move namespaces.rst from kbuild/ to core-api/")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py                    | 2 +-
 Documentation/kernel-hacking/hacking.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 3c7bdf4cd31f..fa2bfcd6df1d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -38,7 +38,7 @@ needs_sphinx = '1.3'
 # ones.
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
-              'maintainers_include']
+              'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index a3ddb213a5e1..d707a0a61cc9 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -601,7 +601,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+:ref:`Documentation/core-api/symbol-namespaces.rst <Symbol Namespaces>`
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -610,7 +610,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL_GPL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+:ref:`Documentation/core-api/symbol-namespaces.rst <Symbol Namespaces>`
 
 Routines and Conventions
 ========================
-- 
2.21.0

