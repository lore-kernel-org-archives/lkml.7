Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D6E218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ5Zn4X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCVPXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:23:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53217 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCVPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:23:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so2560411wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ah6RWtYHx5cmQbIMfgjIWiIcsDUwnQPWHwEiuQhJMao=;
        b=lJ5Zn4X4UX6yNRHd2ku1OQ8Pa/SrRm6HBJ/ktaLPTLtV0EelN4CD/c1qm3VLZsRrm7
         FQohf7TI6/hTdQINq3lTLT3C3CqDwSiAvHuf88K4guxDOv3Q/UVVBUKHg8CpboMVo0qI
         FiYx4utnLHCaMGJv22vIKZpXarqSLf9gHxLnh29cgLOnJ9nm77Ove+pdxJFnEcg3UeEZ
         RPnxCLzJyfgrMPu79Lg/pywVsmKE7CyiXOO+kFLz1Zs4XROpjpG24ClN+am4jEXmhD+u
         +6KPxvGUIl9n5sC8EYNWoG9aqgvmZLzzm423aoDJxqUnRAD9c3u//dkVZe7VlOWdltUc
         hWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ah6RWtYHx5cmQbIMfgjIWiIcsDUwnQPWHwEiuQhJMao=;
        b=Tj6TxO6LJIlGhukyXfSBlm7s2qSBf1huRb2LzBBcnNqsX1572g0yMgRpkiY0qxAR10
         z6yFAtd1coxNVNEpmHO03sAOO4MT12SLnX7xLYdtvB26GjXwnp/tRZ1s26+SUwk7i/AI
         fYa/9soNp206aEt3Vx1ywbL9pmCZifZELVMfqUwJ1F5ZwV2gFsqTyZTsqKpNLClZ4BxJ
         /plxAioa8TWhBAdo1Os5CY72zzLAlLH5qlzK7mJzOncIgE9IxPIaSjlZA44CM2s0DWnT
         JotJRYJZidNpD8wKUr1Gnf3siECPvF/9p2+I53ODGZIzAWSwGBaVchtqZOuOqKBk99aE
         5SmQ==
X-Gm-Message-State: APjAAAXm5FiIvx9LLz7tr6qNSOtP8hfUFf9MGqqaEagGDmb62HBOnaNP
        gZ8sZiphvY7qtECwOraLg1jBK2q8MIg=
X-Google-Smtp-Source: APXvYqyMJj+iL1nNa/bhojIDpnKaGwfzmR2Wkfe8gmZrGWZA36YEQbDdn0urTA/BuBwn6A7PvMkkVw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3103150wme.29.1553268229872;
        Fri, 22 Mar 2019 08:23:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 24sm12816111wmf.23.2019.03.22.08.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:23:49 -0700 (PDT)
Subject: Re: [PATCH v0] nvmem: core: Export nvmem cell info to userspace
To:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Shiraz Hashim <shashim@codeaurora.org>
References: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b356f99c-15ff-06ce-e40b-4bb8b664b6c9@linaro.org>
Date:   Fri, 22 Mar 2019 15:23:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 05:53, Gaurav Kohli wrote:
> From: Shiraz Hashim <shashim@codeaurora.org>
> 
> Existing nvmem framework export full register space
> as nvmem binary, but not exporting child node of nvmem
> which is nvmem cell. Kernel can read the specific cell
> by using nvmem_cell_read but userspace don't have such
> provision.
> 
> Add framework to export nvmem cell as well, So
> userspace can use it directly.
> 
> Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

Thankyou for the patch.

Why do you need such provision when the userspace can just get the cell 
values using correct offset and size.
This will also bring over head of managing entries dynamically + 
confusing userspace abi.

Unless you have a valid reason or usecase I don't see the need for this.

thanks,
srini
