Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C729C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADC208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agS45cUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfE1MX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:23:56 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34855 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfE1MXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:23:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id k128so7817718ywf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho63X/oK4cACFoOG/qxpAshfZBqM2QPX+6fVvcv9ihw=;
        b=agS45cUeZCvr1i9MlBes4VkX+m6c9gZS+PscFCoOEvsHVnOEan8JoTPkq8S+W3/mB7
         hukgtdcCw5aaOQvs15XB5pE0A4m0DQbeAQ9p0eKMRf6/DAVhuflQF9KJy6I4UqkUnY88
         6MsvzH8wMD0DW/IwzHvrdfIhS9jlauRsLIObyWI5j4HTimfEeWoypiW9d3I6mHOLIwdz
         4BkzOFO/A5pnfGWHiZq+a2NxbOPrbiY9F5g/4DpKajBLoeqOy7NpsHjgrMLGUxEYD4n6
         O18r6qMWQmAqbgcBRGQoEyJfrJIG4beUlSK1e0N8qX4oTadQhhiIz9swyyjwUrHwTKMK
         j/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho63X/oK4cACFoOG/qxpAshfZBqM2QPX+6fVvcv9ihw=;
        b=m5BTNKWWTG/UQlHK8RycDGM8QtSbt6XUL3ZZpNuuotOGQCG8JiWEkuNuvjy/rYAmbu
         ENuY4MdXRvDRJbgyEhm6L6IVxZP8RqK1ufUsqDgkLB0Ims2pzlNSA7wy4nSI3/KvKixt
         eaILCUDL/D30HgJaazAgZJseoukqQ5iaXBKgRCPoJWTypFJIFgCeG27SlUSXDD4UUiLS
         Ej1AUo1jnjf8haYuO2uuTOexCpfqI2siSwbmkC640zKLOlwoUZvLnUmPKR3wss37z32J
         PeaTL+Z31xRJR2EOz8ofHVNQAIbdkIh/7bTMrBHKiEV73TCFfYDHNyTjZklXeGC/ZAE+
         vMZg==
X-Gm-Message-State: APjAAAVTZUuENMl1NnXZtH0LWTjNaIJ7LxPOVBGdctNBPxCZXWBAskS1
        0m2R/QCIR4pXKKh6+t70E0k8FMzj6DG1EnquPp7jCDr+4D0wpw==
X-Google-Smtp-Source: APXvYqwduV3IQwIaAUuhgLCx3ag2nDNLD1N4v+jP3NKxsqHNn/DI7yLI6o3ddZu1/cbPyxR/LHvKSRm6GVDKjHivIeM=
X-Received: by 2002:a81:4ecc:: with SMTP id c195mr58339348ywb.31.1559046234749;
 Tue, 28 May 2019 05:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <155851393823.15728.9489409117921369593.stgit@devnote2> <155851395498.15728.830529496248543583.stgit@devnote2>
In-Reply-To: <155851395498.15728.830529496248543583.stgit@devnote2>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 28 May 2019 14:23:43 +0200
Message-ID: <CADYN=9KHQPQTgy==TYZ5iD_zViPbHq4hgOUwuX69aQWV6vZOQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tracing/kprobe: Add kprobe_event= boot parameter
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 at 10:32, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Add kprobe_event= boot parameter to define kprobe events
> at boot time.
> The definition syntax is similar to tracefs/kprobe_events
> interface, but use ',' and ';' instead of ' ' and '\n'
> respectively. e.g.
>
>   kprobe_event=p,vfs_read,$arg1,$arg2
>
> This puts a probe on vfs_read with argument1 and 2, and
> enable the new event.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

I built an arm64 kernel from todays linux-next tag next-20190528 and
ran in to this issue when I booted it up in qemu:

[    9.068772][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.2.0-rc2-next-20190528-00019-g9a6008710716 #8
[    9.072893][    T1] Hardware name: linux,dummy-virt (DT)
[    9.075143][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
[    9.077528][    T1] pc : kprobe_target+0x0/0x30
[    9.079479][    T1] lr : init_test_probes+0x134/0x540
[    9.081611][    T1] sp : ffff80003f51fbe0
[    9.083331][    T1] x29: ffff80003f51fbe0 x28: ffff200013c17820
[    9.085906][    T1] x27: ffff200015d3ab40 x26: ffff2000122bb120
[    9.088491][    T1] x25: 0000000000000000 x24: ffff200013c08ae0
[    9.091068][    T1] x23: ffff200015d39000 x22: ffff200013a15ac8
[    9.093667][    T1] x21: 1ffff00007ea3f86 x20: ffff200015d39420
[    9.096214][    T1] x19: ffff2000122bad20 x18: 0000000000001400
[    9.098831][    T1] x17: 0000000000000000 x16: ffff80003f510040
[    9.101410][    T1] x15: 0000000000001480 x14: 1ffff00007ea3ea2
[    9.103963][    T1] x13: 00000000f1f1f1f1 x12: ffff040002782e0d
[    9.106549][    T1] x11: 1fffe40002782e0c x10: ffff040002782e0c
[    9.109120][    T1] x9 : 1fffe40002782e0c x8 : dfff200000000000
[    9.111676][    T1] x7 : ffff040002782e0d x6 : ffff200013c17067
[    9.114234][    T1] x5 : ffff80003f510040 x4 : 0000000000000000
[    9.116843][    T1] x3 : ffff200010427508 x2 : 0000000000000000
[    9.119409][    T1] x1 : ffff200010426e10 x0 : 0000000000a6326b
[    9.121980][    T1] Call trace:
[    9.123380][    T1]  kprobe_target+0x0/0x30
[    9.125205][    T1]  init_kprobes+0x2b8/0x300
[    9.127074][    T1]  do_one_initcall+0x4c0/0xa68
[    9.129076][    T1]  kernel_init_freeable+0x3c4/0x4e4
[    9.131234][    T1]  kernel_init+0x14/0x1fc
[    9.133032][    T1]  ret_from_fork+0x10/0x18
[    9.134908][    T1] Code: a9446bf9 f9402bfb a8d87bfd d65f03c0 (d4200080)
[    9.137845][    T1] ---[ end trace 49243ee03446b072 ]---
[    9.140114][    T1] Kernel panic - not syncing: Fatal exception
[    9.142684][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---

I bisected down to this commit as the one that introduces this issue.
I'm unsure why this causes the call trace though, any ideas?

Cheers,
Anders
