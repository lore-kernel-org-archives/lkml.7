Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF943C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756E82147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTRDNsgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDHNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:22:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53861 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:22:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so14355393wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UgEHHVmN1KQQ2fUpHIFj+E2e41iSgwLH7Yp3RcEOekk=;
        b=RTRDNsgJAqqusXC6f/AW/xyoZc9HJdvR/B984/NPWZ1H5ppY3cJdwB3sqx9LTUkNqt
         3XLQOQ6JsMnr0hmdB2jDuDbkDm/RthNbvCq1zb9NRT7Pva8GrhZ8K0iMmbrrAK7PT1hR
         vLCRxX3vrjw59pVlKWz/HmKf2HGzRTwnqJrR5CsnP68BvZdVcY8EmQvLRiaK1bcVcO7V
         G0ROthve88wRTQnchyaYTlOxdMUqZbc/A0wwKCBm76vS6SLNjh6DQFsgxlr4HD1Eqjl2
         xOzMqHS0qJxebFmcf8+NciwKn38NVb/9behx+7GHgfFT9kU8nPuG414fXhT6ELyu5SGa
         Do9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgEHHVmN1KQQ2fUpHIFj+E2e41iSgwLH7Yp3RcEOekk=;
        b=qfi6NL/kabyO9fjYS/VodKmq/yafZMRSp2ifeTQuDz2tVEfuoW0WiHHMt2drB05Hc2
         LbFqHhRhSdhHZjy5V9AlI+ZliclFB6yjC3ztN0gHs9GwY/rl6OpOryfRONzn/142wnB9
         yiYsmubWaRzj8tkjJiaU7QuhJS6M1lJ4/ZW3mFSri4Ak93yTtg55+5trsUH9TkOtVNJF
         M5uuco5cmaDhIEjK2N+wbdcRcLKrkxK2h2lTb6c/5wcjp5iNnTDxcx8vqiwG6jMv0jj5
         Q++GNZqJVcpi67o29h8In5NDnmF7BdNpCTWO2essP6m9fxnMqapCXdXeUI6Es/3PV1uG
         qMuA==
X-Gm-Message-State: APjAAAUbyLzj8QPo6/mXvJ/fkYrItYQsMgFkYl1JreyfyspeFF7fPcv9
        U+IqqWYVS4E4dFvcIczd25tCp3iCAEA=
X-Google-Smtp-Source: APXvYqyI4AB/RmpEolgRZcDlZhCir6KB2Ei0Hcd9w3EABXPvbZsJ20O+IMxcMuHMn2b7zL/eiuynyg==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr17131271wmk.9.1554729772742;
        Mon, 08 Apr 2019 06:22:52 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 13sm9509736wmj.33.2019.04.08.06.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:22:52 -0700 (PDT)
Subject: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
 <a738fce5-1108-34d7-d255-dfcb86f51c56@linaro.org>
 <20190408121141.GK7480@piout.net>
 <ce42bb5f-c77e-e882-0579-2bbf95d7b1a5@linaro.org>
 <20190408124213.GL7480@piout.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e9e10fa5-dba6-e9ca-f319-036a71105b6a@linaro.org>
Date:   Mon, 8 Apr 2019 15:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408124213.GL7480@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 14:42, Alexandre Belloni wrote:
> On 08/04/2019 14:35:05+0200, Daniel Lezcano wrote:
>>
>> What about commit 51f0aeb2d21f1 ?
>>
> 
> Well, do you see anything parsing that in drivers/clocksource ?

So to make it clear:

1. You say I said anything, emphasis this word in the previous answer.
But you are the one who should have argue and give the reasons of the
changes (and I'm sure they are valid). At the moment of the discussion
in the thread you mentioned, the DT change was already present.
 - Why did you not clarified this point in the thread discussion?
 - Why there is no Rob's acked-by in this commit?


2. You keep sending the atmel rework series again and again. And I'm
reviewing it again and again. And you object every single comment I do
on your code. I've already told you that.


3. I'm putting on the table again this clockevent/clocksource selection
from the DT hoping we can finally find a solution for *everyone* and
instead of jumping on the opportunity to discuss it, you blame me to not
have done this for you before.


4. Bonus, you resend your series again for the nth times two years after
the last discussion.


Do you want to see some progress?

Propose something generic telling if the node pointer is for a
clocksource or a clockevent. Get agreement from everyone and then resend
your atmel rework based on this.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

