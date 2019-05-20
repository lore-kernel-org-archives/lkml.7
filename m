Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF79C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F83920675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CItiLunt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfETJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:36:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41071 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbfETJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:36:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id q16so781289ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVmG+KgAS/L8zReuTwf2tG62bM9a7Io4idy5Ia1ZZIw=;
        b=CItiLuntAhzOMGH2VJ//VLpv/1cTB8FN7h7gueSZp7+ondzT4GAkchg89CIMQlKFCH
         +PTP10KnFd3DEk6wgkzuQkb6WmUByoW1S17NW/sqSFxs/pJAl0n1/KOiI5NwUo53VuN/
         3WhWE0Fo0J0Aw6fOq1nQ8XXjwhj9eeTaEnllHzRAz3S2QVQ8NX0gp02/99F/FWQnHm2o
         qk7JJ1qPEtuOeMjLcCwP+/Ht+TvyGGm6x5OONe8RshUFKQIwvWXfR4rJ/+NbLE5fz4qO
         59F+Ga0fmI6oNS5NlIUbmYUQ9/00bX0wh08LL65062trdQZW43TGqsruRXx6pgzJ0AQx
         IKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVmG+KgAS/L8zReuTwf2tG62bM9a7Io4idy5Ia1ZZIw=;
        b=Oy4leXVmJ2moODaUmQB7M2DJNtKLBQTlIlb/kmt2RceTKjdDdNC0UZ/dhD7vpTYf9k
         gBceSWlEdm/uTULw8NOytFLNEA6GrkyRrFJk6GrxqR38cIJtbX2bjXSZJEVrbfxMjek4
         vsUkMBRBCLwbgv19ZOChBOq5iQ7FN/XsZG/U20jBQ6Xb02BIfsaj3N6Itoy+zHVtvIF1
         +rKpIYOPiv1keFr9d3rqA7uftYYKJJiL5YGPaWrOhtXn5Qb2jwk18WbqCZAcB6YOgqOt
         f2v6NeybPDdC5uhVwPVa9jq7GxfuRCCY5yGqqpHQGq1Irh0d6qXddVBnFTKFbwtBVFhf
         dNHw==
X-Gm-Message-State: APjAAAWAw5liUrDypueBO9L9e/ijsK7xwB0ErBUYCYhzj+3BdsawC/Mp
        nsk5K6IJqI5MftKJX/61U7b4LqalZWw=
X-Google-Smtp-Source: APXvYqwaXw2NIta4ydW0the9uuNpiHIG2CIaAvFEtua7oAjOr+r4sGkRe1H8tyT2JKQhRZXwIrjRmg==
X-Received: by 2002:a2e:9410:: with SMTP id i16mr7604284ljh.152.1558345016801;
        Mon, 20 May 2019 02:36:56 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.27])
        by smtp.gmail.com with ESMTPSA id h25sm3594162ljb.80.2019.05.20.02.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:36:56 -0700 (PDT)
Subject: Re: [PATCH] of_net: fix of_get_mac_address retval if compiled without
 CONFIG_OF
To:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1558268324-5596-1-git-send-email-ynezz@true.cz>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <421e4a76-dbd7-73ac-d8cd-af0bcd789a03@cogentembedded.com>
Date:   Mon, 20 May 2019 12:36:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558268324-5596-1-git-send-email-ynezz@true.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 19.05.2019 15:18, Petr Štetiar wrote:

> of_get_mac_address prior to commit d01f449c008a ("of_net: add NVMEM
> support to of_get_mac_address") could return only valid pointer or NULL,
> after this change it could return only valid pointer or ERR_PTR encoded
> error value, but I've forget to change the return value of

    It's either "I've forgotten" or just "I forgot".

> of_get_mac_address in case where the kernel is compiled without
> CONFIG_OF, so I'm doing so now.

    Well, better late... :-)

> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: d01f449c008a ("of_net: add NVMEM support to of_get_mac_address")
> Reported-by: Octavio Alvarez <octallk1@alvarezp.org>
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
[...]

MBR, Sergei
