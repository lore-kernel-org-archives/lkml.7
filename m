Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30934C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053BB2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WMGkKeOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLHOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:14:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36091 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:14:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so16557633lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=moBLNgsFkEFILNTGmzFVRskFLWF0bywiqBaR+demKl0=;
        b=WMGkKeOZSZv4nK3kYqjUDbJgm6OIX8/Pp5ul5RcMLv8HRndoSur1Gj5yp8uTwr6viK
         8pIe3W5+rvA5uDSH0I+6oPAWY7C94jtjF9Ot+31Ik/dH+uPG7MB8lgizP93vIMt3xMc5
         N+J/WomRl5rVfra1rtwsIIzgkQZcJ0HySeqwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moBLNgsFkEFILNTGmzFVRskFLWF0bywiqBaR+demKl0=;
        b=U1zDpb92FhzME7oiFEt5kOSPOVkBVra+u2/kYvEGerLCVh+UWEsu6EhV1vwSdF2H9r
         it9qXIoCN6vpSImqpefnAI0lkezZQmxs0gYoTs+CyUHudwmqS52aDh6KBa/zfDHpLkyh
         8urjw21Dh/nYX9NyHvXfJh0JnarGthUdRpzypLL/kbEp2EcpUC7xhjFOv6LbH9LKwF1j
         Vi8Bv1rTFOxi4V6nLAmnyoBN8EKAs/F6mFoNEvNgglw4sIs2u7AsCw4OjwWCbbPcavXE
         q9wpv1qKjpnxXpLAo54PI6VcsAq8EWp8fWRnj9P7HHI5cEBe0GRpK/fBQSq1nQ83/Htj
         n5lA==
X-Gm-Message-State: APjAAAWL04IlIIdhYyIQSE58VmmzGYcJtX3he1FYj8+25ExOYatYHJ3q
        HPMukrMp1j46mxg38v74JcTeLA==
X-Google-Smtp-Source: APXvYqyGJCHfIoWOsBaNjhwiw9M0OJ8bZPYtuCumKkdWcGPrH+aj9AtA3dwPCKUzoK1SUKCQ1cmZMA==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr2947819ljj.25.1573542862167;
        Mon, 11 Nov 2019 23:14:22 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p193sm12765748lfa.18.2019.11.11.23.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 23:14:21 -0800 (PST)
Subject: Re: [PATCH v4 04/47] soc: fsl: qe: introduce qe_io{read,write}*
 wrappers
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-5-linux@rasmusvillemoes.dk>
 <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e37d24c5-6d4f-c8bf-1c38-f3e8b8e85eeb@rasmusvillemoes.dk>
Date:   Tue, 12 Nov 2019 08:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 06.17, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> The QUICC engine drivers use the powerpc-specific out_be32() etc. In
>> order to allow those drivers to build for other architectures, those
>> must be replaced by iowrite32be(). However, on powerpc, out_be32() is
>> a simple inline function while iowrite32be() is out-of-line. So in
>> order not to introduce a performance regression on powerpc when making
>> the drivers work on other architectures, introduce qe_io* helpers.
> 
> Isn't it also true that iowrite32be() assumes a little-endian platform
> and always does a byte swap?
> 

No. You're probably thinking of the implementation in lib/iomap.c where
one has

#define mmio_read32be(addr) swab32(readl(addr))
unsigned int ioread32be(void __iomem *addr)
{
        IO_COND(addr, return pio_read32be(port), return
mmio_read32be(addr));
        return 0xffffffff;
}


#define mmio_write32be(val,port) writel(swab32(val),port)
void iowrite32be(u32 val, void __iomem *addr)
{
        IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
}

but that's because readl and writel by definition work on little-endian
registers. I.e., on a BE platform, the readl and writel implementation
must themselves contain a swab, so the above would end up doing two
swabs on a BE platform.

(On PPC, there's a separate definition of mmio_read32be, namely
writel_be, which in turn does a out_be32, so on PPC that doesn't
actually end up doing two swabs).

So ioread32be etc. have well-defined semantics: access a big-endian
register and return the result in native endianness.
