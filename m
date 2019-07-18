Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAA4C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66B02184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jy9lZlRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfGRVBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:01:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39131 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391404AbfGRVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:01:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id w190so21622408qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d3gbOiHWq+PQGcMb84EGW5VHcSxkdLLOkJ058Sc+Rjk=;
        b=jy9lZlRYlM8JvML25Tv8fe+vQV0yYqaChAXX99N+l/b8CgwUZFls+Mtq+bVnuMUsep
         S5TCoSCQG7H2sNk7TQ4y1vW1DYglPnuZ+hmRp0r1sHiESBnnEdfTNLCfG/Q/29XWyn2d
         TAGeGRjxENk5Zwlp0dsa8AJ+vlB+egVE/oed4QYBeXM15iISqHmw1B2e6JltUroQq0s8
         1KUTG2uxDBV/jcgwc6kynh9u3ugYvKoJ9HmPPSZFuiaTgEkh2eVpwFqzd1FRlioVSyrN
         DduCXRUWfjHpxf42DYoajqLXwSZOsMYF9MfwxLd6D1h5xSXB1ThszMKzQT2TOUlk+VfJ
         xRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d3gbOiHWq+PQGcMb84EGW5VHcSxkdLLOkJ058Sc+Rjk=;
        b=MTjP0D/KGAvWvd5Hlex5CjTn48vrkJ0AT6lOIxgQe4YuvSvSRfR4tIiWWwJMm8RWxs
         v6SQ7yV7LQrgzq++dwuAMOTggO24ynb5lfwTbGCdoJjGCB5dRIHMmpZJvBLLIgkD1pmH
         YgnE9G8l05RLRJk4+acEgzZJDmh9F6KtXMDHYgihf9v0uFpGhrGlt3fPmjID1fJWqzq4
         1afZ80q/z+wXQrDlnfU6+zFYGqYMzJ04jkRgU0sZS6mtvE+cQ+xq7SRNiDac3E41p7oZ
         fqDepzjnl8krxudz1JkIT8Mfc0HaH/Ol7v80vb0FywDfam7u+kOV1hy1EDkpDb1d1/6M
         q6cA==
X-Gm-Message-State: APjAAAVclvT52WNDgNcmkmg5zMnWwUI5VG/iGwkHeYSfXkQFLacKSr10
        ZxA20sMgrIF4IYNbX58MyV+TIw==
X-Google-Smtp-Source: APXvYqzYEVlqRbknyJdNr7IF8xQFjBVOZ61wk9QdKZJMce5AC0j3Ju2qkIoD1gIRBmjt53tYD4nZ9g==
X-Received: by 2002:a37:96c4:: with SMTP id y187mr32372461qkd.462.1563483689167;
        Thu, 18 Jul 2019 14:01:29 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r26sm12644419qkm.57.2019.07.18.14.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:01:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190712.175038.755685144649934618.davem@davemloft.net>
Date:   Thu, 18 Jul 2019 17:01:27 -0400
Cc:     sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        natechancellor@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
 <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw>
 <20190712.175038.755685144649934618.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Qian Cai <cai@lca.pw>
> Date: Fri, 12 Jul 2019 20:27:09 -0400
>=20
>> Actually, GCC would consider it a const with -O2 optimized level =
because it found that it was never modified and it does not understand =
it is a module parameter. Considering the following code.
>>=20
>> # cat const.c=20
>> #include <stdio.h>
>>=20
>> static int a =3D 1;
>>=20
>> int main(void)
>> {
>> 	if (__builtin_constant_p(a))
>> 		printf("a is a const.\n");
>>=20
>> 	return 0;
>> }
>>=20
>> # gcc -O2 const.c -o const
>=20
> That's not a complete test case, and with a proper test case that
> shows the externalization of the address of &a done by the module
> parameter macros, gcc should not make this optimization or we should
> define the module parameter macros in a way that makes this properly
> clear to the compiler.
>=20
> It makes no sense to hack around this locally in drivers and other
> modules.

If you see the warning in the original patch,

=
https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.p=
w/

GCC definitely optimize rx_frag_size  to be a constant while I just =
confirmed clang
-O2 does not. The problem is that I have no clue about how to let GCC =
not to
optimize a module parameter.

Though, I have added a few people who might know more of compilers than =
myself.=
