Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF81FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890342184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KSdCZILN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCUBTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:19:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36070 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCUBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:19:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id v10so3946720lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzDD0zY7ocErcFqZPMrXjysu/75kHNdRiWI1f+hCUAc=;
        b=KSdCZILNJh/i1FMeuYyqWj3x2h6ZRcGSVEy+EwyEFcOynT3qV4dOOGtxz3QwQRRHbD
         Ty5z/7KDLWzSwHRrnLngUkgIvvoLKo3dwCa06qWh2TH2zGY/i5OLqsWcLHg4IZgs8icZ
         BFIyfFTIpjPngDd2bakDyBkvpgG1Z0k+WwftltRTNcs4oaboXtwAC2tzxBUItBe5Nam1
         At87vznjXcTjWvH/ZLaZi6c6eGBrHcHkHDr9oVPC3bX8cc3MVkFSkQ098UGb6OhxztIG
         4Myk7htUSUdZ6FvQfJeKXn7uCVROlqhAwibRCu4nl9IJhkdb7wLJa7zYwPeR0idoTbp1
         GBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzDD0zY7ocErcFqZPMrXjysu/75kHNdRiWI1f+hCUAc=;
        b=QBVeXP0FJfF47LpdBV+l7g2uPz/AR9wsmUwDAOrwLhsDMqnBw3MDpvhjbl26veq0yW
         cRfxc+hlPRYRTRwl+Mbizg1oWYrgG8axMhvs2Rg8qegNMqUNvYdd52N41IXKvLncvWMH
         XBFqixQ5V7mtxHMgn54Ahw92PB5fGezMjFyaKAevToDMoeTfik8fV56oq+JhE4smaH97
         ADz9OrQNE1w2F/sXRdxRfw33qwxLFRUE2eVB3i59b8BpAKqiAxxZ48TORGAutsEKrSV4
         ulUNHqnHESdM+nioxCIAsNtdOA29RYOdq9NDYBnbbipKvwmaWMe74YTUdpfkZ697qhFQ
         BZiw==
X-Gm-Message-State: APjAAAVZwswPRM6MyMmHj8ozn7py1jU8UZ6ZGcCjGx1PcAkkf8RaqieM
        WoHep/ewW4wV7sWwqD5euurhZKW7PaBFWygWl0eX
X-Google-Smtp-Source: APXvYqxJsMgDoiVFUNhLX4sseZvQWuOCnKNeH9xJ99s4kh2ETMNxPPAyJsic2SekW3e0MR4/fBuEf/L4PTnpxlaOVJk=
X-Received: by 2002:a2e:904b:: with SMTP id n11mr490729ljg.57.1553131177518;
 Wed, 20 Mar 2019 18:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232908.GF16301@altlinux.org>
In-Reply-To: <20190317232908.GF16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:19:26 -0400
Message-ID: <CAHC9VhT3TXnZoARX=powgCjxdruV_H58sM3Gmc8BjOHnvXpffA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] Move EM_HEXAGON to uapi/linux/elf-em.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This should never have been defined in the arch tree to begin with,
> and now uapi/linux/audit.h header is going to use EM_HEXAGON
> in order to define AUDIT_ARCH_HEXAGON which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/hexagon/include/asm/elf.h | 6 +-----
>  include/uapi/linux/elf-em.h    | 1 +
>  2 files changed, 2 insertions(+), 5 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
