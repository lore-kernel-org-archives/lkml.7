Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41377C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0377620820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYy6xY0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDJVwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:52:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33773 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJVwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:52:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so536270wmi.0;
        Wed, 10 Apr 2019 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OBY6T42d3o5ggv5VkhBg8He59Bd/P5r/KyV+iKfrvCU=;
        b=vYy6xY0u2wcnwKxlediRiKduC91GingKlZ6/5HddCBu6sWVpmBqGWBHpCCqfG/Md/3
         Yj8lJYQyosx0pBU8+JNiWCtjsQk9S/45NaFDuZKhA6o1BNQ6nrDL6PbPsfX9U5IkasSW
         OdSuAn6ndWw0x9XIATOE/rLZ2+Wl+Jqdk9PD5AENOIZhmmB4wA2oy54QDgrhN6TQ7py0
         AMVHY5aVQ2s5dI/PSWR79T0x6dO084JTMLIMuudzB7Yeb+9eIRy0g8hk1+BQXLeGeVwa
         /WpvSvhvuYkj+npdSh9HF1CGVWK9oE6g96ZcDmSYFAkmximhgU7M8Dq1H4u/TjH6xmGi
         x7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBY6T42d3o5ggv5VkhBg8He59Bd/P5r/KyV+iKfrvCU=;
        b=tfyaZRkTBGInHDUIWyH5kullvJk6bnOYtzuowThUpNpUwBgLuX1iU/ESMtsT69NI4N
         +ODoh8PJcHuMvBJltR56yURcxYVpsOq0ROTR1nnUyhqCa+/j9dBRju1QymzbP+bS/9QU
         pLGyuDDiPhYGT3TZnrkYtu+6yGv8VGjj1n7W6BBu3S6nh64Ai6rBYTpBzsM2h0cnSMUc
         LVTV8kwFvf+6J73E4BNtVRMCIlkyPH2nHziGKo0LcQB7WBEOCnwOt0igjRcd5bMjB8T1
         zrJefMGQTU31Y0WnDs5HBU1+v4NKCWuqJXyUpBM7I3gQ5L/4lEj2VH2/4p2oS1ed1gbr
         TWTQ==
X-Gm-Message-State: APjAAAU+p1TD0y1XJe1XkOCVPOUwxq4ls+LRkzR8+aB5RM01naNweu90
        f1XLspc3zLIWA4+os+BQUo2hcvYsFRQ=
X-Google-Smtp-Source: APXvYqwroFNP+LSXOXPj9pzgUEktpnZdbo1T5zFxrWukH3GX4QwU4qZmglgL8wddojopCqvN7ZBHNQ==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr4292488wmb.92.1554933166548;
        Wed, 10 Apr 2019 14:52:46 -0700 (PDT)
Received: from [192.168.1.2] (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id e7sm4173427wme.37.2019.04.10.14.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:52:46 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 11/22] net: dsa: Allow drivers to modulate
 between presence and absence of tagging
To:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-12-olteanv@gmail.com>
 <b2f505f2-0dd4-c0c7-89d1-fb9ddd040708@gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <eab251c3-2bb4-f437-c2e5-2832f9c80708@gmail.com>
Date:   Thu, 11 Apr 2019 00:52:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b2f505f2-0dd4-c0c7-89d1-fb9ddd040708@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 5:17 AM, Florian Fainelli wrote:
> 
> 
> On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
>> Frames get processed by DSA and redirected to switch port net devices
>> based on the ETH_P_XDSA multiplexed packet_type handler found by the
>> network stack when calling eth_type_trans().
>>
>> The running assumption is that once the DSA .rcv function is called, DSA
>> is always able to decode the switch tag in order to change the skb->dev
>> from its master.
>>
>> However there are tagging protocols (such as the new
>> DSA_TAG_PROTO_SJA1105) where this assumption is not completely true,
>> since switch tagging piggybacks on the absence of a vlan_filtering
>> bridge.
>>
>> Having DSA receive untagged traffic would put it in an impossible
>> situation: the eth_type_trans() function would invoke the DSA .rcv(),
>> which could not change skb->dev, then eth_type_trans() would be invoked
>> again, which again would call the DSA .rcv, and the packet would never
>> be able to exit the DSA filter and would spiral in a loop until the
>> whole system dies.
>>
>> This happens because eth_type_trans() doesn't actually look at the skb
>> (so as to identify a potential tag) when it deems it as being
>> ETH_P_XDSA. It just checks whether skb->dev has a DSA private pointer
>> installed (therefore it's a DSA master) and that there exists a .rcv
>> callback (everybody except DSA_TAG_PROTO_NONE has that). This is
>> understandable as there are many switch tags out there, and exhaustively
>> checking for all of them is far from ideal.
>>
>> The solution lies in the observation that a more nuanced check can be
>> made when eth_type_trans() determines that switch tagging is used or
>> not. In a way, this reverts patch "717ffbfb28ac net: dsa: remove
>> dsa_uses_tagged_protocol", but instead of adding it back as a DSA
>> function, it is now a boolean property. This is because the driver might
>> actually know better when it can and can't support switch tagging.
>>
>> With this patch, all tagging protocols can morph at runtime into the
>> DSA_TAG_PROTO_NONE on receive, by setting cpu_dp->uses_tag_protocol = 0.
>> This permits them to at least terminate traffic through the master net
>> device. Their .rcv callback no longer even gets called in this mode.
>>
>> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> ---
> 
> [snip]
> 
>> +	/* Property used to allow traffic at runtime to bypass the DSA
>> +	 * filter in eth_type_trans and be processed as regular on the
>> +	 * master net device.
>> +	 */
>> +	bool			uses_tag_protocol;
> 
> This gets used in the hot path can you make sure this is part of the
> first cache line of a dsa_port? pahole is a good tool for determining
> where a member is in a given structure. With that:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Can you give a bit more context about what makes the first cache line 
special?

Also I am not all that satisfied with my own solution here, maybe you 
could share a thought? Basically the SJA1105 *can* actually do a very 
crude form of switch tagging, but only for MAC filtered traffic, and it 
actually mangles bytes 4 and 5 of the DMAC in the process (sort of 
01-80-C2-XX-XX-00). (the irony is that then I can configure it to send 
me a follow-up "meta frame" where it gives me back the value of my XX-XX 
bytes it overwrote).
So receiving MAC filtered frames can be made to not require the 8021Q 
switch tagging. But the fundamental problem is that when I set 
uses_tag_protocol = 0 because I can no longer process 8021Q tags, I 
inherently break my reception of MAC filtered traffic too. Having to 
terminate traffic on the master port is not a big deal, but turning the 
switch back into an unmanaged brick is not that nice, especially since 
it's an unnecessary loss.
Ideally what I would like to have is a way to let DSA (drivers) classify 
skb's and determine whether they can decode a port from them 
(individually) or not.

Thanks,
-Vladimir
