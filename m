Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA2C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D020672
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ixA6CFkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfK2QEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:04:11 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:36697 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfK2QEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:04:11 -0500
Received: by mail-pl1-f171.google.com with SMTP id k20so605831pls.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=55yYEkm6RHJrPbGEbz5YaTrG6Snd2G6eoPVI+U2I9sw=;
        b=ixA6CFkEosFzfEFCuAMfiMcqA4yRfzWdPkgAQy+nlXnxzy72RoRXy12bxu7vVQRGW4
         q2Urr/WgXBsoiltbaiFdJaW+2Ic6va6kdHryTK502qDrAKETHoB0ztHiluS9AhqYclxX
         ftLioSXEjsN+i39I0lBJtS40Xs7f7kdq2eGx4xJL4uq3bMnocnEaf0kNUylJUjVZ68wo
         2gt9Bp68qEiH2AuFun6lNbK3qj9MugJ+4QALqXdBC9vvd9wljCgh85MKJK0cGK+PmaKZ
         4+wUSu9VMHM2G8xjmQL/g6EqfZX3IavR0EP16J317lBJzIRC88cftXSovW1ooylDjU1+
         DPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=55yYEkm6RHJrPbGEbz5YaTrG6Snd2G6eoPVI+U2I9sw=;
        b=T8MbHeF0Uw3D1DifiAHQILcRGaUtKknA4KGwfEPq1ZpbgAx6clDviMpWW3sEz+Qkp5
         9cGIxOHw/JFQ2EMh0+RPBkuYBv6DF8bXp2hRVOXfB481cZ1UOZwr8JCXQGaC84nYd77S
         KzbZJjpcqMiOUwdb9DVIOeNIvnmQGgjy6rhMNRqnWYbz9sr3I6NIN5ry3J1LBmb+Rhrd
         3I6okbBI758c4i4EPhKgc5E4P+LnAo+O5jXDqHXT2j9T51Tb4dMHKTo71MeJF0QEDOtq
         s2PymXkqEc8HN/m8TEVqFn+3NzyXwcUL8xRZWlRIN3kege9AXRREtNMHoQ7xEVH0z6kF
         vMvQ==
X-Gm-Message-State: APjAAAUHZrwn6yXYdg74jz/FQ3C09pUByxOZCfldS5Y7svHkO2e0oHHg
        bISPspUQbIjI1BJsGuDei0F1KdeOX+Z8vA==
X-Google-Smtp-Source: APXvYqzLZT3KWZYjNqWSQy2mj7zlWghNfW8U+ubCCK8iIBbW4a8KCTN325YznK1PmfsXvxdONXDJng==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10mr15393104plb.45.1575043450234;
        Fri, 29 Nov 2019 08:04:10 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:99f0:a6fb:215a:45a7? ([2605:e000:100e:8c61:99f0:a6fb:215a:45a7])
        by smtp.gmail.com with ESMTPSA id ay16sm13351352pjb.2.2019.11.29.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 08:04:08 -0800 (PST)
Subject: Re: Build failure on latest powerpc/merge (311ae9e159d8 io_uring: fix
 dead-hung for non-iter fixed rw)
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <71cf82d5-5986-43b7-cf1c-acba429a89d6@c-s.fr>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3a95d445-1f5c-7750-f0de-ddc427800b3b@kernel.dk>
Date:   Fri, 29 Nov 2019 08:04:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <71cf82d5-5986-43b7-cf1c-acba429a89d6@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/19 6:53 AM, Christophe Leroy wrote:
>     CC      fs/io_uring.o
> fs/io_uring.c: In function ‘loop_rw_iter’:
> fs/io_uring.c:1628:21: error: implicit declaration of function ‘kmap’
> [-Werror=implicit-function-declaration]
>       iovec.iov_base = kmap(iter->bvec->bv_page)
>                        ^
> fs/io_uring.c:1628:19: warning: assignment makes pointer from integer
> without a cast [-Wint-conversion]
>       iovec.iov_base = kmap(iter->bvec->bv_page)
>                      ^
> fs/io_uring.c:1643:4: error: implicit declaration of function ‘kunmap’
> [-Werror=implicit-function-declaration]
>       kunmap(iter->bvec->bv_page);
>       ^
> 
> 
> Reverting commit 311ae9e159d8 ("io_uring: fix dead-hung for non-iter
> fixed rw") clears the failure.
> 
> Most likely an #include is missing.

Huh weird how the build bots didn't catch that. Does the below work?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c2e8c25da01..745eb005fefe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -69,6 +69,7 @@
  #include <linux/nospec.h>
  #include <linux/sizes.h>
  #include <linux/hugetlb.h>
+#include <linux/highmem.h>
  
  #define CREATE_TRACE_POINTS
  #include <trace/events/io_uring.h>

-- 
Jens Axboe

