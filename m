Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E38620675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXW40dw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDRXK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:10:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39092 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:10:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id d12so2814923lfk.6;
        Thu, 18 Apr 2019 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VRJTwiPcVKV+l4Nv4+3RQXSKIlj6B6htoOdLtRSzD6M=;
        b=KXW40dw4cJhxb2DbIDoi/tZQAz6DxEpchCEYrFRqd37SWwZinuCyqKZY2BLW9z7cvn
         Uo8SCVjLlxL0AlT7f4XITfaDES7QG1hLWxQDoXzGbEeFKdc/H83fZagIZRqgdIPMjj/+
         WgmUk4v15NKmiRlhUb6Rq7k3fSgUXFo8si1vT2+oCsfU+Q2CU+nmsBU4A507fB4WWxnP
         ATIfa/MllpwUVv9sekbbE5wVCRQ9DAS3QCGqDQ/uVqNhwcXr7QAj0ubp9+YgVWkyOgwq
         gjT1awzpLjyhDWGrywHTGKM1Iu6XHQa+OnptSQb6t06CQgzSzG7tT6j23mQjlK6HI17V
         kYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VRJTwiPcVKV+l4Nv4+3RQXSKIlj6B6htoOdLtRSzD6M=;
        b=E9ovqQWs1UFKOmFzHpNEIq37zyt79+vKPId5X2t4JNFBpoyeuDPHFvOL5UcsrQhg+U
         +DVFf5HzcdulWtFNsBuA05XPQlqa2XXLq0WbYZxkGPf9Bb1eGzb/pztBmDDf+ZF6Z/zv
         ZyD+2aAXEi3SoYnir/epfBIp/LVe+iTxlc6Su4AGgWisTt4czNXljeMT8K9OPM2qMldR
         azlIcHBd5xaMI1MLLF079qrOK2yBM4hy0mmW9Fp80s0wFmWYfdXxKHeKA8PlosPXaMkH
         IwenSB/taCKbYIM135UF4qpWKFuDWIA8HrDUpIotQJIhHpOFsIQDXUVz3rf0wXiHLmft
         CSKA==
X-Gm-Message-State: APjAAAWLg4jj49vMi4NAzxiJY7NP+lj9cOtnw6hpX7exkqvl2ivlw/RB
        lXREgAYVJgXml34Q0zj+Ak2GbTPr26dIDr2qWoE=
X-Google-Smtp-Source: APXvYqwd7Bpsz49KEvM71xnABGwEvzQO7aKwNMgRyV1uM4IPn2HjVVWtCg7awSKNnPF/M+h6UJTTmeASE3Fg/r3OO9U=
X-Received: by 2002:a19:7911:: with SMTP id u17mr376277lfc.90.1555629024588;
 Thu, 18 Apr 2019 16:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180513.GA4863@udknight>
In-Reply-To: <20190418180513.GA4863@udknight>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Apr 2019 16:10:12 -0700
Message-ID: <CAADnVQ+RL4YuQs72v+sjLg-VLy476=4nORfoxYbb7Mp==vdt0w@mail.gmail.com>
Subject: Re: [PATCH v2] fix compile errors due to unsync linux/in6.h and netinet/in.h
To:     Wang YanQing <udknight@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:06 AM Wang YanQing <udknight@gmail.com> wrote:
>
> I meet below compile errors:
> "
> In file included from test_tcpnotify_kern.c:12:
> /usr/include/netinet/in.h:101:5: error: expected identifier
>     IPPROTO_HOPOPTS = 0,   /* IPv6 Hop-by-Hop options.  */
>     ^
> /usr/include/linux/in6.h:131:26: note: expanded from macro 'IPPROTO_HOPOPTS'
>                                 ^
> In file included from test_tcpnotify_kern.c:12:
> /usr/include/netinet/in.h:103:5: error: expected identifier
>     IPPROTO_ROUTING = 43,  /* IPv6 routing header.  */
>     ^
> /usr/include/linux/in6.h:132:26: note: expanded from macro 'IPPROTO_ROUTING'
>                                 ^
> In file included from test_tcpnotify_kern.c:12:
> /usr/include/netinet/in.h:105:5: error: expected identifier
>     IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
>     ^
> /usr/include/linux/in6.h:133:26: note: expanded from macro 'IPPROTO_FRAGMENT'
> "
> The same compile errors are reported for test_tcpbpf_kern.c too.
>
> My environment:
> lsb_release -a:
> No LSB modules are available.
> Distributor ID: Ubuntu
> Description:    Ubuntu 16.04.6 LTS
> Release:        16.04
> Codename:       xenial
>
> dpkg -l | grep libc-dev:
> ii  libc-dev-bin              2.23-0ubuntu11           amd64        GNU C Library: Development binaries
> ii  linux-libc-dev:amd64      4.4.0-145.171            amd64        Linux Kernel Headers for development.
>
> The reason is linux/in6.h and netinet/in.h aren't synchronous about how to
> handle the same definitions, IPPROTO_HOPOPTS, etc.
>
> This patch fixes the compile errors by moving <netinet/in.h> to before the
> <linux/*.h>.
>
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Added 'selftests/bpf' to commit log and pushed.
