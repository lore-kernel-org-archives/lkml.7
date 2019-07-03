Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B257BC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861AE218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGCIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:41:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35395 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfGCIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:41:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so1665630qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpaf9lU2R84ri7xVwxgAUugNK8mi0QVQIdzUzZXfbDo=;
        b=Zr9JRl7Mnkg75XR4ijGTZUMfjuQ85kDMUgiqHMezT6hUNubz+5rhKOop9D9uMBZNg/
         F6jQsa5pHVsN1mP0mdgw5Xx1i4gB2lLx2XLxxnpbZRUYrULnz3eDNoMr+VWWp0SHBqXg
         U0Q4SFyF/uUItst3CrjfnvlXHqBrV75YvlOglwT0sSkEa9zgmLG8tTXc0SGsVSDUocGt
         YPkkmmtUn7CidzSOdMdax+LKS2BbuEo+17L7mivrfopcylIka/XWkvbUAs2klc1IUQeQ
         7UKWvmNcn+cQdr/27cfYjlf2pfZR0x4hAlHDN5jzHStVyDvWa2c7MTCDsWEy6YgFZL9J
         IexQ==
X-Gm-Message-State: APjAAAVQ+OND8B/EfrcY00OZvoPMpsvo7JrVsfQl9bd26qRQt/KsUOE/
        3udJkNx/AXvVywJHFNbqKYYT7RjHzy/V7A/1+Io=
X-Google-Smtp-Source: APXvYqw/isIQVR86YurJHzzVWpoyagqBaU3E+QG77fJEsMus7eMH/CMpf6rQRAAXL61ej0CTyYTenRfAOEb6VYIdOxk=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr29008003qtd.18.1562143262038;
 Wed, 03 Jul 2019 01:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com> <20190703001842.12238-3-alistair.francis@wdc.com>
In-Reply-To: <20190703001842.12238-3-alistair.francis@wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 10:40:45 +0200
Message-ID: <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 2:21 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The glibc implementation of siginfo_t results in an allignment of 8 bytes
> for the union _sifields on RV32. The kernel has an allignment of 4 bytes
> for the _sifields union. This results in information being lost when
> glibc parses the siginfo_t struct.

I think the problem is that you incorrectly defined clock_t to 64-bit,
while it is 32 bit in the kernel. You should fix the clock_t definition
instead, it would otherwise cause additional problems.

        Arnd
