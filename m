Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC97F218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CRqPRRvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKDIiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:38:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37901 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:38:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so11586679lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAvLvQnBn2etU9QWbHrMgTtrty/V9iZf2pUKjOUNug8=;
        b=CRqPRRvMc4CiyGWwN0n+HhobnmdoLfjL+0AzezW7ETOIFz5sHfNHH5JNGG6YI+/403
         MsQNEzWz0NSvbA0uWvsbCgqAT3tGi1qsOO0oSW4TRw1r9cIbKDUlQ9wzYhXtlrQDdRZs
         PV5CVnB5sUcQ4tEXqmk5O+Wt9y6sGHLcWmnV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAvLvQnBn2etU9QWbHrMgTtrty/V9iZf2pUKjOUNug8=;
        b=UkkXb6DVtBDr7auT5cLOxJ2waIq128yG7W8sFvYXRgleaVJlSU1umbrpuUnMLLidUV
         pTqdFp2vUoL52/zzEPKrZZ/z1BNh8oUdMXFkxNRg8jMILUT9QZla6FWOr7utJrzV/aL2
         5khqTVUmsOXOwUF+hIpvdKMvr5HfiWECdpUHJs+K8ZakTgwlgtmxLaoiX3b8f5mV6RGA
         Sq4LakQc4xpFWv7vRqNlyPTiSLuDLLAClMJtaw4BPekccdAUmY4fvjzuE0U40K4ABpbH
         iVICfwRoTFSDIb576IsroiHjAl+a177q9I6u6/7dA1r+lK+oCDDWjPbSbjW7GK17OY+/
         J0WA==
X-Gm-Message-State: APjAAAV6HUcCvhH4U/d6jBjcKC6E89Jh/5eyuV+qTF3pGsHgcQZrbH9a
        /JzrLff6sOiVjiE0kPdpX2QC7A==
X-Google-Smtp-Source: APXvYqzGJdH19phuRzqBS1a9feyj40vilK5OuKVvLX9t8OwmcbQ9em9T2maQ71sFqH2o8LzrUCr3gg==
X-Received: by 2002:ac2:549a:: with SMTP id t26mr15512173lfk.25.1572856688914;
        Mon, 04 Nov 2019 00:38:08 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u11sm8744096lfq.54.2019.11.04.00.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 00:38:08 -0800 (PST)
Subject: Re: [PATCH v3 35/36] net/wan: make FSL_UCC_HDLC explicitly depend on
 PPC32
To:     Leo Li <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-36-linux@rasmusvillemoes.dk>
 <4e2ac670-2bf4-fb47-2130-c0120bcf0111@c-s.fr>
 <VE1PR04MB6687D4620E32176BDC120DBA8F620@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <24ea27b6-adea-cc74-f480-b68de163f531@rasmusvillemoes.dk>
Date:   Mon, 4 Nov 2019 09:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6687D4620E32176BDC120DBA8F620@VE1PR04MB6687.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 23.31, Leo Li wrote:
> 
> 
>> -----Original Message-----
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>> Sent: Friday, November 1, 2019 11:30 AM
>> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>; Qiang Zhao
>> <qiang.zhao@nxp.com>; Leo Li <leoyang.li@nxp.com>
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; Scott Wood <oss@buserror.net>;
>> netdev@vger.kernel.org
>> Subject: Re: [PATCH v3 35/36] net/wan: make FSL_UCC_HDLC explicitly
>> depend on PPC32
>>
>>
>>
>> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>>> Currently, FSL_UCC_HDLC depends on QUICC_ENGINE, which in turn
>> depends
>>> on PPC32. As preparation for removing the latter and thus allowing the
>>> core QE code to be built for other architectures, make FSL_UCC_HDLC
>>> explicitly depend on PPC32.
>>
>> Is that really powerpc specific ? Can't the ARM QE perform HDLC on UCC ?

I think the driver would build on ARM. Whether it works I don't know. I
know it does not build on 64 bit hosts (see kbuild report for v2,23/23).

> No.  Actually the HDLC and TDM are the major reason to integrate a QE on the ARM based Layerscape SoCs.

[citation needed].

> Since Rasmus doesn't have the hardware to test this feature Qiang Zhao probably can help verify the functionality of TDM and we can drop this patch.

No, this patch cannot be dropped. Please see the kbuild complaints for
v2,23/23 about use of IS_ERR_VALUE on not-sizeof(long) entities. I see
kbuild has complained about the same thing for v3 since apparently the
same thing appears in ucc_slow.c. So I'll fix that.

Moreover, as you say and know, I do not have the hardware to test it, so
I'm not going to even attempt to fix up fsl_ucc_hdlc.c. If Qiang Zhao or
somebody else can verify that it works just fine on ARM and fixes the
allmodconfig problem(s), he/she is more than welcome to sign off on a
patch that removes the CONFIG_PPC32 dependency or replaces it with
something else.

Rasmus
