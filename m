Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8566D2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DC95j/c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCTOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:34:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40772 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCTOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:34:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so3022754wri.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9gf5vEOicvdaLY+Lte1r0sJrNaxQUSIFlZ/Cjd0HhPE=;
        b=DC95j/c/26SpIrVNxjTurhze0RXRKhsltdoAkDdL3sj01cVf17jiiMPaV6ducB6mAK
         Qj30OG7Z3SpJykLrOR3uMKjHPHbV96XCCCMsA+WVy99Q8Wc6U8GRap6r5E5ldBPUtumi
         8s+1RSLJscQLmoFWjoCuaoffYfSBefHfkxbx4AbYdKOj7zchr1aZHfG+lCCiClKrSJYK
         GW7yaNc1eHiM4j7yhTQiLkDPDKvvdpTg0bpRbM0jR6WmkCcVkBVgj+ldW+K9nJXLFWm3
         CHXuOwROs+84/QvbGB9NJZS4wj24Ns1nGWYzoORXtl1y7KezFMnYWtgPzuNwpalzCAcv
         PDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gf5vEOicvdaLY+Lte1r0sJrNaxQUSIFlZ/Cjd0HhPE=;
        b=paddLKQzNrDon/yXAVpL3RLoPdjAIIQrQdHN/htecMQ9HCVQl8QioX/8s+64nLQudI
         ox6iW0xDb9gjwyxGEvU3PhnLdsUcSd1wmk3J7D/tBbBQLB9jbIDssFVr6gyhYVsFo9VH
         qpf4hDKO8+T2Y4GoCWX3H0EVisIOIKpG5kvP9Zl6X1d2rhwlgN52aGHo9KlIXnGPsIiw
         LESPAHvLxFx2AXXggHX6KI9uNrpcvXVOw1CmIV44cyxpWO945kK6KkW+jn5hMDn1LuHQ
         xDgPbqewN+d0RS7bJNC8CvPUX4pGqVDFCDxo0e+9OnM8uD2Y7u7bEI7QGcfG4xPbjg4T
         2zSA==
X-Gm-Message-State: APjAAAVWviyO4T3nICRieXNQa+up5+C+bpdjYggfq3Zmv4gXlNWBZbys
        GuH4EM3Ohe5EFipiHLROHlFxB2W4CcU=
X-Google-Smtp-Source: APXvYqxnMirFz/1J9mXZKf/Y2crwc4hIqvgsBO6bLfm0QgF4ufTdHcUx8Kt2TO1E/pvR8YGBVutxBw==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr12090139wrm.277.1553092467120;
        Wed, 20 Mar 2019 07:34:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n11sm5552905wrt.63.2019.03.20.07.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:34:26 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
Date:   Wed, 20 Mar 2019 14:34:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2019 14:12, Gaurav Kohli wrote:
> Current nvmem framework allows user space to read all register space
> populated by nvmem binary file, In case we don't want to expose value
> of registers to userspace and only want kernel space to read cell
> value from nvmem_cell_read_u32.
> 
> To protect the same, Add no-read-write property to prevent read
> from userspace.
> 

Can you explain the real need of this?
Is there any issue you are noticing while reading nvmem content from 
userspace?

I don't think this is the right way to do this, its misleading in many 
ways. Also this should not be a part of DT binding.

If we decide that we need this feature, then better way to do this using 
a new Kernel config.

thanks,
srini
