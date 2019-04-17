Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78444C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333312177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jALf2NLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfDQAQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:16:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38819 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfDQAQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:16:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id a6so18564827oie.5;
        Tue, 16 Apr 2019 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XcaI9/xXWtrgOWcS0jgWDkWwiglNkG+KHqsyskqnRRk=;
        b=jALf2NLtHBwY6zRfF4jZUootFkcgu6SHUKitvZhX+of6Umffsoo0XRZJeegdlFslkL
         21xmjLsnx2cyDfthjf7vNbD5AAUtUsmjjbMqD0YFSVjmUJANE798VEORA68bFcIxWgE1
         MHlNTp3ObSuag4Vr0y74/XLLtHLtBjiossLGiKHafvihY66wDN1bOpPd50YWWovP0Jb3
         GIn43urfnbmSyigXrcFyOLYTe3KygedsXdYhDFivIEZoBdI/Ioc4nXt+iCEqIMWvRUxN
         AE64h5ymTbjDxcSWzrLlLMNxplVTHs0Xf20KWYXk8QBfDAWKYA5muQ0qT69UYrdkpCdq
         Yqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XcaI9/xXWtrgOWcS0jgWDkWwiglNkG+KHqsyskqnRRk=;
        b=CrN5QSAyW9RxcuR53eru2qxQOOwSrqrs5Q4gCKGdhQ+0T5YpKTX+wEqIUkRxcS/d44
         BzgEO7BFtZB+vo8agxiqlt6BOy1Ei9M0hS2FY4/FeHJ3v8lQ+/FHmrDm4Q4oARQiLOUO
         qW0IACCjzKauhMp8GCNEv2ibzlNOQ4sfU6VuRacId7fxpVazavmXXpZjKqP5ewqdgXIR
         FNNtugffEX0HJDCt10JlAJUqy5KD03NQfzfU3NAiYe8Ky7WTAic1BXKAWyxtPmgOwYvG
         kJjH9RA1Q/0a4EGSVDy6hk1dRMfR6UXXeYNBvJKd/qf8NaPZgmivlACiIji/DhQ6z2La
         E1rQ==
X-Gm-Message-State: APjAAAXy0Ksx7aLPQZV6K+q7dvsIKHZcyL6pr2l1YGGNn33ENHZZOKIP
        kTQU04ElmNE1byr/VorjhvA=
X-Google-Smtp-Source: APXvYqzwqn6zEzev9ogPRmh48fL6hnNknCpCvNwtVQVLx45qgTY2Izy/m+4TFjrteNQkltVC/ILvJg==
X-Received: by 2002:aca:3c8a:: with SMTP id j132mr23283684oia.38.1555460167048;
        Tue, 16 Apr 2019 17:16:07 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id j82sm16572474oih.31.2019.04.16.17.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 17:16:05 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     vivien.didelot@gmail.com, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com> <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bf0e5b35-f401-fbd9-dd18-ef47ec2ae587@gmail.com>
Date:   Tue, 16 Apr 2019 17:16:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2019 14:27, Vladimir Oltean wrote:
> 
> Ok, let's put this another way.
> A switch is primarily a device used to offload the forwarding of
> traffic based on L2 rules. Additionally there may be some management
> traffic for stuff like STP that needs to be terminated on the host
> port of the switch. For that, the hardware's job is to filter and tag
> management frames on their way to the host port, and the software's
> job is to process the source port and switch id information in a
> meaningful way.
> Now both this particular switch hardware, and DSA, are taking the
> above definitions to extremes.
> The switch says: "that's all you want to see? ok, so that's all I'm
> going to give you". So its native (hardware) tagging protocol is to
> trap link-local traffic and overwrite two bytes of its destination MAC
> with the switch ID and the source port. No more, no less. It is an
> incomplete solution, but it does the job for practical use cases.

Indeed.

> Now DSA says: "I want these to be fully capable net devices, I want
> the user to not even realize what's going on under the hood". I don't
> think that terminating iperf traffic through switch ports is a
> realistic usage scenario. So in a way discussions about performance
> and optimizations on DSA hotpath are slightly pointless IMO.

Actually it is on Broadcom devices that I directly or indirectly helped 
to support with bcm_sf2/b53 we have 2Gb/sec capable management ports and 
we run iperf directly on the host CPUs. Some ports remain standalone 
(e.g.: WAN) and the others can be bridged together (LAN + WLAN).

> Now what my driver says is that it offers a bit of both. It speaks the
> hardware's tagging protocol so it is capable of management traffic,
> but it also speaks the DSA paradigm, so in a way pushes the hardware
> to work in a mode it was never intended to, by repurposing VLANs when
> the user doesn't request them. So on one hand there is some overlap
> between the hardware tagging protocol and the VLAN one (in standalone
> mode and in VLAN-unaware bridged mode, management traffic *could* use
> VLAN tagging but it doesn't rely on it), and on the other hand the
> reunion of the two tagging protocols is decent, but still doesn't
> cover the entire spectrum (when put under a VLAN-aware bridge, you
> lose the ability to decode general traffic). So you'd better not rely
> on VLANs to decode the management traffic, because you won't be able
> to always rely on that, and that is a shame since a bridge with both
> vlan_filtering 1 and stp_state 1 is a real usage scenario, and the
> hardware is capable of that combination.
> But all of that is secondary. Let's forget about VLAN tagging for a
> second and concentrate on the tagging of management traffic. The
> limiting factor here is the software architecture of DSA, because in
> order for me to decode that in the driver/tagger, I'd have to drop
> everything else coming on the master net device (I explained in 13/24
> why). I believe that DSA being all-or-nothing about switch tagging is
> turning a blind eye to the devices that don't go overboard with
> features, and give you what's needed in a real-world design but not
> much else.

I would word it differently and say that up until now, whatever DSA 
assumed about switches was something that was supportable and with the 
sja1105 we are faced with an interesting of limits on both designs. I 
don't think DSA is unreasonable in assuming that management frame is 
always tagged with a proprietary switch protocol; because that's what 
has happened across a wide variety of vendors. The NXP SJA1105 is not 
unreasonable but it does present some challenges.

> What would you improve about this design (assuming you're talking
> about the filter function)?

Would assigning different MAC addresses to each standalone port help in 
any way such that you could leverage filtering in HW based on MAC DA?
-- 
Florian
