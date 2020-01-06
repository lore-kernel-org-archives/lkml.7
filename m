Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E4C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FC02071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr/NU8zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAFLsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:48:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32913 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:48:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so49329378wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 03:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4fh77HcOBicOgcun7U7maW56RGFTuZ9CXMMMeikZWI=;
        b=jr/NU8zPSX6A0ALwf3vfwlT0/+q6xAmzovRMzy1uu5AGvvdMOJ/gQN4k3KEC2lHV8m
         lQDnr3IaAVl2PWR5u3hX2qw6LiMN5BEFQ1vgYCXzeS6HqGe1EBky0E2cUp7zIRlctxk8
         VWoT28OvQosLf59TQ/0CtX4E6pko2w6G+su+r3eYe9/c8Ua4IrbIeYcO7msgTScvSO6T
         M13dj0xeOPx4VcqR9CIBze3S2N9DKB1eMiLkYHjWH9zsD91OyayI+AkcStDyDtyVuieF
         r/c3zDfXNJiI/F4FzUg8hvLokjzRXRRJiuPxebMpQwAVQZMIBNz1+3zeXp2zLFvJJ/Iu
         JLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4fh77HcOBicOgcun7U7maW56RGFTuZ9CXMMMeikZWI=;
        b=BH2yZgj5XHfmxnnUXtBlGYxulXQ3eFL98fqMtNxUlr87Jb8jfRp90ziWCGTaUSxo8/
         c7CQ8qoE8GXvNIfdYuVCyPvrDybTgo3vQEsJauHiJLzWLBKrnH1qQ1VoXE6QqNW160cM
         G2K8afZFMj9jIQ1Pk1Va7eFyTLfbs4m7ZO3xm3fRB5R4cd1wd4EIQuSEKCrjD/bRpOKP
         3HLhPbxU8MdolJ6HCdPr9wuWWpBrHD3uoonCRFOok/GFqRksioyEsycP2Ik4A4nBr2+p
         HqZe13gXhIxnaJtvxXG7NJDGcrg30y61bkl2ri1mxN2DAf/f4VgXYIOgwUANLRWHvmkZ
         /A9A==
X-Gm-Message-State: APjAAAV0SwXqbJPhQDL4IUAHTf27l2ktlML1TY9XM3lE2ZXrvlBeAtW7
        21UL+jOdCgqK0bi3zOgPjiQsSQ==
X-Google-Smtp-Source: APXvYqwIpLAww7W1ZFO2MhW5/NpaWYRr9A2WLSbnrmFWlg7Wz5pM9T1xSC302RbTGvysaELnFmzGww==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr107276855wro.105.1578311308312;
        Mon, 06 Jan 2020 03:48:28 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g25sm23882140wmh.3.2020.01.06.03.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 03:48:27 -0800 (PST)
