Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73097C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C0621738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="P1hm04nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfGXNJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:09:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41039 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfGXNJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:09:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so44428063ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f4suZrpfhVME9PStBS3l8/qYNB52LjXte4Jp7QV1fJc=;
        b=P1hm04nmq8167DSE3iTDmBtlSkwmwS0C9IQYXgXAr3bOqgsitm4JZyJpEwjECFSJ3r
         hVs+wZSxh9IimkkFqfvll8rE1TX6cXYyb3yJrOQ4slWIUZeOdB5qdSQVrQjt4D7xVDlu
         rrCg74BJef1BmvhakY4s2UB0xlON8LZ++gDkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f4suZrpfhVME9PStBS3l8/qYNB52LjXte4Jp7QV1fJc=;
        b=Fcey8NnNSRxtqHccNEgra6tUAcky5004lyw5xj8AANSvqCy5zehUgz1/zRxIHg7tND
         8EToOR+7GiFeBPtE613esDcq2qRWt9DPYdrkv6EZKPsyY3PBfjaDfUri6ONMlIzBkgJn
         FezdZvalNcLVwgkVNgJhnqhYBL7oQIe8Y3GwbanSxF73jN3Xav7/XzMPUt85XuMs9ICt
         nle1iYWhEGg1/S/NZnKLSUdNFZDR9ACP8/1o6UPl3+V4YvtsPdEnvFpki67VMtGXtPVl
         BSnkHNn8HCQIsxaUnf9JAGkxMVBP8cjIeDWVR7bz/pwZI+UKVzzl5Uzqu1bnfZqr+Gza
         EZIQ==
X-Gm-Message-State: APjAAAUXHdy+4PnN6NdZFG0vlUZiOr8+ypu+ZNHqaRYY3i8gH4wlSDJy
        X0lIbH2KzmmRPgCAvpIZOW3Frpzw4mBDVQ==
X-Google-Smtp-Source: APXvYqyvAFqxSWtH3PlfUwSteuCMN+fUFBjvA8cZCWk+4aDvXTvZddDHhQVliHvtjV77g0yqQZzgBg==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr41945289ljh.79.1563973752416;
        Wed, 24 Jul 2019 06:09:12 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u13sm7095045lfl.61.2019.07.24.06.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:09:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Yann Droneaud <ydroneaud@opteya.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
 <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
 <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <396d1eed-8edf-aa77-110b-c50ead3a5fd5@rasmusvillemoes.dk>
Date:   Wed, 24 Jul 2019 15:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2019 14.05, Yann Droneaud wrote:
> Hi,
> 

> Beware that snprintf(), per C standard, is supposed to return the
> length of the formatted string, regarless of the size of the
> destination buffer.
> 
> So encouraging developper to write something like code below because
> snprintf() in kernel behave in a non-standard way,

The kernel's snprintf() does not behave in a non-standard way, at least
not with respect to its return value. It doesn't support %n or floating
point, of course, and there are some quirks regarding precision (see
lib/test_printf.c for details).

There's the non-standard scnprintf() for getting the length of the
formatted string, which can safely be used in an append loop. Or one can
use the seq_buf API.

Rasmus
