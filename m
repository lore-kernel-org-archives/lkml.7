Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2FCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB72421473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PqoQvzDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfDHKXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:23:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55990 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554718989; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YG2rCSEWGmHwSf0TVaqngGYKpa7LURt8tfGQ+HtEtuE=;
        b=PqoQvzDTSpHGrXTOBPg1fiebnKVNFMbLopVljXEjjz5fDkXbYRggSrJC0k1iYFCyiuy4oZ
        32D00htHkAH1EMMH9DVbJoMnOy7tV04CW9YmVNlcBIIANltjH5bb1ZID5DSfpoo37NL62o
        Xv6/dv6o/UDTEHQdiNGdMIvy4bTv09g=
Date:   Mon, 08 Apr 2019 12:23:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1554718983.1893.0@crapouillou.net>
In-Reply-To: <20190408093824.yzpd7mve6df7lpka@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-4-contact@artur-rojek.eu>
        <20190324153137.04857cdf@archlinux>
        <20190407165234.is66vmnjfc35jnho@earth.universe>
        <1554664077.4322.0@crapouillou.net>
        <20190408093824.yzpd7mve6df7lpka@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 8 avril 2019 =E0 11:38, Sebastian Reichel <sre@kernel.org> a=20
=E9crit :
> Hi Paul,
>=20
> On Sun, Apr 07, 2019 at 09:07:57PM +0200, Paul Cercueil wrote:
>>  Hi Sebastian,
>>=20
>>  Le dim. 7 avril 2019 =E0 18:52, Sebastian Reichel <sre@kernel.org> a=20
>> =E9crit :
>>  > Hi,
>>  >
>>  > On Sun, Mar 24, 2019 at 03:31:37PM +0000, Jonathan Cameron wrote:
>>  > >  On Sat, 23 Mar 2019 18:28:09 +0100
>>  > >  Artur Rojek <contact@artur-rojek.eu> wrote:
>>  > >
>>  > >  > Add a driver for battery present on Ingenic JZ47xx SoCs.
>>  > >  >
>>  > >  > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  > >  The IIO parts look fine to me.
>>  > >  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>  > >
>>  > >  Sebastian, assuming you are happy with this version,
>>  >
>>  > The driver itself looks ok. I'm a bit unhappy, that we already=20
>> have
>>  > jz4740-battery. This driver is much cleaner, but does not yet seem
>>  > to be ready to replace it. Artur Rojek what are your plans=20
>> regarding
>>  > to the existing driver? Is there currently work going on migrating
>>  > JZ47xx to DT?
>>=20
>>  Why do you think it's not ready? Feature-wise, it has everything we
>>  need to replace jz4740-battery, which will be trashed as soon as the
>>  LB60 board code is updated to use the new driver.
>=20
> jz4740-battery has a few features not provided by your driver.
> For example the gpio providing the charging status.

Artur sumitted a separate patchset for this functionality:
https://lkml.org/lkml/2019/2/26/501

> Assuming you plan to trash the old driver soon:
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
>>  We are working on porting the JZ47xx code to devicetree, yes. The
>>  ultimate goal is to completely get rid of
>>  arch/mips/jz4740/board-qi_lb60.c and arch/mips/jz4740/platform.c.
>=20
> Ok, sounds good.
>=20
> -- Sebastian

=

