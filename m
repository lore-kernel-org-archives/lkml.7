Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F10C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F926AE5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="QYGMBdN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEaOqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:46:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45467 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:46:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so6679666wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZQYx0sfOVBJiI82TzgbbG1aRSIvbp+SnVQCCJZ93hw=;
        b=QYGMBdN818EmjHtrdbUl0XCnQUYiP0fByvbx1zL9Y1SQtNn6v20CYW3ULe9PxnaWHW
         pIKwtkBxoGZOyBBjymUaQZIbV3sMpohGadFozqFsq1z4J5kkyMaVJe15IKej0tN5lfCi
         74zjjmlT1ywTLDy+0PksZp77KtFdLNUlru05b8Sw2Bivk0Q3dZovt6qqIq3d0RfFKShy
         ZUoVLisIQ6T7B0qja4i58lXlIPKk7alsZOsz7Li+QkPDhvyH8Mi7sBoie+Dz1zYOTyL9
         xcHxIXKGvbmIriEwtqnKnbMsqk0VfWUGQuSKwUnsknqkMIEIs1aml3jtSmIc+/l+oX/U
         teRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZQYx0sfOVBJiI82TzgbbG1aRSIvbp+SnVQCCJZ93hw=;
        b=k+8aF73zUtBxlWuY1AMNBEYelFuF/xYq8m7vd4WaQcV0vgAUSn0BekdV8HF2568swm
         UYRCXQdeMlNc4sKbcLMFwR1YP1rsyYYsOnCDSqU6ns0/YcB+ga0rAm+2lEQZk213Aupw
         Q+DrhHhebag+RLFelT536usviRZXRgI4TVvo7TwIHxut9AVLiO2edbXDY6dyjhgroU48
         Vc+HUYKIQ2FPSjIX4rZ4s7k6FSh4jZf0QYpKSzvJ2GJPRhBx8c4v/xutKIyOKPD+GwpP
         pxGdNAHLG/xEuEYl5NxXremO+DoW2GdoFqTNd5r8pdKRT49maJmgi5VUVuXVIUnznkv6
         Lwog==
X-Gm-Message-State: APjAAAWXHLNzOIQiOUrI+tbCUGH5f2NeZHelRMLuP2e7oP0oCri2eEjs
        O4I3rOpI5cpS8Ip3e7O/achyxg==
X-Google-Smtp-Source: APXvYqyscR5zODXGlLGwvT+mCTgGS4EvmpPkRdYWrdiJnzEhPlaSI775Dh9vceu9TUIV8sutdX8+Bg==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr4332044wrn.38.1559313992677;
        Fri, 31 May 2019 07:46:32 -0700 (PDT)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id c2sm3206840wrf.75.2019.05.31.07.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:46:31 -0700 (PDT)
Subject: Re: [PATCH] net: dsa: mv88e6xxx: avoid error message on remove from
 VLAN 0
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
References: <20190531073514.2171-1-nikita.yoush@cogentembedded.com>
 <20190531103105.GE23464@t480s.localdomain> <20190531143758.GB23821@lunn.ch>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <422482dc-8887-0f92-c8c9-f9d639882c77@cogentembedded.com>
Date:   Fri, 31 May 2019 17:46:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531143758.GB23821@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



31.05.2019 17:37, Andrew Lunn wrote:
>> I'm not sure that I like the semantic of it, because the driver can actually
>> support VID 0 per-se, only the kernel does not use VLAN 0. Thus I would avoid
>> calling the port_vlan_del() ops for VID 0, directly into the upper DSA layer.
>>
>> Florian, Andrew, wouldn't the following patch be more adequate?
>>
>>     diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>>     index 1e2ae9d59b88..80f228258a92 100644
>>     --- a/net/dsa/slave.c
>>     +++ b/net/dsa/slave.c
>>     @@ -1063,6 +1063,10 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
>>             struct bridge_vlan_info info;
>>             int ret;
>>      
>>     +       /* VID 0 has a special meaning and is never programmed in hardware */
>>     +       if (!vid)
>>     +               return 0;
>>     +
>>             /* Check for a possible bridge VLAN entry now since there is no
>>              * need to emulate the switchdev prepare + commit phase.
>>              */
>  
> Hi Vivien
> 
> If we put this in rx_kill_vid, we should probably have something
> similar in rx_add_vid, just in case the kernel does start using VID 0.

Kernel currently does, but it is caught in
mv88e6xxx_port_check_hw_vlan() and returns -ENOTSUPP from there.
