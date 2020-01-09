Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F7F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JdbcOcAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgAIS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:26:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33036 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgAIS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578594385; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7mnA1zFIIsxMJSYYMGqbzDcRJ8RmSW6DGKrWFZCfvA=;
        b=JdbcOcAY3g06/e5/0YsGPLkQVsnDdF/aKwC7FJWvdZbsmeFgwOhT+626zzRRxXFe+Fnjyt
        efYxXjOC+VRe0vkxDm55lDNbPdcKjmyJXSdzoZ1BNTgPOyu+0WYDlWCzrB76Rzyk2kIUTe
        Ke150XU3SJRfit7WG159rmlllHxumyk=
Date:   Thu, 09 Jan 2020 15:26:09 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1578594369.3.0@crapouillou.net>
In-Reply-To: <87a76wln67.fsf@nanos.tec.linutronix.de>
References: <20200107010630.954648-1-paul@crapouillou.net>
        <20200107010630.954648-2-paul@crapouillou.net>
        <87a76wln67.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


Le jeu., janv. 9, 2020 at 15:28, Thomas Gleixner <tglx@linutronix.de> a=20
=E9crit :
> Paul Cercueil <paul@crapouillou.net> writes:
>>  +static u64 notrace ingenic_ost_clocksource_read64(struct=20
>> clocksource *cs)
>>  +{
>>  +	u32 val1, val2;
>>  +	u64 count, recount;
>>  +	s64 diff;
>>  +
>>  +	/*
>>  +	 * The buffering of the upper 32 bits of the timer prevents wrong
>>  +	 * results from the bottom 32 bits overflowing due to the timer=20
>> ticking
>>  +	 * along. However, it does not prevent wrong results from=20
>> simultaneous
>>  +	 * reads of the timer, which could reset the buffer mid-read.
>>  +	 * Since this kind of wrong read can happen only when the bottom=20
>> bits
>>  +	 * overflow, there will be minutes between wrong reads, so if we=20
>> read
>>  +	 * twice in succession, at least one of the reads will be correct.
>>  +	 */
>>  +
>>  +	/* Bypass the regmap here as we must return as soon as possible */
>=20
> I have a hard time to understand this comment. "Bypass the regmap ..."
> and then use a regmap function?

Ah, sorry, it's a leftover from a previous version of the patch. It=20
used to bypass the regmap in order to complete as fast as possible.

>=20
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
>>  +	count =3D (u64)val1 | (u64)val2 << 32;
>>  +
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
>>  +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
>>  +	recount =3D (u64)val1 | (u64)val2 << 32;
>>  +
>>  +	/*
>>  +	 * A wrong read will produce a result that is 1<<32 too high: the=20
>> bottom
>>  +	 * part from before overflow and the upper part from after=20
>> overflow.
>>  +	 * Therefore, the lower value of the two reads is the correct=20
>> value.
>>  +	 */
>>  +
>>  +	diff =3D (s64)(recount - count);
>>  +	if (unlikely(diff < 0))
>>  +		count =3D recount;
>=20
> Is this really the right approach here? What is the 64bit readout=20
> buying
> you?
>=20
> The timekeeping code can handle a 32bit counter perfectly fine and the
> only advantage you get is that your maximum possible idle time will be
> longer with a 64bit counter.
>=20
> But is that really worth the overhead of four MMIO reads versus one=20
> in a
> hotpath?

The timer is 64-bit so I thought it made sense to register it as such.=20
Using it as just a 32-bit counter sounds better indeed.

Thanks,
-Paul


=

