Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2AC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB10208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cXPQ2Qf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfGMA1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:27:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44027 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfGMA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:27:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so7752519qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/b1FhYxov1no8AIqKnTicBtEIZykZHc9EwDW+pUQyt0=;
        b=cXPQ2Qf1eeSNA2EGxwYad+zRzfzIhNuRdIqiEzoYXeH2TemMl0NTmLV4X/TQ+izKoW
         uxAWH5D1ie7TtLCRI/OJNORV/fB/1w+W9N8QZvyRIkuQo0GpNmQv4cpi+js8WQ+7Xu6n
         zUVOTJbLjqT7MM0zDbvrOIkjplJQnBiAkCB7S2Au16N+gUOkQQmvZ4kQqnze8OJ8qgxp
         2NPv/OR+jRLlTLe8mt0pm3LQVzikg7xES8qOgoI0VNTK7sktDMgAN/1Jod6vFjsU5BXh
         TAFHbvLi0fsN/qSmuk8RGwzCtUyOwBPOSJXKGsSkxkJcnjn38I4IXf9EVPGf1rJxFcaD
         0JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/b1FhYxov1no8AIqKnTicBtEIZykZHc9EwDW+pUQyt0=;
        b=RgdvDuVe/+ZMiczcpdrw6eUBvsGk8dn/FSikPleYIASePOkOqtEWw/wHV3+CUMZbDX
         8Ut5owJXjJeE+p6X+7KulFbEyO4dc8lq0zBVvgK8pRCKBx5OJ27jjcGObg3RGSgZvfi3
         kGMSayInJy2cHwJZjrJzfQ4xLmkHVZGzXsbjfp6FWzL8AB7uqlZGKe9yehbvPimi7Q5q
         QrqGAkER+oDTsajf3zYcGduzUFcJkHn36vXOJ3rrnesKSxnhFauXp2T/0UkCmN6mmHRH
         vFdD0ENPgZq7ZpWuEuXDjWoikZuXvR7R1nyaNfuk7KXemMJ8yyHmpslNndzrdcYMDcLm
         vpBA==
X-Gm-Message-State: APjAAAWKA32FXlGQkHs7x62dtNP8EjfiEoJ9DBbDr4xOEmkglpBXaVtv
        pSfRvbUGk6twqdyeZyZED9HQjw==
X-Google-Smtp-Source: APXvYqxe5GNimyT2mRnWHw7NTML9DguxquzhqvGrNJEFRydui+CrARbyZoVGFEouI3krFFd9HhaKKA==
X-Received: by 2002:a37:a692:: with SMTP id p140mr8197020qke.432.1562977631518;
        Fri, 12 Jul 2019 17:27:11 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d31sm5467712qta.39.2019.07.12.17.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 17:27:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190712.154606.493382088615011132.davem@davemloft.net>
Date:   Fri, 12 Jul 2019 20:27:09 -0400
Cc:     sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
 <20190712.154606.493382088615011132.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2019, at 6:46 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Qian Cai <cai@lca.pw>
> Date: Fri, 12 Jul 2019 15:23:21 -0400
>=20
>> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
>> problem for the be2net driver as "rx_frag_size" could be a module
>> parameter that can be changed while loading the module.
>=20
> Why is this a problem?

Well, for example, if rx_frag_size was set to 8096 when loading the =
module, the kernel has already used the default value 2048 during =
compilation time.

>=20
>> That commit checks __builtin_constant_p() first in get_order() which
>> cause "adapter->big_page_size" to be assigned a value based on the
>> the default "rx_frag_size" value at the compilation time. It also
>> generate a compilation warning,
>=20
> rx_frag_size is not a constant, therefore the __builtin_constant_p()
> test should not pass.
>=20
> This explanation doesn't seem valid.

Actually, GCC would consider it a const with -O2 optimized level because =
it found that it was never modified and it does not understand it is a =
module parameter. Considering the following code.

# cat const.c=20
#include <stdio.h>

static int a =3D 1;

int main(void)
{
	if (__builtin_constant_p(a))
		printf("a is a const.\n");

	return 0;
}

# gcc -O2 const.c -o const

# ./const=20
a is a const.=
