Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8ACA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8452067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1vdbmth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKADJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:09:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfKADJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:09:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id e6so6537810wrw.1;
        Thu, 31 Oct 2019 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MilvW8KF1q1GBDWNa38zLUbdbpUmypfuUOJIrybukug=;
        b=i1vdbmthHHL/BD//a+Lc4IWp0ufRC1HSfc+xoViJcNxseK8PgLdkpo23OB131Oonci
         u6rzC9GICpbfyzeWs+LS4PV7whOmAXAwVFThc4JZTt3EGpxiu6Oy8TrGHtp/5z5sxKUG
         /jjH+cMRhUmo25sp11d5vTnyvsUddHZG6VqYa9uGv6CMRMO2cZo8SXdnmHivTiLaPpOZ
         xa9pjxLrMZgp319+bjpZKm1r5iHtDfHbWqXcqdhcAGT8M5sOhKd2xkeU0W1s3I7oofM8
         uMkP4s+6Htf1VMcp5fgJ7NzetLpKgcGHIq88q11eSHRypKglYUoceaoGb50yPph7qoqz
         Ai4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MilvW8KF1q1GBDWNa38zLUbdbpUmypfuUOJIrybukug=;
        b=t8wTUC8k/827BzZXP0RltM2JZ9M5eNyPlKfx6b2YMrsiq+T1Tx76hr4O3KSIHIhiSd
         5aJx7psTcx+5MX58ZmNDpWqkTg/Z04U1qfJhMrYvDLwlYnqvVN/jZ6vykpRtntPI4dOH
         h6Wr7eJ/oTq0gf5zGgKcfSRakecbxmQKN+Bx3vPmqGzdVilOxxtLDVQ1EJXX4C1J9gRP
         hSEX00O3GgdIUfaykxtBO3B25qtPRZp0271OcB2WGw/JfViHbU/Qi+/QHU1ci8EwvS06
         wDCRumGyIVmLVkdX2IPe3IBFOfGXKXlKWA+Aya2Jciy4bnQcKpv8VnqFS5me/PYze17X
         1HEA==
X-Gm-Message-State: APjAAAUTyk8V2uYANDzNRflML3s2vNOdxL5a3DmshtVd8dSbW4vlJSD6
        w8Tb84hsYGwB93NRb8tPDFtpMj05
X-Google-Smtp-Source: APXvYqxOq8uZUxxuLNBzeC5oJfEwK0DGyj8pTKhYtDY1N4Yuug8YgW27P1o874r9SV8ZDTA4Z3kJiw==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr8604105wrs.343.1572577757353;
        Thu, 31 Oct 2019 20:09:17 -0700 (PDT)
Received: from [10.230.29.119] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n17sm5484967wrt.25.2019.10.31.20.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:09:16 -0700 (PDT)
Subject: Re: [PATCH] reset: brcmstb: Fix resource checks
To:     linux-arm-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191101030616.27372-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0f0c6be8-0e3c-7294-75aa-58c3b33d621e@gmail.com>
Date:   Thu, 31 Oct 2019 20:09:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191101030616.27372-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2019 8:06 PM, Florian Fainelli wrote:
> The use of IS_ALIGNED() is incorrect, the typical resource we pass looks
> like this: start: 0x8404318, size: 0x30. When using IS_ALIGNED() we will
> get the following 0x8404318 & (0x18 - 1) = 0x10 which is definitively
> not equal to 0.
> 
> Replace this with an appropriate check on the start address and the
> resource size to be a multiple of SW_INIT_BANK_SIZE.
> 
> Fixes: 77750bc089e4 ("reset: Add Broadcom STB SW_INIT reset controller driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sorry this fails building on 32-bit because it triggers a 64-bit
division let me go back and fix this...
-- 
Florian
