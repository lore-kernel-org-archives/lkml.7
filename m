Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAFC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC54620866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hu/9UibJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEASZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:25:39 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:33634 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEASZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:25:39 -0400
Received: by mail-vk1-f173.google.com with SMTP id r195so717205vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL8fj/1WvD1XOCsOkJZLbwr2FkrpulNbESBS+POuiy4=;
        b=hu/9UibJbGHN4C66jypCqfrbpjHMgUcaeYXOGUNbli3BiwRurGxcpdiXWQHRQ5i06U
         Y11FqcRwwKe4Azn+8nSK+mXnIP8Lr8lTLiTGRZ3nr/fhzubOnGjrJnrDWU/Dpet3fmLk
         YEKBuYVr+e4TorKS95zgT9WAQiACfYixLAVkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL8fj/1WvD1XOCsOkJZLbwr2FkrpulNbESBS+POuiy4=;
        b=OHWJOxg6ZD3CW7LyJ9EOjpHLp7xewEMlhc6/u6QaICfFyPNYfQDvHM+0XY7Uuu6iyj
         e2OmAwmBhIsk0cjTMFlo389A2Pg2RkAHuuIgZBJr2XKN32Gmor28l/U52lmOdovTru5o
         n9RWZx6LhNPMtlghzf0qxMgbQ13yaIAqGomRGTYI4CWwioBgx+WucT60pBTQn0HbE+zJ
         ZeM3q5nGohn8qllDB/dGwwCWgiQG/jwz716Hq54ySQFdAZr4gyInLwEEVkL7eAWAuraM
         SYgUYAWm0R54ttox+WSK7Dg+pWawSWyBu6B6iK9AKimX2IEiI7hTsZNrt0oGRRKJ76QP
         Rw2w==
X-Gm-Message-State: APjAAAWDJuE2kxVor+EuHpG7ZPTVhPU0azt3XLU/CYuTV3duiIF582ZZ
        6hDTq3BQbf5uuKgsGwALSNJCjIOp/SI=
X-Google-Smtp-Source: APXvYqyxz9b7lDL9yzoMGbiYtCAETvLErwKkH1i2UBv4rikWaW1eM6E32d1KdLAkhPRRKAQdKWwbRQ==
X-Received: by 2002:a1f:3458:: with SMTP id b85mr39201947vka.4.1556735137597;
        Wed, 01 May 2019 11:25:37 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id w69sm15541861vsc.8.2019.05.01.11.25.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:25:36 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id e207so6040964vsd.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:25:36 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr39824551vsp.188.1556735135694;
 Wed, 01 May 2019 11:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190501160636.30841-1-hch@lst.de>
In-Reply-To: <20190501160636.30841-1-hch@lst.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 May 2019 11:25:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKMswkBy-kEk7mb01v3oJADvGyhRf6JMh7BsjUKsme9QA@mail.gmail.com>
Message-ID: <CAGXu5jKMswkBy-kEk7mb01v3oJADvGyhRf6JMh7BsjUKsme9QA@mail.gmail.com>
Subject: Re: fix filler_t callback type mismatches
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 9:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Casting mapping->a_ops->readpage to filler_t causes an indirect call
> type mismatch with Control-Flow Integrity checking. This change fixes
> the mismatch in read_cache_page_gfp and read_mapping_page by adding
> using a NULL filler argument as an indication to call ->readpage
> directly, and by passing the right parameter callbacks in nfs and jffs2.

Nice. This looks great; thanks for looking at this. For the series
(including patch 5):

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
