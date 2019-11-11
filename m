Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F343DC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACFC21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NTMOinJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKKOoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:44:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35643 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfKKOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:44:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13so10865143pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=LU8AMzMDy4OOUqnFmi5XN0F2ODrVM91j32IqE/77mHI=;
        b=NTMOinJQKgGx9JbjTBpaKVajY1gfGsX1WblOyp3NBFsN8p75WfacP6UqvvXptVTVId
         xN5qz61ZGXzP9BO1kdYSvUOKp39Fbhf66yDAtZWO5BKFue22crRdtliWAHS4kz2fTSfn
         76wXnu2Gctwypqjj2Ju18XWXFc/3dzXGUwRIqHNjdCmv1mmK1k7ayrSQh4xKVlXgR3iY
         NYRa8Ad7h162TBo7EYx3gGgD3fsHCxv0IT2DFhME9aROh7ybGMZsLX7HKJHvJ9G/lY2d
         PN7HPgDwPADieUk7aqhYEFA5qnheSRp14/hszYvfmRF7NBno4Ps/bJO3zF5v9m0oeLr6
         w6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LU8AMzMDy4OOUqnFmi5XN0F2ODrVM91j32IqE/77mHI=;
        b=bul1XU49oQsqYwsfiNz3QAttgkdmQcFwO3nwbyl1SVVeBVg51iKUOAI4RyeE5qBkpo
         hIkt3d4L5ums6JasJN5XnWqY0xTjbYVPWj0cj+NDLTKBlNs3/jUWlEd3cjMuIGzzk0wp
         bFNRKax4V3vIuELH8ktwg2DOLGdUtqpzv3Yv8VwhhxPlY6pDdtbmgVpdEvNm34UZANMI
         iFuzuitgcH1K+2Km/0Uq2XSbEU4IXx/m7nPgjDM2I5OFfctDOWvFlWs0bAEihnBnunFH
         uwMRF7mzluijdnb1zPGAIm89aT9FkLF6k1a4sxiMN/LRTayhTwuoTG+oK4YwKGW7P4p0
         +MXw==
X-Gm-Message-State: APjAAAXbPlarY/6TMecOk3cbWpOmiP1FRTbG/+T8krIsWAPpYCKuWUpK
        eI/fI2SCixYYsePSWlKU7wAzN6PPxuk=
X-Google-Smtp-Source: APXvYqx0YKzHjeIhgnYjvdDvP29Rz7Fr9hL8YrdKueSuJN1eULz6g6R0rM2MwrtthHa/AXMwwqvLnw==
X-Received: by 2002:a63:7210:: with SMTP id n16mr27806220pgc.397.1573483454953;
        Mon, 11 Nov 2019 06:44:14 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:dd5e:2cce:fe26:7bc6])
        by smtp.gmail.com with ESMTPSA id q126sm2117762pfb.42.2019.11.11.06.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 06:44:14 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v4 3/4] soc: amlogic: Add support for Secure power domains controller
In-Reply-To: <57b9c706-c341-c7cf-698a-66335b34442b@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com> <1572868028-73076-4-git-send-email-jianxin.pan@amlogic.com> <7hmud4stfo.fsf@baylibre.com> <57b9c706-c341-c7cf-698a-66335b34442b@amlogic.com>
Date:   Mon, 11 Nov 2019 06:44:13 -0800
Message-ID: <7h36eucw1u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> writes:

[...]

>>> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
>>> +	SEC_PD(IR,	0),
>>> +	SEC_PD(SPICC,	0),
>>> +	SEC_PD(SPIFC,	0),
>>> +	SEC_PD(USB,	0),
>>> +	/* NIC is for NIC400, and should be always on */
>> 
>> Why?
>> 
> NIC domain is for ARM CoreLink NIC-400 Network Interconnect, and should be always on since bootloader.

OK, makes sense.  I suggest a minor change to the comment to remind that
this is an interconnect:

   /* NIC is for the Arm NIC-400 interconnect, and should be always on */

Thanks,

Kevin

