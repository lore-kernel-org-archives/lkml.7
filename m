Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4D8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hUxoFsGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfGaUE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:04:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44081 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGaUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:04:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so32599207pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DvIle9Z7Le0W/koXErTIOG9PhIMMIXfJqWN4mPJ33BE=;
        b=hUxoFsGkeADYymjGHq5GAFM8PLLF2oTqH90Qwa1lVGomKVeJv3LpYYq908h6tx+NC6
         JboSViSFWGOnrHw3eax6eEOT2n+FS9htW1HchWAp3w0jojJ78gsyAANzR8f7TlGgYKbp
         yQKiR7/Vje+a0p9TBadUOpZtoN9epeDzQlCK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvIle9Z7Le0W/koXErTIOG9PhIMMIXfJqWN4mPJ33BE=;
        b=HzB9+yCZrJjbH7Dq9KpGAcXMR1uHMuaaG5cNQLcUJ4Og1263N9cz2qP+Lbl4dWkpRW
         2lQP/PphMYxW9q1rDUkCQF5+JbhUo4eFJzDVETvPmkAdE5YOyqMZ1myiQXSYdZ7RJtOI
         lYFAnpnBHYU5bCztriDT3qGETFg4kj4scoOMgfXWbil4ko0G7dAqZ6fJ/SpJC1sqO/jF
         qxs+/x1a7gcLo8V+BMF4lTv/DlyGipfds85Mx/1sqs6QNHfErVUxUhwI/i/r5Q1l1mD8
         5uLIP/lp1PwtIFnXrkwfbgkZeANu50524BigJXiV09Zl48l2yjqyB7HY70tWERXxSxno
         MXKQ==
X-Gm-Message-State: APjAAAUbod8THQtXmiph/KZvt+btUXHy1I39Spd+x6Hh2DToyZvbP9A0
        FhAd3H8wIjuglZPbrO/AEHWktw==
X-Google-Smtp-Source: APXvYqwIJxMJOxdtJ5g0WQFgFO3TDsvWgqhNn6FrJTk3e9UcxKXtIPqx/42ra07S8mgFqWWw/OG6iw==
X-Received: by 2002:a63:1455:: with SMTP id 21mr71350404pgu.116.1564603497556;
        Wed, 31 Jul 2019 13:04:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm84014438pfo.93.2019.07.31.13.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 13:04:56 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:04:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: slub: Fix slab walking for init_on_free
Message-ID: <201907311304.2AAF454F5C@keescook>
References: <CAG_fn=VBGE=YvkZX0C45qu29zqfvLMP10w_owj4vfFxPcK5iow@mail.gmail.com>
 <20190731193240.29477-1-labbott@redhat.com>
 <20190731193509.GG4700@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731193509.GG4700@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:35:09PM -0700, Matthew Wilcox wrote:
> On Wed, Jul 31, 2019 at 03:32:40PM -0400, Laura Abbott wrote:
> > Fix this by ensuring the value we set with set_freepointer is either NULL
> > or another value in the chain.
> > 
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> 
> Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
