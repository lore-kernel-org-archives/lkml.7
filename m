Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DDE2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ashwireless-com.20150623.gappssmtp.com header.i=@ashwireless-com.20150623.gappssmtp.com header.b="qlh5YoIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfCOKH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:07:59 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55557 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfCOKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:07:58 -0400
Received: by mail-wm1-f47.google.com with SMTP id 4so5843617wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ashwireless-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=BlL/ECopNu618o3zband1lVVMnlB11F+5+kb5RBUYRk=;
        b=qlh5YoIApKYil6Rq2+s+R9NO30FNtA5bMiAVd2029XsW/kIqRTgK8O2Ec/bh+Ylzwf
         5vpUAL5WpQ2MAaq5HXoMBjHUYp2ba9nt9Rsu1f+KE2NfQw5RGzFETQBgimNbo6FYt1qE
         8lZqCekzpcoBxJC3S3u6nhnzXDJronlamK97Jt4iENZZRqBUzA+gTqwW5Gp6B0H2VMCZ
         RQlMT3xF9W5gbF+ZnjN/OJ+mC3iSd2ji0vFuZL2aZdDHu74tWdltT/ITFQBYmosq5HJw
         p1+kxMCdxcIpS0884lc59adgIq/mWVZxB2wrTuamDEfvPl3YgWdcPwIPj5AOlRhNHQiE
         /59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=BlL/ECopNu618o3zband1lVVMnlB11F+5+kb5RBUYRk=;
        b=hPaHaOeqZ9zVcmHXTT/NOjtxhvxbQuYXWtYXE3eaJNnMHvg5YoJ6koV75a5Dlf7pCr
         SMtxfJ/BVjP6Aro0YkR4NdXxjGLI8U9BIoaJj/2LmgmXhyJSvk+MAIPGbrt6OxpbNIJk
         M0E7bg+HCfSM7GteSDCa27RumQb53V491TfjWkyJSYmsqBKzvjcl1F6+6qubQScUh/uo
         gUbGjBslpBsNwzQnCZz46VI2wCejJtAIdep+ZzO2KGYAsy0qgAZlYTbuWue7L630Q5wl
         32DBe+q5XQrdkTtfWPBeHcLoGQdfDBI6PYHfoyoVXbsQGT0GBGfUV6FwoqlgMCD0Vk53
         XdOw==
X-Gm-Message-State: APjAAAXmwzw4NMnRshn0gmuQFfonqa9TI+1nieKY63wO5GdbeMnpSWz+
        6mWnQr/ysA8T4SoFcHZAM0g9dT3qT4Q=
X-Google-Smtp-Source: APXvYqyPG2qA4aaKZ+FJWFV4AZZoLwzZ+Cf7Jq7xPdH2jDaLnI+9lPnayGB314loDzg/ICXS7dlwrg==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr1481474wmj.121.1552644476617;
        Fri, 15 Mar 2019 03:07:56 -0700 (PDT)
Received: from [192.168.0.117] ([88.215.34.26])
        by smtp.gmail.com with ESMTPSA id y12sm1736376wma.44.2019.03.15.03.07.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 03:07:56 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Michael Haben <mh@ashwireless.com>
Subject: Memory-compaction not working on Atmel SAMA5 ARM platform, kernel
 v4.14 and v4.20
Message-ID: <bed0e6da-55be-ff26-64e7-42e62163dba5@ashwireless.com>
Date:   Fri, 15 Mar 2019 10:07:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


Memory-compaction is not working for me on an Atmel SAMA5D2 SoC with 
128Mbyte of RAM, on kernel versions 4.14.73. 4.14.88 and 4.20.0

Using "cat /proc/buddyinfo" to observe the state of memory 
fragmentation, and "echo 1 > /proc/sys/vm/compact_memory" to (try to) 
trigger compaction.

My kernel's /proc/config.gz includes "CONFIG_COMPACTION=y" and 
"CONFIG_MIGRATION=y"

I have rebuilt v4.20 several++ times, enabling various "CONFIG_xxx" 
items trying to enable tracing, but without success 
(/sys/kernel/debug/tracing is not present), so I haven't been able to 
observe whether the compaction-trigger is having any effect at all.


Some circumstantial evidence: memory-compaction was working on another 
ARM platform (Raspberry Pi) with kernel v4.9 (Raspbian Jessie), but 
stopped working when I dist-upgraded it to v4.14.98 (Raspbian Stretch).  
The "
/proc/sys/vm/compact_memory" device-node is present, but writing to it 
has no effect on the output from "cat /proc/buddyinfo".


So my questions are:

1.  Are "CONFIG_COMPACTION=y" + "CONFIG_MIGRATION=y" the only settings 
necessary for memory-compaction to be present and working in a kernel?  
I have Done My Own Research, but Am Not An Expert on Linux kernel features!

2.  Must I persevere with trying to get tracing working, or is there 
another way I can debug this issue?


Thank you,

Mike Haben

ASH Wireless

