Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D79C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438632084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuO0KSxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDCCW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:22:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:22:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so7218078plt.10;
        Tue, 02 Apr 2019 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGuGt7gPQpz7uRjDb5DlB6RTu9FU3pXiVkPZr38mKsg=;
        b=uuO0KSxcOGMDLe4jjokmZqnEWPcB6xxrz/wM0pd0FgPS+oKz+gRYhdYTogtiD5n8by
         RM4CojuagGH8llDGer84Lehh8xXDHBJpc1+6MhVkV3Uj8hP10Xil13DN5Z9mLMTVS0cR
         KzfqAM9c+cw8pN/ayGrNvGLEQE0NnlrIRW9ClZDw8c4UPuWTRft1uVg8zEcq8R/hI4ou
         DBzsw7HSUNFs16MlBQM56dzJNkFfUyoduZQLPW+42UQ7vpNPuE5nbX0qjDE/uNG1ztiV
         dDE+iVcHWDEiQNu0fV4bynyCm8obEVcJbG8O9zY+Vk3nLCdf0W32UwiYC32avyB8Yy4X
         08/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGuGt7gPQpz7uRjDb5DlB6RTu9FU3pXiVkPZr38mKsg=;
        b=eClWHzpwcolFrBaMmNZmYX8NyemQKMsOyHjGlXSHlvvyUqFKfbwqV1MUf7kdanVG7B
         Yk/L4E0ky2gO2XOoipktbcTb3RnZSXhfmZtc23ot2rOROpay1KmxUJw21QNIStzxYWmI
         iSOPKVFDJdFCH/9TaqcoVr1ZASOHAl8I/sD3bUodq3dHMjBBjNhsikdykVZBQEjB8K7F
         GUvl7KLo89CuXSJ5U/nWOX8C8LWtyixHWMpZ89LcxiJm3cZ8AorPMwTIdtj/98+wOHqc
         24vaa6Yw+GCDF1x7JUlpvSk8AkCUMqm/mibATXUlVLLmNPgHfhDiKYSMxKrMYXn0y8c0
         BJdg==
X-Gm-Message-State: APjAAAW6sCVclhQJLJG6yW34nVoOG6NlsWQosAXfRYipsiiOK8MaDzoe
        IMQprWqdpyBbJO3P3h6x2GkEhqCe
X-Google-Smtp-Source: APXvYqzyNIBeFr6PzcT/i+gnSMxGnZctEUgjtYlG+hfK7vbAettVqWdcQGjYPCm37+H4QXSZJLOwyQ==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr53111875pln.144.1554258176483;
        Tue, 02 Apr 2019 19:22:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o76sm41405268pfa.156.2019.04.02.19.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 19:22:54 -0700 (PDT)
Subject: Re: [PATCH 3.16 00/99] 3.16.65-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1554212307.17110877@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af7bb5af-f0d1-d499-98b9-4c49d11aa39d@roeck-us.net>
Date:   Tue, 2 Apr 2019 19:22:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 6:38 AM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.65 release.
> There are 99 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 04 13:38:27 UTC 2019.
> Anything received after that time might be too late.
> 

For v3.16.64-99-gfff72cd6bb56:

Build results:
	total: 137 pass: 132 fail: 5
Failed builds:
	arm:allmodconfig
	i386:tools/perf
	powerpc:ppc64e_defconfig
	powerpc:cell_defconfig
	powerpc:maple_defconfig
Qemu test results:
	total: 222 pass: 210 fail: 12
Failed tests:
	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs
	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd
	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd
	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd
	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs


sound/pci/hda/hda_tegra.c: In function 'hda_tegra_suspend':
sound/pci/hda/hda_tegra.c:256:25: error: implicit declaration of function 'azx_bus'

arch/powerpc/kernel/signal_64.c: In function 'sys_rt_sigreturn':
arch/powerpc/kernel/signal_64.c:713:7: error: 'msr' undeclared

Guenter
