Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAFE206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fmnpwAJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKNIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:55:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34994 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:55:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so5797164ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Yha/Jq+ZFQjtGyiO5rUc6KyiAaRy2IYHugA0slnRKs=;
        b=fmnpwAJEY8GNrGE9anOHfwVKoipdKrgLR1iOYFzBsD9kaxaEe0UKTTvstTn0CQD5Jv
         kBlb3kU6U71mmLvUAx8y5bzM1W5GYgs91XI2PEJVPdlaoXjQUYsmi0CUn53ZT04RkXtj
         OMIsyIx4Q3flxHoYZKaCn7Qh8bHpnYYK1XmLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Yha/Jq+ZFQjtGyiO5rUc6KyiAaRy2IYHugA0slnRKs=;
        b=eU5N3yw3G3hvZjQlH0/X7WFmmGk/FDfeW5T6lHOImpUUycildgvkE92vCfmYCL1+GY
         1D90m6zEuo04O/gixaEgKNGbeqdJDZx64qJRTOIaNj/RjISNV3EcTLjaEwHdS4WtVzGi
         FR6nmQZf/OKe9+zC/8ArCzCt5EL1D0Y3OuxrAF4woCrkgELufRN4SzcaYpoREvi1CwIQ
         MAP/MxUjSNgXSde3xGjrGiGKN7pvlIFqL3FuvuJLkUHChydKqZ54ont2ubqnElPavQB8
         8z2K/hhhqML+oGDErwvHAum2ZDLCXraHQ0uxoc7xCbUzipR+3HnVYNfTvv4ksWegazWE
         UBcQ==
X-Gm-Message-State: APjAAAVU8TQtRhcAFJ2BY/fVtsOn3MR8Jz0QYXV5rVyESfNI5yMJcW6u
        HujPN9VOn88LSQ1X6PD3YnAHEg==
X-Google-Smtp-Source: APXvYqzqg3aGYow1vlq3tQPQhPBivdAM8jYV30pHK5iJmyQtydaEA/+ygPKZ92IqgkK8EwdBreBjrQ==
X-Received: by 2002:a2e:890e:: with SMTP id d14mr5652232lji.6.1573721725489;
        Thu, 14 Nov 2019 00:55:25 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e14sm1984603ljb.75.2019.11.14.00.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:55:24 -0800 (PST)
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
 <e37d24c5-6d4f-c8bf-1c38-f3e8b8e85eeb@rasmusvillemoes.dk>
 <38d87cf8-5945-61d7-80a7-c8374cbe729b@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4592eea6-1ba6-5c08-0500-6ccf030d7929@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 09:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38d87cf8-5945-61d7-80a7-c8374cbe729b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 06.08, Timur Tabi wrote:
> On 11/12/19 1:14 AM, Rasmus Villemoes wrote:
>> but that's because readl and writel by definition work on little-endian
>> registers. I.e., on a BE platform, the readl and writel implementation
>> must themselves contain a swab, so the above would end up doing two
>> swabs on a BE platform.
> 
> Do you know whether the compiler optimizes-out the double swab?
>

Depends. It's almost impossible to figure out how swab32() is defined,
so how much visibility gcc has into how it works is hard to say. But a
further complication is that the arch may not have, say (simplifying
somewhat)

#define readl(x) swab32(*(volatile u32*)x)

but instead have readl implemented as inline asm which includes the
byteswap. PPC being a case in point, where the readl is in_le32 which is
done with a lwbrx instruction, and certainly gcc couldn't in any way
change a swab32(asm("lwbrx")) into asm("lwz"). But ppc defines its own
mmio_read32be, so that's not an issue.

>> (On PPC, there's a separate definition of mmio_read32be, namely
>> writel_be, which in turn does a out_be32, so on PPC that doesn't
>> actually end up doing two swabs).
>>
>> So ioread32be etc. have well-defined semantics: access a big-endian
>> register and return the result in native endianness.
> 
> It seems weird that there aren't any cross-arch lightweight
> endian-specific I/O accessors.

Agreed, but I'm really not prepared for trying to go down that rabbit
hole again.

Rasmus
