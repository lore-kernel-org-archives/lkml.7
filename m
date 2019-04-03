Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33790C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AA520693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Coq9e0YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCBZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:25:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36646 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:25:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so13340152ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTXTjbu6DJIQc8NFJSYiqPfZyS3U6rOibd7vzKP+eY0=;
        b=Coq9e0YI7xs3iHLHOwDqJb8bdvAGzKPCqosZjlVQ7PHIQpxiRklQEKeehNiryoLV+E
         UuPWIpXIWKUMhAwNo1V6zBB5BKo8C8wKPN4KB1mva7mNc9jEUdjIJAWOt6h3lUbuEiXS
         lAi5K94PHc1u2z8r+r1dvr0TVgnwJUtSY/kxa4W99D3SOVUryzwHJ95wsGwpqm5ECfOP
         9ciTgroafGyvp1fAu7D98tAiPRzP9HzqLaUYxeuNS0E5q44hc+fquxwXG/W0AKKsa/W+
         1TYWmG9UKvO1wZSmYJ3BYW7NRPb8zKnc9Tbh8RSarXiL6ShxS43u0qul+0V4gOeRJWpi
         twWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTXTjbu6DJIQc8NFJSYiqPfZyS3U6rOibd7vzKP+eY0=;
        b=CiDQU1nPFi+uLlR8yvVqPhiYpmJmh7JeU5tDnMQ6X+guFYZZxYbtIhHNwOGdsA/Wk4
         9FTP5MF/pf6a/h5hQ+1U8W+NPWugOJaPWBxEFsEH/ppC4nUF8KfmmH1jz0dzgV6abiNm
         8iQQgbELLDn4brpwwp8BOCrN56YqmaGslE4Im/SuQZ1zK1dggsRAqXDpA/J57RF5NPV2
         MYcZrTpoPkZDT5NHuNZnD8iwNfTcp9C056IiHnt9jTce2Zpgcbz+ADYoKqun5B2YgZB7
         fenKI8ogZ3h03UTx5A1G90r0CO6/9kAxdmQ6yk+CqgeNIjxyNK5szKyytWtV2h40PyZ1
         gFtA==
X-Gm-Message-State: APjAAAValjZWu1K7OImi5ZQY2LL03Q7rbaZPSzkocJfADFHpQITIGDxW
        nFtuKhWsUL0ltAp08X9RizfEa7Og83BuZO7WeNu2
X-Google-Smtp-Source: APXvYqw+k6lmWsK2vH/Pmcjla9OQJ7D5ESbL9Kx/zrdYrzL6CoC7Wnl2yPlZia5+12zk6zzJcSXZcYkhfy9Pt8J/gyI=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr9191024ljc.120.1554254729960;
 Tue, 02 Apr 2019 18:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122212.68a9964d@canb.auug.org.au>
In-Reply-To: <20190403122212.68a9964d@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Apr 2019 21:25:18 -0400
Message-ID: <CAHC9VhRbYZzd=526r4k6d12Rs=PKx0ro4+04BKfAN-ozarc2cg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the selinux tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:22 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Paul,
>
> After merging the selinux tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> x86_64-linux-gnu-ld: security/selinux/hooks.o: in function `selinux_kernfs_init_security':
> hooks.c:(.text+0x8f7d): undefined reference to `kernfs_xattr_get'
> x86_64-linux-gnu-ld: hooks.c:(.text+0x8ff5): undefined reference to `kernfs_xattr_get'
> x86_64-linux-gnu-ld: hooks.c:(.text+0x91b5): undefined reference to `kernfs_xattr_set'
>
> Caused by commit
>
>   1991af34fa26 ("kernfs: fix xattr name handling in LSM helpers")
>
> I have used the selinux tree from next-20190402 for today.

Hi Stephen,

My apologies, I just noticed the same failure and removed the commit
from selinux/next.  I let Ondrej know and I would expect he'll have an
updated patch shortly.

-- 
paul moore
www.paul-moore.com
