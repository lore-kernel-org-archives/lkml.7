Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F83A2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5/Izu+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCTOZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:25:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTOZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:25:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so2968818wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJZ+YrJB76v44y8pGCHMamF0l+A/H+lquNh9MfjhJmk=;
        b=Z5/Izu+MEjPqdKibEmIgMEO5aKk4qwQibtu6fq7Izbx+h2rlCDs/OJc7BjL80DE1EK
         9d9FhmrzW1AKjhDPZ986wmzzhYsCUMh8Ur5wH4cBCkw6f+0JB/mgDeNTI9/EdTjb8pZG
         j/F1hXlkLWgKmPiomELnq9T29yAnAOJzaQb9Z9g81zH8EQoz0C0XZ6/y/JdPvLbIBz3w
         kzSnsuG/74kOFABdeYMw7qQQU+QIWu8TiXYLrV1OOoZikepsZT+ak59noVjqQ0Er2O5c
         K2oiqSZ1VJlLe4Aa91xFAwefnNfK/f/RHCorQZZ9Nil/WdtHOy9JmTe5QCB4O8jXd+Jk
         MJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJZ+YrJB76v44y8pGCHMamF0l+A/H+lquNh9MfjhJmk=;
        b=nid3pfewiOXjm+k9gm3CsZK09thZiXsjAVCN58hXP6DkHutUijrRpXAE5sytESpIZt
         uKh2+9jFYjO1aWwY4AmOcOpp7rx1kHmKTQQ4y6yeJ+yk2Bh3f3RmBf4JWArAiFchEuGT
         V+nGk8rqzXhcmEKbI813wbe5LcLSgdCM7vHEaQSIO4Yn/UgqlYaPQuiA1ZF67Bx+31Ox
         DUteLZ8T8iyQesM9IdNT1mXr7GsZIzp4Pl8dE6cnKe2vwM7P56gW3Ce3lVKDWbYDB99k
         MgQnIClyudUySf30SgHmm4kGB0qAB8hlSjh5ESVyIf4yL1XYpsMevDzdoGyYjbPI7z2R
         TiBw==
X-Gm-Message-State: APjAAAXiVjaHR5gWqSbgIwOzWFs9Bqbk/qBUK8AFPcyIM9npXnEna6ER
        S1d3Hgt7Wmswl8+H51NTQkpkOPqVLMk=
X-Google-Smtp-Source: APXvYqyBz7l2YuBTrWgUA4H5vNoE41PXmzAwx8+1oy1xPE+tUq/p0piGGFsswSPtUJnp2/CmEKP5+w==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr16638861wrp.241.1553091930211;
        Wed, 20 Mar 2019 07:25:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z14sm2950585wrv.78.2019.03.20.07.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:25:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Add nvmem support on STM32
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        lionel.debieve@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <06ec547f-8c7c-0326-200f-22fcdca42b72@linaro.org>
Date:   Wed, 20 Mar 2019 14:25:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2019 10:19, Fabrice Gasnier wrote:
> Non volatile memory area is available on STM32. It contains various
> factory programmed information such as unique device ID, analog calibration...
> This patchset adds:
> - NVMEM support to access stm32 data cells
> - helper to read 16 bits cells.
> 
> ---
> Changes in v2:
> - update "st,stm32f4-otp" compatible as discussed with Rob
> - add stm32f429 dts
> - add core helper to read 16 bits cells
> 
> Fabrice Gasnier (6):
>    dt-bindings: nvmem: Add STM32 factory-programmed romem
>    nvmem: Add driver for STM32 factory-programmed read only mem
>    nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>    nvmem: core: add nvmem_cell_read_u16

Applied all the nvmem patches except DTS patches to nvmem next

Thanks,
srini
