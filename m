Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48752083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1NKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:10:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1NKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:10:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so4727229qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZGMhlAqLT3yxPYwrXSNZ2bJPTLwblZNG69r1i+sP/0=;
        b=go1IFFGiRizZILUtjoXS+KxCz7uAXsZRHkHxSmhxJ5LFTDeBRI8DdW8+GSAhxD4loj
         6hZHgFzsohM6C2YD4CIVVWMjbBGjb8dF8W0s2Lm+OaGZyspKZLvRdO6famu/tYmnIvR+
         6vF7dKKH2l0ScfdrRsYLhe6jXdzXGpVM9TJfbikGenVyocqfyMDOnPUuXMjPiWlDe0fm
         l4M+Bo+pK3dJMYc+gpmf8s7OuLPB+c5Xd87sZMEQ/TexdOqspC90hSTH3HCgN1s/313I
         VHLFwIuitu37+KZk2VRgJBm83u7fsOLKLMKPqMm2hF1XaxBqPq/5vlwGtf6J4h3iRUvD
         0zUg==
X-Gm-Message-State: APjAAAWdzNXila9p2Q5WfqU9w1ovRwtO9bbfhC3Fng+aVcGPdCeN2zgU
        PTdSlnIUjH0CQKVe5rAGKCyCwPxyXZoYiyPGL3E=
X-Google-Smtp-Source: APXvYqz/uy9FWoPgcCIPsrNWdvriun+RHwQE6m09AWuN+ZVT9jYrjc/D3z+9REf7tJBGsduns2vaQgsAWGGQjyJVCuc=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr8587053qki.286.1561727404146;
 Fri, 28 Jun 2019 06:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104007.2721479-1-arnd@arndb.de> <20190628124422.GA9888@infradead.org>
In-Reply-To: <20190628124422.GA9888@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jun 2019 15:09:47 +0200
Message-ID: <CAK8P3a1jwPQvX6f+eMZLdnF2ZawDB9obF3hjk2P9RJxDr6HUQA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix 32-bit linking
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 2:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 28, 2019 at 12:39:52PM +0200, Arnd Bergmann wrote:
> > Not all architectures support get_user() with a 64-bit argument:
>
> Which architectures are still missing?  I think we finally need to
> get everyone in line instead of repeatedly working around the lack
> of minor arch support.

I came across this on arm-nommu (which disables
CONFIG_CPU_SPECTRE) during randconfig testing.

I don't see an easy way to add this in there, short of rewriting the
whole __get_user_err() function. Any suggestions?

      Arnd
