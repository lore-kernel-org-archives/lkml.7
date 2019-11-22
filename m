Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D7C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315392071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtmv8yyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVVoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:44:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35628 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:44:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id r7so9024965ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WzsRNzMSO1tjlQDox4N0bbP7FNmEFzO1ttPQx1fi8gw=;
        b=qtmv8yyKC52BqwZzDvhrYn7a3OQJkoBMBZTLuqcbb5siOXkg5kjCbR78norYHVy5Dx
         EISdbX0COg9E6jRHqhLxWyboPOF0MXE76WZoykx0b/MGHAAGMdu/4xA5Go1T8nswRtNg
         rZLsLMNEvDx9qwxLCMs73sfP+lachsYqecmcnkj7Z80euyiw3wrMvYVz+ugzEdr2RePG
         GuElJLQkCQXOOVDD7e5C7NrMPVTkEqp8mtsZhapbEElF2mr9++OsTKacs5AUUOYqyPe4
         xEuR5+6DxChfoA6XwWiBxMRvHs3j2ncYJXxRSHgc4XrCQcjs4vl09ViE0G4GgK8TOEla
         6whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WzsRNzMSO1tjlQDox4N0bbP7FNmEFzO1ttPQx1fi8gw=;
        b=crSKlqafSRz84BB5r/rA+vNSsrfU/oO4H4agldk98I+/tgcbv8za1TtBmpcuyqEzb9
         TiQEe4dIIDglg2ow2kkGUknf2/z31jue7coyttc3xn8Tc6+bFrZj5Ix6y5DrB8fqA+3M
         ylrzhqCr3WHgbywzT9OkpNb1zrutZ5RNSYe1/hn4g6+Qvy5/s2kek9sY98j84l77NYbU
         lOJQVTm11A1yZJhhFRVWuTmDrD3e/gdw0PErFumckvkHTJ4pTuNSD6syNEnVSEXIvtp3
         q9B5TSs0G8EGGcsUgPLDYZuJlvQLt025fGGpeSjSK0P7UZdH0wBeO0lejkKCxWOpQqom
         qYVw==
X-Gm-Message-State: APjAAAXOQgM4aWLLb0SJb/lOsjU3bM9zE+3g1+K6CD2YKdsKSaiYdJ7i
        J/vzWwDbRCCLq2TM79poXKuYEJ4+QPTqHah01UuckA==
X-Google-Smtp-Source: APXvYqy8UyyB+cLeHsjkt6W1tRNHxCWeX56xU3yByQimMyi56Mdd7ePhw51TYKbD9TM8V/1SWGD3K/p03YJMOdxEb5E=
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr13919480ljj.252.1574459047219;
 Fri, 22 Nov 2019 13:44:07 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 22 Nov 2019 22:43:56 +0100
Message-ID: <CADYN=9LGeAzBtgZOwA4ro+KnXp=1J1i7h3Sne6BqHvaf4Z6byA@mail.gmail.com>
Subject: next-20191122: qemu arm64: WARNING: suspicious RCU usage
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing the following warning when I'm booting an arm64 allmodconfig
kernel [1] on linux-next; tag next-20191122, is this anything you've seen
before ?

The code seems to have introduced a long time ago and the warning was
added recently 28875945ba98 ("rcu: Add support for consolidated-RCU
reader checking").

[  193.853316][    T1] Kprobe smoke test: started
[  193.898283][    T1]
[  193.899587][    T1] =============================
[  193.901777][    T1] WARNING: suspicious RCU usage
[  193.903518][    T1] 5.4.0-rc8-next-20191122-00015-gaf188dd3de19 #1
Not tainted
[  193.906423][    T1] -----------------------------
[  193.908214][    T1] kernel/kprobes.c:329 RCU-list traversed in
non-reader section!!
[  193.911189][    T1]
[  193.911189][    T1] other info that might help us debug this:
[  193.911189][    T1]
[  193.914972][    T1]
[  193.914972][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  193.918084][    T1] 1 lock held by swapper/0/1:
[  193.919774][    T1]  #0: ffffa00014255a30 (kprobe_mutex){+.+.}, at:
register_kprobe+0xa0/0xb28
[  193.923346][    T1]
[  193.923346][    T1] stack backtrace:
[  193.925877][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.4.0-rc8-next-20191122-00015-gaf188dd3de19 #1
[  193.929388][    T1] Hardware name: linux,dummy-virt (DT)
[  193.931247][    T1] Call trace:
[  193.932516][    T1]  dump_backtrace+0x0/0x2d0
[  193.933989][    T1]  show_stack+0x28/0x38
[  193.935375][    T1]  dump_stack+0x1e8/0x28c
[  193.936935][    T1]  lockdep_rcu_suspicious+0xf4/0x108
[  193.938727][    T1]  get_kprobe+0xe0/0x188
[  193.940251][    T1]  __get_valid_kprobe+0x30/0x168
[  193.941937][    T1]  register_kprobe+0xa8/0xb28
[  193.943541][    T1]  init_test_probes+0xf8/0x548
[  193.945220][    T1]  run_init_test_probes+0x6c/0xa0
[  193.946946][    T1]  do_one_initcall+0x4c8/0xae8
[  193.948646][    T1]  kernel_init_freeable+0x3e8/0x508
[  193.950393][    T1]  kernel_init+0x1c/0x208
[  193.951940][    T1]  ret_from_fork+0x10/0x18
[  194.367780][    T1] Kprobe smoke test: passed successfully

Cheers,
Anders
[1] http://people.linaro.org/~anders.roxell/kernel_config-next-20191122.config
