Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD9C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0192075C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=aplu.fr header.i=@aplu.fr header.b="rRgtwzvs";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=aplu.fr header.i=@aplu.fr header.b="rRgtwzvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHDTqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 15:46:51 -0400
Received: from eva.aplu.fr ([91.224.149.41]:59988 "EHLO eva.aplu.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfHDTqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 15:46:50 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Aug 2019 15:46:49 EDT
Received: from eva.aplu.fr (localhost [127.0.0.1])
        by eva.aplu.fr (Postfix) with ESMTP id 43C6AF5F;
        Sun,  4 Aug 2019 21:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1564947493; bh=vNPJk4q6+aWce9t4vIvS914bQ5S4c9pYsNe1kT+QSZY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rRgtwzvsJIRYu4fX6S5e3iEbXW/OJwD9xG6HqlGrhNXYXO1rI2xLX3pL3+B1yLap0
         2h8YgqX+N9xR7Vq5iQ42uPQKC6guyIivG7VVcED2u+P+nbEXaG7FFoSNcoFpCX5lQQ
         /N4qLi2T0bUDl0OzhKGK/ObQixQ/HTerPsT84V0O09gU4OdnhVn2KrML4nWFHDT6aQ
         MuGph5MCPOTnitOJ+RI7HbZHwipsdpt2W/2Qcpop6o0z4WmCM9SpY3oYqeO/izwZFj
         m9rowPF9Er8RyF5HnKJhHs24xc4gRBuw22+vx73L3QhbMJG+oJiPsP8B9HQIuPoqXU
         7wDgI0jF1joXm40pfuT1v4GTTSdUmI8YR5FLsUKqpFdUIAo1pd1BWcTsHUVvpGKK7E
         vsqPV2KGU7lKRPkwWV5JNbb3Dy+2iGnQFkttV28IQzvp8fkden/S6tYOwe1InpWEX7
         BCEQIGKGnscN86q464ZA4RNhVQHkV1Q+Lu8KDy+dOyRBxR0tiLkL+DOfvdu7LL12uR
         HghlyRc7fKpuA/MV0+TwjIxdUmsW53NlImBWak+AZG0gWKNUERbSKNvEquRKUurw+d
         PJ2WBfQtetAizAjPRErwOQIWkauL+7pWBC75fiLaQBOJf2oVLAi4snHRJC1vFWAs4W
         w2b+H0tBE3Y2S8e3d+pDLIUs=
Received: from [IPv6:2a03:7220:8081:2901::1003] (unknown [IPv6:2a03:7220:8081:2901::1003])
        by eva.aplu.fr (Postfix) with ESMTPSA id D0295E27;
        Sun,  4 Aug 2019 21:38:12 +0200 (CEST)
Authentication-Results: eva.aplu.fr; dmarc=fail (p=none dis=none) header.from=aplu.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1564947493; bh=vNPJk4q6+aWce9t4vIvS914bQ5S4c9pYsNe1kT+QSZY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rRgtwzvsJIRYu4fX6S5e3iEbXW/OJwD9xG6HqlGrhNXYXO1rI2xLX3pL3+B1yLap0
         2h8YgqX+N9xR7Vq5iQ42uPQKC6guyIivG7VVcED2u+P+nbEXaG7FFoSNcoFpCX5lQQ
         /N4qLi2T0bUDl0OzhKGK/ObQixQ/HTerPsT84V0O09gU4OdnhVn2KrML4nWFHDT6aQ
         MuGph5MCPOTnitOJ+RI7HbZHwipsdpt2W/2Qcpop6o0z4WmCM9SpY3oYqeO/izwZFj
         m9rowPF9Er8RyF5HnKJhHs24xc4gRBuw22+vx73L3QhbMJG+oJiPsP8B9HQIuPoqXU
         7wDgI0jF1joXm40pfuT1v4GTTSdUmI8YR5FLsUKqpFdUIAo1pd1BWcTsHUVvpGKK7E
         vsqPV2KGU7lKRPkwWV5JNbb3Dy+2iGnQFkttV28IQzvp8fkden/S6tYOwe1InpWEX7
         BCEQIGKGnscN86q464ZA4RNhVQHkV1Q+Lu8KDy+dOyRBxR0tiLkL+DOfvdu7LL12uR
         HghlyRc7fKpuA/MV0+TwjIxdUmsW53NlImBWak+AZG0gWKNUERbSKNvEquRKUurw+d
         PJ2WBfQtetAizAjPRErwOQIWkauL+7pWBC75fiLaQBOJf2oVLAi4snHRJC1vFWAs4W
         w2b+H0tBE3Y2S8e3d+pDLIUs=
Subject: Re: [PATCH] ARM: dts: meson8b: add ethernet fifo sizes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20190718093623.23598-1-jbrunet@baylibre.com>
 <CAFBinCBefuCvTL0E_zf=EQDLyTjE5sQD-TkHNj2vQ2UOCsmtkA@mail.gmail.com>
From:   Aymeric <mulx@aplu.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=mulx@aplu.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b5ad180d-af13-cc37-87da-1aa72f10f518@aplu.fr>
Date:   Sun, 4 Aug 2019 21:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBefuCvTL0E_zf=EQDLyTjE5sQD-TkHNj2vQ2UOCsmtkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/07/2019 à 21:56, Martin Blumenstingl a écrit :
> On Thu, Jul 18, 2019 at 11:36 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> If unspecified in DT, the fifo sizes are not automatically detected by
>> the dwmac1000 dma driver and the reported fifo sizes default to 0.
>> Because of this, flow control will be turned off on the device.
>>
>> Add the fifo sizes provided by the datasheet in the SoC in DT so
>> flow control may be enabled if necessary.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> I wonder if this "fixes" some of the performance issues on Odroid-C1
> testing this is now on my TODO-list for the weekend


Good! and maybe that will fix the stability issue I'm seeing when using
the board with a 1 gigabit link! (cf
http://lists.infradead.org/pipermail/linux-amlogic/2019-June/012341.html)

I'll try that asap on my board too :)

Thanks.

-- 
Aymeric
