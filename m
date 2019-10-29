Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF58CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2522087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IpOq05N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJ2Wuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:50:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2Wuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:50:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so96549wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=btcO2kbQzjWCRPlDPp2ih4Wwes8/F4qc3tgqqhv/xx8=;
        b=IpOq05N4KjE4zg1oC5O7H20w97yojnP1buo5WYqtlFfYFF3MNAXbfZtKUaRR23Hev5
         MfdWZAUKaGTCTo5ws7T0XlnPU1wZZYu25+voj37P/E9iHJQjeESf9QY7McgoJIrMwVSn
         +V5iqH6DXsiTXkyN/6pPQ5/cnKEegZm2BKZzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=btcO2kbQzjWCRPlDPp2ih4Wwes8/F4qc3tgqqhv/xx8=;
        b=OlJS59DMQS0XmMz49QSCGyIFhCxzrDypKqPuT+GlJJpdnzqfF8RcGGR4VTKivsLfjD
         CuNYwYKiOAj2b6ZzUfk643Xf1EoqDV6VQzvOH0hySr+u1Gxxz8dWRBijTLALHYA8YGS+
         ftvjTFbp455nXHERoQGb0JHktDvg2LQwgT2en81ZHIhtjcJOF53V4jArP2/d/jWoVdaJ
         A6lFSH85AL6L/LWAjN27un9iP6DNQfM4ySfGYfA0484+8UlD/BO1W/zHrTWn1S02kC5l
         SwMIp+4yPXbOCWkWsafbVhOZ/15VLgkUdBPM4v4zP0iaHG9XoXRAB85XYTR/PdoKo6Yx
         uLIQ==
X-Gm-Message-State: APjAAAWW9oI8RE7nDn4U3U69hdkEBUjQ+GCR34izJyqsvHQejPZ6eYCF
        HE/NpqLEplSfyPiJGR/sbU/J3Q==
X-Google-Smtp-Source: APXvYqwvFUOZBquoDvuOipQqVhVeJTxzpP1yQP9WQ69QCPwyrvLFWnlerZKyvn/QDEJrMiW4edqnQA==
X-Received: by 2002:a05:600c:350:: with SMTP id u16mr5802601wmd.160.1572389444332;
        Tue, 29 Oct 2019 15:50:44 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id x7sm903106wrg.63.2019.10.29.15.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 15:50:43 -0700 (PDT)
Subject: Re: [PATCH v2 20/23] serial: make SERIAL_QE depend on PPC32
To:     Leo Li <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-21-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687CA599C89D46076C9B3518F610@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <42d151c0-bbf9-62a5-5930-70d62418bb84@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 23:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6687CA599C89D46076C9B3518F610@VE1PR04MB6687.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 23.44, Leo Li wrote:
> 
> 
>> -----Original Message-----
>> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Sent: Friday, October 25, 2019 7:41 AM
>> To: Qiang Zhao <qiang.zhao@nxp.com>; Leo Li <leoyang.li@nxp.com>;
>> Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; Scott Wood <oss@buserror.net>; Valentin
>> Longchamp <valentin.longchamp@keymile.com>; Rasmus Villemoes
>> <linux@rasmusvillemoes.dk>; linux-serial@vger.kernel.org
>> Subject: [PATCH v2 20/23] serial: make SERIAL_QE depend on PPC32
>>
>> Currently SERIAL_QE depends on QUICC_ENGINE, which in turn depends on
>> PPC32, so this doesn't add any extra dependency. However, the QUICC
>> Engine IP block also exists on some arm boards, so this serves as preparation
>> for removing the PPC32 dependency from QUICC_ENGINE and build the QE
>> support in drivers/soc/fsl/qe, while preventing allmodconfig/randconfig
>> failures due to SERIAL_QE not being supported yet.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> I think your purpose of this series is to make the QE UART not depending on PPC32.  If it does accomplish that then we don't need this change.

Yeah, as I've said in private, I now have the patches to make this work,
so this patch (and the later one removing it again) are both gone from
my current dev branch. I'll still wait a day or two to allow the ppc
people to respond to the inline/OOL iowrite32be issue, but after that
I'll resend the whole series.

Rasmus
