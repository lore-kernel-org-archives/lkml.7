Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67AC10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13FA2176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt5Gespz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfDQAJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:09:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37220 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbfDQAJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:09:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so18559927oif.4;
        Tue, 16 Apr 2019 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iyt/AlOO/t5kISwy/69Ng+gkae5nr7bxslgaJMBUNb4=;
        b=Pt5GespznByOFhyBY57zjSiSzHLRqmDBP2CQLcc0zAzTdZ3lHaGGvZX38bUwjFA57q
         cPd+DHmC+mHD/bzF/pyldDFbOjFUEHwblQL4BK3gQuLXW5Lfg7pJhz1+QW+09HV0NLQa
         6vRmRkcOpJyHbbtG050gmx0P+H4T+Ck03CWQsUjYoKppNzpz/3+I9NJ4o1aNCGUBh5B6
         SuZd0997+2pQCgdDGIB+btAmX/QBzV+NYqd2AQuzk52IfQ0ImdNjPJDCZ0lRHRDudpsT
         a8zYZ3O4Fa/U9Km1VEcW84E/6kXXQQ4jdc2ZJM55JUeyZYkPWlYoR9NUEFO29lrs+RJJ
         dTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iyt/AlOO/t5kISwy/69Ng+gkae5nr7bxslgaJMBUNb4=;
        b=W3LJFVZawvkRceSkzkP09l/2hwFEuqBpglSqYcS+bi4tY4Hict3RNh2SCw1xCWe0UL
         R33N0DBV2PZLl4nilMhIUXzYufnECP1Db/KDz3CJ+BEg6+WexDRLfB0e/baUCgazqSNH
         dJCPgpgKrzqA/sRBuLfkoWvnositHGQkt0PYR913RRFVCUG/bQ+20WIQ1Jo4pF0WK9lu
         PASejDHw9fZXmR+UWHFVCSoEMq+wb2fB+jZGKiEiGVrf4d07Z2pv5IjgaxI/VpQG9Nvd
         Euxl4lMEPwwGj8u7dAvqpTi6XAclIICjr2Ez2GNwSTtRm24BVFgQcqO/anc17tFehdXq
         a5NA==
X-Gm-Message-State: APjAAAWZbWOH9IrMZEpOIUqFl6KILS9Nqy7T6cLrMPFGsWMjDqJmlD12
        ErbQyRbJ6loUJKU41Hso5+F6BqFD
X-Google-Smtp-Source: APXvYqwhHyOOE5UrD3WHetlHSaXqbr8rMuBNOA2e+UKXFml8LmYQiGWpkYSxG+7Q1lMt5mcPnJs0mg==
X-Received: by 2002:aca:3746:: with SMTP id e67mr23844048oia.37.1555459787928;
        Tue, 16 Apr 2019 17:09:47 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id i11sm18464895otl.27.2019.04.16.17.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 17:09:47 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
To:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc:     vivien.didelot@gmail.com, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com> <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
 <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
 <20190414161757.GB10323@lunn.ch>
 <CA+h21ho9AKSmX=6CU1P_fddcYSGB-DN0T-XqVYg8GnTRfuShVw@mail.gmail.com>
 <20190414191318.GE10323@lunn.ch>
 <CA+h21hrGPfo4-QxMjG9hqitd6qBWEpcYHeqvyPzYMFpkSLbBQw@mail.gmail.com>
 <20190415030710.GC24455@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4ffd859f-e05f-0a9a-1e83-fd462eac34d9@gmail.com>
Date:   Tue, 16 Apr 2019 17:09:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415030710.GC24455@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2019 20:07, Andrew Lunn wrote:
>> It fails to decode the frames, obviously. But so does any other EtherType.
> 
>> Florian was hinting
>> (https://lwn.net/ml/netdev/b52f4cdf-edcf-0757-1d6e-d4a831ec7943@gmail.com/)
>> at the recent pull requests submitted to tcpdump and libpcap that make
>> it possible to decode based on the string in
>> /sys/class/net/${master}/dsa/tagging. I admit I haven't actually
>> tested or studied those closely yet (there are more important things
>> to focus on ATM), but since my driver returns "8021q" in sysfs and
>> yours returns "edsa", I would presume tcpdump could use that
>> information.
> 
> No it does not. It is a valid EtherType, that is what is used to
> trigger the decoding, it takes no notice of what is in
> /sys/class/net/${master}/dsa/tagging, nor the extra meta-data added to
> the pcap file. There is no need. you can identify it is a Marvell EDSA
> header from the EtherType.
> 
> In fact, this tcpdump code for decoding EDSA pre-dated Florians
> patches by a few years.
> 
> You only need the code which Florian added when you cannot identify
> the header directly from the packet. And that is true for most of the
> tagging protocols. But EDSA you can.

Correct.

> 
>> Anyway, since you obviously know more on this topic than I do,
>> please make me understand what are the real problems in spoofing the
>> Ethertype as a Marvell one.
> 
> Despite there being an EDSA EtherType in the frame, what follows is
> not an ESDA header. It is like having the IPv4 EtherType but what
> following is not an IP header. Broken.
I suppose this is a valid point, but in that case any EtherType would do 
and technically using ETH_P_EDSA is just an one of the many possible 
choices for configuring the Marvell EDSA EtherType, you just need to 
pick one that is not going to trick the switching into thinking this is 
invalid LLC/SNAP.

With Vivien's latest tcpdump changes, I don't think we need to rely on 
ETH_P_EDSA to be present anyway since the kernel tells us (when available).
-- 
Florian
