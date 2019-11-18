Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A78C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4F2222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKRXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:14:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41784 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfKRXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:14:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 207so2993592pge.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 15:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5T5w0+YP6bAfrz0Su1CbB2mvqzr4wyLw5/A7zapB5W8=;
        b=J/6m8q7Qfyge9NFke5to2CyxpgVaOnDFdp25MTCSGcBtZ9/8SRgj+zo+4++EH4rzhs
         rR40I4A9SACNeE91nyIGu5NCUD60z+irLsiO+2DKJ+UjmXv1VxRYEAKWO31g/LrI1dXC
         SD9l9tFurz/eH1ON1CbVO5iiPUToZztWGUvo0NSI22EpVzbexbid0gpnn3BFgDubECJe
         mYr5pcSJRYXjwocQ/TTV7HOYOQ+u4MHH5w7FKMe3OiV5h52XU3hVOQlMLMmQsgftxjCg
         F/vF5G3Hzfhg8JIm7+u9LBoGYpsj6Bd5Gqnr+MbZ2ZYoijsNLjbNatxu0RxeEfWr2uyu
         2QSg==
X-Gm-Message-State: APjAAAVnR3SCzZEuby6n8jNpXnEOhn1+sAw8rIfbyXed2JM6ri3SEoqq
        T9TBJBHkz7gKBoOmMQeCUhg=
X-Google-Smtp-Source: APXvYqyoTPvE2tSZgpER1q28KWhDz1UjiZi15VB9YtdSTtVmlj9+3Fn1ZJ99JdkY1xYXpQF0ijh5xg==
X-Received: by 2002:a63:4104:: with SMTP id o4mr1919442pga.169.1574118848642;
        Mon, 18 Nov 2019 15:14:08 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 39sm562453pjo.7.2019.11.18.15.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 15:14:07 -0800 (PST)
Subject: Re: Compilation error for target liblockdep
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, mingo <mingo@kernel.org>,
        "alexander.levin" <alexander.levin@microsoft.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <tencent_221B7250536E082573770ABA@qq.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e3ae190e-0888-3d4a-e969-9604d4ab8695@acm.org>
Date:   Mon, 18 Nov 2019 15:14:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <tencent_221B7250536E082573770ABA@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 1:20 AM, Zhengyuan Liu wrote:
> I got a compilation error while building target liblockdep and I think I'd
> better report it to you. The error info showed as bellow:
> 
>          # cd SRC/tools
>          # make liblockdep
>            DESCEND  lib/lockdep
>            CC       lockdep.o
>          In file included from lockdep.c:33:0:
>          ../../../kernel/locking/lockdep.c:53:28: fatal error: linux/rcupdate.h: No such file or directory
>          compilation terminated.
>          mv: cannot stat './.lockdep.o.tmp': No such file or directory
>          /home/lzy/kernel-upstream/linux-linus-ubuntu/tools/build/Makefile.build:96: recipe for target 'lockdep.o' failed
>          make[2]: *** [lockdep.o] Error 1
>          Makefile:121: recipe for target 'liblockdep-in.o' failed
>          make[1]: *** [liblockdep-in.o] Error 2
>          Makefile:68: recipe for target 'liblockdep' failed
>          make: *** [liblockdep] Error 2
> 
> BTW, It was introduced by commit a0b0fd53e1e ("locking/lockdep: Free lock classes that are no longer in use").

(+Peter)

Hi Zhengyuan Liu,

The approach of liblockdep is fragile. Every time an additional kernel 
header is included from the lockdep code or a change is made in one of 
the kernel headers used by lockdep, that change has to be ported to the 
include files in the tools/lib/lockdep/include/liblockdep/ directory. I 
think there are two possible solutions:
- Making the changes necessary to make liblockdep build again.
- Removing the code under tools/lib/lockdep and porting this code to the
   new KUnit framework. If I understood the KUnit framework correctly it
   is based on UML and hence does not require kernel headers to be
   duplicated.

I'm not sure what the best approach is.

Thanks,

Bart.
