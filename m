Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CAD2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0hqCEBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDCKJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:09:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37353 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:09:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so7423973wmf.2;
        Wed, 03 Apr 2019 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLBSRHgbVphx1ASPXFEW/iof2ku1Ec2Nc0MFuU95O/g=;
        b=f0hqCEBIo3JWpjmaVWBvxaKOZqojW3g7NsNmoXkWSfwwm7gj3JNFqmks4sWN1sf2+f
         4xMrDcHzdwF5/oxhU8ZS2lGFWTbu/OddAwB3O5Gs9CcBrT9OcZiocjqv4x5mAbP7N+X9
         o5ceADssG7//6s4L1BEksNqSbBD1rqohygzPLR90ZM5Y06Wf7d5RujsQDE4QlUmmKczp
         CpMSp3773uHZHwZ5BAmmjfdMezLKTEvagC4mHo6WbLftYG7q4ufNFXi41gDLZA7xR9ob
         fRfXDCkWlo6M3TJbHCA6Nuwoix02vuS2UYWOd+Pl9ralOL4glum7gdpwyyKG8Dp+Bas2
         53cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLBSRHgbVphx1ASPXFEW/iof2ku1Ec2Nc0MFuU95O/g=;
        b=smDrG+/NMqfGsjjGj0LunuvpKfW3A2+em1dm5BjEO0vMlvkhb7C8JskbjltaBHOFo2
         KtVt/NuAHhQn0YZoCXsPqcvpLs2vhAYaNEbIKj8zryWzIQwL3iB93SOVnY1o/8AFQeMV
         oYeWiI1yLeo5/D+b9otju37ivYY7xpOk6H/zKKZ7vsdZnV7Ie3ua3w4Sb/Oa+aJRhK9e
         kzzilixdeXdwSoQvWfv75wL9VmvGhrKbt7JuIlyR/QyvbyZMOc9ATU40ejMnQSkXfXdH
         9dRYIat2Korw43KgpozwsJhf13EErtWLLVaP+qMZRWGimkY6cz1cJ+c863/40RZnfz9w
         fmRA==
X-Gm-Message-State: APjAAAVDdZu6A73E5yxs+uEoulg+HWpQef2rrzNp0ICOLwQjEazuPh58
        fJq8N9Riig1P2PNaYpjt7B8=
X-Google-Smtp-Source: APXvYqw0sM2gp3+VqXOWwyXF+4q6mv61hqpn4Qts+WzR2f9vfxJzef1WWN8O7kAYmAqvi982PiMIuw==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr1367529wmb.11.1554286170656;
        Wed, 03 Apr 2019 03:09:30 -0700 (PDT)
Received: from [192.168.1.22] ([94.230.156.24])
        by smtp.gmail.com with ESMTPSA id c6sm16440304wmb.21.2019.04.03.03.09.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 03:09:30 -0700 (PDT)
Subject: Re: [PATCH net-next 16/17] Documentation: networking: dsa: Add
 details about NXP SJA1105 driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-17-olteanv@gmail.com> <20190402212422.GH22349@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <47131b09-8f39-0cdc-70cd-809b64448097@gmail.com>
Date:   Wed, 3 Apr 2019 13:09:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190402212422.GH22349@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 12:24 AM, Andrew Lunn wrote:
>> +The switches do not support switch tagging in hardware. But they do support
>> +customizing the TPID by which VLAN traffic is identified as such. The switch
>> +driver is leveraging CONFIG_NET_DSA_TAG_8021Q by requesting that special VLANs
>> +(with a custom TPID of ETH_P_EDSA instead of ETH_P_8021Q)
> 
> Hi Vladimir
> 
> Reusing ETH_P_EDSA is possibility going to case problems in tcpdump.
> It has code which looks for this Ethertype and uses it to call the
> Marvell EDSA header decoder code. This is not going to work for your
> switch, where you have a normal VLAN header.
> 
> I wounder if we should allocate a new EtherType for this application
> of VLANs?
> 
>     Andrew
> 

Hi Andrew,

This makes me wonder whether I would be able to use an EtherType range 
to support cascading switch tags on SJA1105.
In theory if I were to consistently lie to all switches within a switch 
tree, I could make all of them see each other's fake VLAN-tagged traffic 
as untagged.
By the way what is the simple ETH_P_DSA used for?

Thank you,
-Vladimir
