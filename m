Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DB1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333CE2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AkwI3nWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCUBVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:21:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43199 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfCUBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:21:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so3371890lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIqmkPC2ktuumkrxKyCDJqBUYjD1ty9m32sM1o8hS4A=;
        b=AkwI3nWJ4UK7zZPQvFq8EF893KE3kJ2RpoX7YyKSdq+DoQyqokCxlru7L/310C2SyP
         sFsBC44abL6PHvNtmAYx/g1UmXcDiPbSjqz7nGypKDr20AA13Iz1dBi8qdlnwggkilfQ
         +Uo3UvmNIhz89eh2urb5oD4dWgxAFHhVFJIv5/RhZYozFEEZ45QcH2BP3ySYiDXyifqb
         +3tvMmpm3y52roUTo3MO8Et3QJR6jAzljJMddaceA0lFBRc30fod/LooxTwU9IulR1Vq
         5SQsMLOvC6+RqJHDdRfJtRqmlojInxN4KCRsY9/i+RDVhK5lTerzcMcnn6e2AhMoRfdC
         xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIqmkPC2ktuumkrxKyCDJqBUYjD1ty9m32sM1o8hS4A=;
        b=ipEoOrb/Ag0jKpMHYLSiGqYGh8D85TYij+OOZ2IrIvJPG65NiTkqMAyU1WafBH63rY
         DIIBp8DVbkx1YsZlYvBr16PlTs3B2hQKeQwFKlp4Z1a58Kr3mZRpC5FvJ9rLgxiqiKrW
         mbK5y8/hDvV6QNt1Ko+Bla7FXg2nIT9stxIVj+1zFd+Ry8vWxXYbJJivhlU5cyUPRO02
         n3d+9boMWwoG1REPHqlDXBwyxVUOYxMUlK8wGv/B4104wRVhN/sevzSdOnfmSl9wPuhx
         0NvkB/7uVxA/Z/LEzqM0rxiRw2JUPNBtpeCo57vIPTVFA4vuS5Jc35zJK7T5MtqwScI6
         7r2g==
X-Gm-Message-State: APjAAAWAo5yqe1V4UCX7l85OzjjNHj0wo6RP/W5EfRop5i+sABK7y/3u
        8foZZlUpwb0xIj0cuNhQORkWFog0SctMM6LeoZ1Gs6l+A6/H
X-Google-Smtp-Source: APXvYqy4+tGBfX/N6W7mOZFAlvI/iVimHrw1jL0cyadPXutx4QCEhx9gZk/NMkp9RxaFKjv/X4pUWAvyjRvRA1/Ls/s=
X-Received: by 2002:a19:238f:: with SMTP id j137mr398539lfj.79.1553131298185;
 Wed, 20 Mar 2019 18:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190317233002.GK16301@altlinux.org>
In-Reply-To: <20190317233002.GK16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:21:27 -0400
Message-ID: <CAHC9VhQRZdVHKHA76SgKo-ESskj-=1++QXb4-m8LwSgjg-TR5Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] nios2: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-audit@redhat.com,
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
> Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: added Acked-by
>
>  arch/nios2/include/asm/syscall.h | 6 ++++++
>  include/uapi/linux/audit.h       | 1 +
>  2 files changed, 7 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
