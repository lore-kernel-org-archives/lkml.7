Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ACC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F9A2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bTV6Vuwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfI1RSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 13:18:00 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39353 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfI1RR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 13:17:59 -0400
Received: by mail-ed1-f43.google.com with SMTP id a15so4987457edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7u/X3ZsFh4QCXB1aDRlTZlN8LRgGRgqAHEMfX3+HruA=;
        b=bTV6VuwqQqIF1Ma73g7wCouckooUqmlm9owfdFD4H6eYXsBN0Rb/vG/+TRh+BprT9p
         OnZakAH4YHab3eGQt1mh894EwjNMSYHtUYMxdNFysuETUzHj5NXIx/3ekY1M4VgMUCCC
         6ENAGFIdIeNzZAtB+L33z3vstoYkwuyU6Kkic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7u/X3ZsFh4QCXB1aDRlTZlN8LRgGRgqAHEMfX3+HruA=;
        b=s+oOLyNvJQ3Bg7LMP0vALMbkKokoAAm7lYdDTZ/vvEuBaBkotSC9774HoIwnjHpTu4
         4Wae+DxUbIBVz01X1vpC5mopYmYpe85AyVTDqqz2IDtIJgUL4duoXTFWyeM4f+3+3G/D
         L1IPPDHYTJ/oqUYZr4qgCRWXAV8lBd5/AT9T8u1eK0Ski8MsszxPOXi7MZtqXwnU7Tmh
         Hrbgrfd+1eTI36+v+k2ZJNStJLi4/CdEZLIdktVTNy2GhILNvPq/Y+yKJM3/q4RDegMq
         N+E3W0fKSRMt+kG5aXLawRKj+oH6wLoZ61ziPhoW38IiAHjIn+FigV/NjSg7oFRjCs8s
         o3wQ==
X-Gm-Message-State: APjAAAUNafknvVd+TLzWTaww3Jl06ubZqsug6W8MR7NUpwc+im/lqsGe
        DFlapyBPgz9KkaK/JODXDQHRkSVWdhcycw==
X-Google-Smtp-Source: APXvYqw+SpalO7sAbvtGJvVtIWcpz59QxBPqlFkoTeUF/LM8oiWaxPgeFBYFFhgb5EUoOH6JNPH3Gw==
X-Received: by 2002:a17:906:b84c:: with SMTP id ga12mr12894606ejb.0.1569691077724;
        Sat, 28 Sep 2019 10:17:57 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id p4sm1309608edc.38.2019.09.28.10.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 10:17:57 -0700 (PDT)
Subject: Re: x86/purgatory: undefined symbol __stack_chk_fail
To:     Andreas Smas <andreas@lonelycoder.com>,
        linux-kernel@vger.kernel.org
References: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fc900727-b79f-b22a-4ae5-8774c2feab84@rasmusvillemoes.dk>
Date:   Sat, 28 Sep 2019 19:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2019 17.50, Andreas Smas wrote:
> Hi,
> 
> For me, kernels built including this commit
> b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)
> 
> results in kexec() failing to load the kernel:
> 
> kexec: Undefined symbol: __stack_chk_fail
> kexec-bzImage64: Loading purgatory failed
> 
> Can be seen:
> 
> $ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
> 
> Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)

Ubuntu's gcc has -fstack-protector enabled by default, so this happens
if one doesn't pass -fno-stack-protector (which I guess is implied by
-ffreestanding) explicitly.

> Adding -ffreestanding or -fno-stack-protector to ccflags-y in
> arch/x86/purgatory/Makefile
> fixes the problem. Not sure which would be preferred.

Probably -fno-stack-protector, guarded by
CONFIG_CC_HAS_STACKPROTECTOR_NONE (because not all gccs understand
-fno-stack-protector), so

ifdef CONFIG_CC_HAS_STACKPROTECTOR_NONE
ccflags-y += -fno-stack-protector
endif

Rasmus

