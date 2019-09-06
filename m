Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA97206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNtLs7t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbfIFKdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:33:17 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37417 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393114AbfIFKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:33:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id t5so2002985ybt.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65kVRSd8L6r82UlwVzMF798b1GwajejAzPsNu4zkBd4=;
        b=cNtLs7t70/jENml7I67T2qq/VnnyS6oVPTZ7t23q2zNAANfHm94FqvGIz5/A0B7lI1
         yL55SqSaei7LxwdaPyritIGoz5+etu/qTp/kFN56tqjjX3LdoeXx1SOcdfyhzdERmzrr
         Ybkgp1cfMf5YFJ6HlnUsQgV2FrVo1pK2NBnnp2qDKid9bM2CZ/hsPUTMzbaINBY5Nix+
         z5ewMczg71ofUthuAF0uJW6xR30xHT5NwhVmvOi5Mlqv2Rc/oSw8j2FBb6rBtMbLmzop
         cbnNyI+opTA0Sp4iWspHo0bGkPN04st+UR8dyeAe4UeeC3EOTbnV5VlXTwtDOa6iY68N
         +a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65kVRSd8L6r82UlwVzMF798b1GwajejAzPsNu4zkBd4=;
        b=CVEGQtZMWc82lrLunYICNAKNyivLaa7LvZi3nC6Gn/xjYoYXsl2TTIxtuDvu6ZrVTi
         gqcvZntE0wfYrpUIWgofmOU9hAXREHjX2OFOQmZvt5K4OXCUv7lKyPyIMLs1pg24ODSN
         zWp6ikICoPDFdtp2tKYZ//V37i1JcpJkcqpfj50DhP8sdKP70xcYzOhcqFcp5GRg8f5R
         WEkp57509qaRHAdDqVt5NPpQhyrcYwyFkqfF3D+T5VkSJB7wtq5jN9K9XuyOMIwCSgaN
         szqiyG7PGofFN4LLjLl5pfl+2Tifl2B35rHmQr1GU7E4Yc+g3WMxG1YjOc5J4C1pglYn
         Pd/w==
X-Gm-Message-State: APjAAAVlM9Hm31V6ywqwQZn4EJQHmpIqFFK97oTM4H8Wrrtwt1F+y8ki
        m8ayGarFtIzs1CjcrP4KdRC2RZJoYctvNRvamsnh/Q==
X-Google-Smtp-Source: APXvYqwBjBAwgsV078IZd+51O1lMDUU4BGyKOGjc61Zk4J4JlexzXKO2wa/7pvCSj8np7KCjXG6Vm/Iwj9cJB1u/qrk=
X-Received: by 2002:a25:ca51:: with SMTP id a78mr5614515ybg.303.1567765993696;
 Fri, 06 Sep 2019 03:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190906093429.930-1-chunguo.feng@amlogic.com>
In-Reply-To: <20190906093429.930-1-chunguo.feng@amlogic.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 6 Sep 2019 12:33:02 +0200
Message-ID: <CANn89iLK7oY0OZK+g+HadktByojxVbdbPj9d5ephYh0qs3fXRA@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix tcp_disconnect() not clear tp->fastopen_rsk sometimes
To:     chunguo feng <chunguo.feng@amlogic.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:34 AM chunguo feng <chunguo.feng@amlogic.com> wrote:
>
> From: fengchunguo <chunguo.feng@amlogic.com>
>
> This patch avoids fastopen_rsk not be cleared every times, then occur
> the below BUG_ON:
> tcp_v4_destroy_sock
>         ->BUG_ON(tp->fastopen_rsk);
>
> When playback some videos from netwrok,used tcp_disconnect continually.

Wow, tcp_disconnect() being used by something else than syzkaller !

>         kthread+0x114/0x140
>         ret_from_fork+0x10/0x18
>
> Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
> ---
>  net/ipv4/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 61082065b26a..f5c354c0b24c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2655,6 +2655,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>         /* Clean up fastopen related fields */
>         tcp_free_fastopen_req(tp);
>         inet->defer_connect = 0;
> +       tp->fastopen_rsk = 0;
>
>         WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
>

This seems suspicious to me.

Are we leaking a block of memory after your patch ?

If the block of memory has been freed, maybe clear the pointer at the
place the free happened ?

I am traveling to Lisbon for LPC, maybe Yuchung or Neal can take a look.
