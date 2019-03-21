Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C649C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1298218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="r/dFrEjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCUBSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:18:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43051 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:18:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so3367456lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6BNKYQmd7f/P74NYF9bzQbO7o28sToq2pxfXnFbI7o=;
        b=r/dFrEjgwkOAIrMrl8OiF0hlNxi/hHEFAvciRTw8vyxCVAvnfe1Gle959fvwsz+wH9
         5ej5HUvkkHtkPebIkkKmebpWvAio/hkDFFhdbGTmEljgBKa55GBjecT+J3Zz3P2+hcKv
         gcI6cyPUZAxEtF01pErEfNu8rh8qnDlQT+ydOfcd+stuBNUm0ReBXMRRPoHNNeJ+IC13
         cM1d9iB13OmsUQtnA6qWxHETtgBrBxSoQfBbPizgeGjF4uZRrkwvjRcus1uGPvonc7sp
         PlRkJX451y17Uc7jTtlHNZil6OT//uWNyc5/i6MGr48SYZ0C0BKQk/V3qiTKQ1wh8cjO
         6ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6BNKYQmd7f/P74NYF9bzQbO7o28sToq2pxfXnFbI7o=;
        b=ZYAxtkQ3LhttiO/cRrSt6+dE+pC5ruhU1lUi26VnqziiMfAEpkq8BmChiJV7Jix8Mn
         9TcVPGbpLQLUqkgnwQGWaC4D/0+xVrLTwMsMuBmcBxH+KWWoO6NzzMsGI0Y5jEk6dbbj
         YVFUPYrmtiWVQVtsyu0Te28RnNWyEoDIGFS/ukaNfDfjasDc9Skfkj21DfUWH+3vRhWI
         ErLa748ppO0cg+Y1VFh6UA0wwVVjAJWXYkwN22gMKWx8DDkooEvcT4nu/CMt+fpIuMGq
         HBF/7fI8vnO19WQ0uHwGUsxA7vK4prTEbYPpg4m8ru0RGXrIqT9GZ88OzDF97WB8AJhx
         xXpQ==
X-Gm-Message-State: APjAAAWTG7dPY/QGS1XXDYLiyzcpbgja9NJa5fPldrAOccKdsc+AglIP
        zhOWNhLJyAOotsjy9BsEeCS0YbRP0rDD0XXFopqA
X-Google-Smtp-Source: APXvYqxVsSEb0srcbBW5N7R9NX7Rjhpe2qOYX4hSIwGnMaSyQpEa4kkvSQSs70U8kbaG/wXhK3Qf99OwjuThMrt8PXU=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr380473lfb.117.1553131108078;
 Wed, 20 Mar 2019 18:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232847.GC16301@altlinux.org>
In-Reply-To: <20190317232847.GC16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:18:17 -0400
Message-ID: <CAHC9VhTVqYLnaLkZqVcdtOsNqisZz6DaGsnPu13FjNfYco9Yxg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] arc: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:28 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/arc/include/asm/syscall.h | 11 +++++++++++
>  include/uapi/linux/audit.h     |  4 ++++
>  2 files changed, 15 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
