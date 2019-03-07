Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3333C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E12B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbRMnnk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:02:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39234 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:02:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so8429403wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O9ZT9ahjeyolr/Iany3CM/GPdDq7jZeHLFOqe4NtOr4=;
        b=rbRMnnk9+2OOPMPcrNXa8kd7HWrvSYx9i8w9ZkPvmkqeKKKWxB9RJGUd1IusI4/cTg
         qXw8f4Crm9UM8BxR5Yu4YBpB+3F9G2pNRBIgpbBMdjG2FegCqqiJyR40bafVy44LqLTC
         G2RSNwa9i3ib/3C1clU2Tq095OUQJzIKwWC4siLLw20rT4cBEPL9I0Z170M18bdzsQgN
         UJHfhiGD7WkDq5EBJXUuxnDeATmsI5ThEOmiIRfsLTUetFBgXR2wW760kR3WlB4oUxrt
         RxK7ybd7gcj6MtJEpcNmFibkMGvqpteg1QUysqvda9fL93+WOugJTgNemSfW/6CvR7yI
         0b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9ZT9ahjeyolr/Iany3CM/GPdDq7jZeHLFOqe4NtOr4=;
        b=X7d7uWW+kbLoX0WFfogVRnHrd9vPElfPnHb7ln5TQxSMBmDFtr/nhCMoSeXna8zIao
         lBj1SxIl/sK9r6aC6AT3AgKLo3RPi34WJWfBHj+sMKPzXU1DCqJQR190ikqroURCGZtN
         51gc6Uch1TvWHYDh5LID/e8xIzBVUwurCCa0xT+2IFZvqHJqDxTYRTiRbiyK/zCO9AXN
         iRDfrWFJXj/Yo6JwmEhabRg0X+cSFRLRzR2fBIc0B0VqK8H/UXbf1vZZmVpg048bvZZ/
         iFq7b7SMsS/x/s33F3BDO4MSBhmKkUdN4/UQ7r5K+GjBxG1epcetXub0/FgW28HKnn7d
         vh/Q==
X-Gm-Message-State: APjAAAVWR7K9rQeChLRxkFkEUk5I0Lih64l5ixRfmHOpMroTCp2UlkOT
        DUPHWmCQa6sYabbxXdzkTIZVm2ZhT44=
X-Google-Smtp-Source: APXvYqy0ZwE6yY91Doux3I/MDuUkohh2AlQHw4EXEvlmosOGQuXmNbK+sUV0eH+mNqtFRz8zm/Hh2A==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr5230733wme.45.1551949370784;
        Thu, 07 Mar 2019 01:02:50 -0800 (PST)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id q5sm5455976wrn.43.2019.03.07.01.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:02:50 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/npcm: select TIMER_OF
To:     Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, linux-kernel@vger.kernel.org
References: <20190305132529.3835223-1-arnd@arndb.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <46cf05f5-8f52-12fb-fc29-c4e98b1340a6@linaro.org>
Date:   Thu, 7 Mar 2019 10:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305132529.3835223-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 14:24, Arnd Bergmann wrote:
> When this is disabled, we get a link failure:
> 
> drivers/clocksource/timer-npcm7xx.o: In function `npcm7xx_timer_init':
> timer-npcm7xx.c:(.init.text+0xf): undefined reference to `timer_of_init'
> 
> Fixes: 1c00289ecd12 ("clocksource/drivers/npcm: Add NPCM7xx timer driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied thanks


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

