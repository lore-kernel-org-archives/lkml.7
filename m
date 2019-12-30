Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92889C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F46222C4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMOl0NfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfL3NlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:41:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34427 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3NlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:41:01 -0500
Received: by mail-yw1-f68.google.com with SMTP id b186so14093502ywc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGzPYKUVu3c/nY8lDHX/WpdNFa7rqqFtVUQ1GhvvgzI=;
        b=HMOl0NfUe59KNPwN3rupWGM8NTgeAGnLbF8B+75zNeLMinYwPYyBGeTiOYeEfBVG8U
         8bsaODv1BEVilvRyBhNKYAnUXCFYZzo/l1I+PHjKoQEex2+6LFdna+PwZT9Fweb4KlLs
         KtJQMtABuZ6+SnNhJgkazDVzycJHeln59myv+yix7QHE8Du9dGXmylFtJEW0y4ok4TfY
         TZ93Hat0NzifmKpnoP6A1XRxxrxzs2cTNi5Ha6jz9qGWQctBkTQ4n2Mxay5/sIMim2+B
         bRaSX3R9XCtrQw7qoowBaiN7ma3GLoYhhQp7RaT/87JgHX4n0VkIFd/JNGtdfu4I4yjT
         Cvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGzPYKUVu3c/nY8lDHX/WpdNFa7rqqFtVUQ1GhvvgzI=;
        b=qvM+ZaeUO4Di66qG46JnO8S4hpnSBxthkbno6yjNsMPfoU6GkYyLqoydySXK6MiI7V
         9yRcOTYoOZYqEoN4WSY0uW3TH9rkkNPXU1K7aL1I74k4OR/V+9A6UQk6Q9IU5Cg7glaU
         swLvpmAgYG+eebW2j3XVVPM5awOzw7mHJ8pZL2vZQQxOaKG7OaEpn3w857EVo5Y0lTQO
         uF6TRSrrxN7YD5h2mMnS1RFD/BR9E/ic67aNRfihL2aPOUucQqS25PHARtPXZggKdQ8+
         GPY+etFAN56UVh8h9GQDXiz3g3xTub13C3H4FTcj4z6S6RUhzTky9fklbctG0yCyiXX1
         gpyA==
X-Gm-Message-State: APjAAAVqvRVT5dcWe4q2j1ygB2rqTq4GbbGC0teEnP9caVsp9JEifxAM
        dQp/N948BPsUvHASq7iR3MEUV/cnnDg+OJKD5jU3Rg==
X-Google-Smtp-Source: APXvYqx6bOTVgBVKKmvRBKRsSSejeEIXGEv/OtIei+OyNv+ywEt+Y+J2w4HSX1ofnaDDNnritsQe2ng9xWOZbupLlWQ=
X-Received: by 2002:a0d:dd56:: with SMTP id g83mr47756883ywe.174.1577713260439;
 Mon, 30 Dec 2019 05:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1577699681-14748-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1577699681-14748-1-git-send-email-yangpc@wangsu.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 30 Dec 2019 05:40:49 -0800
Message-ID: <CANn89iLq6Tt5TZj9SXxK02y=3f35kRSsR2zGBL=1QmFmJBpvXQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix "old stuff" D-SACK causing SACK to be treated as D-SACK
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 1:55 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> When we receive a D-SACK, where the sequence number satisfies:
>         undo_marker <= start_seq < end_seq <= prior_snd_una
> we consider this is a valid D-SACK and tcp_is_sackblock_valid()
> returns true, then this D-SACK is discarded as "old stuff",
> but the variable first_sack_index is not marked as negative
> in tcp_sacktag_write_queue().
>
> If this D-SACK also carries a SACK that needs to be processed
> (for example, the previous SACK segment was lost),

What do you mean by ' previous sack segment was lost'  ?

 this SACK
> will be treated as a D-SACK in the following processing of
> tcp_sacktag_write_queue(), which will eventually lead to
> incorrect updates of undo_retrans and reordering.
>
> Fixes: fd6dad616d4f ("[TCP]: Earlier SACK block verification & simplify access to them")
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 88b987c..0238b55 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1727,8 +1727,11 @@ static int tcp_sack_cache_ok(const struct tcp_sock *tp, const struct tcp_sack_bl
>                 }
>
>                 /* Ignore very old stuff early */
> -               if (!after(sp[used_sacks].end_seq, prior_snd_una))
> +               if (!after(sp[used_sacks].end_seq, prior_snd_una)) {
> +                       if (i == 0)
> +                               first_sack_index = -1;
>                         continue;
> +               }
>
>                 used_sacks++;
>         }


Hi Pengcheng Yang

This corner case deserves a packetdrill test so that we understand the
issue, can you provide one ?

Thanks.
