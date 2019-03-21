Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45931218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oR0ZYNiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCUBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:20:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36651 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:20:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so3395428lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvBwdTcEw1R5zX8xVZtB1Te0FHgHwkHqhIHaa6yTtKo=;
        b=oR0ZYNiHYYSmZwTkUCioNpDX6I8AjLk+QXdNl1Ozv82+/8REq7h9nf9vgkf1E2v5aP
         SA76FY5IyxajClhEF99T1EFnyP7LMwBC3vhJfM9xgZ+eBKk52bSEwsmWpcnIwEnshld2
         pVJ1IemWN8HMXOgwJRLoZJQ1fo+gyLZQJJcr2S7eYmPNqe/3AVEEVExlpUDbghpDODIS
         x+6P/vQ18k9Q12xjLKv+GRZFaVZBwD27ItU/yVBBlMYGoNGvCNil5+ez3vZbWjgqDbpa
         14x3bwPLR2ACGOgr9MvV2aMlTurIkVsP+PgQH3eQXqQbhljmtN/Ey2I71pPNQEcqO07r
         XqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvBwdTcEw1R5zX8xVZtB1Te0FHgHwkHqhIHaa6yTtKo=;
        b=KbGDtvCa1WHzFUzCWTYJ+e0+TuHV1DJ9a0BKM5sd4TuwUBNX8bKfcPO0WccC71L9DK
         p5bscKv7z3IWCGuzCZw9btBhL6tPjnoLdg9oNWkPzAVUQVAY1ywYYZLdZaJsA+BCUpIj
         x92SW8rrgtCXr2hY0Jki4TblEOQUKLeqlkIJfaeIV4/31moLvoVyHrIxeGpUPrFZaKOx
         0SzmayRPpbcjf8r0YUYzhzGWK5HEljM6Izj3hzs+tcuqfaaXgF2hjpWG868SFm73ED2+
         OHUMWoTl3lsLrdIzgpdXmSaRJ37mgKDbkY2zdUMJcc3ws2aUDtAX+xX6uey0hDwzUQPa
         OH5w==
X-Gm-Message-State: APjAAAXqJERu4QUqv4zB2s08K98vjnOEu/QL3UKeiouNW+ETngMRYM3A
        rSldu8x09hQmC9ZZzSJADWyuItn9C/PLEApnkYSv
X-Google-Smtp-Source: APXvYqzUZ05wmhFOLhGfFHMyf6PZGJyI4RGRNrE5z4mlzF3w+267oal5GIb3YHK4prgH2Gr0Hj7VFAMinuelgW2t6xc=
X-Received: by 2002:a19:7613:: with SMTP id c19mr372155lff.105.1553131200075;
 Wed, 20 Mar 2019 18:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232932.GG16301@altlinux.org>
In-Reply-To: <20190317232932.GG16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:19:49 -0400
Message-ID: <CAHC9VhStCeH=fmgt8TAG+MeW_OWsLC75LrZeh2pUcmnWSWCBgQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] hexagon: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/hexagon/include/asm/syscall.h | 8 ++++++++
>  include/uapi/linux/audit.h         | 1 +
>  2 files changed, 9 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
