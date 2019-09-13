Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73EC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A114B20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbfIMMTk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:19:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388308AbfIMMT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:19:29 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B7AB3A206
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:19:29 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id c23so17053106edb.14
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 05:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FUyOcPi0NHmHBGgNXqP+P7obEs5/r8uMUZC4jE6n+fs=;
        b=PbtLQIkRrMR3Z3/4aBjbVpRMQ/VB9wZuM2nR8DO5u18K4MUo7vVZEoj5v5TM1t2vMC
         0owQfWefKo3kXcQYn3tRb5gXkHb5/V7kITQ9mmzbcxu4v+/1hCnP+ucEi0eruG/Cm942
         XBvx0Am6BQcAI/jIuSidulcIAOxB5cE42BDCMzOrB9gbk1VB3ipzgvM2LwkrBDjd2m6B
         2sO+LYAqs79B5dcoS8YrEmjIcgVivZFIDJzCTJ+pQncFp1hAg6Sshky8muYkaUDX10Jq
         u4v/+IfedsZj+spM2H+0KLJ02hNTxLbN/I0HcpQD8j5f/2hC15W3tEsoMWnea1eYYHuA
         2gfw==
X-Gm-Message-State: APjAAAX2UdrdZYlXWzhVD2PS1iFSM+QUMz+FfEzivQEIV7e6+O96jNg/
        3oRoRXwLgsaQXPV+lgJYA/3Y9dobfysgTSkg/omLkBRoSMnDvtbtJwO+FrHzonJVS60UyAOyYT1
        mz67mueRiaihAlPoEkA2Mwj73
X-Received: by 2002:a50:f30c:: with SMTP id p12mr46858204edm.299.1568377167967;
        Fri, 13 Sep 2019 05:19:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyJlvDFyQWbdgNap7j6wIzmKQY/VrKSgEVURx/1Gzi41LI0cvKYDz9tVgKPwUjHeIr/5xDNA==
X-Received: by 2002:a50:f30c:: with SMTP id p12mr46858177edm.299.1568377167788;
        Fri, 13 Sep 2019 05:19:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p11sm5241842edh.77.2019.09.13.05.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 05:19:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 68597180613; Fri, 13 Sep 2019 14:19:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
In-Reply-To: <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
References: <20190909223236.157099-1-samitolvanen@google.com> <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com> <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com> <87impzt4pu.fsf@toke.dk> <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com> <87sgp1ssfk.fsf@toke.dk> <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 13 Sep 2019 14:19:26 +0200
Message-ID: <87h85gs81d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Tolvanen <samitolvanen@google.com> writes:

> On Thu, Sep 12, 2019 at 3:52 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> I think it would be good if you do both. I'm a bit worried that XDP
>> performance will end up in a "death by a thousand paper cuts" situation,
>> so I'd rather push back on even relatively small overheads like this; so
>> being able to turn it off in the config would be good.
>
> OK, thanks for the feedback. In that case, I think it's probably
> better to wait until we have CFI ready for upstreaming and use the
> same config for this one.

SGTM, thanks!

>> Can you share more details about what the "future CFI checking" is
>> likely to look like?
>
> Sure, I posted an overview of CFI and what we're doing in Pixel devices here:
>
> https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html

Great, thank you.

-Toke
