Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18630C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20FE2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+HdPDbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfJGOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:25:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43631 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:25:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so1015921pgl.10;
        Mon, 07 Oct 2019 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6cKf9Yx3TmejeHBa/hPwjDOmZeRHg3GuMqxre+x+ds=;
        b=H+HdPDbpaytRhFAVSUU7E+FdpTwhsL5uSEHLs6QxP6d8sGLuwAZUOKHUGtzJBBKOVg
         qgwhh6OS2BYnCpl1V/kJI/uyWaa/wJDmzwArI3Nxvn2wmwGGwJpzZUcGPCNchze353vz
         Q89Uk1RbaC2h9S0tu47Gd8FuD+7B8tKJxuK59E9EWCrpqShuGKdu+h0CBEEuGKaec3Qr
         I0p8zCaG5J0ZDXMrjLgMIaVPD7jnap5zx3DpJcWPuZ4tClFW7+ag7TP63NKnYWItD3sA
         KGFxDR9cIaoNIoNYGw0Fca98bt05mxCORtxbtQJ8sxEmuRtubHMCQeNKM/2pA5gPDq2b
         hzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6cKf9Yx3TmejeHBa/hPwjDOmZeRHg3GuMqxre+x+ds=;
        b=SJWVmNKp0AiLp1nRU5UD9T4DeJLfzYHZGCqAAa2tsbnpJEGcYsL6Thbgg4a5bqB2Rd
         XPMeKJ+Pn3gFfx5NKrb9uOWBBAVbsquPCLvWAheq4T9BeMeP2xBrMUGONfXwM4WlLCjp
         w+ByZxq6TkfZg7ngagT6nHDbsqfBwj4N+CK8qF9wnM1N7I5c2UUGU9nNvDrbuQ91Ij8A
         U2ugDf1Wexyl4nSX3eVjPZPF+dled+qBWDmTAd7agQIh6geOuljW/wXOazq3FfZCKxiG
         HmFrzoHoVwVKLPOTan5P8Cy0MC43kFQCUPqcCUecoWBFxLvxb+gLnLUB04e9bEVyM3nL
         yf4A==
X-Gm-Message-State: APjAAAVIXNXH0Yd8y6VOptPvELAHLKPW1DowsJR3FwAckLDMshvcijun
        lB79QGlhCsznonKLph3zenk=
X-Google-Smtp-Source: APXvYqzyz7HiRItRcW9JAUlaeLL57XHqULxgUPPwavT9gRM/HJ61Y9I2Rjou38t2Eac9ZO4/O/EpiQ==
X-Received: by 2002:a63:1a4e:: with SMTP id a14mr10316608pgm.376.1570458345657;
        Mon, 07 Oct 2019 07:25:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8sm15883715pgt.40.2019.10.07.07.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:25:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] regulator: fixed: add possibility to enable by
 clock
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <20190910062103.39641-1-philippe.schenker@toradex.com>
 <20190910062103.39641-2-philippe.schenker@toradex.com>
 <20191007132918.GA580@roeck-us.net>
 <3072f9de201a9d06cb0b71018be25f316c3d4435.camel@toradex.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <50190291-7146-5a2d-e4ae-c08c3de553d3@roeck-us.net>
Date:   Mon, 7 Oct 2019 07:25:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3072f9de201a9d06cb0b71018be25f316c3d4435.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 6:57 AM, Philippe Schenker wrote:
> On Mon, 2019-10-07 at 06:29 -0700, Guenter Roeck wrote:
>> On Tue, Sep 10, 2019 at 06:21:15AM +0000, Philippe Schenker wrote:
>>> This commit adds the possibility to choose the compatible
>>> "regulator-fixed-clock" in devicetree.
>>>
>>> This is a special regulator-fixed that has to have a clock, from
>>> which
>>> the regulator gets switched on and off.
>>>
>>> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>>
>> This patch causes a crash in one of my qemu tests (kzm machine with
>> imx_v6_v7_defconfig). Reverting this patch fixes the problem.
>> Crash backtrace and bisect log attached below.
>>
>> Guenter
> 
> Axel Lin sent a patch to fix this NULL pointer issue with my patch
> (Thanks by the way :)). I guess it will help for your issue. Could you
> please test if this patch solves your issue?
> 

Yes, it does. I replied with Tested-by: on the fixup patch.

Thanks,
Guenter
