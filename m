Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24592064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrJUHuU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfG3CZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:25:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44507 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfG3CZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:25:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so29203771pgl.11;
        Mon, 29 Jul 2019 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=55k9NFfRR+7Bx+XKSd6kfHUFFpdKPg71wG72rnPnBsw=;
        b=HrJUHuU4OFWz8krTIl86jtUT0upkOid3pdXpTYggsLp4dULqLopoWrh1BJlk5e1JRA
         MOql52f9Pm3k/CBCYM4wrcT6ntnUOZtCCEh0kreXUkmStmbn65WI+rSeb3a65qxjBH6u
         TUxbL7WOb6ntdTcZrOX/15X+zTfYXRr0+M876iGD7LYHw7bM1LwaqU9EdXwnXYd8i3rP
         A4yJhob3iEHN4pnt3lvXhzSTJWGKlk0pB3FZNnvwqZYTRD7jOjnrKmN/o4Zhro13o32Z
         Lhn1jjTIdnx2hntjJy6T1X0J4wFYFk1hoQl8x89VLuWSQztagvPBCgEIlu9FrOAJxS2W
         apaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=55k9NFfRR+7Bx+XKSd6kfHUFFpdKPg71wG72rnPnBsw=;
        b=KOmj9aIWqv852wx17/TOt33A7ePFdoXshu+pb3U3inyN2K6axE2K2W1AHq398LkP3n
         p64DvEUXjure+lntIv2GeEU6cGdopVgCAyp/TLbAMOfH4hJ9yUTMMnaL6gEstqQNeIDs
         zhPFA/4q2nLc+myV8aw3lBi2GqvmvjduTjRdAJzbdscsIqu/0FZsrIxgoQqDarZm0hbb
         2gM1dK+fOl4M40KTb9yybBIpjL1m/IjqSOO1UApehjCwW23xZLOdLDOB7b9kq3AL99/n
         OF0cK2qPNlydIzmLCaXHIZ/2bfZr8MYGuYbJnFRXt/lvZJ1s9gL0gsP6LMVFAZmdLUI8
         mnPQ==
X-Gm-Message-State: APjAAAXNcbr6kzZevAhmGUMCije/hbam448yDxS8eKHhsJ50+giTLhvH
        iODHCAhY+pCxQyqlhVayvLiZOQjdL5A=
X-Google-Smtp-Source: APXvYqzXvavd6LshFTj5EfxavDfAapZNtM28f89ySQC2zu5O1jL5VJ1zemraSS/iq7csotwiUcsMew==
X-Received: by 2002:a63:f50d:: with SMTP id w13mr106681017pgh.411.1564453537284;
        Mon, 29 Jul 2019 19:25:37 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id s5sm44967828pfm.97.2019.07.29.19.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:25:36 -0700 (PDT)
Subject: Re: [PATCH] net: phy: phy_led_triggers: Fix a possible null-pointer
 dereference in phy_led_trigger_change_speed()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190729092424.30928-1-baijiaju1990@gmail.com>
 <20190729134553.GC4110@lunn.ch>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <f603f3c3-f7c9-8dff-5f30-74174282819c@gmail.com>
Date:   Tue, 30 Jul 2019 10:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729134553.GC4110@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/29 21:45, Andrew Lunn wrote:
> On Mon, Jul 29, 2019 at 05:24:24PM +0800, Jia-Ju Bai wrote:
>> In phy_led_trigger_change_speed(), there is an if statement on line 48
>> to check whether phy->last_triggered is NULL:
>>      if (!phy->last_triggered)
>>
>> When phy->last_triggered is NULL, it is used on line 52:
>>      led_trigger_event(&phy->last_triggered->trigger, LED_OFF);
>>
>> Thus, a possible null-pointer dereference may occur.
>>
>> To fix this bug, led_trigger_event(&phy->last_triggered->trigger,
>> LED_OFF) is called when phy->last_triggered is not NULL.
>>
>> This bug is found by a static analysis tool STCheck written by us.
> Who is 'us'?

Me and my colleague...


Best wishes,
Jia-Ju Bai
