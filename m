Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD04C74820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE26E2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="ldA8m8xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfGJM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:59:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36102 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:59:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so2188316wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=orbBb9a1qfFgN+xq6RnxCXAYQ4k3T2hPbN79oSDoD6A=;
        b=ldA8m8xwwRiTTIS2btCFnRuckdleBnwm0XHxSxB7e6PjcxARxDBKkRu1D4+dNXWC90
         Xx6zrhRq0ia6YkLp8DSATZ2dXVJZm8SanZSLVSObGjg5xd7IMke97ZvqXQ9XHFT9VSM0
         aM82zj3EEYaIRxhn9t9VvLWmJtO+xoLgor9HcivfxNEWdM1u+JDvTjxrbrZ4ZuEyHS47
         tq/Zh+CjCWXwYO084l04fe8Cf3gKWoq85+etFsYHC0ZxheKoF1reM5NpKBdeCXoFQRhN
         UqEQX79MY2jPlH+qXCfxEoXmFeCsURLx+f2Zoh4t8qUq0t6qshax95odHt/WPSoi+hAG
         6Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=orbBb9a1qfFgN+xq6RnxCXAYQ4k3T2hPbN79oSDoD6A=;
        b=hI4+Hp6Kg4ygfdDxurcl/VL+YRK2pV44ycbUpy9G9na2dnn9TepkKxaFEtXOSjG0gZ
         IY/ZJ5SR2/1B2xr/1brL2V/90MOap+u6wEeHkIIffkuy7oQ5MwPWVRWvkr1bpq2FeqyM
         Kcpr/aKSCO3IJmtKo5m0Y40+pxg15WZWmCmJuzp21i1+WmanDIrQ5w20LVt56jmpsQZc
         kkUvdJSP4M6Z8PAqId4r93DGHVonxP9e+daQda66gLpPJWu/2qBG0suKQi0qJOvXfffx
         jhaybSQXY47XfVReadCDFI7u+wr8JBLMj89BLblutWKuj5hoDSL80Ml3+9r4NMGuSlTY
         M50g==
X-Gm-Message-State: APjAAAWPZjGNwA2V6c14rojCZDvcRjYU5uBncG8zivbTG8kkPX17I26g
        sERUxsCa81aRnHi5sYPUlaaqpQ==
X-Google-Smtp-Source: APXvYqxFETRr0/i1rEqU4t0aMzwWbWuCsai3umAiF81aED1Fb7uqJiZsZ9ohbK20Rl73QCO0PePVPA==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr5690149wmc.168.1562763585316;
        Wed, 10 Jul 2019 05:59:45 -0700 (PDT)
Received: from localhost (ip-89-176-1-116.net.upcbroadband.cz. [89.176.1.116])
        by smtp.gmail.com with ESMTPSA id i18sm2130111wrp.91.2019.07.10.05.59.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 05:59:44 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:59:43 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/15] ethtool: netlink bitset handling
Message-ID: <20190710125943.GC2291@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <cb614bebee1686293127194e8f7ced72955c7c7f.1562067622.git.mkubecek@suse.cz>
 <20190703114933.GW2250@nanopsycho>
 <20190703181851.GP20101@unicorn.suse.cz>
 <20190704080435.GF2250@nanopsycho>
 <20190704115236.GR20101@unicorn.suse.cz>
 <20190709141817.GE2301@nanopsycho.orion>
 <20190710123803.GB5700@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710123803.GB5700@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 10, 2019 at 02:38:03PM CEST, mkubecek@suse.cz wrote:
