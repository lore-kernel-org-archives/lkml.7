Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F49C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7F2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6B88wfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfJHGPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:15:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38333 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbfJHGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:15:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so17864199wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E71giQmMij00dVZC1MhajR7ZkRCMhyeEhHHekrYHzJo=;
        b=e6B88wfiaQtJEuGtwLFB2tp0DVFW7RKkM9KtSuOw3IUwN5tbCGQUZqOpRgWdrdMytw
         02KEDRLZWYQCJBbf9SAxYvBMiTjb4ktnqWEqK/FtHHJO2VtvWoTxJ2JLVTgJUp546nc8
         Z6B7tlotl/P4XNsDSHq11NKHRspsUuwGwOro2pZXJYCtYrJ1MdSKYRwUlImCzOEtPefk
         J1s8mVNHj4EhOwh/jQQjmdw30UfJbi8qBVY/W2BHXf3JPXDwCPq3gmm8EmTNdZiT0iQN
         xdfIfYamgHXcmYsVg0ZnLgThiaHPu8KKtpgZn0cgCN76Wu0Js2IkORzU7uwkPPhHEtQ2
         bvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E71giQmMij00dVZC1MhajR7ZkRCMhyeEhHHekrYHzJo=;
        b=F92i3AU0nW1lR0VgJkdo9EARzevaG01zrtNCPbATnalS+fTVG6IdgMgS3VJYCyXyrd
         fEEh/UNJHcGlcGje1MtUahvlZ8Q3p9NF1SudmQ3TwJhy0KHj1KTLjIWt70n7HDThayiv
         oguNrLDKYLRvKzegSPgUqSdtpYm6GJ9ZqfEbAxw0nL974DSmIY25JBFePkuiJVhq5dSn
         BsDkO508AM9jxQsa1jod8A7/UdsU25Qf1rPawfPkOd04+n4bb7K6XcAGaSCu9hGiFpME
         FOj2xEUDnlA49lVQn6vunF1SJmqXX22W7J9o+RpFjtJ0N0lJV1Fkkcf1+ovX9lRhPP4f
         /6tQ==
X-Gm-Message-State: APjAAAXR3BEOdYUG3FAniXv44ociR2UNH1ThJgCDViJnkgDT/fa92H8v
        ze3JinWQbLp+EeUDXdeFlREHFQ==
X-Google-Smtp-Source: APXvYqzonXSfQ3IqovyLtUkcieMOHhIx076yuyqJl6GycLQeI3fTH5SSWCjKL4p7JInVnQ0wY+gAMA==
X-Received: by 2002:a5d:6052:: with SMTP id j18mr15168796wrt.40.1570515322804;
        Mon, 07 Oct 2019 23:15:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id t83sm3247995wmt.18.2019.10.07.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 23:15:22 -0700 (PDT)
Date:   Tue, 8 Oct 2019 07:15:21 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: move namespaces.rst from kbuild/ to core-api/
Message-ID: <20191008061521.GD23938@google.com>
References: <20191008031009.17364-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191008031009.17364-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 12:10:09PM +0900, Masahiro Yamada wrote:
>We discussed a better location for this file, and agreed that
>core-api/ is a good fit. Rename it to symbol-namespaces.rst
>for disambiguation, and also add it to index.rst and MAINTAINERS.

Acked-by: Matthias Maennich <maennich@google.com>

Thank you!

Cheers,
Matthias
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> Documentation/core-api/index.rst                                 | 1 +
> .../{kbuild/namespaces.rst => core-api/symbol-namespaces.rst}    | 0
> MAINTAINERS                                                      | 1 +
> 3 files changed, 2 insertions(+)
> rename Documentation/{kbuild/namespaces.rst => core-api/symbol-namespaces.rst} (100%)
>
>diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
>index fa16a0538dcb..ab0eae1c153a 100644
>--- a/Documentation/core-api/index.rst
>+++ b/Documentation/core-api/index.rst
>@@ -38,6 +38,7 @@ Core utilities
>    protection-keys
>    ../RCU/index
>    gcc-plugins
>+   symbol-namespaces
>
>
> Interfaces for kernel debugging
>diff --git a/Documentation/kbuild/namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
>similarity index 100%
>rename from Documentation/kbuild/namespaces.rst
>rename to Documentation/core-api/symbol-namespaces.rst
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 55199ef7fa74..a0ca64057b0d 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -11547,6 +11547,7 @@ NSDEPS
> M:	Matthias Maennich <maennich@google.com>
> S:	Maintained
> F:	scripts/nsdeps
>+F:	Documentation/core-api/symbol-namespaces.rst
>
> NTB AMD DRIVER
> M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>-- 
>2.17.1
>
