Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F920818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWFTY/Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKKIzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:55:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34677 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKKIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:55:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id y186so3409719lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KG554UB1ORd5BSnPyJC3hx3P5Fy8n9UoGQr/WopwYhw=;
        b=RWFTY/GmE3egVq2pj+6t/3Uo2UVyvdrxIrZSaAHkOy7tzeVUGbrNPIkkxuIfXiTjkw
         cAA6wai3LhmYL2Xmzxjy6+5L6GpZHd8ocAzFCO2wv0nBA2AwGH1MmarHMFzGthPxGFlO
         +oPzyVwtvN1MxORG4zuKONxuplLyKBa5oVgLAqVAFCB2gPY9HdLWF9v33EfFSc5VUDuh
         7lf07F/pevfpjgvZbF8iv+8Sk67AeFjI53pIup+Amar0aRyABuIa0QdYBlmc+3LuaMet
         oMX2s12znPU8Ys+WOcsQn4xTPYowhkM4lVXDce9lmuo7ooIQlaNwX1VlMef+KNkqby7P
         q6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KG554UB1ORd5BSnPyJC3hx3P5Fy8n9UoGQr/WopwYhw=;
        b=OtReAO7UZSR7WYh7VOqCmTVvCIJxrY8A8q4LIOk4zdoBvVW2ZXQmGlMxJSQ0Sg7zY0
         Ha27gDYxf0TuyzF0DW/Vq273+EKMLHwMvAW6P6F9B4RJcE1sBtlDa4IwBVaNiMku4uUm
         hbnB6B2dMzPUvWZyaXPlP3Mq75WNmf5/CGnUzIAtQBjBsE1RiDh+gGr3ZqgokV1aLg1r
         XF5GmTrc3J9H1bxht20D7+M/ascKfWh6fIJNeJZcXRxv1RSTiwTRz8a7qRRwdPGusTWg
         l4nnur2fhCGxOynJN0ooMbg1L8ae89hyw4EUGQUmw/jkczDefpEmy9jDrdS+Kw/J9pvh
         437A==
X-Gm-Message-State: APjAAAUEWztN1q1GzaU9VSS9RM4nQwGW1SWQry6KlfwOkAPxMPXJXBwN
        tLSTv4E+Hsup6KHWaosTA5DUeQ==
X-Google-Smtp-Source: APXvYqwzd9rbmzLlM918vPzJl2Y+6mHnBAs+b8zL1e3+XqdvrLgiKth8gwDxh0rw5IZ0xEuUfc0DgQ==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr14821473lfc.153.1573462499663;
        Mon, 11 Nov 2019 00:54:59 -0800 (PST)
Received: from localhost.localdomain (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id f25sm6345000lfm.26.2019.11.11.00.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:54:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:59:25 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Subject: next-20191108: qemu arm64: WARNING: suspicious RCU usage
Message-ID: <20191111075925.GB25277@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing the following warning when I'm booting an arm64 allmodconfig
kernel [1] on linux-next tag next-20191108, is this anything you've seen
before ?


The code seems to have introduced that is f0ad0860d01e ("ipv4: ipmr:
support multiple tables") in 2010 and the warning was added reacently
28875945ba98 ("rcu: Add support for consolidated-RCU reader checking").


[   32.496021][    T1] =============================
[   32.497616][    T1] WARNING: suspicious RCU usage
[   32.499614][    T1] 5.4.0-rc6-next-20191108-00003-gf74bac957b5c-dirty #2 Not tainted
[   32.502018][    T1] -----------------------------
[   32.503976][    T1] net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!
[   32.506746][    T1] 
[   32.506746][    T1] other info that might help us debug this:
[   32.506746][    T1] 
[   32.509794][    T1] 
[   32.509794][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   32.512661][    T1] 1 lock held by swapper/0/1:
[   32.514169][    T1]  #0: ffffa000150dd678 (pernet_ops_rwsem){+.+.}, at: register_pernet_subsys+0x24/0x50
[   32.517621][    T1] 
[   32.517621][    T1] stack backtrace:
[   32.519930][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc6-next-20191108-00003-gf74bac957b5c-dirty #2
[   32.523063][    T1] Hardware name: linux,dummy-virt (DT)
[   32.524787][    T1] Call trace:
[   32.525946][    T1]  dump_backtrace+0x0/0x2d0
[   32.527433][    T1]  show_stack+0x20/0x30
[   32.528811][    T1]  dump_stack+0x204/0x2ac
[   32.530258][    T1]  lockdep_rcu_suspicious+0xf4/0x108
[   32.531993][    T1]  ipmr_get_table+0xc8/0x170
[   32.533496][    T1]  ipmr_new_table+0x48/0xa0
[   32.535002][    T1]  ipmr_net_init+0xe8/0x258
[   32.536465][    T1]  ops_init+0x280/0x2d8
[   32.537876][    T1]  register_pernet_operations+0x210/0x420
[   32.539707][    T1]  register_pernet_subsys+0x30/0x50
[   32.541372][    T1]  ip_mr_init+0x54/0x180
[   32.542785][    T1]  inet_init+0x25c/0x3e8
[   32.544186][    T1]  do_one_initcall+0x4c0/0xad8
[   32.545757][    T1]  kernel_init_freeable+0x3e0/0x500
[   32.547443][    T1]  kernel_init+0x14/0x1f0
[   32.548875][    T1]  ret_from_fork+0x10/0x18


Cheers,
Anders
[1] http://people.linaro.org/~anders.roxell/kernel_config-next-20191108.config
