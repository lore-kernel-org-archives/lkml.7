Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421F9239C8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX8vkcdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfE2OU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:20:26 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33887 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfE2OUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:20:25 -0400
Received: by mail-yb1-f194.google.com with SMTP id x32so861394ybh.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUy0z4iSw34EaGviaEu3i8ULKI62dWY3xWhXEM5Or4o=;
        b=nX8vkcdpQ250rHdvswa6gSnnyCCuekV8Y/Xr/b1Ri+6EQz6pcC8HEhm20DkF2803/V
         6h4uIWinRWCh1BLMcqyteNi4gUowgMqyaN9NNPmqciBKaKI8vh1ZpBzv6uMJxsgecn+j
         vQFdeX2+iCimufwEDA5tgOWlK106FwR2egiV1Dy+xm+Kw7mH+o4FraKUgNUZSUOgdsCN
         DJgLZ4t/ICEO/KVZwe+PALiCzoWeOzrFY+fIlzSQZy7Nstf97VU24MORsPYPuMhihveb
         yMhjcKftyqHLorJrSLOpvXLQG21/Idq4GwHtM+djB/XebFWT2bd+oF/F0aXQViFD0RAE
         plpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUy0z4iSw34EaGviaEu3i8ULKI62dWY3xWhXEM5Or4o=;
        b=o7B7tVWDrJA9y9dGf/kZeTXUqKOONdQ1A/4wCHxtsfRxgpP6yol1cxm8/A8kuFEB3N
         6GEv0HAiraxJ/tiT6DvRYpoWHgRSkFT49HD/6+65Imr9/YHF7GKK7VBb89Q+DrhPMNQW
         srKeJInmPS0KwzC/4kp/ugWZMU5iYigzDZURiT2wp3QKF9W1THreESAGJoHlJ/D2+PGA
         xiD76WsEcWIG4OaYTEBmfPaHwt6ne7+VuoVH4bO9AJpr/d+YP3m+bm4WOc8G+4bVULEL
         JeE78tI7KHiebogKEKYaoaO/NMsDNOpkmvtrL68OLILgxxS8jraLSBeggeB2EiHy9BoG
         IWIg==
X-Gm-Message-State: APjAAAXd8UnhxbSy7jODTb7VxYZ+4j+/y0WjmdEFd6Vu72WJUV8i2p6G
        5dG0e1TrZtHKha2gAj+Jk82T71agkmzcXC8zShc3hg==
X-Google-Smtp-Source: APXvYqzuGn7f+/A1+DvTXLL0+G25nRQoJzz2tfgcamvslvVhXbiLT1ISami0iRSa6tkNePNALyPbKXpwvT+5t8QFdjg=
X-Received: by 2002:a25:7642:: with SMTP id r63mr31031362ybc.253.1559139624452;
 Wed, 29 May 2019 07:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <1559117459-27353-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559117459-27353-1-git-send-email-92siuyang@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 May 2019 07:20:12 -0700
Message-ID: <CANn89iLxxiX+4E7EURNKb=xRkk97rPaKTkpSc6Yu7fZbiwPT6w@mail.gmail.com>
Subject: Re: [PATCH] ipv4: tcp_input: fix stack out of bounds when parsing TCP options.
To:     Young Xiao <92siuyang@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:10 AM Young Xiao <92siuyang@gmail.com> wrote:
>
> The TCP option parsing routines in tcp_parse_options function could
> read one byte out of the buffer of the TCP options.
>
> 1         while (length > 0) {
> 2                 int opcode = *ptr++;
> 3                 int opsize;
> 4
> 5                 switch (opcode) {
> 6                 case TCPOPT_EOL:
> 7                         return;
> 8                 case TCPOPT_NOP:        /* Ref: RFC 793 section 3.1 */
> 9                         length--;
> 10                        continue;
> 11                default:
> 12                        opsize = *ptr++; //out of bound access
>
> If length = 1, then there is an access in line2.
> And another access is occurred in line 12.
> This would lead to out-of-bound access.
>
> Therefore, in the patch we check that the available data length is
> larger enough to pase both TCP option code and size.
>
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 20f6fac..9775825 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3791,6 +3791,8 @@ void tcp_parse_options(const struct net *net,
>                         length--;
>                         continue;
>                 default:
> +                       if (length < 2)
> +                               return;
>                         opsize = *ptr++;
>                         if (opsize < 2) /* "silly options" */
>                                 return;

In practice we are good, since we have at least 320 bytes of room there,
and the test done later catches silly options.

if (opsize < 2) /* "silly options" */
    return;
if (opsize > length)   /* remember, opsize >= 2 here */
     return; /* don't parse partial options */

I guess adding yet another conditional will make this code obviously
correct for all eyes
and various tools.

Thanks.

Signed-off-by: Eric Dumazet <edumazet@google.com>
