Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A61C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7606120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEbIouJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfDQPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:49:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45222 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbfDQPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:49:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so27844345qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:message-id;
        bh=ldlfQdp0b+PLq5poadYBs1Z8qFiXQXJ5rJOoSjPx4j0=;
        b=OEbIouJlcGkbpepUYvo/jhY2QZz6r6c+k0yYuE+zjzL5Cmpc0V71bSBwDjQRXPFGIN
         Dh3WswRNSWUqqmXaA143KsQN+Z4dX3Ewkvg+qH0AhyFUNC6Al27rj0g42Zov1jo3e3XE
         Qm21sXvArgMtfdWRZbUCgNcn59WB0jPZITY9gS7vOq4MYuSt9zWsrkfYR6EcRi0lFV8Q
         n5bVpa2c1tbVl1L4Dq1LuEuzoOX8iI2Lm/DS/3Xlc5pnJDD92/mLkldajH+08nAPWgHU
         VsA0HzY2SxGIjpZJdwA6N43qYP6c7aIUdyS2kZcQL2ft1rNOUwjFzhO4lru8ltHH7uKw
         9A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:message-id;
        bh=ldlfQdp0b+PLq5poadYBs1Z8qFiXQXJ5rJOoSjPx4j0=;
        b=ClwepoTbPIKGiJHM7rz4ESentyYPoMyCfILvcK5P4LFDUPzrHsTiNjUm2A+IAM+TjA
         JoGp8RjWFbOVMEbIrjj7P/hirpHXA8ZV+atIQUw+WVmfqF034/mrBYQxAivBXJIi6ykx
         48NvU5Uj1Nf4UTLxV/g8a1l7gugYLeH7XYnNwwP9Ag30JcEyLpDhME05cp3Cc+wibmK7
         AlVew388UN66/t07HuJP1npS8lCT+PGEVjrLtAMJ6QESyfKldccTcncTk2TVr2drwQ35
         D9br4iI361WEGYVcqUbBNmr+WM6LIaTM6Wc9yBm5N3o1+EGyprV3vwEQqwgB+NgtHSJB
         dqwA==
X-Gm-Message-State: APjAAAXuaQ2e/fsW5OQW+/w/222S6loVX1ZkXb7m1DMU/T1ujic1gj+o
        ct39C6Ek3dRX/zFgp3rQdx4=
X-Google-Smtp-Source: APXvYqwQm0E1lt43L1eK5KT8Xxf8BPGqvJy/MRzlZefK1Cg2N37hclIoJyIDfHHFhIUSpWChMfuWyA==
X-Received: by 2002:ac8:852:: with SMTP id x18mr72388546qth.222.1555516157319;
        Wed, 17 Apr 2019 08:49:17 -0700 (PDT)
Received: from [172.16.101.85] ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id h24sm38370632qte.50.2019.04.17.08.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:49:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Wed, 17 Apr 2019 12:48:05 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20190417144002.GB2705@krava>
References: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com> <20190417073952.GF17024@krava> <20190417143542.GA5246@kernel.org> <20190417144002.GB2705@krava>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] perf record: collect user registers set jointly with dwarf stacks
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <60FB78F1-BC48-4172-9669-DD3846F1F0E0@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 17, 2019 11:40:02 AM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wro=
te:
>On Wed, Apr 17, 2019 at 11:35:42AM -0300, Arnaldo Carvalho de Melo
>wrote:
>> Em Wed, Apr 17, 2019 at 09:39:52AM +0200, Jiri Olsa escreveu:
>> > On Mon, Apr 15, 2019 at 06:36:13PM +0300, Alexey Budankov wrote:
>> > >=20
>> > > When dwarf stacks are collected jointly with user specified
>register
>> > > set using --user-regs option like below the full register context
>is
>> > > still captured on a sample:
>> > >=20
>> > >   $ perf record -g --call-graph dwarf,1024 --user-regs=3DIP,SP,BP
>-- matrix=2Egcc=2Eg=2EO3
>> > >=20
>> > >   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002):
>23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>> > >   =2E=2E=2E FP chain: nr:0
>> > >   =2E=2E=2E user regs: mask 0xff0fff ABI 64-bit
>> > >   =2E=2E=2E=2E AX    0x53b
>> > >   =2E=2E=2E=2E BX    0x7ffedbdd3cc0
>> > >   =2E=2E=2E=2E CX    0xffffffff
>> > >   =2E=2E=2E=2E DX    0x33d3a
>> > >   =2E=2E=2E=2E SI    0x7f09b74c38d0
>> > >   =2E=2E=2E=2E DI    0x0
>> > >   =2E=2E=2E=2E BP    0x401260
>> > >   =2E=2E=2E=2E SP    0x7ffedbdd3cc0
>> > >   =2E=2E=2E=2E IP    0x401236
>> > >   =2E=2E=2E=2E FLAGS 0x20a
>> > >   =2E=2E=2E=2E CS    0x33
>> > >   =2E=2E=2E=2E SS    0x2b
>> > >   =2E=2E=2E=2E R8    0x7f09b74c3800
>> > >   =2E=2E=2E=2E R9    0x7f09b74c2da0
>> > >   =2E=2E=2E=2E R10   0xfffffffffffff3ce
>> > >   =2E=2E=2E=2E R11   0x246
>> > >   =2E=2E=2E=2E R12   0x401070
>> > >   =2E=2E=2E=2E R13   0x7ffedbdd5db0
>> > >   =2E=2E=2E=2E R14   0x0
>> > >   =2E=2E=2E=2E R15   0x0
>> > >   =2E=2E=2E ustack: size 1024, offset 0xe0
>> > >    =2E data_src: 0x5080021
>> > >    =2E=2E=2E thread: stack_test2=2Eg=2EO:23828
>> > >    =2E=2E=2E=2E=2E=2E dso: /root/abudanko/stacks/stack_test2=2Eg=2E=
O3
>> > >=20
>> > > After applying the change suggested in the patch the sample data
>contain
>> > > only user specified register values:
>> > >=20
>> > >   $ perf record -g --call-graph dwarf,1024 --user-regs=3DIP,SP,BP
>-- matrix=2Egcc=2Eg=2E03
>> > >=20
>> > >   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002):
>23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
>> > >   =2E=2E=2E FP chain: nr:0
>> > >   =2E=2E=2E user regs: mask 0x1c0 ABI 64-bit
>> > >   =2E=2E=2E=2E BP    0x401260
>> > >   =2E=2E=2E=2E SP    0x7ffd3d85cc20
>> > >   =2E=2E=2E=2E IP    0x401236
>> > >   =2E=2E=2E ustack: size 1024, offset 0x58
>> > >    =2E data_src: 0x5080021
>> > >    =2E=2E=2E thread: stack_test2=2Eg=2EO:23839
>> > >    =2E=2E=2E=2E=2E=2E dso: /root/abudanko/stacks/stack_test2=2Eg=2E=
O3
>> > >=20
>> > > Signed-off-by: Alexey Budankov <alexey=2Ebudankov@linux=2Eintel=2Ec=
om>
>> >=20
>> > Acked-by: Jiri Olsa <jolsa@kernel=2Eorg>
>>=20
>> So, there are registers that are needed to do the DWARF unwinding,
>> right? But at the same time, if the user says only some are needed,
>he
>> better know what they're doing and ask for at least the registers
>needed
>> for the unwinding process to be successfull, right?
>
>yep, that's how understand that

So we need to document that, stating that specifying a set of registers to=
gether with requesting DWARF callchains may break things=2E

- Arnaldo




