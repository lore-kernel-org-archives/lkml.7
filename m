Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D87C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1AA20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eFOhVmlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDZT1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:27:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34355 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:27:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so4117589edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tTfRCHqmH+z9DhHDera/jjPlkYEo0EnHWbbyTECQ5QY=;
        b=eFOhVmlC3umrVGgW7LMVOjf9DAZcxAT1MqU5bkMTm4MGWxYXbOjQy+VbjLIwNYK0rr
         BN1FjacLUQfD3zcx9y1ZqBdUu/Cyso91WOGkXw8Wd4V9GzuKLuG+7ih/j1FE9/nqUToJ
         jAAOdaCcvEYa78LnDRrUGRumQVdCQG0xhWHno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tTfRCHqmH+z9DhHDera/jjPlkYEo0EnHWbbyTECQ5QY=;
        b=BNeBoUX5jrfiShYQ8KxgaoN3464o1XaP1tBqgtyP8sW7SvRetlAsrXeHE5JyQyv6hg
         RsgQxYMbst7wtuXyEf2CzBmG/Or5w1NqZ29ENCOZGMdXdPxH/GU0RH/KiXQomLGPKsSp
         1DRB232RNUbbKJUdKUUMPPlqPY/cNY8/0qhOGQqtnIayDUKlbr4IvS8zNIxKdnEu1+Ox
         CeQpeEyrJeWZmH5eGfMHEYAbmtpxbTn86PpneuB/JA6WagG5fxxMPc+A5VCv8FTUCrBI
         hT0O4sxqC0H+e/jwmb4VG3SCYcsWvU29DgIFfI36Dwe8aMUrrjKjOGIp9PaAABHPz+EU
         1EMQ==
X-Gm-Message-State: APjAAAV3PSKCLqDYwURj21EcLLwu4ymn4/y1L4cwFTN7jJ/K746vicqG
        PGqTkAxwFqIvVhuGXxCl+gR0/CMHVG046g+N
X-Google-Smtp-Source: APXvYqz0JI7WmlhrL4kaOVGT0iWCbaq7VC6ut69qY9GSy9mNONJZcgDGAjKQWABQgqadCD7PVP/REQ==
X-Received: by 2002:a50:9052:: with SMTP id z18mr28602383edz.256.1556306867585;
        Fri, 26 Apr 2019 12:27:47 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id d4sm3893381ede.7.2019.04.26.12.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:27:46 -0700 (PDT)
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
To:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <88270f30-fa5d-5bc5-931c-dc643ca8acc5@rasmusvillemoes.dk>
Date:   Fri, 26 Apr 2019 21:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426190603.5982-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 21.06, Rasmus Villemoes wrote:

> Andrew, please apply and/or fold into 9/10.

Hm, I'm getting bounces for Andrew's email address:

                   The mail system

<akpm@mail.linuxfoundation.org>: host 172.17.192.39[172.17.192.39] said: 550
    5.1.1 <akpm@mail.linuxfoundation.org>: Recipient address rejected: User
    unknown in local recipient table (in reply to RCPT TO command)

I think these fixups need to go through his tree as well. Any ideas
what's going on?

Rasmus
