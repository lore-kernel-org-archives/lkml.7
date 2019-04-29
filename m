Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051B32075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SkYBydP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfD2Xkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:40:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34212 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Xkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:40:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so6121751pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kQkHemo9SnkEIk+eKPM3YMOa8r+5exMM2K2AltP76MQ=;
        b=SkYBydP71KoumEQnhUbbZdXhgwcMk0aj3uSULj/xgwBK735SIjs14CRyw7aHF3S4EC
         rgUkMKtIfuvgya4uGY+jtX7jHi+bzWG76phfrozylymojMybq9I/fatyUgQ4pZEJLkrm
         KGp3EAV6d2/5np6dKA6iVjKp5dAxmjuDLc4wQsvHcuvBClLPgiJwdfMR+yHmJ4qhJvyc
         cSWkxoodvEd5Q97aJr1G8uBQ9aocP5mXc/Y1ztIJ/bdPZdiEfmPQE7zwmf6d8bJzVDTA
         wulWHeCxnrdyyZUXbGacKSBnM/8+7W7SUzImZ+b9Gi4ghZY/GdtNBKyAncX61Z/w/Tao
         Qf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kQkHemo9SnkEIk+eKPM3YMOa8r+5exMM2K2AltP76MQ=;
        b=OMJDEiJvDIqCXbGghBO7rUywzvL/T86GD7KbKkH+4C+jQT8ZchiIiE9UtRtMWa9un5
         b98kPrFOoBvD9so0IBFGH6abK8XFJpKqXBW3TCLlEFmbL3hwVgXYbuChwo8fkNA2hc8S
         CYukdeYiBnT/LdxGZ7hWbspwcP5UHoU5oQLIKGS/iFHS2Qzu9Cmqlw0Y0YwFbbFuvo5q
         ciMYijEJ3p92KimJQ/VIGnvZYjwzICvOTUwXeBGuub0jPIt670EHNbo+Pouj3zICgvT9
         7FarmTluAaVX2C1UKJha80U3MKn1MW6hQwreVMXfb56UR/vcJxFFP1JRQT2sBw7tO5wW
         xAdA==
X-Gm-Message-State: APjAAAU8LjOyDzZlTHqhUGnEZV3vd6fDKjBcB4WOVL1i5j1HDxoPeHjL
        HStbTUwpNUrDWfo/TUTeVVahDg==
X-Google-Smtp-Source: APXvYqxlYjLsc5ty1cws8jR/tQPvjy1C0IvyXfQ9MArN7jjwERLNMdl07fbZFel9nF8CO6PlkziXlw==
X-Received: by 2002:a63:c746:: with SMTP id v6mr62692430pgg.401.1556581235393;
        Mon, 29 Apr 2019 16:40:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x6sm14221715pfm.114.2019.04.29.16.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:40:34 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:40:34 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:35:53 PDT (-0700)
Subject:     Re: [PATCH] riscv: vdso: drop unnecessary cc-ldoption
In-Reply-To: <20190424062020.GA3902@infradead.org>
CC:     ndesaulniers@google.com, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-riscv@lists.infradead.org, aurelien@aurel32.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ndesaulniers@google.com, Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-4ffee2ab-ecda-4776-991a-adeb7d0b8c79@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 23:20:20 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 02:22:53PM -0700, Nick Desaulniers wrote:
>> Towards the goal of removing cc-ldoption, it seems that --hash-style=
>> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
>> of binutils for the kernel according to
>> Documentation/process/changes.rst is 2.20.
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!  This in on for-next.
