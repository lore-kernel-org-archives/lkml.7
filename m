Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGDIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:34:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35650 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGDIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:34:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so4709132qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++/HKhsN/QQmLM6JQP1fW7J8KtQqaq40rFMcnPScN9I=;
        b=QRy/VS145q02ewAmxoO+V1Q4m4YchBvIGn1kSzKdgzAIONmb1QfyiOfzyzJ5Q+96Tm
         XaGfl+lvMYoIT6bia7u3mjsU6LNRgwox7Hi8Lsy/Hd2MnKx9YtjZGk0c4eumZQ48KcQC
         OYLJIDVWjKwdY0VccRQh0tpxPW7p3M+w7oBvEZq4PwL21ji99pmpJZYB9R32Jps3Eb2o
         hxt1A/fsl4uslMBltVzsOtzQYCdK1PKGv+pNHUinNxv+aYuVOueO/AWdVWxpa9KQpbWA
         JaXrUOXLrp78Xvsd866g5uIjOsXZdRED6v5rHpH9M7mbNhM1loqGTkk3n/3SSsoOqhUc
         k3ww==
X-Gm-Message-State: APjAAAUWGhyk8HpPn7l67sCZZ/G84hga6s0fkSE42kSjEC+nygreXdZ4
        iBvVVuQLu73YrdcFj85bbDh68MEHYsNfoe2xYpg=
X-Google-Smtp-Source: APXvYqz6v7EmV3ngwarEeCmQheK2cppB5SWn6b8d1ITzAPozhijhSTjEbVFH/kwEzCFgZNgcYLW6HoSeSwOry1W386E=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr33754444qkm.3.1562229277017;
 Thu, 04 Jul 2019 01:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com>
 <20190703001842.12238-3-alistair.francis@wdc.com> <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
 <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com>
 <CAK8P3a1zJPiR06uxZ5QVoEyDU64v=oUu_p9X-mULLeXN-som8A@mail.gmail.com> <CAKmqyKMtsQaq9DpfPY=T0pixrH2sntewDz42dTvD5rDcK+ZV0w@mail.gmail.com>
In-Reply-To: <CAKmqyKMtsQaq9DpfPY=T0pixrH2sntewDz42dTvD5rDcK+ZV0w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jul 2019 10:34:20 +0200
Message-ID: <CAK8P3a36CXf+HGgL=nNYzc-1Qhh=tu6to0opwYjO4fO5KDxUDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 12:18 AM Alistair Francis <alistair23@gmail.com> wrote:
> On Wed, Jul 3, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Jul 3, 2019 at 8:45 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > What I don't understand though is how that impacted this struct, it
> > > doesn't use clock_t at all, everything in the struct is an int or
> > > void*.
> >
> > si_utime/si_stime in siginfo are clock_t.
>
> But they are further down the struct. I just assumed that GCC would
> align those as required, I guess it aligns the start of the struct to
> match some 64-bit members which seems strange.

These are the regular struct alignment rules. Essentially you would
get something like

struct s {
    int a;
    int b;
    int c;
    union {
         int d;
         long long e;
   };
   int f;
};

Since 'e' has 8 byte alignment, the same is true for the union,
and putting the union in a struct also requires the same alignment
for the struct itself, so now you get padding after 'c' and 'f'.

       Arnd