>On Tue, Jul 09, 2019 at 04:18:17PM +0200, Jiri Pirko wrote:
>> 
>> I understand. So how about avoid the bitfield all together and just
>> have array of either bits of strings or combinations?
>> 
>> ETHTOOL_CMD_SETTINGS_SET (U->K)
>>     ETHTOOL_A_HEADER
>>         ETHTOOL_A_DEV_NAME = "eth3"
>>     ETHTOOL_A_SETTINGS_PRIV_FLAGS
>>        ETHTOOL_A_SETTINGS_PRIV_FLAG
>>            ETHTOOL_A_FLAG_NAME = "legacy-rx"
>> 	   ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>> 
>> or the same with index instead of string
>> 
>> ETHTOOL_CMD_SETTINGS_SET (U->K)
>>     ETHTOOL_A_HEADER
>>         ETHTOOL_A_DEV_NAME = "eth3"
>>     ETHTOOL_A_SETTINGS_PRIV_FLAGS
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 0
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>> 
>> 
>> For set you can combine both when you want to set multiple bits:
>> 
>> ETHTOOL_CMD_SETTINGS_SET (U->K)
>>     ETHTOOL_A_HEADER
>>         ETHTOOL_A_DEV_NAME = "eth3"
>>     ETHTOOL_A_SETTINGS_PRIV_FLAGS
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 2
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 8
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_NAME = "legacy-rx"
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>> 
>> 
>> For get this might be a bit bigger message:
>> 
>> ETHTOOL_CMD_SETTINGS_GET_REPLY (K->U)
>>     ETHTOOL_A_HEADER
>>         ETHTOOL_A_DEV_NAME = "eth3"
>>     ETHTOOL_A_SETTINGS_PRIV_FLAGS
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 0
>>             ETHTOOL_A_FLAG_NAME = "legacy-rx"
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 1
>>             ETHTOOL_A_FLAG_NAME = "vf-ipsec"
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>>         ETHTOOL_A_SETTINGS_PRIV_FLAG
>>             ETHTOOL_A_FLAG_INDEX = 8
>>             ETHTOOL_A_FLAG_NAME = "something-else"
>>  	    ETHTOOL_A_FLAG_VALUE   (NLA_FLAG)
>
>This is perfect for "one shot" applications but not so much for long
>running ones, either "ethtool --monitor" or management or monitoring
>daemons. Repeating the names in every notification message would be
>a waste, it's much more convenient to load the strings only once and

Yeah, for those aplications, the ETHTOOL_A_FLAG_NAME could be omitted


>cache them. Even if we omit the names in notifications (and possibly the
>GET replies if client opts for it), this format still takes 12-16 bytes
>per bit.
>
>So the problem I'm trying to address is that there are two types of
>clients with very different mode of work and different preferences.
>
>Looking at the bitset.c, I would rather say that most of the complexity
>and ugliness comes from dealing with both unsigned long based bitmaps
>and u32 based ones. Originally, there were functions working with
>unsigned long based bitmaps and the variants with "32" suffix were
>wrappers around them which converted u32 bitmaps to unsigned long ones
>and back. This became a problem when kernel started issuing warnings
>about variable length arrays as getting rid of them meant two kmalloc()
>and two kfree() for each u32 bitmap operation, even if most of the
>bitmaps are in rather short in practice.
>
>Maybe the wrapper could do something like
>
>int ethnl_put_bitset32(const u32 *value, const u32 *mask,
>		       unsigned int size,  ...)
>{
>	unsigned long fixed_value[2], fixed_mask[2];
>	unsigned long *tmp_value = fixed_value;
>	unsigned long *tmp_mask = fixed_mask;
>
>	if (size > sizeof(fixed_value) * BITS_PER_BYTE) {
>		tmp_value = bitmap_alloc(size);
>		if (!tmp_value)
>			return -ENOMEM;
>		tmp_mask = bitmap_alloc(size);
>		if (!tmp_mask) {
>			kfree(tmp_value);
>			return -ENOMEM;
>		}
>	}
>
>	bitmap_from_arr32(tmp_value, value, size);
>	bitmap_from_arr32(tmp_mask, mask, size);
>	ret = ethnl_put_bitset(tmp_value, tmp_mask, size, ...);
>}
>
>This way we would make bitset.c code cleaner while avoiding allocating
>short bitmaps (which is the most common case). 

I'm primarily concerned about the uapi. Plus if the uapi approach is united
for both index and string, we can omit this whole bitset abomination...


>
>Michal
