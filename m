Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F1C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C29206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SRkgLFaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfKFH4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:56:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40217 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfKFH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:56:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so18386861ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xweVifWZ/YqguIkP3wRFBeRke8fVrDKetgEyLrXZK4A=;
        b=SRkgLFaa63C9qmcFdcf/s/KAPgAENphVcMUoM+vz9BIEzbf8c06I0Y1Hb5KXR42LXI
         G+i3eaIvU5rZa0kOrwSOnHxSXGm7OyVoMHx/peFrsf/OMV0cjkz5laiG3DlkVHfPCESn
         Pq9m25d73Eymy1sG4V505XAYT460OEuZk3NdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xweVifWZ/YqguIkP3wRFBeRke8fVrDKetgEyLrXZK4A=;
        b=Q4TWrz4uXVgjBd/dd06RY+9RhBFVNPJeb9fRlvvyL/BQ/uV7QtCo5+MpggJVyXxuoj
         QbGsoDv7S9397rin0Hk72CS9x0gaIanP7HH9AD7FaI3HrM1P+5/EhsLxA5kUblTsMNPs
         1LUvJ26jB3BgKllXlHqET1OOEDPUgpajRvjPX+8YcTbLd4LRsd88N3UuhccB1Kn/h0h6
         XH2iIacsvKXGBzah51SHQmKOudIlQaLUMDNBkpiIJuPKz14+lxHPn/jn41nYkmEkoc+o
         2JeflPACs6y2Hlb3CgczcMn02qNl4RtUMjwenzG2JlRzYDyNiCPoYVM6VNi7v/pardQH
         NRmA==
X-Gm-Message-State: APjAAAXyyTXNLjSuP3qRA3M/gPQq0Gwg8M4IB3CgAxGX60JQg/f7s+AI
        T4/u2NEJDR5XQHMaj8vEX7EVDA==
X-Google-Smtp-Source: APXvYqx0UMAxK46d8rifJbbO0Iei8z4btT+kJJezWPrwvpREfmjRSXZQf51n+CDfByMCvypaqmMFbg==
X-Received: by 2002:a05:651c:105:: with SMTP id a5mr819866ljb.45.1573026973653;
        Tue, 05 Nov 2019 23:56:13 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d27sm11001361lfb.3.2019.11.05.23.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 23:56:12 -0800 (PST)
Subject: Re: [PATCH v3 35/36] net/wan: make FSL_UCC_HDLC explicitly depend on
 PPC32
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
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
 <24ea27b6-adea-cc74-f480-b68de163f531@rasmusvillemoes.dk>
 <VE1PR04MB67686E14A4E0D33C77B43EA6917E0@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d8bf1d7f-b4c6-ef92-9fac-a3668ff37d8d@rasmusvillemoes.dk>
Date:   Wed, 6 Nov 2019 08:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB67686E14A4E0D33C77B43EA6917E0@VE1PR04MB6768.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2019 07.16, Qiang Zhao wrote:

> 
> I tested your v3 patches on ls1043ardb which is arm64 for fsl_ucc_hdlc, it can work,
> Only it will put a compile warning, I also made a patch to fix it.
> I can send a patch to remove PPC32 dependency when I send my patch to support ARM64.
> Or I add my patch in your patchset.

Please send your patch (without whatever Kconfig hunk you needed to add)
with a proper changelog etc. If it looks reasonable (to me, reviewers of
the whole thing obviously also need to agree), I'll include it in my
series and drop adding the PPC32 addition to FSL_UCC_HDLC. Otherwise
I'll keep that and then you can later drop the PPC32 dependency.

Rasmus

