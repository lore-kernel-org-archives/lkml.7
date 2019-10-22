Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7BC47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41EC21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="h/3Uo75y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJVKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:17:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33560 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:17:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so16555494ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPQHJmcEnXeH/iiZIyJlOmriHnC0d9InpVAG+IS31RU=;
        b=h/3Uo75yRFQRRe+mjVmd8cMUmSai80wzLccdR09BlGw6HnocUgAczaz4IgYFRWgG3H
         OJdRbFB9Mz9fLShfMfIQz/v973qofYhFRWlTSouwX+s3dVq2XD/i9xdJL7HBCWbL6ait
         GeYoY67YnMUOYKMguf97VQFeB/gYvg8+cWRaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPQHJmcEnXeH/iiZIyJlOmriHnC0d9InpVAG+IS31RU=;
        b=l2HwIxj7FX7ZgXDAJmGJ96Bb88N2BD351PU6jXE+DP9wdsl4Upsb34d2GwWbQcOUhf
         ZB0EQKWS8SHnGh44YMJaDl9vkAkKDivHe4WmRiKATPzX3gIr/P/VCzA5TR6W8o1Lb6An
         TPaAe4idxcY0fBuAqAe/any/uBt0jSO4FQZ0u0Duwz3Wd0dqOvkZOEf2St50NknVPAV8
         kYTUGe16sjR8/mZdQVoBDoJRtEX4AL67Qo6H2tP5RKSBTSMQ5mYNVfiJa0V+blQhl7WS
         +AMS1SF+nHkB0jMEXs7p0FbHihujPaJclsPn9CiF5MjFdYfNm9NGaH6Yjf3Cccc3e617
         3zjw==
X-Gm-Message-State: APjAAAW5ETRE4y8Uie5WiTYYooxSpP2zNSa7YAzYI3JzD6yrAcDgONdG
        iqTF7kMtJ7akd+QDZuCOJ5GPGg==
X-Google-Smtp-Source: APXvYqwrLO6yXk3q5+ZZIbKEWNFhquBa+3kRuXdGYBzSGzi6Tc86djtM/ixn33Sd74ROetfVBAw3WQ==
X-Received: by 2002:a2e:8716:: with SMTP id m22mr10796456lji.102.1571739466229;
        Tue, 22 Oct 2019 03:17:46 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b19sm7866434lji.41.2019.10.22.03.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:17:45 -0700 (PDT)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
 <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
 <679bf33b-8c05-b77a-0cb2-d79dc5bfbe75@rasmusvillemoes.dk>
 <CADRPPNSiMUy77Dhxjg03sHDxyZzWf_BP8a5+fCncbynyO_cNGg@mail.gmail.com>
 <VE1PR04MB676825D5709839AEF75ED44C91680@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <43033011-1a2a-dea3-e3c9-75895f997407@rasmusvillemoes.dk>
Date:   Tue, 22 Oct 2019 12:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB676825D5709839AEF75ED44C91680@VE1PR04MB6768.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2019 04.24, Qiang Zhao wrote:
> On Mon, Oct 22, 2019 at 6:11 AM Leo Li wrote

>> Right.  I'm really interested in getting this applied to my tree and make it
>> upstream.  Zhao Qiang, can you help to review Rasmus's patches and
>> comment?
> 
> As you know, I maintained a similar patchset removing PPC, and someone told me qe_ic should moved into drivers/irqchip/.
> I also thought qe_ic is a interrupt control driver, should be moved into dir irqchip.

Yes, and I also plan to do that at some point. However, that's
orthogonal to making the driver build on ARM, so I don't want to mix the
two. Making it usable on ARM is my/our priority currently.

I'd appreciate your input on my patches.

Rasmus

