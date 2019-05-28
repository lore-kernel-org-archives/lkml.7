Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7BAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALnyFScM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfE1FTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:19:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40506 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1FTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:19:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so6507199qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9vAkjT4zw1XDm8fsnSZlNEkjl4Nf7vHSlfSiY9KNso=;
        b=ALnyFScMHMtERUW5uD1FraHSomTN3wSkzcc4PKpGg+PWHBFD84hbVQEZQWoagJ5Xhb
         Mv1aFVz+PDS7WTLRjjzI3/r4f3n/zx7N3TJBC3qPz/FgPJY6s+MobfxiX3TxfZ4FQITm
         UtogIZKfFDygLEtHVL0jzihfUraD7hhrSKZ5jVQ9B64yED3R1Hs+HbvBE7hRMCNY5+5Y
         B/Yt2q4HmPgHIjcXO60h+/KlR+T943toFQ9IFKyU0WPZ2uNthhcK1PVqEO5iew+mGhU0
         U497rM9uHMfnVPHfaU8O3uc/81MIvFhI+gAfEoN0yIRlpSvXJViZoXlf2cC9Gn22QzPW
         yUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9vAkjT4zw1XDm8fsnSZlNEkjl4Nf7vHSlfSiY9KNso=;
        b=p7fhQxVYDlkLy74HGy6IaP010EjPBC+qFup3WNxDNzntTw57rOVpB79a73PjB2BLRh
         zthSZ+e3K8dPxYY5V0rJhdQdZQnEF951NQa4dfSW+12exRXa7JHYHLak5XygO1aab58j
         mrhVwggwcq7/n/984090exOYkWv2oIYI7Js4sCzPl74CPmFI6OMYgRAR+V1rcf7DSNdr
         ATrY8yaLLrorgsTtEPm6UgGfP4xB3budDap3mtZxPyv5yrvwLI46m6lDZ4Ch88Gwereh
         aILdKQrNoLpNFToDv9Wmgnp/6STQSjGh2rAGyZz6uLO09q6CQsP22YB4rdQ35L2t3CVq
         qXiQ==
X-Gm-Message-State: APjAAAXpX603/xb5e9Ug/LfP1KXbrwm8zvPzBeIrzmpPuj/O3wHRBoW0
        BSGG+pWExoO6LJX1uba+/QqxNQ==
X-Google-Smtp-Source: APXvYqxy8NJKLvh/0D73f9xSTX35TDleS3jm+lfG9xUeZFBhjVdzfEIXiW9z84VlnU9ZXc5GOVMmrw==
X-Received: by 2002:a37:a247:: with SMTP id l68mr540762qke.89.1559020771336;
        Mon, 27 May 2019 22:19:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li483-211.members.linode.com. [50.116.44.211])
        by smtp.gmail.com with ESMTPSA id w189sm1054949qkc.38.2019.05.27.22.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 22:19:30 -0700 (PDT)
Date:   Tue, 28 May 2019 13:19:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190528051924.GA19112@leoy-ThinkPad-X240s>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:
> This series adds the support for CoreSight devices on ACPI based
> platforms. The device connections are encoded as _DSD graph property[0],
> with CoreSight specific extensions to indicate the direction of data
> flow as described in [1]. Components attached to CPUs are listed
> as child devices of the corresponding CPU, removing explicit links
> to the CPU like we do in the DT.
> 
> The majority of the series cleans up the driver and prepares the subsystem
> for platform agnostic firwmare probing, naming scheme, searching etc.
> 
> We introduce platform independent helpers to parse the platform supplied
> information. Thus we rename the platform handling code from:
> 	of_coresight.c  => coresight-platform.c
> 
> The CoreSight driver creates shadow devices that appear on the Coresight
> bus, in addition to the real devices (e.g, AMBA bus devices). The name
> of these devices match the real device. This makes the device name
> a bit cryptic for ACPI platform. So this series also introduces a generic
> platform agnostic device naming scheme for the shadow Coresight devices.
> Towards this we also make changes to the way we lookup devices to resolve
> the connections, as we can't use the names to identify the devices. So,
> we use the "fwnode_handle" of the real device for the device lookups.
> Towards that we clean up the drivers to keep track of the "CoreSight"
> device rather than the "real" device. However, all real operations,
> like DMA allocation, Power management etc. must be performed on
> the real device which is the parent of the shadow device.
> 
> Finally we add the support for parsing the ACPI platform data. The power
> management support is missing in the ACPI (and this is not specific to
> CoreSight). The firmware must ensure that the respective power domains
> are turned on.
> 
> Applies on v5.2-rc1
> 
> Tested on a Juno-r0 board with ACPI bindings patch (Patch 31/30) added on
> top of [2]. You would need to make sure that the debug power domain is
> turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
> Juno board while at UEFI). arm32 code is only compile tested.

After I applied this patch set, I found all device names under
'/sys/bus/event_source/devices/cs_etm/sinks/' have been changed as
below on my DB410c board:
# ls /sys/bus/event_source/devices/cs_etm/sinks/
tmc_etf0  tmc_etr0  tpiu0

This leads to below command failure when open PMU device:
# perf record -e cs_etm/@826000.etr/ --per-thread uname
failed to set sink "826000.etr" on event cs_etm/@826000.etr/ with 2 (No such file or directory)

I must use below command so that perf can match string with the
device name under '/sys/bus/event_source/devices/cs_etm/sinks/':
# perf record -e cs_etm/@tmc_etr0/ --per-thread uname

Seems to me, this is an unexpected change and when I worked on the
patch set v2, IIRC that version still can use '826000.etr' to open PMU
device.

Please help confirm for this.  Thanks!

Leo.
