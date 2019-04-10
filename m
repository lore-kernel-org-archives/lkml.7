Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F0BC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8kN77/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfDJCRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:17:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:17:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so365881plb.12;
        Tue, 09 Apr 2019 19:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6CLuPA/AJhfGD4Iu0YQ5LK2CB0ty+XzJLOlx2nNx34=;
        b=n8kN77/0SMaU8oWAbWVkX7bejuEg4CTGtLuXPuMhYxoWL9O4ocUe+d93DD4wwROm0n
         UGOw6lRcEvz/rHTl9hGnzZWf7lZQ4zv6wYIB6wx8ThfR96w/h9dzeiPCWuCrcCBhX50y
         ZF8t2yw35dBrNa6lUmGTyk7uaKi9SqiIsgjyFy0VwKoMCUTksXk37UPb2/DtuWmsh4dF
         lsjNrXota9UgoyIet2yCvm6Elui350dbrv5k08oU5Ff+E4q1hSUYJwdymS3R7JWAPHrg
         yzRXdr2Uo8mnNiPHo49H3gkrmg9aCD79mBiLitYsynpzYfZVYknN29vohcNX77yfOMnf
         efQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6CLuPA/AJhfGD4Iu0YQ5LK2CB0ty+XzJLOlx2nNx34=;
        b=EahY2Jc1QINef+YDgFfCBlFu667fBqLY9U3WbEKiGllzBnnPp4Nm4QURCtZn3fONxn
         OiAJKPjqG8I8+neXXM/WsyMc8A4ef+3huPi3BpmUK1bMfo5hed1yQokADPTAeR4pdsiq
         ccuSPw/hOzDmu3pQEBvOYfajPVCeQzyzgwYBZKicjdrfxsweBsJxjhdyvgm1JEO6VtmO
         wFFFLYHRJQ5U1lLs790+PA0ob4MLGgtp/BmrShcD7ouEoQxHzQYYXxM7HvZvQDMBD+hU
         cQJ7wZW7XxuBj9ZfR77VoQsFQC3ZsiIdko7+gPey2jfOt2Oc+gyJOwN16ba2858TT+PF
         0/3g==
X-Gm-Message-State: APjAAAXDKgSuLcKcmNIIfUK3ljHMR2yE569UYUNP6AWBDOu+lKmcORYb
        EK7nu+eXY+A+L6VkN9kRlTOZqsma
X-Google-Smtp-Source: APXvYqxahvER3l3RWHaJDgYOoEty7DE5Royj2KsXzmqAy3GsHSn1AzB3Fg5d+n5YS2JdswahOE3fvw==
X-Received: by 2002:a17:902:5ac4:: with SMTP id g4mr39056294plm.261.1554862637923;
        Tue, 09 Apr 2019 19:17:17 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y1sm44932398pgc.29.2019.04.09.19.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:17:17 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 11/22] net: dsa: Allow drivers to modulate
 between presence and absence of tagging
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-12-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b2f505f2-0dd4-c0c7-89d1-fb9ddd040708@gmail.com>
Date:   Tue, 9 Apr 2019 19:17:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-12-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> Frames get processed by DSA and redirected to switch port net devices
> based on the ETH_P_XDSA multiplexed packet_type handler found by the
> network stack when calling eth_type_trans().
> 
> The running assumption is that once the DSA .rcv function is called, DSA
> is always able to decode the switch tag in order to change the skb->dev
> from its master.
> 
> However there are tagging protocols (such as the new
> DSA_TAG_PROTO_SJA1105) where this assumption is not completely true,
> since switch tagging piggybacks on the absence of a vlan_filtering
> bridge.
> 
> Having DSA receive untagged traffic would put it in an impossible
> situation: the eth_type_trans() function would invoke the DSA .rcv(),
> which could not change skb->dev, then eth_type_trans() would be invoked
> again, which again would call the DSA .rcv, and the packet would never
> be able to exit the DSA filter and would spiral in a loop until the
> whole system dies.
> 
> This happens because eth_type_trans() doesn't actually look at the skb
> (so as to identify a potential tag) when it deems it as being
> ETH_P_XDSA. It just checks whether skb->dev has a DSA private pointer
> installed (therefore it's a DSA master) and that there exists a .rcv
> callback (everybody except DSA_TAG_PROTO_NONE has that). This is
> understandable as there are many switch tags out there, and exhaustively
> checking for all of them is far from ideal.
> 
> The solution lies in the observation that a more nuanced check can be
> made when eth_type_trans() determines that switch tagging is used or
> not. In a way, this reverts patch "717ffbfb28ac net: dsa: remove
> dsa_uses_tagged_protocol", but instead of adding it back as a DSA
> function, it is now a boolean property. This is because the driver might
> actually know better when it can and can't support switch tagging.
> 
> With this patch, all tagging protocols can morph at runtime into the
> DSA_TAG_PROTO_NONE on receive, by setting cpu_dp->uses_tag_protocol = 0.
> This permits them to at least terminate traffic through the master net
> device. Their .rcv callback no longer even gets called in this mode.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> ---

[snip]

> +	/* Property used to allow traffic at runtime to bypass the DSA
> +	 * filter in eth_type_trans and be processed as regular on the
> +	 * master net device.
> +	 */
> +	bool			uses_tag_protocol;

This gets used in the hot path can you make sure this is part of the
first cache line of a dsa_port? pahole is a good tool for determining
where a member is in a given structure. With that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
