Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C31C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538052082C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPK8QXdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406416AbfIGBYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 21:24:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46936 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406400AbfIGBYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 21:24:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so6445956lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEvfAeH1+QnRAS4bDZMCk0ZaJEhgzrd8FSpH8DNHr7E=;
        b=MPK8QXdTbmrBAjjf4ZxHzTHJNgns7GcUfyegDYCbyS6B8ThW2aVAkjLsLqoekGwCfA
         t+El/gWbEAPSx6CSSJ1brYPYAkrMoZgSzRCNqNZ6/jqzB5wtRDBiPOionCSBEg6dctHd
         DDX+Ia1Yazqrmzzaqy2ga8rYTrZKuYL9HROFN4FyP0emw4Lm7auvAqaqdivR3L/EHKRb
         yFr5GR8n/OdRDI+O6zBNpqXY96PQ+datAOuOAbZ6bu/nwFgDRipzEIbkowPnF+5EgKgT
         oID6Gxzqn5PZ/igaUV4yPnQ6LTloxPsEZBtbbld7MhwoalwsuF3IEPBu97VQBGmQ/HKM
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dEvfAeH1+QnRAS4bDZMCk0ZaJEhgzrd8FSpH8DNHr7E=;
        b=OQ7JOWrSDUwysQCPjO6iaBp8wzNwrJ9ozp0sqUhg8uh9E/b9tMIzPYcZBNg+meBkTW
         V234XlEF9/mqFAGne3b2Z6uuKBOghZMbNjBvn7+q72ji+l0lG9Qbcb4HjqwY+7jHgHGe
         o23UQWtD8zc1IvU38gT0S5wI4efvjGbJIOONJXSbw9qgg9qoqBIASmuJ5l99a69u7gL+
         9Fxid26xonk4Sy4O2I7TQbivNXZKzVvltEKyeSGZkLNQdk55JtA54ZdJTAKx7pKG574u
         tHo6KI33OhW58pt63yoeiIhRb0FQM5B8oiU6L94Ad0OW/xsWm1U48D9eOkudaez3uaTv
         8xtA==
X-Gm-Message-State: APjAAAWBtleevhx/DorRbPKA7QOhbzb7atYLRnlvIvU6mi4Ek2EpHy/p
        dAe7v8CTLdeyyx6nBaWw3fPWmQ==
X-Google-Smtp-Source: APXvYqxT2w9ujZ8nGy5dRXmD7sSvF34/U5b1u0zKlWMwjYrokQ4iRkdVNJJanv4Wj23s/ql1fMVGNg==
X-Received: by 2002:ac2:5451:: with SMTP id d17mr8094711lfn.77.1567819491989;
        Fri, 06 Sep 2019 18:24:51 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e21sm1413684lfj.10.2019.09.06.18.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 18:24:51 -0700 (PDT)
Date:   Sat, 7 Sep 2019 04:24:49 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 8/8] samples: bpf: Makefile: base progs build on
 Makefile.progs
Message-ID: <20190907012448.GC3053@khorivan>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
 <20190904212212.13052-9-ivan.khoronzhuk@linaro.org>
 <20190906233429.6ass5x5inaypvbpr@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190906233429.6ass5x5inaypvbpr@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:34:31PM -0700, Alexei Starovoitov wrote:
>On Thu, Sep 05, 2019 at 12:22:12AM +0300, Ivan Khoronzhuk wrote:
>> +
>> +If need to use environment of target board, the SYSROOT also can be set,
>> +pointing on FS of target board:
>> +
>> +make samples/bpf/ LLC=~/git/llvm/build/bin/llc \
>> +     CLANG=~/git/llvm/build/bin/clang \
>> +     SYSROOT=~/some_sdk/linux-devkit/sysroots/aarch64-linux-gnu
>
>Patches 7 and 8 look quite heavy. I don't have a way to test them
>which makes me a bit uneasy to accept them as-is.
>Would be great if somebody could give Tested-by.
>
I can try to split patch 8 in v2, but not significantly.

-- 
Regards,
Ivan Khoronzhuk
