Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741DEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C9221655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2WmlKJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJGObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:31:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40012 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:31:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so8328377pgl.7;
        Mon, 07 Oct 2019 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2At1y9KA5mfpevHWnQPZHB4PFv/Qu4O9Kv2KCvAKsps=;
        b=L2WmlKJdQwNgVbcJE119/1KVF0saNnxUt37UU5+ZoaigA1ONIEaGNemRqxwetnWLg4
         hjauTVSezFQ9CVITC25sj/x/OMWVMoSbpaw+ypTcc2WeFfkLrLXppP5XyKVr2mC6tRAL
         0kaKpmcpTUutQyoFrmq1Q/rsCvEXw0Ne/51/mhl0TwcWMCF7aO2sHGT7DKjpUi0RHM7D
         dhHOHMQZxWUO3YeL9Me9bsiIMRfPgSkY37o7MjwlcHX7t6X/tDcAQM+3vtnlXFxBNRFW
         vWhHYIJthKdtfXAcdKnVNbSkpaDWUyQ5vbwdBcQHAqfIJA1bDJNJsGfP50jRsVWAtsr/
         5BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2At1y9KA5mfpevHWnQPZHB4PFv/Qu4O9Kv2KCvAKsps=;
        b=P8or9Zovd3vH0QHn5aJueOJWUMF6X3gXqjaznlWFHwbshYJYXYfFisqO+gPyKyvNnX
         IxRqMkn/TliIMSjFe+oYcaDZ+TJLwdWpInD2z+WhXsnk/9JdbTl1Zll7X6FMhbgpTL0n
         Y7KiAV35a4RlkuYis9llElYPl1IGDoPWejskuGOM2MMeliW2xhk0QYichAsIhmOMXrae
         5VW6V/gYtauPZuOVpczRsT+HxJHozt4pS1OBWm4av1UGO73HzCnrLlbELGEW7xwrzzYM
         EUwlV2ocE1Pymit8Lx7kArm8heACQBLA8/G1rcPFitGQ+XoK5Qddj/dI99UOBiMJDyVz
         bshQ==
X-Gm-Message-State: APjAAAXgdf112m2o22KBv+dGH1LQC0HKgKlnUeM+nJauUuFufrs5w6ow
        YoXB3Oyo8QK4OpbDpGlnaY8w3IDg
X-Google-Smtp-Source: APXvYqx64FT9QppAhB7enRcsSabhlyFsHm44WhyzbdH+gp62HQYN+7mxnXvhJlmmysbod3QfzjNuEg==
X-Received: by 2002:a63:6c89:: with SMTP id h131mr30521423pgc.380.1570458665503;
        Mon, 07 Oct 2019 07:31:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i74sm18525272pfe.28.2019.10.07.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:31:04 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/36] 4.4.196-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191006171038.266461022@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2ae37179-5896-35bc-e272-ed617f847524@roeck-us.net>
Date:   Mon, 7 Oct 2019 07:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/19 10:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.196 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 08 Oct 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 169 fail: 1
Failed builds:
	powerpc:defconfig
Qemu test results:
	total: 324 pass: 313 fail: 11
Failed tests:
	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:sdhci:mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs
	ppc64:pseries:pseries_defconfig:initrd
	ppc64:pseries:pseries_defconfig:scsi:rootfs
	ppc64:pseries:pseries_defconfig:usb:rootfs
	ppc64:pseries:pseries_defconfig:sdhci:mmc:rootfs
	ppc64:pseries:pseries_defconfig:nvme:rootfs

Failure as already reported.

arch/powerpc/kernel/eeh_driver.c: In function ‘eeh_handle_normal_event’:
arch/powerpc/kernel/eeh_driver.c:678:2: error: implicit declaration of function ‘eeh_for_each_pe’

Guenter
