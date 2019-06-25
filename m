Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67FC48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F2B20883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Siaob2p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfFYSdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:33:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34049 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfFYSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:33:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id q128so4913346ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1bhlSYUHtmacSSZu3GVj7bv0K+nCRKddkIcoLBahUI=;
        b=Siaob2p81baD4yZPX63ez9l1o9fjOkHn0DslQPlKa+/CotLvGRfg2bD7y+vsM38XIA
         8OzOkIkfy3f347jH+OkizC7buijoVIRXQvNC5nR0RkXsMfMX/CVnlfL5IcckK/a2K/CX
         iM5EpSF8zJkMeLQpEPga/bkb3OXdQTBzJEwQKD2Ic90tYUHT3SbiHyPJmOLLGqiR52QS
         pRAEIf2JVRHm35WgdunMsfdmU2vzOtc0TQDDdokbA9WEY2dxqfQxUJmcIgMj2YbIhd1K
         qvlg5/rlWRToD5oMKqFqrSJjF/81sX6w/LB6cP/k20ylrxDGTA0ESeJdvcbt4CiSvt4d
         P4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1bhlSYUHtmacSSZu3GVj7bv0K+nCRKddkIcoLBahUI=;
        b=mPJTto1MBaZFDcL85nWXUgkz0s7s4loSKIj0y8CkEo0Bx7wxOUdTW+Su2xRhCgiTGK
         xD1g8um/1+cJTY9Y6v8QNlxy05IlsUVKWtvs8/jWlp9IvXEN+Q+G2feL15JSoVgfm2WD
         mj/w+iSDcG1qCadz0UF2ShwpnFqx+uO0md8wwfy7jarMCPXutzkr0cuw1qjHjM9746YI
         1rp17YdA3aoYCIyRaLNgPFOwx7htJRWO4vgi4eU5HkTdDw2YuuP/9yyIsU90McIiDwS1
         wRPXBpVYerjrg/q7OY/XQwktKQxtcxrBDSdyroGX9NMc5bPR4T6iInnANfycQuG+4Bsc
         EyNQ==
X-Gm-Message-State: APjAAAVSREMU7tx7TDAd+AZGwF+Vipcwt981C39Qbje8+J12vmqcwnep
        l11mMCT4kIIkBJOAuXLqWjwE+KXkICQy9AwNiWRqaA==
X-Google-Smtp-Source: APXvYqzB2SGCBLLDlRYUQopLUMQh20hwgk0JlEIVaKoR2twTZTObVhIb0w7G5cEHMSePdBylToiRO03nIDF7L9Lxyhw=
X-Received: by 2002:a81:4c44:: with SMTP id z65mr112330ywa.4.1561487614082;
 Tue, 25 Jun 2019 11:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-8-guro@fb.com>
In-Reply-To: <20190611231813.3148843-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 11:33:23 -0700
Message-ID: <CALvZod7EZYZJR68dqKF7V9xdgeYo8YnssR94O5zku9qii+xJPA@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> Currently the memcg_params.dying flag and the corresponding
> workqueue used for the asynchronous deactivation of kmem_caches
> is synchronized using the slab_mutex.
>
> It makes impossible to check this flag from the irq context,
> which will be required in order to implement asynchronous release
> of kmem_caches.
>
> So let's switch over to the irq-save flavor of the spinlock-based
> synchronization.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
