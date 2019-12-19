Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB10C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB696227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIJVkAgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSKvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:51:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54964 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:51:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so4938266wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHcgDnG+4B/fOMPXVM0OtdDtgVdqPAu1gFVGhHkedBU=;
        b=PIJVkAgYzurVsLG3CEij7N7uAfX13xHLy2HMwTEJiCPq8Yy5pa+gzMqZIZ+TWTWkID
         yHDOqbLx/tDPUD4vpQaLUfEJVvPLuVurrHvNpZp0ilbSb002pfJimB5X2sj2Qm22iNHo
         w4ZC5MI9/fmDuogZxRIX+m0lWFzByaDrTiOrRMl153CSR8cH5KyT/IMo8MOUhPygw8Xv
         pTdFAVokgRAnby2N1PKD2KnzJIK/nJnuor1TRj4crxBsab+GSlALSxduWjB5JljQc2sF
         T77SzliNPAnS+gW1VxJWSUIyQivodEQo0K9Z/Qlcqvde7wquuoqCdb/yTncJdtbqi8Qi
         hFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHcgDnG+4B/fOMPXVM0OtdDtgVdqPAu1gFVGhHkedBU=;
        b=NCzh+qd222K/7ujmG4yOpVIZMKlyIsAq93gxLJ924r7dupOlFEn+GutQWlGsY4vKN/
         Euj6iKhCKllPTwQML6DBEJL3BFjPrty3iBy4rL0VT7i9TOenUEUJGYzVLL8uy5wL7uAN
         HA9VaurksjJT6mF1Bvm2Sdv6ybaYXVt2b5ET91RMEgV/dXPJLgAHbcndrC9HbB/YXeo3
         vto8/rUUU4bf4u7qrh4OLBBu4DSyHrszhDiWUv249kKczOeguFx1h5Ssw6/nBeeTW7Gp
         cmnBt+r5d+Ui9My+nCL4qaLnxCFPzqBb9bG1AzTtNQx/WTTWiyybtjBeYGZ9NT24/cAl
         /PNQ==
X-Gm-Message-State: APjAAAU9GKFyDWutxHx5qWTWQGjEc3PogknQv5LulP54nQKiomZ0gq9I
        OWeRvgBCUmt2q8YTD7TOdXr9fw==
X-Google-Smtp-Source: APXvYqzUppHZ9MXvAXF3lT0iqwtk0JC3H7rxAWOmJlNvqgo86afcy2yRnfh3wV8+oXtWOB9cM9MAWQ==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr9596970wmj.54.1576752703724;
        Thu, 19 Dec 2019 02:51:43 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y20sm5528069wmi.25.2019.12.19.02.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:51:43 -0800 (PST)
Subject: Re: [PATCH v2 0/4] at24: move write-protect pin handling to nvmem
 core
To:     Khouloud Touil <ktouil@baylibre.com>, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org
References: <20191210154157.21930-1-ktouil@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cd9f342c-5576-57f5-c62d-a78c5876a7fd@linaro.org>
Date:   Thu, 19 Dec 2019 10:51:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191210154157.21930-1-ktouil@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2019 15:41, Khouloud Touil wrote:
> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
>      
> Instead of modifying all the drivers to check this pin, make the
> nvmem subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> This patchset:
> 
> - adds support for the write-protect pin split into two parts.
> The first patch modifies modifies the relevant binding document,
> while the second modifies the nvmem code to pull the write-protect
> GPIO low (if present) during write operations.
> 
> - removes support for the write-protect pin split into two parts.
> The first patch modifies the relevant binding document to remove
> the wp-gpio, while the second removes the relevant code in the
> at24 driver.
> 
> Changes since v1:
> -Add an explenation on how the wp-gpios works
> -keep reference to the wp-gpios in the at24 binding
> 
> Khouloud Touil (4):
>    dt-bindings: nvmem: new optional property write-protect-gpios
>    nvmem: add support for the write-protect pin
>    dt-bindings: at24: remove the optional property write-protect-gpios
>    eeprom: at24: remove the write-protect pin support
> 

Thanks Khouloud for this patchset,

I can take this via nvmem tree once we get an ack on dt bindings from DT 
maintainers.


--srini
>   .../devicetree/bindings/eeprom/at24.yaml      |  6 +-----
>   .../devicetree/bindings/nvmem/nvmem.yaml      |  9 +++++++++
>   drivers/misc/eeprom/at24.c                    |  9 ---------
>   drivers/nvmem/core.c                          | 19 +++++++++++++++++--
>   drivers/nvmem/nvmem.h                         |  2 ++
>   include/linux/nvmem-provider.h                |  3 +++
>   6 files changed, 32 insertions(+), 16 deletions(-)
> 
