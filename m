Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF492184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="png9P/RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfCUBWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:22:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44772 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfCUBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:22:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id n18so3898653ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/9mkPDueWB5jp9h6m/DpFMCTE6IOskbl9YcUe6dgl8=;
        b=png9P/RBDcgvnGnMYJdCsY7XR0VRtYY91hJDT2HGsHCCxS51+Fbj3ULgh8aAgIeCgf
         4JT2ZXS9vGsIZEvgvemm3KLHGAFtQL385PBEqmFSPsBDTNjLWjHq2ewXwXtEWnlAus3S
         ZIoJ7Fms+oB2pYosQPlTOCBJsJEkXMRZJwxgp7qsFrqkwq7L4hxTxXQrm3fs6vanLnCB
         X2/Z3oMVBMgJUD8jIZnwGed1cpoeTFVWwwS0SP/n0EiD7FIGthzrgiJ2ny5SMc0wbahh
         UgJGPN6iIDJVkxcMYH2+646cWp85mLXXby6b6HJhIMQ4Z7OoZXrJ7dbQ42Io+lWh958E
         XwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/9mkPDueWB5jp9h6m/DpFMCTE6IOskbl9YcUe6dgl8=;
        b=p+llpzxuVqr9MkHO6MM28qu/n/W87X+z1BMp9XpxodKRcRmnblRkgbCHHUe+338rZX
         C0gkuZe3Edv1SGOeqtHdQtQrLduNPFNkVXqqiqcC8VXDExnwDl3Np51jN8IuVwsVUtd8
         WaS+U1B6uEVgQwWITPzYhucqDUqp1KuKOO6BDGIRp+MZeop6Av3ppduq8nkBCi5m9Tk/
         y6UTCOchy6dfZDUZ2Ai8YbWWHK2IJJz6uXz5J57T5uR+RWqHjKcsgHqF8GpdP2qWu3Jg
         Yi1+j4Q/Sfq+UeKDC5KX6d3/JRDU6n3JsKEsRIQzLjHiTUEAj87h5CcyIWrMxVN/nmng
         01bw==
X-Gm-Message-State: APjAAAWvFnunmfJjD+Mtp7h6Ffbo9N5tGYOxyRX+74SRGVZK5zeAEYPm
        roaw1RaEufMvR9DGBxUeVpwelBLfu0qV9qd1LlY0
X-Google-Smtp-Source: APXvYqzJ9uakQrILXknNNxNUFOS39iO4LJRCvOBo3e2PvVP+epBzpFDneTQD7XEZhkHpy9C66AB7z9Lopa+dYUHLwA8=
X-Received: by 2002:a2e:904b:: with SMTP id n11mr494682ljg.57.1553131336141;
 Wed, 20 Mar 2019 18:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190317233011.GM16301@altlinux.org>
In-Reply-To: <20190317233011.GM16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:22:05 -0400
Message-ID: <CAHC9VhQBoaZZCOd1e12A=JU-U9=Eu+is8ictLzcj+KJJX2xtag@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] unicore32: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
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
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
>  include/uapi/linux/audit.h           |  1 +
>  2 files changed, 13 insertions(+)
>  create mode 100644 arch/unicore32/include/asm/syscall.h

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
