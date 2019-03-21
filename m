Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F022184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QgWrU/Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCUBVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:21:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34892 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfCUBVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:21:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so3397478lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lixPi6vF9E+Z05ridF/EOCJDYp24FpZ4RzmYu5tBcYY=;
        b=QgWrU/Hg24mYE9VxUFBZ3N24fHqqkUQqF+RBus2jspdVC6/cBZNjZxvMuYRdtfuDIn
         h9c44uXmNHAxSx39hHb6CTP536iP0nXqMjf0cjN66Xa8PwxFgPZ69Sj7c4Nep6TpUl63
         fdWPuegzevKaA7w678LJ9gWcINaGZzI0uh8tRahtiR7AqBz96TlAsL6JaqV5jaFB0w5u
         p7u7UrVTkneBONjeXepPL/YLUAEKQjAO01oqAo8ohGAzNHLuU0+dFfQTiiWzo32+33f7
         kbJBjm4j3gWidtHhdhXDEhOrWQM1r3MTntO0AzKDlyqzq6/Gx4w3R/0P9f7TUpaZ74h1
         7+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lixPi6vF9E+Z05ridF/EOCJDYp24FpZ4RzmYu5tBcYY=;
        b=XGLkLC6yivyQBxuvz4gmLOTypJKJSKlbjjxDITIHmF94xkwTe3v/mvjddlUZU4djgk
         U2TcvhAZnHVhlqp3qI5f3+9WSo9M9ezEFckaYMXy1iAX1Fwml31m4+GnVyA9HeRdYy1S
         rMQGbb1+cOwQg90k4MMVK9AzAWYeP7qxTVN4i0lpf71xFAGrLGrer09AjVgIbpCmf9e+
         8IvL6JJ2Fg3y7u+BttecL7jwuvvSiIO9nwncBrH34W90Kjsx66PKeo6h7VJWyjmc4zc6
         LtKS4wsm9T/gjzl8JgbU2QHC8WD5Cbm4/xrrzTFgOjosniEzQXljNCNeq1DuWagCXzyG
         ZG1g==
X-Gm-Message-State: APjAAAUYrwB+OvcQM4JdXf/PWlp9ZbBryGV1Xb0mo4cvQjpGcx+W5qoo
        yq6iHX2NctSHHvzof5D5R5+IxoXz9coAMzNqcSbe
X-Google-Smtp-Source: APXvYqzHsWGAJpoNrUi7z71O7Yxj+Ch6bOq7I+TaH1X1ZBgT+6sKOFDO6IpGkQ9eoNcsVZr4x2FrLXJUZboGXmWtK5M=
X-Received: by 2002:a19:4f44:: with SMTP id a4mr405583lfk.72.1553131263817;
 Wed, 20 Mar 2019 18:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232957.GJ16301@altlinux.org>
In-Reply-To: <20190317232957.GJ16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:20:53 -0400
Message-ID: <CAHC9VhT7EJY9BYwXVUm+imTvcxEWjGvMuVHd6U8cfXJBaa++zA@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] nds32: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
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
> Acked-by: Vincent Chen <vincentc@andestech.com>
> Acked-by: Greentime Hu <greentime@andestech.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: added Acked-by
>
>  arch/nds32/include/asm/syscall.h | 9 +++++++++
>  include/uapi/linux/audit.h       | 2 ++
>  2 files changed, 11 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
