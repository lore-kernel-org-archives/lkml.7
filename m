Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252FC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B93321741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQpuhzC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDJCEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:04:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33580 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfDJCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:04:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so431755pfo.0;
        Tue, 09 Apr 2019 19:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VWuTeUBon0KFvi6W7xslMkPEge1AmX60EgXE4RIiKQ=;
        b=CQpuhzC9FC19+uBY/NEFV8Sdh4cowa2P3xCUoRYCgnah88eld2WcHSvniDH+6ey/jT
         hcZgqt8BLwog7YHUejxuWc42NR2DnMs+hQ7conC7PP4bni7uE0TL5Bmq3ZD46NDNl3jx
         BLuezge6bg9fx96CueYPdlLbvdr+sCNeRw8slLqgjBKg9Tay1D/FS+WQ81b7gWiM+AXx
         jUu585GkVVb1M7RBZEJ2TlLXB7oCBHObmNcz3FdLLduIc4u36CmbSLUgqjhsSOie++G2
         uHKG0DbtdHsyf6i6WIkm0+7GvaxWihGQT0B53clkkJbKUxNE1xYE6t8aHpkUkfR5nS87
         VlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VWuTeUBon0KFvi6W7xslMkPEge1AmX60EgXE4RIiKQ=;
        b=I3/pB3BQKMc9orCSSxRkRzbBRKaowSU7KtCHW64k8ed/sITH4f+r6vdejAuEv8L+ZZ
         tC5fWj/Osu0nPeV/cr28DDkymJS1AEdFHQ/xR9/Oi6UE9gvAouXL5w+B+cRSdHEnk6oJ
         JYA1RP3FeJnwFcaO19LIxe2gU6T4Wi/10PXYB2yfHHoJVixLO76tJhG11cnV/07umFqL
         85sqgUmknSvkXufmBzZXviCKy97KOVWilKnrV7+2aJV5HSSZG5d+7oCJa/Im8DE+UO9R
         3c2/LLXPH+sYRCSdp4uS1OD6pgTlZX6D4Cu7L5Flm19QVF7svhvsx6xrq5lR+24kpMJa
         kOgA==
X-Gm-Message-State: APjAAAU0EPyoXP0gRSOVTbKBJz86Pq5/Jd8wuJDVotXJ6T0pFX08Q+3R
        Qazgn9hKeCaFyGBoOwhftFduRyVZ
X-Google-Smtp-Source: APXvYqzVwaABwgJvMNGUO5Qn6R4anXmF3RuyUeHAIIrE/+5B9flgH3qniBNTQ7RArIAbMH3+Q7WNLg==
X-Received: by 2002:a65:53cb:: with SMTP id z11mr37442061pgr.139.1554861871030;
        Tue, 09 Apr 2019 19:04:31 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r76sm34887135pfa.39.2019.04.09.19.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:04:30 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 07/22] ether: Add dedicated Ethertype for
 pseudo-802.1Q DSA tagging
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-8-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <613d43d9-5331-3b1c-c044-a1dcf0bf21e2@gmail.com>
Date:   Tue, 9 Apr 2019 19:04:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-8-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> With the newly added DSA_TAG_PROTO_8021Q, switch devices that don't
> support a native insertion/extraction header on the CPU port may still
> enjoy the benefits of port isolation with a custom VLAN tag.
> 
> For this, they need to have a customizable TPID in hardware and a new
> Ethertype to distinguish between real 802.1Q traffic and the private
> tags used for port separation.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Why was not using ETH_P_EDSA not suitable? Also how do we intend to use
this from user-space? The latest libpcap/tcpdump changes essentially
look at the dsa/tagging sysfs attribute for the master network device to
determine what type of underlying tagging protocol is used, since you
allocated a new one (NET_DSA_TAG_8021Q) you could have added a matching
string in sysfs so we can recognize it?
-- 
Florian
