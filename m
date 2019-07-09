Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02399C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CE120861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGINkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:40:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:58352 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfGINkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:40:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A67C2737;
        Tue,  9 Jul 2019 13:40:51 +0000 (UTC)
Date:   Tue, 9 Jul 2019 07:40:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     NitinGote <nitin.r.gote@intel.com>
Cc:     joe@perches.com, akpm@linux-foundation.org, apw@canonical.com,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Added warnings in checkpatch.pl script to :
Message-ID: <20190709074050.289aab82@lwn.net>
In-Reply-To: <20190709122417.25778-1-nitin.r.gote@intel.com>
References: <20190709122417.25778-1-nitin.r.gote@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Jul 2019 17:54:17 +0530
NitinGote <nitin.r.gote@intel.com> wrote:

> From: Nitin Gote <nitin.r.gote@intel.com>

The patch needs a proper subject line.

> 1. Deprecate strcpy() in favor of strscpy().
> 2. Deprecate strlcpy() in favor of strscpy().
> 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> 
> Updated strncpy() section in Documentation/process/deprecated.rst
> to cover strscpy_pad() case.
> 
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
>  Change log:
>  v1->v2
>  - For string related apis, created different %deprecated_string_api
>    and these will get emitted at CHECK Level using command line option
>    -f/--file to avoid bad patched from novice script users.
> 
>  v2->v3
>  - Avoided use of $check in implementation.
>  - Incorporated trivial comments.
> 
>  Documentation/process/deprecated.rst |  6 +++---
>  scripts/checkpatch.pl                | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 49e0f64a3427..f564de3caf76 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -93,9 +93,9 @@ will be NUL terminated. This can lead to various linear read overflows
>  and other misbehavior due to the missing termination. It also NUL-pads the
>  destination buffer if the source contents are shorter than the destination
>  buffer size, which may be a needless performance penalty for callers using
> -only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
> -(Users of :c:func:`strscpy` still needing NUL-padding will need an
> -explicit :c:func:`memset` added.)
> +only NUL-terminated strings. In this case, the safe replacement is
> +:c:func:`strscpy`. If, however, the destination buffer still needs
> +NUL-padding, the safe replacement is :c:func:`strscpy_pad`.

Please don't use :c:func: in anything new; just write that as strscpy()
(or whatever) and The Right Thing will happen.

(Maybe we need a checkpatch rule for that :)

Thanks,

jon
