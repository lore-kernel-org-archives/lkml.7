Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C624679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZVZg1Ei9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLTLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:14:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40982 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:14:04 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so7626258ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 03:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mH3XZT+YMNHEJWKS0Zd0RJBzA4An1P+4VwftqqkQXCI=;
        b=ZVZg1Ei9PZeqOGZ7E3o0PzlpZC/Y2zHtJHvS9v7Gg4q4zHc97XIUnAe0tEX88dcrJ/
         v35tdd1Z5nTMN3Yng+ZXzB1gpU1cLsmP64/W4rEdWsCbZc1LtNYx3nyQs+7rnXXQyI/1
         JoTHXb42CDSz5sC6MEmOyNcsKSbxmcu9s+dQI/bGYg6xorIYrL1dmd+oIMK5OQP6G1dK
         0nLReX9nIc2H0XpAsaWNP/aw9BMBFW9JbwVH5rqnTS0HDZASuaeJPL0ndK8vqPbzBdDv
         kZIB+cF4E3vm/5QuyHLsblIW80MBddUNWNqP/k0ZsYQmsGYEC396MgokanqsYNlkyyDj
         UDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mH3XZT+YMNHEJWKS0Zd0RJBzA4An1P+4VwftqqkQXCI=;
        b=tdNKRbCJcUEorn/0B9yiSNTP5+R7g/9EByjsOI9njIet04wqfDbzdajsL0wnl0bzFk
         +lwfwIDvsry0V6aXaz/peBcW5XGLYOIvAXJZ0PyOZAVrcUI59VpNDn+N98g4/yrddDZL
         8NJPDf0jhrIu4tnA1JxBxuUK1FJH836JRt9+mGTiS5ry6jxjUBJ6qmM7lXmMMEpz5TUY
         akQIjWSBHCMbQKXEXhm7Kt5WS/jY5jS1VBtLUFzeFRvDkZBJzKTz+Jp4ExtufjWUOUot
         ZUL5m1hcen8Fadjikd+O/opmsSb4/51Gj7ea6S3uB1Q3zYI7GuvJBpH8CkUvX/cSxTGq
         HxMg==
X-Gm-Message-State: APjAAAWTYY5BniNJ3LKJs2Np0J2yFbG0N11uL2Gp9e7kZQ0hld0VV+x6
        GnooTz7vx4dZXgRJaQnruDWK/w==
X-Google-Smtp-Source: APXvYqznBuM585NgLqPzogn6fCMIQ0H/MasG6SulYfokSLcS+K9NM3LiM4D14DprkMSUJTp4ZsBbYA==
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr12329966ilq.300.1576840443304;
        Fri, 20 Dec 2019 03:14:03 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id g62sm4389797ile.39.2019.12.20.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 03:14:02 -0800 (PST)
Date:   Fri, 20 Dec 2019 03:14:00 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Patrick Staehlin <me@packi.ch>
cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Kao <alankao@andestech.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zong Li <zong@andestech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-riscv@lists.infradead.org,
        zhong jiang <zhongjiang@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jim Wilson <jimw@sifive.com>
Subject: Re: [RFC/RFT 2/2] RISC-V: kprobes/kretprobe support
In-Reply-To: <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
Message-ID: <alpine.DEB.2.21.9999.1912200313100.3767@viisi.sifive.com>
References: <20181113195804.22825-1-me@packi.ch> <20181113195804.22825-3-me@packi.ch> <20181114003730.06f810517a270070734df4ce@kernel.org> <20181114074951.0902699286fdf8652f2878a4@kernel.org> <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Patrick,

Are you still working on these kprobes/kretprobe patches for RISC-V?


- Paul
