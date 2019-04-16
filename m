Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCDCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EB320880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYPAcUwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfDPXE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:04:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38702 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfDPXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:04:58 -0400
Received: by mail-it1-f194.google.com with SMTP id f22so1478276ita.3;
        Tue, 16 Apr 2019 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D222hi2fI3ZV2+nSZWHWH5bkSynr1vLqwuPHSHAur2w=;
        b=EYPAcUwV1blcnTqb/nMj/7DO7Tm8Z8yYK38wGJ8WcMbKMmTXSRaDm4r7RfmU3B083D
         qfvNqWHNsZmgwX+iuma3GWbymnY1OhhehMOwdECDpFyMw2NXFevInyWdYarg/EojyshT
         cSY31zsFpZ1SLfZvfYuNMI1X6ZtMyZUhF1MGxuJIZICCZ4no/4TAtbOdD7fgd5a1z7Er
         PYW1iVD6IwjDp7d2sc9X37KVD4+nPf9Flg0tEKM86038MMG6p6hRMObGf9ys/4lBAdrV
         5/eFw+BDcVWRA9vWzZGyBIqBPYfADhTCkhha1nTI5MI+Palkaf49/eA8+RAJ0VJrYNxA
         74Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D222hi2fI3ZV2+nSZWHWH5bkSynr1vLqwuPHSHAur2w=;
        b=XcrZZ7j0DVSg+jC2hT3WXM5Bi9BzJD7+XAUMm9GsaMyr8X3XWstjkw68wd8OfwJCwZ
         AL9PO21kBBboUlNiK86KKr+g9lJYuprsOMZkbmYxsUxxtbfDSU/9IZXmth4y3X3PYYnM
         hudSfvEXFOfFaIcF+QVm3p8XbCzWCHMHcTOHvXpeYnRSQ8rCpGIEsjTJkcZD/AmzHbuA
         deKXRLrsZiTLQ1BhrhKCFadOhq9af6YZk2Q1vtfyJo9+wKJ5tuD5SVX7/CejEl2vDL0c
         ytlKJrW8tWwNM7K2FAczKLMkk7xQcNIxVivqc8kXvlwoj3ffj3hNchKlfSs5ZIyhoa+8
         m6QQ==
X-Gm-Message-State: APjAAAUNC6ym1LrAXcz/w0wmXWbwnXKDmnn1ZGMJV8P9zTqNkOj57i5A
        VPVt3JVe/DdC50XtgErqAQdP14aZTE96nUv1IAc=
X-Google-Smtp-Source: APXvYqw1Y+Ozh8pcpIlv2IRyiQtoTLMOqpGd8FlQG1YuwYB+xp5bNER3DwJlPNPBlnZ88RO4zG0RWr1kl6hV4gPYKYQ=
X-Received: by 2002:a05:660c:d4:: with SMTP id q20mr24372791itk.102.1555455897580;
 Tue, 16 Apr 2019 16:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190416203143.408835-1-arnd@arndb.de>
In-Reply-To: <20190416203143.408835-1-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 16 Apr 2019 16:04:44 -0700
Message-ID: <CABeXuvqa14ybq9d_BniwuURwjM+PfWTTbkeVXOF9SwbLVvok+Q@mail.gmail.com>
Subject: Re: [PATCH net] socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>

Thanks,
-Deepa

On Tue, Apr 16, 2019 at 1:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It looks like the new socket options only work correctly
> for native execution, but in case of compat mode fall back
> to the old behavior as we ignore the 'old_timeval' flag.
>
> Rework so we treat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW the
> same way in compat and native 32-bit mode.
>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
>  net/core/sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index dc7c31d66200..1e418c0b3b73 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -348,7 +348,7 @@ static int sock_get_timeout(long timeo, void *optval, bool old_timeval)
>                 tv.tv_usec = ((timeo % HZ) * USEC_PER_SEC) / HZ;
>         }
>
> -       if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
> +       if (old_timeval && in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
>                 struct old_timeval32 tv32 = { tv.tv_sec, tv.tv_usec };
>                 *(struct old_timeval32 *)optval = tv32;
>                 return sizeof(tv32);
> @@ -372,7 +372,7 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool
>  {
>         struct __kernel_sock_timeval tv;
>
> -       if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
> +       if (old_timeval && in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
>                 struct old_timeval32 tv32;
>
>                 if (optlen < sizeof(tv32))
> --
> 2.20.0
>
