Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53B5216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="x6exvqB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392364AbfETQxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:53:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41760 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388746AbfETQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:53:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so7499740pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c20f3Uy5AB/Gpwno1cTjtsaMqlmM2s5OZcsDjKv33Gg=;
        b=x6exvqB1OaLuoM/xTiWeSQdbIEXNbyjWXnZRBmL+g2ZZMe3hd+o7640/p7qsiaTP5w
         YeRJt7aoK8jBv2DKS7z0F9Sx6bYhOMvuTSqpXojvsPXjT1ZZFb+ujclCy7ljg653sEB1
         AmJeuNL6lUkF8vcSARDLqFL8iDbu/xiLz0mYarz0FK9VmjhUgL1bBne7TZAJ9McuIl+3
         vZiJMo+riMWztQ8K6fvfhmjfFUtio+9UH/T86P5BfsCJxcHSZ/K+AOCYyiYu5oUHRws8
         jPw4cOty4/yPUpmBKG5PA/ApMGHqVKRwqdC86vHbVWHACmYSmrSvuahUUR4KuNxipXGS
         Dvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c20f3Uy5AB/Gpwno1cTjtsaMqlmM2s5OZcsDjKv33Gg=;
        b=U+T38/qHNlTRmU1euL46E5mewgUVsxx5R673JL57eSwJDc4MpMeO2zXVHgLmCPesj1
         J9aG1MmBVN5nfnoVe2HlcOEjw0bZrvGbgnSGhSGNbDxaCpBpyBrq0PPYThMvzfJ/l+QI
         K3hHL10zUDQei2KFJfa4I2mBfJkd79Z6qxqNRsZwIqR2h/WxKnGIY7RYV5dpkkoG5kIJ
         obYeK1q3HS/KyzWVbYALzFdb6/2tagH644+02FsXlfm3xbXOtKdBFzaFyzvi83XC6apf
         qAI5mP/rSQEUYwcqrr7DxgSTkbil+3cc4eUyTC4pxI3BV2sMZLHfhXpQr55BmUEjXV4L
         Tjig==
X-Gm-Message-State: APjAAAUVXGE+YW4S1sf6pJ49lZb2o2zjPNPyDvAe50iFfQ8MuxqIz3Yc
        CTHIHUG77YXDdirRCjlXkvSfPh9MFi4=
X-Google-Smtp-Source: APXvYqwNXBSATkDA+MTsDrIhuYp39xzy7Plfkd7vDczjkfCUq8ddFXOENvNKA9O8rggfnMmevZUPww==
X-Received: by 2002:a62:575b:: with SMTP id l88mr80907008pfb.143.1558371203496;
        Mon, 20 May 2019 09:53:23 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id k13sm14575196pgr.90.2019.05.20.09.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:53:22 -0700 (PDT)
Date:   Mon, 20 May 2019 09:53:22 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 2/5] libbpf: add missing typedef
Message-ID: <20190520165322.GH10244@mini-arch>
References: <20190518004639.20648-1-mcroce@redhat.com>
 <20190518004639.20648-2-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518004639.20648-2-mcroce@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Matteo Croce wrote:
> Sync tools/include/linux/types.h with the UAPI one to fix this build error:
> 
> make -C samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=samples/bpf/../../ O=
>   HOSTCC  samples/bpf/sock_example
> In file included from samples/bpf/sock_example.c:27:
> /usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
>   102 |  __sum16 check;
>       |  ^~~~~~~
> make[2]: *** [scripts/Makefile.host:92: samples/bpf/sock_example] Error 1
> make[1]: *** [Makefile:1763: samples/bpf/] Error 2
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  tools/include/linux/types.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index 154eb4e3ca7c..5266dbfee945 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -58,6 +58,9 @@ typedef __u32 __bitwise __be32;
>  typedef __u64 __bitwise __le64;
>  typedef __u64 __bitwise __be64;
>  
> +typedef __u16 __bitwise __sum16;
> +typedef __u32 __bitwise __wsum;
If you do that, you should probably remove 'typedef __u16 __sum16;'
from test_progs.h:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/test_progs.h#n13

> +
>  typedef struct {
>  	int counter;
>  } atomic_t;
> -- 
> 2.21.0
> 
