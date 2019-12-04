Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCBAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA752073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcveGWFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLDU07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:26:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbfLDU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575491217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfQKeXnNoYxsQBvNeoTQ/YZry60QJ/3YXLUrpnggw2I=;
        b=DcveGWFR2OhN6KwmJD2wWc0doMaboRrTzJiNjWn+yYfw0GeEg71jDMDdLAZIMCVLI8+FDc
        AL1mPVMgPs/bH/c53a23L0BL1DsEEfolvCfeCsDj1OAHcqym5UBfcRMM/oo3N4v22mpGDD
        AsfuezrizmZmf/1+2LrGEwWl7kMutzw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-HD-rWFbCMfq1o1-cCPc1hQ-1; Wed, 04 Dec 2019 15:26:56 -0500
Received: by mail-pl1-f200.google.com with SMTP id k22so251691pls.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfQKeXnNoYxsQBvNeoTQ/YZry60QJ/3YXLUrpnggw2I=;
        b=tHnZzzIfEuVyWxo/W7UB2925G4mzU8+AptGBRx5Td6sja0zuvjjybZOeT9u2TIAUig
         yG5Pc2Zf2BLIuc87zxTOyVlDFVCKXuoD35bGiDNZG1bWDVhWtyySK6Jjw9VAhWca+Ul3
         mrGbEzveznY0lZEV9Jzs1qA/sohGAPL5Ef15e1WWPfOd4D/m00KicdXyEbMHEUdoVRWD
         Vp0hxBVNFEL/b/TE0/NmnoGoM1o3pfWnYaZ7NekBgR0AQRIQDYd0uwvyyQya2BNdLdkw
         tY524NXJZNWQ922jYUgitmnj4LLezf8HkkuL7izOpmusF445JAAwSzKSTC7UZhQiMN3Z
         iwAg==
X-Gm-Message-State: APjAAAWVUy+ETJPdpsbpqp9vwIBF4LdDz9oO4/xm23ICqeCgEJlOAEyN
        VCcpX6CM2agmqZgoic5tGZs7Nwe4302OsDXFojBU8DWt0s5o17Pg9uv+aWdYfeTjJGPO/BUYia/
        KIYs/pu7kmlshHH/eubcjT1rn
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr5095402pjs.26.1575491215432;
        Wed, 04 Dec 2019 12:26:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTX+qKz/Awrxl/ThBCNJPWIQMObcavP5XlWM7RVd2DLBDfFutgms5AXLhrvCBKU/i0mHVd1w==
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr5095373pjs.26.1575491215147;
        Wed, 04 Dec 2019 12:26:55 -0800 (PST)
Received: from localhost.localdomain ([122.177.160.143])
        by smtp.gmail.com with ESMTPSA id s2sm9483979pfb.109.2019.12.04.12.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 12:26:54 -0800 (PST)
Subject: Re: [PATCH v2 0/3] arm64: kexec_file: add kdump
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     kexec@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <da0113d3-24b8-6263-b06e-0e58037f292f@redhat.com>
Date:   Thu, 5 Dec 2019 01:56:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191114051510.17037-1-takahiro.akashi@linaro.org>
Content-Language: en-US
X-MC-Unique: HD-rWFbCMfq1o1-cCPc1hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

Thanks for the patchset.

On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> This is the last piece of my kexec_file_load implementation for arm64.
> It is now ready for being merged as some relevant patch to dtc/libfdt[1]
> has finally been integrated in v5.3-rc1.
> (Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)
> 
> Patch#1 and #2 are preliminary patches for libfdt component.
> Patch#3 is to add kdump support.
> 
> Bhepesh's patch[3] will be required for 52-bit VA support.
> Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
> enabled or not, a matching fix on user space side, crash utility,
> will also be needed.
> 
> Anyway, I tested my patch, at least, with the following configuration:
> 1) CONFIG_ARM64_BITS_48=y
> 2) CONFIG_ARM64_BITS_52=y, but vabits_actual=48
> 
> (I don't have any platform to use for
> 3) CONFIG_ARM64_BITS_52=y, and vabits_actual=52)
> 
> [1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
>      v1.5.0-23-g87963ee20693"), in particular
> 	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/693411.html
> 
> Changes in v2 (Nov 14, 2019)
> * rebased to v5.4-rc7
> * no functional changes

This looks like a step in the right direction. I have some minor 
nitpicks which I have mentioned in the individual patch reviews.

With those addressed (v2?):

Tested-and-Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

> AKASHI Takahiro (3):
>    libfdt: define UINT32_MAX in libfdt_env.h
>    libfdt: include fdt_addresses.c
>    arm64: kexec_file: add crash dump support
> 
>   arch/arm64/include/asm/kexec.h         |   4 +
>   arch/arm64/kernel/kexec_image.c        |   4 -
>   arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
>   include/linux/libfdt_env.h             |   3 +
>   lib/Makefile                           |   2 +-
>   lib/fdt_addresses.c                    |   2 +
>   6 files changed, 112 insertions(+), 9 deletions(-)
>   create mode 100644 lib/fdt_addresses.c
> 

