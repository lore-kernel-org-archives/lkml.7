Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE2AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573572184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KYjLZa6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCUBTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:19:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:19:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so3945141ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cZHh5p8SPIV848HtsOJ3/kkkFwpu621zDEBGewBax4=;
        b=KYjLZa6uIVC9QHnkN/8k1gEfi6bWoa0iF1TGp3EOD7GpZ3GiEJflw4nV4EUIF8ekc6
         ZjaG8WLgZt+Oh+cjjkcXr+SazNRKjr2y6sX/s2hQUre5qEZGHICkrJDPVMgfht2jU6kG
         ZwXxi9S/UD68J62wz0ZxkdT/WQ62zcQrKxvTHC4eopy6PNt91H1NJrX4WHbw9ia30LWF
         UiOP+Fe5OWnFP84+DqUJW0kZe0z1NE8PyOs8UGKPfxB6WCWo4kgmz0x9JtPNsHgHb/HU
         HCpyMDIZh/zw2y2KXHxsnr9k+pLzeqJ38hjODB9ViRRAydwHEwxH3EskiRtVg9Y8ynAh
         uTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cZHh5p8SPIV848HtsOJ3/kkkFwpu621zDEBGewBax4=;
        b=EfA4yxa0VqnhbZUGrmZCP/g4iRX5cTbSPd8P2lELqTmvxU4Nt43JoTPuXvRXeA7SsU
         O+wO/8hZZEKr4EfkfrgnwXNkw+4AE+xDSjQEH+qJWaHFPDBsl/AWoppl7lTMhVmrJH8A
         iEateMNAOp+JKit0TY15FXb6qdOjX11K/9hmFNg5A4M4qb/hG5e8VzVppXeh8ouGO2sb
         1aJo91BipaRXvBIMz++BgpbptM7O6PlkFhdTuUBzUYuZhSNglHJYQ8H9hocU7jz07ptf
         +nHhy7BRUXu44YfUCtvwgMh0PoaKApp472MSSK2n6V0HMcVgoEQafkWSdjUAdmxIWf1o
         L/qA==
X-Gm-Message-State: APjAAAW8FrZfJHqKqM/k3OQAKUntVsShyWxh4SATOW0F5SmQR/yYDtDg
        n2suExYYGAHL1hMjiFGS+zQdtAYwMJd3pL47p3/R
X-Google-Smtp-Source: APXvYqwV+au1E6jEmffFJUhOWOHuBVYHWRqTyFBWOc+JNBiUaUKXm+gxt0GP30YHOL6dihSumAzr48ya6AqAvuRALZg=
X-Received: by 2002:a2e:413:: with SMTP id 19mr478513lje.196.1553131154429;
 Wed, 20 Mar 2019 18:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232901.GE16301@altlinux.org>
In-Reply-To: <20190317232901.GE16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:19:03 -0400
Message-ID: <CAHC9VhQN3UOLkj6L4Xu2vZOqEAroPh=srNcuRkngPLMoEwBzvA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] h8300: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        uclinux-h8-devel@lists.sourceforge.jp, linux-audit@redhat.com,
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
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/h8300/include/asm/syscall.h | 6 ++++++
>  include/uapi/linux/audit.h       | 1 +
>  2 files changed, 7 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
