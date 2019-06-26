Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C785C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157952080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dG0Kh3Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFZQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:48:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46604 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFZQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:48:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so3501739wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OoEaJv7aaqTqsijzQaaYdkI+HMpgRA4Nz4+oOvolsqU=;
        b=dG0Kh3Lo3L+KjkpWUyRqJHULACKCqOiHDzKZMCIhv80+LK5mAayW0rFQ63wrU0q4x8
         Q0BbXgQ+irrQMzb0OW7JXp4ad13a6m5qbyVXQ36STSmCHIgq2/8MQxuvbbzRr3KBNB/8
         coofV77Wy2DHdKB1ChjxSpCnSZ9ezyt96+67mw0HNqsIL3v63NlBlFa8Tc2umtPTTlGc
         +qbIV6RR5O0yywpBNjAde9z2OKnn8g7D/GjAhjOTVZfTrALXfSirrDPQYW6rNzqPJQRD
         E2RuWftv70iIKw7ABFMOJjbC42BbNpBdXr/AbKi3IyRTJYFyLOui4uRpsPlQd+I2W2T7
         HktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OoEaJv7aaqTqsijzQaaYdkI+HMpgRA4Nz4+oOvolsqU=;
        b=KDZPCGVLkIgoup5VouKBe6bYb+c0GTr/L3nm9601VFMtm+4xbjk38ETBgwc4FPAVYV
         Fmt13dIObnIFNl3vWI0nspdfAHcQ3QqcBXhqsZXZtZ9oOUHjfOXhtETfrknhIlUUB5X7
         qVe4hwJzBbFonJXvY0FejKSkgq2F9c9Ls0GnYcIR/LKHpDcSjSKuplGfpn6dbKZ29EJT
         /WOFlvD1Mg0BnEQHsr2ka8OqX3OfyWkrA7fKwI4dFpJ0NX3oQkLL7SyZNFjbmKpiPG5O
         JwdqfYKOiD9Qyp5f6c2Ilcr2ukGS3pagglBSk9SXOoM3hV+yzxFXdpOG0d3mWruFWBKY
         2m3w==
X-Gm-Message-State: APjAAAXgFCLdZmy8gAI23Gl0BE3pwc8/68S4Dt9ryC8GOJQu6CXD7LIo
        sOLHyADeVY2k/6VShegNcsOvww==
X-Google-Smtp-Source: APXvYqzljHLjpMMOMI1Yqco6tVQVtYxV8w+lvdpSFV8LZdGnL4jU6y/yU8JphcP1IsxPsHN/z/ex1A==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr4649769wrv.89.1561567735012;
        Wed, 26 Jun 2019 09:48:55 -0700 (PDT)
Received: from localhost (ip-89-176-222-26.net.upcbroadband.cz. [89.176.222.26])
        by smtp.gmail.com with ESMTPSA id o6sm3792212wmc.15.2019.06.26.09.48.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:48:54 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:48:53 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     mirq-linux@rere.qmqm.pl
Cc:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        sdf@google.com, jianbol@mellanox.com, jiri@mellanox.com,
        willemb@google.com, sdf@fomichev.me, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bonding: Always enable vlan tx offload
Message-ID: <20190626164853.GC2424@nanopsycho>
References: <20190624135007.GA17673@nanopsycho>
 <20190626080844.20796-1-yuehaibing@huawei.com>
 <20190626161337.GA18953@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626161337.GA18953@qmqm.qmqm.pl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 26, 2019 at 06:13:38PM CEST, mirq-linux@rere.qmqm.pl wrote:
>On Wed, Jun 26, 2019 at 04:08:44PM +0800, YueHaibing wrote:
>> We build vlan on top of bonding interface, which vlan offload
>> is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
>> BOND_XMIT_POLICY_ENCAP34.
>> 
>> Because vlan tx offload is off, vlan tci is cleared and skb push
>> the vlan header in validate_xmit_vlan() while sending from vlan
>> devices. Then in bond_xmit_hash, __skb_flow_dissect() fails to
>> get information from protocol headers encapsulated within vlan,
>> because 'nhoff' is points to IP header, so bond hashing is based
>> on layer 2 info, which fails to distribute packets across slaves.
>> 
>> This patch always enable bonding's vlan tx offload, pass the vlan
>> packets to the slave devices with vlan tci, let them to handle
>> vlan implementation.
>[...]
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 407f4095a37a..799fc38c5c34 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -4320,12 +4320,12 @@ void bond_setup(struct net_device *bond_dev)
>>  	bond_dev->features |= NETIF_F_NETNS_LOCAL;
>>  
>>  	bond_dev->hw_features = BOND_VLAN_FEATURES |
>> -				NETIF_F_HW_VLAN_CTAG_TX |
>>  				NETIF_F_HW_VLAN_CTAG_RX |
>>  				NETIF_F_HW_VLAN_CTAG_FILTER;
>>  
>>  	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
>>  	bond_dev->features |= bond_dev->hw_features;
>> +	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
>>  }
>>  
>>  /* Destroy a bonding device.
>> 
>
>I can see that bonding driver uses dev_queue_xmit() to pass packets to
>slave links, but I can't see where in the path it does software fallback
>for devices without HW VLAN tagging. Generally drivers that don't ever
>do VLAN offload also ignore vlan_tci presence. Am I missing something
>here?

validate_xmit_skb->validate_xmit_vlan


>
>Best Regards,
>Michał Mirosław
