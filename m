Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F19C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6CF217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FwXdqIF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfGHTmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:42:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35945 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfGHTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:42:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so14264705qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2520ZhVAOQoNGXYuUGDLJjBfxAVnsIhGVD7re8gWhA=;
        b=FwXdqIF/gpAygHufUZMo4KWVn6X3sII2NMiwCVW4yEdYt73bF+jPuZARQTIXXSrEOL
         2MPhssfotLjGgvN5mmKY6jPn+Ks8ycpjrqfacgetYaStCQjKHZKq04WQpNP3Exek0J+q
         3I83OxfacKbyb+EqHLIybI2E3trBwoNfbBbPV25f59uRRAKCsxMz5oMGUKt4S1CDgLaY
         9epbEvq1KXXDLYvqNvTit3j8CT57G/FI8DFwsbw3pTNTEzViLcvaEUvkt+bDhRXuSHRr
         DAU7fmxgjJB9JtUk0SbLo6Awp9TBXnSP0mO561x7qCrrRLSS1/i4sMZ+foxvGp3KGXWt
         xTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2520ZhVAOQoNGXYuUGDLJjBfxAVnsIhGVD7re8gWhA=;
        b=QD6xjB0WwvaEzO1J9VfTCFtlAQsJaI6FeBLaPaJQaP39h8pvp64iKdRLxptysbRsDg
         K1V0z+vAaCQeEYcSVl9pibtfWLhG9ZQvAVqDOy/urILlPDKundlmfS5lq6V2lvy1RJ5g
         hHDFKrB/dHkOwckpPC1Kf39NL7wMuaP416bIodmaXaW4E6iQdu43sKDlgHVWCVuh4B+c
         bnldbE2NXRa83u2APJjQh/gIjxT8QJT/mPK6ik+d7RtirCYyAlucV7AE8pBQvxiqtAC2
         ZPxX6tznMyayOcYKeeEd867/d/Z25tPBXi5F8JqraURtLDDAWzksivJJVHVcFMPzP3i6
         5uJA==
X-Gm-Message-State: APjAAAXGx1x3RjcuB1S7DGxDX6L46ghsXNv3/e3ZktNdz2KmosdYl+/D
        xBx9BECyde5NU7QSCnGbVZfXXQ==
X-Google-Smtp-Source: APXvYqzDnPKRcu4yowhPT1O3C/U/0l/RxhU7tbYwxwZhmqrWUP3bSIXP+QDg2CkP3cGtGBrlp6jLXA==
X-Received: by 2002:a37:a013:: with SMTP id j19mr15574885qke.401.1562614922050;
        Mon, 08 Jul 2019 12:42:02 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a18sm7509573qkk.69.2019.07.08.12.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:42:01 -0700 (PDT)
Message-ID: <1562614919.8510.9.camel@lca.pw>
Subject: Re: [PATCH v2] gpu/drm_memory: fix a few warnings
From:   Qian Cai <cai@lca.pw>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, joe@perches.com,
        linux-spdx@archiver.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, rfontana@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, corbet@lwn.net,
        gregkh@linuxfoundation.org
Date:   Mon, 08 Jul 2019 15:41:59 -0400
In-Reply-To: <CAKb7UvhoW2F5LSf4B=vJhLykPCme_ixwbUBup_sBXjoQa72Fzw@mail.gmail.com>
References: <1562609151-7283-1-git-send-email-cai@lca.pw>
         <CAKb7UvhoW2F5LSf4B=vJhLykPCme_ixwbUBup_sBXjoQa72Fzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-08 at 15:21 -0400, Ilia Mirkin wrote:
> On Mon, Jul 8, 2019 at 2:06 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > The opening comment mark "/**" is reserved for kernel-doc comments, so
> > it will generate a warning with "make W=1".
> > 
> > drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
> > drm_memory.c
> > 
> > Also, silence a checkpatch warning by adding a license identfiter where
> > it indicates the MIT license further down in the source file.
> > 
> > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > 
> > It becomes redundant to add both an SPDX identifier and have a
> > description of the license in the comment block at the top, so remove
> > the later.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: remove the redundant description of the license.
> > 
> >  drivers/gpu/drm/drm_memory.c | 22 ++--------------------
> >  1 file changed, 2 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> > index 132fef8ff1b6..86a11fc8e954 100644
> > --- a/drivers/gpu/drm/drm_memory.c
> > +++ b/drivers/gpu/drm/drm_memory.c
> > @@ -1,4 +1,5 @@
> > -/**
> > +// SPDX-License-Identifier: MIT
> > +/*
> >   * \file drm_memory.c
> >   * Memory management wrappers for DRM
> >   *
> > @@ -12,25 +13,6 @@
> >   * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
> >   * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
> >   * All Rights Reserved.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaining a
> > - * copy of this software and associated documentation files (the
> > "Software"),
> > - * to deal in the Software without restriction, including without
> > limitation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice (including the
> > next
> > - * paragraph) shall be included in all copies or substantial portions of
> > the
> > - * Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> > OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES
> > OR
> 
> This talks about VA Linux Systems and/or its suppliers, while the MIT
> licence talks about authors or copyright holders.
> 
> Are such transformations OK to just do?

From,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Document
ation/process/license-rules.rst

"The Linux kernel requires the precise SPDX identifier in all source files."

That is the closest license I can think of.

Anyway, I have added a few people who may know better of the licensing.

> 
>   -ilia
> 
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> >   */
> > 
> >  #include <linux/highmem.h>
> > --
> > 1.8.3.1
> > 
