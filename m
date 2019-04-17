Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD0C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691E2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQlTcaZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfDQAUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:20:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44735 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQAUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:20:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so18555502oib.11;
        Tue, 16 Apr 2019 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b58g4cJPAz/6cOF7x0QwjSMYANQGonoQR6DyLqU4OrE=;
        b=RQlTcaZy7eR8bU/qAhn1kxp/dPe0L//smEtWtVb1gx+QUQKSyGu8oivpkD/8MNjFFB
         /lnkwYmvDVJXuLxm3j/mKL2I7M5FkSINxeijtxRCSBV9nGIF5/MK3S8rFBX8IsV4TTsl
         4J1IebaXfouCwU1bWGbufjPlftaR1wS+6/2F+sLXkKPE38Reri+qPD7Uu4nX5eTo681V
         sfLy8fRNAftSG9iEVBSVV8/KMCaAi8l9LcUPmu+EAmks3PjXsOz1ArE25dP3iS80mnnB
         1o325qPpPiRCYKo22PSiK+DArdhSw982mSGfg1P8EX/XS6iWiRIpk+TixapcQTgPaRIO
         pIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b58g4cJPAz/6cOF7x0QwjSMYANQGonoQR6DyLqU4OrE=;
        b=FRFCoe3YwbA3QEZW1IP9Q/NbHJLHIADKi/cO7F6nM8B+nfpXlE6GimWxEH+SMxbBHl
         Jhs11RHT1+HNaNL2q46SNR13Sf922F1MmiBQ73q2kCf6C50cM7k3Bzwh59kJzuf463Op
         W1GuFA8V1yhI1vRGPeZSIITeFOZ2Gp3pctPObJECfXoxXL9fReTad7DpjSoldA3auVth
         icI85WyhQ44Fpm9dSqFhObfuCLRe4IzklgMi0ioW/dADS58cSh13mRMGf9Zm5KIOaH/k
         FMGbhbzs62cI4JODcR6eo0RGgStF7NRe7C6NSSTZecCs9RR13gc9lTKG32GefocOcpla
         w8Iw==
X-Gm-Message-State: APjAAAVFUmZ8XpoBQPSxiG2q3QIbKrtEDrjJeCKF6oG6q34EdbrBNvps
        DVwWua3Og14KduPXWyQKBHg=
X-Google-Smtp-Source: APXvYqziiM1KU4v/IWEwE8td7OTqUUbOo5BqHQf+TxHbo+SEici9grpfcggtslTvXIUllxLM0jT+9Q==
X-Received: by 2002:aca:304e:: with SMTP id w75mr26373090oiw.176.1555460449814;
        Tue, 16 Apr 2019 17:20:49 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id a34sm24853275otc.46.2019.04.16.17.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 17:20:49 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 23/24] Documentation: net: dsa: Add details
 about NXP SJA1105 driver
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-24-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a09bdb25-6d18-b9f0-2be8-da9ad174ace8@gmail.com>
Date:   Tue, 16 Apr 2019 17:20:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-24-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:

[snip]

> +Segregating the switch ports in multiple bridges is supported (e.g. 2 + 2), but
> +all bridges should have the same level of VLAN awareness (either both have
> +``vlan_filtering`` 0, or both 1). Also an inevitable limitation of the fact
> +that VLAN awareness is global at the switch level is that once a bridge with
> +``vlan_filtering`` enslaves at least one switch port, the other un-bridged
> +ports are no longer available for standalone traffic termination.

That is quite a limitation that I don't think I had fully grasped until 
reading your different patches. Since enslaving ports into a bridge 
comes after the network device was already made available for use, maybe 
you should force the carrier down or something along those lines as soon 
as a port is enslaved into a bridge with vlan_filtering=1 to make this 
more predictable for the user?
-- 
Florian
