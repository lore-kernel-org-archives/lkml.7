Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE41C21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gi0FnqEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfEUJ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:27:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfEUJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:27:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so1006869ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Xy6KpBMf4VElfSxI8JZgNkIn+5swVz4A7VXhYDp2D4=;
        b=gi0FnqEmcboPROS3aUYX2FmzKmldrXp2Xd53Cs+z0s80NF/1tJ+89FLSOmuykkWh0a
         Bseps+m7BHSnZFk5NVsRLKcGhVs10u9VBXuk7ZFWImQxcj/UfGSJbg6gJGqG3M6Eryu0
         +6VMdvaQODEdkEjm10eVWCg6HQioXvq/vhckhU8CXA37bZxImLyV9zUqEhECALNCOSWj
         Io7qmy3Kwb5wIloKJURrXpWb2PPdq2gW5p7a9/ShaO6loZBFBAo1n7iTGu7RKvdGnRAu
         5KIh2bLGig4OqmPNCI6RFNpRPS27XWQk6PKwqmubBBllN7izvBcvS8lnUx17EQ9e1BYP
         sbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Xy6KpBMf4VElfSxI8JZgNkIn+5swVz4A7VXhYDp2D4=;
        b=A6IehnoFsUozHVLIQei4HtngyO2iVVb/FE+umSnqzVGs1nGa7U8cOp1MEK+zfXrmKA
         kYc1hOqfh7whf/wbJHhgukYHNh7/KDkFiNJ9ofUVw0cAirjrQyh1YDUe8oHS2YK7vAJx
         wVyTr/24x24o0EY7IM6O2RNGt4hsDTNrG2MblUqAzhN69JeRSOWR5yNsR+Pe3CQ9BIOS
         K5vOLldKcxfS+d1g4UyZiYf9hzWOPFS7Ujz/a2ABKLYuLroxnIMZ0CbTRqOsQ5RCsZs2
         sArDRCHDm7oQfgOnGiX9VQFw1NP4rKiHyzcJHlB9AX0CPRwAS9stK7EbJmSdyZd7z/Sb
         3CXQ==
X-Gm-Message-State: APjAAAU2wMi0QVQTFr28hByj/R+Aaflxahb5fNp9LSJeD55soGJlerQB
        VqoWpCK20xWKL/l4qhufxTQRzQ==
X-Google-Smtp-Source: APXvYqz2W9cUR77wBpFQtxU/OEIMqFs1dqOYZh2m5bXIMOiU7pDh+NaARFsIcqKmxsWQZ0msZguFsQ==
X-Received: by 2002:a2e:60a:: with SMTP id 10mr3542802ljg.126.1558430852654;
        Tue, 21 May 2019 02:27:32 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.21])
        by smtp.gmail.com with ESMTPSA id u128sm1039382lja.23.2019.05.21.02.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 02:27:31 -0700 (PDT)
Subject: Re: [PATCH v5 2/6] net: stmmac: sun8i: force select external PHY when
 no internal one
To:     megous@megous.com, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20190520235009.16734-1-megous@megous.com>
 <20190520235009.16734-3-megous@megous.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4e031eeb-2819-a97f-73bf-af84b04aa7b2@cogentembedded.com>
Date:   Tue, 21 May 2019 12:27:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520235009.16734-3-megous@megous.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.05.2019 2:50, megous@megous.com wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The PHY selection bit also exists on SoCs without an internal PHY; if it's
> set to 1 (internal PHY, default value) then the MAC will not make use of
> any PHY such SoCs.
          ^ "on" or "with" missing?

> This problem appears when adapting for H6, which has no real internal PHY
> (the "internal PHY" on H6 is not on-die, but on a co-packaged AC200 chip,
> connected via RMII interface at GPIO bank A).
> 
> Force the PHY selection bit to 0 when the SOC doesn't have an internal PHY,
> to address the problem of a wrong default value.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
[...]

MBR, Sergei
