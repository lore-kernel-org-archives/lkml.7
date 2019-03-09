Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E49C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8FE206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4PmONIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCIWCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:02:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34332 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfCIWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:02:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id u65so998552pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99/VGx0ISyw2EcEIgX6IR/A3ypWZCSODUc2rq4rXl80=;
        b=r4PmONIt8rlCuvnN7pG0EHlH7OG+ERkvMXNsEObXMJqvHzstrdMpkINiSpr0oiLDP1
         L1Gfv9RaS2wHcGoTSUbPKAR1WCdw8ojHwm/RckbVSoPuMexC50fQ9znrzDX8tSDUwGll
         UMP/bffrHbufrPUqR/RlZU0X7HdaYG71fJbVosOIqKkE6mEy01FTVuDdeC3+SAc7EhtW
         sYLP6Jf/sj1Ao+j18eVZK1mcJNURFt1tjkVIZcQ1Qhe36KEYwzVSuOA6mSeJIkTbxTk4
         Q0Y5CmZDoa68ADRhQLzrxw3Bvpg/qQ0BmcmoB0y0eM/qN1XCiBDHhk17rKDcFW3EF93k
         by1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=99/VGx0ISyw2EcEIgX6IR/A3ypWZCSODUc2rq4rXl80=;
        b=fNE5U5dBLQYOQPpZTQNOLbf4QMko6EcPiUKfhcfRtw0+Brqr39JpFm3HzCTeryKr+M
         kfB0v7qLkTvrhQ6JickSXyjvOf5uASH3zi0vfefkGP5P8s30toGPDWOmtl8oYNOUNIon
         DVEr9nEIcasafmvYYQt+YwqgTc0WdMusiWqD5Cv3Zf4FY05uDkQJQqeAvsgxbBaUj+1D
         CV9LbdYkmp22ayR4T1DRxXxG4IUgPg4q3U4eMVDkdSC+MNINDyZPnGMsigJGRpFi3DZV
         wTKRgd5h/LNmcBfQhFkUEeD7YYsF060vk/BwUk6GH2NxdOq+vvq+wa2vq607C46Zvrp7
         i5yA==
X-Gm-Message-State: APjAAAUBPNXocrFQz17+xfdtCG/DAnpuWOGwqUHn+RR0sJfYzbgeE4Vr
        TB9TW+0IxOE1moQX3cswIDw=
X-Google-Smtp-Source: APXvYqw2rsXhL4Km5QSZGUdV06zegoOqDGE4fCLKAql0BniOxp1ie4m1I4zsecUHMIbj98xBke9Olg==
X-Received: by 2002:a62:e719:: with SMTP id s25mr25368345pfh.12.1552168920270;
        Sat, 09 Mar 2019 14:02:00 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t10sm2195732pgo.27.2019.03.09.14.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:01:59 -0800 (PST)
Subject: Re: [GIT PULL 1/2] bcm2835-dt-next-2019-03-04
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20190305000218.15180-1-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <a3a023f2-3df7-3dd0-7303-346eb14383ad@gmail.com>
Date:   Sat, 9 Mar 2019 14:01:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190305000218.15180-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2019 4:02 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit ab1b4ef966af90ad79fa3c4c124e47915cddde10:
> 
>   ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-02-01 11:56:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2019-03-04
> 
> for you to fetch changes up to 544e784188f1dd7c797c70b213385e67d92005b6:
> 
>   ARM: dts: bcm283x: Fix hdmi hpd gpio pull (2019-03-04 15:50:10 -0800)
> 
> ----------------------------------------------------------------
> This pull request brings in a fix for detecting HDMI on the Pi B rev 2.
> 
> ----------------------------------------------------------------

Merged into devicetree/fixes, will send this out once v5.0-rc1 is tagged.
-- 
Florian
