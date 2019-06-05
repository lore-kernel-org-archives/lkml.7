Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4059C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BB1206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="T+xYyd3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFEJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:53:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbfFEJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:53:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x559qAUa006990;
        Wed, 5 Jun 2019 11:52:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=QAM96c5x86qtvrcwPA8iFjsdl0keQYZLN5l0wUdrcH4=;
 b=T+xYyd3lN4+QwhVqtmPs285cdb1IwzOyokvWfCgDUhtMnnleJ+BuThjGe8BQC2qPG8gm
 Xlg2+3138kxiOTKGnX9wFhkTKzzPINpNhcBeGUIuubEwd+tUOMNXByaVLtlhBFff4gvN
 5s7Rpk9bXV14j/KHy4i9OJklJregeb2wB56k46ilh2evMQUZxxoTAShYL4aqyjcVtKKK
 4gXY0TRZjhlLKZfOy4n2SGJDuL8CmofQInzBaCGAf6Cmn1BAaQHO7nvzi7GifL+O0JdY
 IoEkKl/8Gh2DT/4dQcbq6vqrjRgcCOnRYftv3OR2pQGbtK0FTXGKSro921+UJbN6tICE tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sunds5v86-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Jun 2019 11:52:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8974334;
        Wed,  5 Jun 2019 09:52:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 608C425FA;
        Wed,  5 Jun 2019 09:52:27 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 5 Jun
 2019 11:52:27 +0200
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Wed, 5 Jun 2019 11:52:27 +0200
From:   Erwan LE RAY <erwan.leray@st.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: Fwd: [PATCH -next] serial: stm32: Make stm32_get_databits static
Thread-Topic: Fwd: [PATCH -next] serial: stm32: Make stm32_get_databits static
Thread-Index: AQHVG22K0BtbDefYo066WH7MNa5zfKaMsGAA
Date:   Wed, 5 Jun 2019 09:52:27 +0000
Message-ID: <1eb3edf6-054d-be59-340c-312f57815912@st.com>
References: <20190528090449.22868-1-yuehaibing@huawei.com>
 <e7a74cb7-fd9f-89d2-8314-5e216eae2d13@st.com>
In-Reply-To: <e7a74cb7-fd9f-89d2-8314-5e216eae2d13@st.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BB60DC7AEE09EE43BA33DB5BCAA320CD@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK for me.

Erwan.


On 6/5/19 9:08 AM, Fabrice Gasnier wrote:
> Un autre qu'on avait pas vu...
>
>
> -------- Forwarded Message --------
> Subject: [PATCH -next] serial: stm32: Make stm32_get_databits static
> Date: Tue, 28 May 2019 17:04:49 +0800
> From: YueHaibing <yuehaibing@huawei.com>
> To: gregkh@linuxfoundation.org, jslaby@suse.com,
> mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
> CC: YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org,
> linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
> linux-stm32@st-md-mailman.stormreply.com
>
> Fix sparse warning:
>
> drivers/tty/serial/stm32-usart.c:603:14: warning:
>   symbol 'stm32_get_databits' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/tty/serial/stm32-usart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c
> b/drivers/tty/serial/stm32-usart.c
> index 9c2b04e..4517f2b 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -600,7 +600,7 @@ static void stm32_shutdown(struct uart_port *port)
>   	free_irq(port->irq, port);
>   }
>   -unsigned int stm32_get_databits(struct ktermios *termios)
> +static unsigned int stm32_get_databits(struct ktermios *termios)
>   {
>   	unsigned int bits;
>   -- 2.7.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel=
