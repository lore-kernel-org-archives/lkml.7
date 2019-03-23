Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9118C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD1218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iWG9dSI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfCWDdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:33:44 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33048 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCWDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:33:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id DA2F5C1D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vYbF6XQdNWy1 for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:33:41 -0500 (CDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 7CB129CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:33:41 -0500 (CDT)
Received: by mail-pf1-f198.google.com with SMTP id h69so4124649pfd.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MP/ZfuUtg9Qw+K2gM355w5gdyRp2wQZJ2WVW2jC8I28=;
        b=iWG9dSI61QaUwQVNa76Mb0Ea2jDJfQKspZBwqux+oagWTG6fF/19R4AK4gwd36cbgU
         aZ/l8x99qgaxp9qab3fkfWGuinu1omML20kBhL4Bx09/U+8CfnHhUv7ib5pevwTyPYKV
         BjCVJfX2TpAOcUKcGike6FkKXU5l8I3f7bJ8zq4yGjDQklrT7DfQ7uU7JIHwKVN1qpyF
         7weiCwCklVkF56k6kFYeWf7ml58u+2S2oa+BEFSyhUmk3JTt70T+/nkAIm8QO9lLIXms
         7ltGFH8ha5qN+aL9LD9vjjH5OlpXXKizTungDaZxZVL6Y8PcT2I9eZQT/lUsxBhU9qO4
         qXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MP/ZfuUtg9Qw+K2gM355w5gdyRp2wQZJ2WVW2jC8I28=;
        b=CEzHtfj9e4hvrZIeZFfJdsBKG4U9iAuMMeksITMSwHDMrhhoANw1cQWMLK6aYeqdn4
         Fx+QjrsoCycspwrRIIt0fZT1lEsLOHyVl/5HsSvirEYlEnI3nRtU0jK7CWweEq8VbYnv
         8FJv0bbZ+9OyTuNjgGVg7i2Bc6Cojdy8LgpuB7FvJXCAnCezWoG94gT6pR4fNx4aeYnd
         m/mkKkGGujvM4t8J3s6VKTHKD3uK5HupoNp6il7CWQCW7GYgAyYciDOepkNzddn/3rxe
         GqQJ2UJ5Q7SSJZHWxYDT+6rqUrdH9b040LsZby5WcZQE8SIl4nndztOgA/uemfi8Gh1P
         mQKg==
X-Gm-Message-State: APjAAAXZvtp8cRgeHg0PKZkEbfjWlBLaK5pjTqgb/RAEc+QbU4cpMEyl
        4dEREykbW+u969riKSl71FhqFZBMagkKOh0gSMvcWlknMezHG0uEV2CfE3faLxNH6mDBedbAQdW
        MVlAZWFGhQ09X/KfKtBBzG5X8Z7zJ
X-Received: by 2002:a17:902:526:: with SMTP id 35mr12306733plf.276.1553312020905;
        Fri, 22 Mar 2019 20:33:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+adO/Vo3J5wOj+041RwzCLIExYdcLwjYFLgsMnIzoVfFm6EL0sFsXD8L9ZH+kcKsvpxOd6Q==
X-Received: by 2002:a17:902:526:: with SMTP id 35mr12306729plf.276.1553312020706;
        Fri, 22 Mar 2019 20:33:40 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id j8sm10964918pff.183.2019.03.22.20.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:33:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: ocelot_board: fix a NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <d61f3d5e-6f8c-5a44-447a-7fc96cb65037@gmail.com>
Date:   Fri, 22 Mar 2019 22:33:40 -0500
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        pakki001@umn.edu,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <62D7010C-B276-4D16-A28F-DA28B49CF663@umn.edu>
References: <20190311063632.21111-1-kjlu@umn.edu>
 <20190311102600.GB1637@piout.net>
 <d61f3d5e-6f8c-5a44-447a-7fc96cb65037@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 9:14 AM, Eric Dumazet <eric.dumazet@gmail.com> =
wrote:
>=20
>=20
>=20
> On 03/11/2019 03:26 AM, Alexandre Belloni wrote:
>> On 11/03/2019 01:36:32-0500, Kangjie Lu wrote:
>>> In case devm_kcalloc fails, the fix returns -ENOMEM to avoid
>>> NULL pointer dereference.
>>>=20
>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>=20
>=20
> A proper error path is needed to avoid memory leaks.

Which objects require free specifically? The memory allocated with=20
devm_kzalloc() is freed automatically. No need to explicitly free it=20
again.

-Kangjie

>=20
>>> ---
>>> drivers/net/ethernet/mscc/ocelot_board.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c =
b/drivers/net/ethernet/mscc/ocelot_board.c
>>> index e7f90101d2e0..af68abf1632a 100644
>>> --- a/drivers/net/ethernet/mscc/ocelot_board.c
>>> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
>>> @@ -256,6 +256,8 @@ static int mscc_ocelot_probe(struct =
platform_device *pdev)
>>>=20
>>> 	ocelot->ports =3D devm_kcalloc(&pdev->dev, =
ocelot->num_phys_ports,
>>> 				     sizeof(struct ocelot_port *), =
GFP_KERNEL);
>>> +	if (!ocelot->ports)
>>> +		return -ENOMEM;
>>>=20
>>> 	INIT_LIST_HEAD(&ocelot->multicast);
>>> 	ocelot_init(ocelot);
>>> --=20
>>> 2.17.1
>>>=20
>>=20

