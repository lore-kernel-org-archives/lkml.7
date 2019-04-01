Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B016C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79FD20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zo3km8hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDAIrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:47:52 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:35242 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDAIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:47:52 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id CBB2F10C2031;
        Mon,  1 Apr 2019 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554108471; bh=iGyhSxira3hBkj54USKjOk4Uq1baPC0mG3vO9jK49Dk=;
        h=From:To:CC:Subject:Date:References:From;
        b=Zo3km8hRX11N2SmBix7n0ti6q8BteT5NX3KqxbR+xQ1jOVSrpzHyL9maD9zQAcUnt
         Sn8EcZ9Slag99pSCQidcUlfwYjTr6CwI2AWBF/DQDksGJaKyIaakpt1Q4uQOMIc7uO
         FgUwsere6p3cp8FXHQke/MgjkS5LlOpVdxPh9BYbzff+5KkEyHSS4fFhB15MOv9l7H
         8/C0kyHbOrbKwHzQEWCCHSK4QJg2VaPFCKtC7zqrXbfFRyVMXTOSSzcOE45ys33nER
         OgWbHw7gZlYRBO4AlUrL1MjHPqAxQfqE8iVDC4kNJwKW90FKOiWVwCw5iE3G+AB2vf
         v2rvAIsIrLHuQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8EDB7A00A1;
        Mon,  1 Apr 2019 08:47:51 +0000 (UTC)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 1 Apr 2019 01:47:51 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 1 Apr 2019 12:47:48 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Subject: Re: [PATCH 4/5] usb: dwc2: get optional clock by
 devm_clk_get_optional()
Thread-Topic: [PATCH 4/5] usb: dwc2: get optional clock by
 devm_clk_get_optional()
Thread-Index: AQHU5tr4DJmsFWRvUkOzwF22vwIhkQ==
Date:   Mon, 1 Apr 2019 08:47:47 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7FDF13@am04wembxa.internal.synopsys.com>
References: <2ec86ffd7de45dabaa7257019a79f1e80751934c.1553937592.git.chunfeng.yun@mediatek.com>
 <e14524a4e6b38140f41e55bb74aedb6599e963e1.1553937592.git.chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/2019 1:28 PM, Chunfeng Yun wrote:=0A=
> Use devm_clk_get_optional() to get optional clock=0A=
> =0A=
> Cc: Minas Harutyunyan <hminas@synopsys.com>=0A=
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>=0A=
=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
>   drivers/usb/dwc2/platform.c | 6 +++---=0A=
>   1 file changed, 3 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c=0A=
> index c0b64d483552..9aa9682a5cd2 100644=0A=
> --- a/drivers/usb/dwc2/platform.c=0A=
> +++ b/drivers/usb/dwc2/platform.c=0A=
> @@ -284,10 +284,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg =
*hsotg)=0A=
>   	}=0A=
>   =0A=
>   	/* Clock */=0A=
> -	hsotg->clk =3D devm_clk_get(hsotg->dev, "otg");=0A=
> +	hsotg->clk =3D devm_clk_get_optional(hsotg->dev, "otg");=0A=
>   	if (IS_ERR(hsotg->clk)) {=0A=
> -		hsotg->clk =3D NULL;=0A=
> -		dev_dbg(hsotg->dev, "cannot get otg clock\n");=0A=
> +		dev_err(hsotg->dev, "cannot get otg clock\n");=0A=
> +		return PTR_ERR(hsotg->clk);=0A=
>   	}=0A=
>   =0A=
>   	/* Regulators */=0A=
> =0A=
=0A=
