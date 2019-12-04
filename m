Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A7C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BB420674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqDkuBSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfLDVr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:47:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLDVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 16:47:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id v2so1330946qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gshFHlXorZRPtuUvzsvKwY0wqb/ip/BbpBdjdSR2BMY=;
        b=JqDkuBSiekK3DptglgzAw7HGuRWyFqFz75JZHEAei1eKHrWBQFIwYR9AXtkHwhAQP4
         x3tfzWPJqM7BeS9hzrQ2N8hLaN63z8d43YxjSmiJESSMABJ9YkImVKEi2QhlLsWNyVPd
         XJBc/x2R657X/QRphac+28VMFRTXyAu6yP+Lr2GmPpWQhwB0hTdf8o6FVtxOzdIw2U8K
         OvOTp7lGcxp6WteJo2ld9wK6/MK91m33Xer8x5TTlOrYDe0Oc1YFhp69Thl8Vf7z7pUb
         3Nd7TTj+pDQ5WOfUV2sqpGHiz/XSNSquOApVPsyx182yHcUZn6zxTbvR9i/1yXKfaQe8
         i/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gshFHlXorZRPtuUvzsvKwY0wqb/ip/BbpBdjdSR2BMY=;
        b=aKralQHqTMlS/3W2Lb8NwmMNQTzs80UZO/jCcad4acJATNdIYJAuNbB46+xS7zfF7Q
         TCua8SkO/23kpjVukG6Pah3tGna96WQ3SqKnj4CWmKKX1YYPzfbkGSRRwI2o0JGfrlU5
         S7h8MuoWG6y5GxjfSbqiLYoagncOHVm+c1KqQb3STNn/TF8M6d7dCt4B2z5iOGSu+PSi
         1tkzaMIHw9Gpz9bkOreheZuQ1V22oqZw3ZIoyQjClLRf0USlxALF3WU+HxzQlCakQxda
         +iSL9l36QqHUXDroJPDEvCVRMzGWYTSWcxoUqJk3ad3tME+n9vRfCL4Jr4u/42cfZalJ
         VYWg==
X-Gm-Message-State: APjAAAWJGCpH0AelfuCve/tXuWi+D/y/4v8TMTFPgDpigh6hUm/Nn2iQ
        ys9+I3TgzdG9eYuW3H59U/gSSlYNAolbYB7TJDVL
X-Google-Smtp-Source: APXvYqxMahnD1mAZ9M4Iwjc54yKiqmHeapB+BulPXaLMVztIApxI04y4AAKBeOqMVvJEDxgBX0C1cizqGeaFFrtc6HY=
X-Received: by 2002:aed:2041:: with SMTP id 59mr4801904qta.79.1575496076161;
 Wed, 04 Dec 2019 13:47:56 -0800 (PST)
MIME-Version: 1.0
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com> <1575473234-5443-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575473234-5443-4-git-send-email-alan.maguire@oracle.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 4 Dec 2019 13:47:19 -0800
Message-ID: <CAAXuY3ruLdiLQaswFB=bhEnjvyTgzCwAhPOxThSyC1Md26km+g@mail.gmail.com>
Subject: Re: [PATCH v6 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 7:28 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
Thanks.
Acked-by: Iurii Zaikin <yzaikin@google.com> # For inode-test, sysctl-test
> --
> 1.8.3.1
>
