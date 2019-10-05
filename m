Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD521C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA53E20873
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Xe3j5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfJEA6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 20:58:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37421 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJEA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:58:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so2909282pgi.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3GjI3HdpMykSY2+YmUKXAGRqWylFQzs02bDymLtXFRo=;
        b=S4Xe3j5UFzuZy9Ry51hOVq8fxBmCZxkot3xa/TgwrqWxHYI4R01/XBxuyHV7jvMYTt
         d6ESb1Y8co6iV0yjNCMTiiG85glaKlitSt6v75329fHF28dw1lGK05f8q+jnEG1qgPch
         QSncUntBp4TPzJTPH/UovGjbxelGdWzz4wpbRRx+cavWzUPmwa9DsQ9f03u4njae4BG4
         nc1dgg7Qtl1SqXWLS5gY6OXrJ2qLOXdwuiioSnCg11zP5u2efG2BqCgiDmHycPrwYFEB
         A9KNXIhBVU1f+RF85lT+Bpjno1bMyB5Z/rmYe8mbQybiVcbEulL9z1xSAu8SRnJ9KIG5
         sMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GjI3HdpMykSY2+YmUKXAGRqWylFQzs02bDymLtXFRo=;
        b=Q2l51eB6MLp0zXxxFBvXjqtBWdgPR2sShCAnXofgEOw1qrc9hbiHrCHOJAbshPhWbC
         r05V38kYnPlSlfsthPEtjMqmKn9CuodZaFD9jpDxbqtnmR/PMnr4QEeNWLVuawyvRbCX
         ONaQGrz2smM7f1PvnqOcWZfq0hhqCZ9rGKgaHOX8GdF40nbawTY4xXqwxtioWueZr6Kr
         q9uTXX0KYaWOMBHauUTswW7oNUvGRTqphVJIH8cDuTlbTbpaG3SuhxnvnNEC8vn9+sVe
         3PGMENOOFoYg5UgZsorLRjbIAcO0IS5DMReHm2oKlfa5LOrUdN0cXlOLU2T4Qo11jl+8
         I59A==
X-Gm-Message-State: APjAAAUq6znS0ekfjhZo3zcc8nSBvPM8tEtphj/sTJqAWF3zwX4FrNSM
        57bMjlb8v8AFzph16iS5dy4=
X-Google-Smtp-Source: APXvYqx7E1GXPDQMTScVb8zQZ11wXcWAK3iRlSBepgyKZbego+uFki/8Sko4fvUeVL/LDW4fOrxYeg==
X-Received: by 2002:a63:682:: with SMTP id 124mr18045104pgg.102.1570237117746;
        Fri, 04 Oct 2019 17:58:37 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id t11sm5611290pjy.10.2019.10.04.17.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 17:58:36 -0700 (PDT)
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
Date:   Fri, 4 Oct 2019 17:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/19 8:54 AM, Will Deacon wrote:

> 
> This one is tricky. What I think we need to avoid is an onslaught of
> patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> code being modified. My worry is that Joe Developer is eager to get their
> first patch into the kernel, so runs this tool and starts spamming
> maintainers with these things to the point that they start ignoring KCSAN
> reports altogether because of the time they take up.
> 
> I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> to have a comment describing the racy access, a bit like we do for memory
> barriers. Another possibility would be to use atomic_t more widely if
> there is genuine concurrency involved.
> 

About READ_ONCE() and WRITE_ONCE(), we will probably need

ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.

WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.

I had a look at first KCSAN reports, and I can tell that tcp_poll() being lockless
means we need to add hundreds of READ_ONCE(), WRITE_ONCE() and ADD_ONCE() all over the places.

-> Absolute nightmare for future backports to stable branches.
