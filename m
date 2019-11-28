Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAEBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F95217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GE+oxFtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1QOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:14:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32803 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:14:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id c124so18749196qkg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=swAWjg0mWyZStjQq/JoheoQkEGMMdPmGAhVcEaoY9Xg=;
        b=GE+oxFtgNAcg6ATJOcfNRJ0lYQnf+CYQZpnNvAGWVvLlUMMm1ZBE0v2LoaG8Sv5gVx
         TQ7KDT/FmW8ULozZHKpdmQCCD7H87rs5XpLvQ0OJoUtrmEczrh0XUs1KkB5FAKUbeJ4m
         l31UyKZ7ZQYOb/TXZS07ah9oVgMfi/Wr1JngN75TOCq2pVOlbqGsj5MrAMyRANP21c65
         0mV3BniwOvi1nuc4BbZU9lw6T/7WQQKPBQsgKyDIgLG01XYKRCPpJfubIv4/CXCYceyb
         QpaybOq3bVONNtF/zn42GQcvuabSgrhPbVD50XQ/BHBf/MHV/875GCgDLLK4SHhAWzjI
         26aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=swAWjg0mWyZStjQq/JoheoQkEGMMdPmGAhVcEaoY9Xg=;
        b=MG+GTBu4lVwEN1vcZ7+XCKLIJh92E9xz/tt+DnGJ+zOuIjlkDEdKRzmKYuwexAY5rA
         kvHYks04t8HV15gJa0elAGzPO6Lht2tApPIpuX2fXq9pQe2uJ/rrMM/Pr0zo6E3oamtF
         uECzjaiYcdAG8+wTL1n8bYRVy/7FgWCD38h2GLOfQhfucpuH7a7GbqZWG1WGDhJ5/ewc
         USG4TtZ1oGHsLya89U/mDvHFrpTSBbzJN+xsNI1E+DF/VohTUuglbse2fy2AdpZxbX6N
         Wl34TAtEbl788x9MzXvn8/rwmp9AMw6zi8gaBM6B8FLnaHfSUC+yosSf/fo5LNIPCStD
         FJWA==
X-Gm-Message-State: APjAAAXRw2iR041hszuI4DyO3pqB5csiP3IdEzPoW4PdhoptGcDK0zIz
        AbXJIa01RQfH+hPehxroMN6E0A==
X-Google-Smtp-Source: APXvYqwmn1ld2Vuf1VCvbx1/sMMTG95qkXhxsIXLZuBxGTgd524dbZVKZj5tWKroDxg56BukvcLyAA==
X-Received: by 2002:a05:620a:13cf:: with SMTP id g15mr10594494qkl.195.1574957679840;
        Thu, 28 Nov 2019 08:14:39 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x8sm9260293qts.82.2019.11.28.08.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 08:14:39 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] ubsan: Split out bounds checker
Date:   Thu, 28 Nov 2019 11:14:38 -0500
Message-Id: <4B3C1889-DE01-43A5-B0BD-0CFC33A5315A@lca.pw>
References: <CACT4Y+a-0ZqGj0hQhOW=aUcjeQpf_487ASnnzdm_M2N7+z17Lg@mail.gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
In-Reply-To: <CACT4Y+a-0ZqGj0hQhOW=aUcjeQpf_487ASnnzdm_M2N7+z17Lg@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 5:39 AM, 'Dmitry Vyukov' via kasan-dev <kasan-dev@goog=
legroups.com> wrote:
>=20
> But also LOCKDEP, KMEMLEAK, ODEBUG, FAULT_INJECTS, etc, all untested
> too. Nobody knows what they produce, and if they even still detect
> bugs, report false positives, etc.
> But that's the kernel testing story...

Yes, those work except PROVE_LOCKING where there are existing potential dead=
locks are almost impossible to fix them properly now. I have been running th=
ose for linux-next daily with all those debugging on where you can borrow th=
e configs etc.

https://github.com/cailca/linux-mm=
