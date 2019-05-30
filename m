Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68413C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9825A09
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfi+lGdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE3OEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:04:53 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:35473 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfE3OEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:04:53 -0400
Received: by mail-lf1-f52.google.com with SMTP id a25so5142996lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBdd1+Yx5uNDMN7i6EJlgqNqno6FViEqIgRf/X7lmfA=;
        b=Sfi+lGdKQh0pEl3l/DONlJsn5sLKbsEf0Z+cH/597Fj0avHk0ONmAu7m9OAz4ZHj/w
         b0vAvLD3PdJUjrzcEQmM2d2T6Ax1BQ27yfaWUVSRCvoISiIw0L6ztt3DDzOa+GMbEKP7
         ga3rQPriZPdkv5NKdMt1BojCubcP3akpwJS94F+++TFv8aTjiFrAaMOCc1C68GM83o4b
         e2IzrlQuiM0skP0ekGERvKtw6q1XLV7MwlUYs88znewi8GjEMU/aGgBGKa/rXSlKTlYU
         NRRLuET7RASglq0ErmUQhB2KVzohJIviR4JW9b7eKIfw5XYi8yuPTZhyDnLKR8aCIcdj
         zUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBdd1+Yx5uNDMN7i6EJlgqNqno6FViEqIgRf/X7lmfA=;
        b=m0FUOTrL0gS2JcffatucuBxaXqRfbdDW1yIH8JYyw35rdsNG0A5sCXIwnS6hTxQJBO
         Nx5q/Iihj4D/SX6BPvBFi9PEeIr00FGmSn8tH5DCLQuxb3J2kcWfI4dAAoUebFDng52o
         Kemit14UOsRY7mV27x8HQlrXcEqv/SE1RP6T+PFmXT8dr6xbQkidEZRGZj2T7pDB4BwZ
         m3w+oK4jVb9dKZVirDnGqF3nvsRtEGwLBQyDhiH+uSBg8tS3ju0tvU0bWKOHm8PaR8Yd
         9a1OoRj5aYY9ibR1B2VZZHg2JUMC3bTlLiiLUttqB4R+bIBvd/VKzUs5Xq2Klcw0anLc
         rdmA==
X-Gm-Message-State: APjAAAWmdjTwYk9aquMkq+pSIhh9YitMVV8xScP7YPet6PU7kjNQr2hq
        Yak0MOM+rkLs4u27hov2SpoLK/ivR/p+HSvZafc=
X-Google-Smtp-Source: APXvYqxGR7wR9DFqMnC0sZGTPTVcEuS0mjCBcJNalnS7NYQt5+TwgC1aWCbdMpBPO5Yv/OsgZ97tGbBX/BlJSYDhq1g=
X-Received: by 2002:a19:2045:: with SMTP id g66mr2236457lfg.132.1559225091000;
 Thu, 30 May 2019 07:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 30 May 2019 22:04:39 +0800
Message-ID: <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 4:36 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Third iteration of the Core-Scheduling feature.
>
> This version fixes mostly correctness related issues in v2 and
> addresses performance issues. Also, addressed some crashes related
> to cgroups and cpu hotplugging.
>
> We have tested and verified that incompatible processes are not
> selected during schedule. In terms of performance, the impact
> depends on the workload:
> - on CPU intensive applications that use all the logical CPUs with
>   SMT enabled, enabling core scheduling performs better than nosmt.
> - on mixed workloads with considerable io compared to cpu usage,
>   nosmt seems to perform better than core scheduling.

My testing scripts can not be completed on this version. I figured out the
number of cpu utilization report entry didn't reach my minimal requirement.
Then I wrote a simple script to verify.
====================
$ cat test.sh
#!/bin/sh

for i in `seq 1 10`
do
    echo `date`, $i
    sleep 1
done
====================

Normally it works as below:

Thu May 30 14:13:40 CST 2019, 1
Thu May 30 14:13:41 CST 2019, 2
Thu May 30 14:13:42 CST 2019, 3
Thu May 30 14:13:43 CST 2019, 4
Thu May 30 14:13:44 CST 2019, 5
Thu May 30 14:13:45 CST 2019, 6
Thu May 30 14:13:46 CST 2019, 7
Thu May 30 14:13:47 CST 2019, 8
Thu May 30 14:13:48 CST 2019, 9
Thu May 30 14:13:49 CST 2019, 10

When the system was running 32 sysbench threads and
32 gemmbench threads, it worked as below(the system
has ~38% idle time)
Thu May 30 14:14:20 CST 2019, 1
Thu May 30 14:14:21 CST 2019, 2
Thu May 30 14:14:22 CST 2019, 3
Thu May 30 14:14:24 CST 2019, 4 <=======x=
Thu May 30 14:14:25 CST 2019, 5
Thu May 30 14:14:26 CST 2019, 6
Thu May 30 14:14:28 CST 2019, 7 <=======x=
Thu May 30 14:14:29 CST 2019, 8
Thu May 30 14:14:31 CST 2019, 9 <=======x=
Thu May 30 14:14:34 CST 2019, 10 <=======x=

And it got worse when the system was running 64/64 case,
the system still had ~3% idle time
Thu May 30 14:26:40 CST 2019, 1
Thu May 30 14:26:46 CST 2019, 2
Thu May 30 14:26:53 CST 2019, 3
Thu May 30 14:27:01 CST 2019, 4
Thu May 30 14:27:03 CST 2019, 5
Thu May 30 14:27:11 CST 2019, 6
Thu May 30 14:27:31 CST 2019, 7
Thu May 30 14:27:32 CST 2019, 8
Thu May 30 14:27:41 CST 2019, 9
Thu May 30 14:27:56 CST 2019, 10

Any thoughts?

Thanks,
-Aubrey
