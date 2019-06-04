Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F5DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389212462B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="b9g0hMic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfFDNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:42:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35838 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727129AbfFDNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:42:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54DfteG014985;
        Tue, 4 Jun 2019 15:41:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=M1ARtYLXli88iDKYpkMnq7TdIq5neeJeurB8IVq3Y8M=;
 b=b9g0hMiciQtFL5y2yOY571VXhnDx2lIN/CI7j+1MLpKo1hrGXeSH497fap8dykQRQigX
 5zC0ptZgKu3QpKYo/dSuF/bywTIktJ0N1OQK6gPHDE+Q4fGPxm/oglW40BWHia+02+Yf
 dJE6nj4/ah802DrCqnbpweoyHTZpFes4l6OGcXBVtO/K86WFtANxHqVvRnyWV1KkCRnp
 3tYasdyHASH/fqtLBw6FH6A9TM0z75LgXQcdIytLXF75wWfGpY4rdDhXcyS6Fam9BFS0
 dpCJjP+1epNmXoLPgp6uCfpf1GEZczW4Z5oDWXEJBAkehXQa8+wiY6i3wlnC/kW6A3Xe YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sunds15t3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 15:41:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6908F70;
        Tue,  4 Jun 2019 13:41:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36F7D2AEA;
        Tue,  4 Jun 2019 13:41:47 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Jun
 2019 15:41:47 +0200
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Tue, 4 Jun 2019 15:41:46 +0200
From:   Erwan LE RAY <erwan.leray@st.com>
To:     Borut Seljak <borut.seljak@t-2.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "\"; linux-arm-kernel\"@lists.infradead.org" 
        <"; linux-arm-kernel"@lists.infradead.org>
Subject: Re: Fwd: [PATCH] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Thread-Topic: Fwd: [PATCH] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Thread-Index: AQHVGr0egfGBr+I5bUuvhxEmcTN9eaaLX30A
Date:   Tue, 4 Jun 2019 13:41:46 +0000
Message-ID: <41dddd5f-5c1c-3346-890a-8018f26ebd49@st.com>
References: <20190604095452.6360-1-borut.seljak@t-2.net>
 <f2a264ac-e334-63b7-18c9-e45cde7bdf95@st.com>
In-Reply-To: <f2a264ac-e334-63b7-18c9-e45cde7bdf95@st.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <524BAF3F71F59E4E93DCC9EEEDA70D24@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borut,

Please add the following line in the commit message (before your=20
sign-off) in a V2 of your patch:

fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware=20
control mode")

I'm OK with the patch itself.

Erwan.


Subject: [PATCH] serial: stm32: fix a recursive locking in
> stm32_config_rs485
> Date: Tue,  4 Jun 2019 11:54:51 +0200
> From: Borut Seljak <borut.seljak@t-2.net>
> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
> <alexandre.torgue@st.com>, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
> borut.seljak@t-2.net, linux-serial@vger.kernel.org, Jiri Slaby
> <jslaby@suse.com>, linux-stm32@st-md-mailman.stormreply.com,
> linux-arm-kernel@lists.infradead.org
>
> Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive lockin=
g.
> Already locked in uart_set_rs485_config.
>
> Signed-off-by: Borut Seljak <borut.seljak@t-2.net>
> ---
>   drivers/tty/serial/stm32-usart.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c
> b/drivers/tty/serial/stm32-usart.c
> index e8d7a7bb4339..da373a465f51 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -107,7 +107,6 @@ static int stm32_config_rs485(struct uart_port *port,
>   	bool over8;
>   	unsigned long flags;
>   -	spin_lock_irqsave(&port->lock, flags);
>   	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>    	port->rs485 =3D *rs485conf;
> @@ -147,7 +146,6 @@ static int stm32_config_rs485(struct uart_port *port,
>   	}
>    	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
> -	spin_unlock_irqrestore(&port->lock, flags);
>    	return 0;
>   }=
