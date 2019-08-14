Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8A206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkSN2Tr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfHNS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:59:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45031 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:59:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so80250425qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgFFBrhVtUGKZZbJJolYXsdk6eeUI4H6Yby6s8HsxXA=;
        b=dkSN2Tr8QitHw/33jCiZhBgFHzbyCTcbfGRIRgnv+neWx9O0HTr2DeIxljWIqJD3Fn
         qGF+8ImOPJQe/JjAqEvQO7d2739TqHbimcDrXcrqOeFk+MJSem0d6oy6qjB5UJdIjJB/
         DNbfYEomOItz26Ame4+Y2h/vA462XSGBZUc2t5qtzlQ/Kn3HVrABoqHV+MdsUrt673lr
         gQ/NcUiQhqCmElCYRZpcxgyPvqz1cSfGPWm09/2CMA8Vw4xF60XkMA7OUr9ZLcACP7b/
         pnKASmC4Z2xsW5L9Hb33tGOqSmRwusJZZltflF6HC9fTM7NNmb3ZP6xvabrjn6PWoKzl
         WC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgFFBrhVtUGKZZbJJolYXsdk6eeUI4H6Yby6s8HsxXA=;
        b=iKe3vjtA0r/u2eC2uhrhHm673+iJPVBx3rbEC6aCF0ZwBwQjExmdx+VCAksGpUJDam
         NZCRYF7bsMrdbl7qJp5f+++C7Xx+zo/afavjACe8eOLw89NvtOSbZNzyT7w9bW4AygZK
         DCu1TR/+zxauRxkyWub7ZazKb4Br9UyomExSup1TQpEVxfj+kotoBSTT9wwFtoF1tNML
         03pr56zhZFEQ7ZZY752Him36tyjYQVLgVRlfSyQvXjUwf7BayP5q78sGxutvfhQhr/IW
         Wa1CQUAfyx4VAHpeHhmsJ62S/Xd6VPcomtdp/9K2Z1umbqRILkKh0OV8uNO6BwkkacUB
         NRXg==
X-Gm-Message-State: APjAAAVbRw60d11ZL2dcp+VIuuW2Il4bmIaaqXL1HwFWP+81pQvUUtjX
        YkLlKLtmyS+cIR61vgeseYk=
X-Google-Smtp-Source: APXvYqzd/EAJYLa22vQNjsabFbparfS53hGh1tL9jaRpG0/iogqB5w0fwOlorjEX9hlu82GQjP7AFw==
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr831669qto.234.1565809191487;
        Wed, 14 Aug 2019 11:59:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.212.110])
        by smtp.gmail.com with ESMTPSA id j50sm341755qtj.30.2019.08.14.11.59.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:59:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9170840857; Wed, 14 Aug 2019 15:52:13 -0300 (-03)
Date:   Wed, 14 Aug 2019 15:52:13 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Igor Lubashev <ilubashe@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Message-ID: <20190814185213.GN9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814184814.GM9280@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> > # echo 0 > /proc/sys/kernel/kptr_restrict
> > # ./tools/perf/perf record -e instructions:k uname
> > perf: Segmentation fault
> > Obtained 10 stack frames.
> > ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7) [0x55af9e590337]
> > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7) [0x7fd31ef99b97]
> > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a]
> > Segmentation fault
> > 
> > I can reproduce this on both x86 and ARM64.
> 
> I don't see this with these two csets removed:
> 
> 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> 
> Which were the ones I guessed were related to the problem you reported,
> so they are out of my ongoing perf/core pull request to Ingo/Thomas, now
> trying with these applied and your instructions...

Can't repro:

[root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
0
[root@quaco ~]# perf record -e instructions:k uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
[root@quaco ~]# echo 1 > /proc/sys/kernel/kptr_restrict
[root@quaco ~]# perf record -e instructions:k uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
[root@quaco ~]# echo 0 > /proc/sys/kernel/kptr_restrict
[root@quaco ~]# perf record -e instructions:k uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
[root@quaco ~]#

[acme@quaco perf]$ git log --oneline --author Lubashev tools/
7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap, acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict checks
d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
c766f3df635d perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
c22e150e3afa perf tools: Add helpers to use capabilities if present
74d5f3d06f70 tools build: Add capability-related feature detection
perf version 5.3.rc4.g7ff5b5911144
[acme@quaco perf]$

- Arnaldo
