Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54182C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DE820663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6Hc4iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCDSYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:24:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfCDSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:24:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so3664069pgd.1;
        Mon, 04 Mar 2019 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTq/AEy2PjpwiaSchG9O/1Z3ts61kfAT8UUEk/HA2hM=;
        b=Ja6Hc4iTQpp8soygeZ8obnbVkHgehBaPU1E923bbtFXE8wRrAX+8d94zk+wP/Jgfnf
         1Bs0oaSG5JgACACNfTQi/ydikmprF0mRUNFniI0fWoap040r7nek3STkesmFSdKZyUJ0
         VAs2nRett84BqrPFVYGuQHxCvtvwuwL+lVd9Hi5If9xnyUGuP7jDaQZlmwX8FwTaa2Or
         WLSRZy//aCmygTaUkuIbNUJc56W1xdSDoR7oGOWHsJsngFCNVjbfCEyJxjLmbjJpfxRI
         TU79MWhMFYx28wSAC7725MzQ675Y1TgWSTE3vukro5/uwpI+RV1KHNUiz06Y588waAWB
         QMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uTq/AEy2PjpwiaSchG9O/1Z3ts61kfAT8UUEk/HA2hM=;
        b=ae7Rn2JmpJsIi4bfLDhl/+OG5mNJzZEM8C2plcS0P13qbBDI5K5H3CuUzuZhTsWwZs
         qERht7+qSn8fPMB+AY3WMhp3sb0Pgfzf3scmQy0mMLefTR682TmL+SfAMMBOrSnuvHTv
         MxbmkMpyw9AjlWSzE6qO4XJ5S7MnV/MwBJWmMH17czU+Nt4wkaKnvCmJtme55YaEqs7U
         rw0/xkg+mzoBECeGmA39Bufzqyz59aziQKMC56e4HUa0yPg7NopWcWzgqB9DGfzKh2lF
         8ROx6utfsp1xo6weQ28uJbagCNzGfU/UxBv8nM+o9KLAiln4mHrflpY/duqIMpXSoZcr
         GLHA==
X-Gm-Message-State: AHQUAuZMddubAAFwBvy4TOnVCz0QBZBp+LF+ZyzQfbVG+ldAUDktKUWu
        ee6gTw0RAkniQ3xiGlqK12c=
X-Google-Smtp-Source: APXvYqzHHd0Gc/9ENlxH0ZSty0mHQr5p0POB+obYfZy+8NXZeBF19wF/Qi2gjAtJWV9KL8Z/xz26sA==
X-Received: by 2002:a62:43c5:: with SMTP id l66mr21564226pfi.77.1551723881203;
        Mon, 04 Mar 2019 10:24:41 -0800 (PST)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v4sm8830545pff.181.2019.03.04.10.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:24:40 -0800 (PST)
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190304132617.GB26378@lunn.ch>
 <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
 <20190304145710.GA17097@lunn.ch>
 <74a6581e-f761-0fb0-3200-e82b7ac88e75@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <04ec6023-7385-d4ad-0bae-2c23e691c6f5@gmail.com>
Date:   Mon, 4 Mar 2019 10:24:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <74a6581e-f761-0fb0-3200-e82b7ac88e75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 10:18 AM, Heiner Kallweit wrote:
> On 04.03.2019 15:57, Andrew Lunn wrote:
>> On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
>>> Hi Andrew,
>>>
>>> On 2019/3/4 21:26, Andrew Lunn wrote:
>>>> On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
>>>>> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
>>>>> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
>>>>> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
>>>>> Let's fix it.
>>>>
>>>> Hi Shaokun, Heiner
>>>>
>>>> Although this fixes the warning, i suspect there i something wrong
>>>> with the original patch adding mv88e6390x_port_set_cmode(). It should
>>>> also be used without CONFIG_NET_DSA_LEGACY.
>>>
>>> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
>>> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)
>>
>> No, i suspect mv88e6390x_ports_cmode_init() is being called from the
>> wrong place, or needs to be called from a second location.
>>
>> [Goes and looks at the code]
>>
>> Yes, it should also be called in mv88e6xxx_probe(). I would call it
>> just after the call to mv88e6xxx_detect(), so that it is the same as
>> in mv88e6xxx_drv_probe().
>>
>> There are two ways DSA drivers can be probed. The legacy way, which is
>> optional, and is slowly getting removed, and the current way. Heiner
>> is new to DSA and probably missed that, and only handled the legacy
>> probe method. I also missed checking when i reviewed to patch :-(
>>
> Right, I missed that, will submit a fix.
> 
> I just saw that the Kconfig entry comment for NET_DSA_LEGACY says:
> "This feature is scheduled for removal in 4.17."
> 
> Was forgotten to remove it or did somebody scream loud enough
> "But I depend on it" ?

The intent was to remove it by that kernel version but the 88e6060
driver still depends on it, and there appears to be some active users
that Andrew worked with.
-- 
Florian
