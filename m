Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825D22082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW78sj5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDJVbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:31:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:31:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so4648019wrp.2;
        Wed, 10 Apr 2019 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zbe9MPScotXybzjN2GlNF/eDv9kDsM1FOvztbhi1n8c=;
        b=TW78sj5/r8e7zwA2aemorqGtCrEfbc48V6O8VUDEFn4+uF+D5JnGuG6EAJRbLWtKnb
         O1cA+Hg0MoQG3s7AvNyzia0dV+bWVyPhL+kBjZL5a0zDKJMHSSv6gQerIcB8IKrfHE5x
         LRk0fY7DAaKSmGj02SkqzTrRofup/Jxl6OBt1Z+oN6qrcQvAZRuoiLmF/ERuocnwKosD
         ED6V+FNW3OA53X0iHby6IyHXL1/XOotW9puT7IvEmaR0j3GGzk0V1hgLjuv3t482V23L
         +T/VA8cVNEUdUO5THawstEIMEP5wviaVCmQpe2FKs47uoqhLFwMu2F5VLFRoiyCZPp2q
         xqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zbe9MPScotXybzjN2GlNF/eDv9kDsM1FOvztbhi1n8c=;
        b=tZd30JPWTVcxDtbUGxzVns5licLFjSzUNJ3VnwrXh2HjhUJuBMIXKm+5M4wG7DauoB
         nDO1KHf6esGcc+Ok1j+exiJq3TtBbwhihmsOjh7OnygPzyR9WAfftPw4BTwLWBxfq+9S
         Hbk98oxkM04YHuACm9zuFkfcJIxKYafWVnpiEQj6PpYw2bXtySLUOl2H9uxcI4xVRqAv
         Iu+/75/GTj5s2WctdnzgbhJexRHzD/xB29zmFWfYMaCnNW4YwN/6qX8wK5RLFPfOmBnr
         95cxW/ZEeYJ9z313SEM7v9GsZIKRMjij4k6ofYTK6n1Pl2YwlgKrZux0zVRB90zDZnv5
         qt9g==
X-Gm-Message-State: APjAAAVJ83cflgeaY7Q8mJ9a09quStQtyB4FhekM3mOy4Vmsmo+HTCfB
        VuoC0MQGBRQOfSQmzsR5ZOk=
X-Google-Smtp-Source: APXvYqw5JiPhTXWXLtekIol7b+WMdcXYPvXmqJgkxpS1nMVizsNrNChubtlghRzQZTxi+SgoFFjH5g==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr23734107wrs.256.1554931877690;
        Wed, 10 Apr 2019 14:31:17 -0700 (PDT)
Received: from [192.168.1.2] (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id o1sm4486218wmh.47.2019.04.10.14.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:31:17 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 07/22] ether: Add dedicated Ethertype for
 pseudo-802.1Q DSA tagging
To:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-8-olteanv@gmail.com>
 <613d43d9-5331-3b1c-c044-a1dcf0bf21e2@gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <b52f4cdf-edcf-0757-1d6e-d4a831ec7943@gmail.com>
Date:   Thu, 11 Apr 2019 00:31:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <613d43d9-5331-3b1c-c044-a1dcf0bf21e2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 5:04 AM, Florian Fainelli wrote:
> On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
>> With the newly added DSA_TAG_PROTO_8021Q, switch devices that don't
>> support a native insertion/extraction header on the CPU port may still
>> enjoy the benefits of port isolation with a custom VLAN tag.
>>
>> For this, they need to have a customizable TPID in hardware and a new
>> Ethertype to distinguish between real 802.1Q traffic and the private
>> tags used for port separation.
>>
>> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> 
> Why was not using ETH_P_EDSA not suitable? Also how do we intend to use
> this from user-space? The latest libpcap/tcpdump changes essentially
> look at the dsa/tagging sysfs attribute for the master network device to
> determine what type of underlying tagging protocol is used, since you
> allocated a new one (NET_DSA_TAG_8021Q) you could have added a matching
> string in sysfs so we can recognize it?
> 

I'll freely admit that I hardly gave a second thoughts to Andrew's 
previous reply, who said that tcpdump will parse these frames as MEDSA 
and not much can be done about it.

But thanks for the hint, I was completely unaware of the recent pull 
requests you guys made for DSA data link types in libpcap. As a pleb I 
am only using the latest tcpdump/libpcap release tag.
I didn't look closely at the pull requests, but you're saying that it's 
possible to discern based on /sys/class/net/eth2/dsa/tagging (which 
returns "sja1105") and figure out that it's not MEDSA?

Also remember that NET_DSA_TAG_8021Q in my proposal is not a real 
tagging protocol and therefore you won't see it in sysfs.

Awaiting some further advice on this, as I have obviously missed out on 
quite a lot.

Thanks,
-Vladimir
