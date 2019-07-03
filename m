Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7754C06510
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD403218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPp129mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfGCA7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:59:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33737 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfGCA7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:59:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id j190so362123ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIf3s/qpqMqc2ju4HSpCa9loV1PYd9khtmiRlahKfMw=;
        b=pPp129mGMAgZmQQqFW2wfGEyipUebLHwGsceAtgrBF3rmcputVE6yLkvSQzI5+Umpe
         ozwXEefLssoK6is8zIDlkwY/8KxjUGg4mFuSKbFB26uy43eFMyRjUtyFLV2PXbRIXp4S
         nXHtGaazQ+NoOvr/kGLrfL86ynZ5+JPT39vV8UPPVwpByVSniduvE865bw+oh4sDDk8e
         jZ+tHN3OsCR6DZ27o/h80jb8FFe8FqUFoAO21NfwxBXtyuAwby9BaxyIDkmG6v6CBDrB
         xMZdvZ8g4jOQzQlCof9FvROv5TZ+hPQySu6YgAIUvgtORBagVLpLL4A6t2rIK8irYDYe
         USHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIf3s/qpqMqc2ju4HSpCa9loV1PYd9khtmiRlahKfMw=;
        b=EqsF7bKmZuGq5igVsL24Oln8YtBAe9v8UNv9Oc4vsvIHExfU0jjBpFDzcdj8Nwytru
         H3ZsAe0klsHxXSfeOWI60HQITtXmfXiokXR1gqrRB46LuhTBQskG7tEYDSEXfICVEwqp
         otIFsyemSsKLg1dOwXi7cuUIOIJitmLajvz5PrAGnEF7w9ARe/xhDZvNmoElbyBff3rp
         j5kdqZwWDzw+1LOakC3Tus7/DN6L1H0avb3W8X0ouDo6io/f6qcs7IFD90+pogoV3n3W
         vvnG2aM+WgKL88GkObP3yr/fUBImdhRx+6r5gLTI0iv3vslqIPRnYQgKMqHrxqXO8NVV
         o40w==
X-Gm-Message-State: APjAAAVXfcEqFK7kQQdG44awnP+5OznS59IClit1dHXDRK3v6XvlcxWU
        8EzJKPVp4sKuzUA7xd2jtXA8fnd+SKSsIxeu72aVxQ==
X-Google-Smtp-Source: APXvYqxK5DEkk2kHSda+WF/FAeUHPkw6wKzo7ZmZsBWNCRYS9CdUUUng7zhdFAAYidX2Li7ETs1OA9wyePtHHTyX7VI=
X-Received: by 2002:a81:ae5d:: with SMTP id g29mr19968749ywk.398.1562115554994;
 Tue, 02 Jul 2019 17:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190702233538.52793-1-henryburns@google.com>
In-Reply-To: <20190702233538.52793-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Jul 2019 17:59:03 -0700
Message-ID: <CALvZod7udORRrz7wzQPRa2Eya5TfrVh9kG037GKsAsSkRJPx7Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 4:35 PM Henry Burns <henryburns@google.com> wrote:
>
> Following zsmalloc.c's example we call trylock_page() and unlock_page().
> Also make z3fold_page_migrate() assert that newpage is passed in locked,
> as per the documentation.
>
> Link: http://lkml.kernel.org/r/20190702005122.41036-1-henryburns@google.com
> Signed-off-by: Henry Burns <henryburns@google.com>
> Suggested-by: Vitaly Wool <vitalywool@gmail.com>
> Acked-by: Vitaly Wool <vitalywool@gmail.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vitaly Vul <vitaly.vul@sony.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Xidong Wang <wangxidong_97@163.com>
> Cc: Jonathan Adams <jwadams@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

We need a "Fixes" tag.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
