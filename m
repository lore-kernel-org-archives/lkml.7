Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A31C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8787020C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPSYG2y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfHIWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:14:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41075 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHIWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:14:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so36152949pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTGM+jKd0j/u9kKivj5QkkT0ws6UqJeC4LOf3qyOSiA=;
        b=ZPSYG2y1FubHnMCujvzkNF9nNq1g/qGihS3NYDYHfoowc1sONFpcYWNKJOsWswrUN7
         8X8J/DAdY5e1GK43gVcXEcONfn6JKlZjPIK/cEJU4xZkkY9E5BlJ6rMEabiwiqyTt5L5
         rRSCuTe8ibPBWDXs7+ytP5eND2MMvLdBCH/7MAdvGJhqBodhDlT5k3zLaZUh/dI29U1c
         6H463+QhLY3jWsJLFnrg2zH2XJPDoMlh1jfs641LcfynH4fwV6mRqFQ+xh+fvDTlBrIa
         t91uYfy0NeJKWYGCvHaGKnIaHtSOa8x6k5c6o8FGkyvGMWwPrBhNC4OLlUTCaJZDsQM8
         HUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTGM+jKd0j/u9kKivj5QkkT0ws6UqJeC4LOf3qyOSiA=;
        b=cMla38lzQ7XZZrtXLR9YGaO2+LyDf2UO9CINDu6w6KHpK0wNHAHA7TGL/GMZo/7qB/
         Zoi+0Meu8c46xK3qPkAvUxzHQvJ8863juypvv1GEV3i6Kstafmg7UzwnHiZNahosbMbU
         vd449JrMw/9jHTkmBPZPkqeqlJvfhD0ZBaEGaB/knvYdeqWII73GxkWlZHKQdCkpHPpk
         fDn/BPeG5nHiQYKcNYtuEd3ioki4Ks3JrtCfgkhsIClK96rPI8tGO4SoO174gdbm9HRR
         naP1BR9kKqxhPBMpZOcdeb4GJ1IA3iPyhppJsh2zQbLv5+gwIudN+eXzWS0OL99BQ4uB
         NjVA==
X-Gm-Message-State: APjAAAVDEJ1YGQf4JHTS5bQAnHWqE0SdsVmqoMymnckOgu1UtIv/19s5
        tapyQyRcFozGNkYhK8/MoefQqZk2EpsN4Ax1z3wq8g==
X-Google-Smtp-Source: APXvYqxitIf75C0kIneyrNkgvFG5aI1vCR6XBvjt3uLYaXSyX1fAscaC6qULNBcaWiY/708qdARMbGa5q8vlVOwuBME=
X-Received: by 2002:aa7:8085:: with SMTP id v5mr6610774pff.165.1565388863281;
 Fri, 09 Aug 2019 15:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190808032916.879-1-cai@lca.pw> <20190808103808.GC46901@lakrids.cambridge.arm.com>
 <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw> <20190809085332.GB48423@lakrids.cambridge.arm.com>
In-Reply-To: <20190809085332.GB48423@lakrids.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Aug 2019 15:14:11 -0700
Message-ID: <CAKwvOdnbZNeCHbvYMgBd-mw0Q3eP-AxM9dqWmM3pZ_BrDaTzbg@mail.gmail.com>
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:53 AM Mark Rutland <mark.rutland@arm.com> wrote:
> * Find a mechanism to suppress the warning on a per-assignment (not
>   per-file) basis, without altering the structure of the existing code.

#pragma push/pop can be used to suppress warnings in a localized
section of a translation unit.

-- 
Thanks,
~Nick Desaulniers
