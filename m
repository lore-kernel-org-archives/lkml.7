Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DDDC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2CB2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EJ2m8BgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLXJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:02:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55951 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLXJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:02:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so297867wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JpIUPsCQ4mUZV8clqM6x3//3zxhuxnyUCEItvWS4lIE=;
        b=EJ2m8BgGEtcQm8iSYsrb6jbllbscoKNSW55IMHI0wPcev4mLznd5VMRKwg2/sTmJx7
         6B0CFsO0Hi5zcoPBFR5UJazH++6qulEdmR+LgsQTpX43ge6h4U8J8ZJNVTYRJqa9zOoX
         KHYdGmdBFl3qmjTINlKlX73vsGbpXDplIawOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JpIUPsCQ4mUZV8clqM6x3//3zxhuxnyUCEItvWS4lIE=;
        b=MsWxp0pmKeQiJ4rTWMQBDMFZh5ucLO4ml8evcwfHcjbvJ6tOk30w9e6yDwvJotmmKV
         YVYA6sr01tYzuNR5tXu+qGFNk0CI1NXUdYO8Sf4JwuVraB3+OmfbcVvb8DEQ5UP2sREg
         BR9dDEjMa3yZ5BI/h86xY5djFAd/bMvf6nNJKiP7NyqjIcx6dl7ZBR1+/rinWGdvr7NX
         S3cAs9nfsyZE50tv4nu/68DDisAWHNR/5U5US65O2MJxVRHA5yORpe04ns0ZlF2kPUhp
         G7oxRpvEBDP8yCfqsWw5vhv7/LPjsj46laLLGLD8BxBZSAiseCJt7Gp3izRd8htKse8d
         +lLg==
X-Gm-Message-State: APjAAAVAUihkWkNF1csJfS6GpDCnUNU4GREcaTX0zxAUlAoq/QRIyY3c
        JLKgGVFgfYu2YniQSu+QoGbQeg==
X-Google-Smtp-Source: APXvYqwaDJpckqJ1JrVbZPbh8vFZ6XADgxx76CNzAlm8TnNSIoHONxdbgCmk6gW2sYiAbh73ok449A==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr3010277wma.12.1577178118405;
        Tue, 24 Dec 2019 01:01:58 -0800 (PST)
Received: from [10.230.41.59] ([192.19.215.251])
        by smtp.gmail.com with ESMTPSA id v22sm1942400wml.11.2019.12.24.01.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 01:01:57 -0800 (PST)
Subject: Re: [PATCH v2 0/9] brcmfmac: add support for BCM4359 SDIO chipset
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Soeren Moch <smoch@web.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20191211235253.2539-1-smoch@web.de>
 <D1B53CE9-E87C-4514-A2D7-0FE70A4D1A5D@gmail.com>
 <cb3ac55f-4c8f-b0a0-41ee-f16b3232c87e@web.de>
 <47DB71CE-ACC4-431D-9E66-D28A8C18C0A4@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3c42d6de-670d-fee8-aa81-99f44d447e87@broadcom.com>
Date:   Tue, 24 Dec 2019 10:01:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <47DB71CE-ACC4-431D-9E66-D28A8C18C0A4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/2019 5:35 AM, Christian Hewitt wrote:
> 
>> On 19 Dec 2019, at 2:04 am, Soeren Moch <smoch@web.de> wrote:
>>
>> I guess you need similar enhancements of the board device tree as in
>> patch 8 of this series for your VIM3 board.
> 
> Wider testing now points to a known SDIO issue (SoC bug) with Amlogic G12A/B hardware. The merged workaround for the bug was only tested with bcmdhd and brcmfmac may require tweaking as the same issue exhibits on an Amlogic G12B device with BCM4356 chip. Testing the series with Amlogic GXM (older) and SM1 (newer) hardware to exclude the SoC bug shows everything working as expected.

Hi Christian,

Can you elaborate on the "known SDIO issue"? Is it an issue with ADMA or 
something else. I am asking because there is a workaround in brcmfmac to 
avoid scatter-gather lists, which may or may not address the issue.

Regards,
Arend