Subject: Re: [PATCH V2] nvmem: core: fix memory abort in cleanup path
To:     Bitan Biswas <bbiswas@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <1578056209-19978-1-git-send-email-bbiswas@nvidia.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0e653322-3002-c4ed-a395-18e99455fc0f@linaro.org>
Date:   Mon, 6 Jan 2020 11:48:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1578056209-19978-1-git-send-email-bbiswas@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2020 12:56, Bitan Biswas wrote:
> nvmem_cell_info_to_nvmem_cell implementation has static
> allocation of name. nvmem_add_cells_from_of() call may
> return error and kfree name results in memory abort. Use
> kstrdup_const() and kfree_const calls for name alloc and free.
> 
> [    8.076461] Unable to handle kernel paging request at virtual address ffffffffffe44888
> [    8.084762] Mem abort info:
> [    8.087694]   ESR = 0x96000006
> [    8.090906]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.096476]   SET = 0, FnV = 0
> [    8.099683]   EA = 0, S1PTW = 0
> [    8.102976] Data abort info:
> [    8.106004]   ISV = 0, ISS = 0x00000006
> [    8.110026]   CM = 0, WnR = 0
> [    8.113154] swapper pgtable: 64k pages, 48-bit VAs, pgdp=00000000815d0000
> [    8.120279] [ffffffffffe44888] pgd=0000000081d30803, pud=0000000081d30803, pmd=0000000000000000
> [    8.129429] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [    8.135257] Modules linked in:
> [    8.138456] CPU: 2 PID: 43 Comm: kworker/2:1 Tainted: G S                5.5.0-rc3-tegra-00051-g6989dd3-dirty #3   [    8.149098] Hardware name: quill (DT)
> [    8.152968] Workqueue: events deferred_probe_work_func
> [    8.158350] pstate: a0000005 (NzCv daif -PAN -UAO)
> [    8.163386] pc : kfree+0x38/0x278
> [    8.166873] lr : nvmem_cell_drop+0x68/0x80
> [    8.171154] sp : ffff80001284f9d0
> [    8.174620] x29: ffff80001284f9d0 x28: ffff0001f677e830
> [    8.180189] x27: ffff800011b0b000 x26: ffff0001c36e1008
> [    8.185755] x25: ffff8000112ad000 x24: ffff8000112c9000
> [    8.191311] x23: ffffffffffffffea x22: ffff800010adc7f0
> [    8.196865] x21: ffffffffffe44880 x20: ffff800011b0b068
> [    8.202424] x19: ffff80001122d380 x18: ffffffffffffffff
> [    8.207987] x17: 00000000d5cb4756 x16: 0000000070b193b8
> [    8.213550] x15: ffff8000119538c8 x14: 0720072007200720
> [    8.219120] x13: 07200720076e0772 x12: 07750762072d0765
> [    8.224685] x11: 0773077507660765 x10: 072f073007300730
> [    8.230253] x9 : 0730073207380733 x8 : 0000000000000151
> [    8.235818] x7 : 07660765072f0720 x6 : ffff0001c00e0f00
> [    8.241382] x5 : 0000000000000000 x4 : ffff0001c0b43800
> [    8.247007] x3 : ffff800011b0b068 x2 : 0000000000000000
> [    8.252567] x1 : 0000000000000000 x0 : ffffffdfffe00000
> [    8.258126] Call trace:
> [    8.260705]  kfree+0x38/0x278
> [    8.263827]  nvmem_cell_drop+0x68/0x80
> [    8.267773]  nvmem_device_remove_all_cells+0x2c/0x50
> [    8.272988]  nvmem_register.part.9+0x520/0x628
> [    8.277655]  devm_nvmem_register+0x48/0xa0
> [    8.281966]  tegra_fuse_probe+0x140/0x1f0
> [    8.286181]  platform_drv_probe+0x50/0xa0
> [    8.290397]  really_probe+0x108/0x348
> [    8.294243]  driver_probe_device+0x58/0x100
> [    8.298618]  __device_attach_driver+0x90/0xb0
> [    8.303172]  bus_for_each_drv+0x64/0xc8
> [    8.307184]  __device_attach+0xd8/0x138
> [    8.311195]  device_initial_probe+0x10/0x18
> [    8.315562]  bus_probe_device+0x90/0x98
> [    8.319572]  deferred_probe_work_func+0x74/0xb0
> [    8.324304]  process_one_work+0x1e0/0x358
> [    8.328490]  worker_thread+0x208/0x488
> [    8.332411]  kthread+0x118/0x120
> [    8.335783]  ret_from_fork+0x10/0x18
> [    8.339561] Code: d350feb5 f2dffbe0 aa1e03f6 8b151815 (f94006a0)
> [    8.345939] ---[ end trace 49b1303c6b83198e ]---
> 
> Fixes: badcdff107cbf ("nvmem: Convert to using %pOFn instead of device_node.name")
> 
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>   drivers/nvmem/core.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Applied Thanks,


--srini
