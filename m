Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30BC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364FB20880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ReDrWcAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDNPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:42:29 -0400
Received: from mout.web.de ([217.72.192.78]:51565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555256536;
        bh=VdRkU4BTv9kiZuRKfCWVN8ahcbVA5Frk2OriueC2iAs=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=ReDrWcAV8F2rItjjlavPcmjkiossjexnEUOJXCUT1itViu4wiQmq7L98uRZJBa5mu
         fB1kPLoBHlyvgIHxci4JBoZiODuBGl/qDgI+p4ATVpfFUSsF78sAmxYOEiX8Q7ODD+
         keREq0onXHkCjZD4aSbkdZuwSBDC01Ep2q735X6I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7Dt-1hTdDZ2G0b-00NTni; Sun, 14
 Apr 2019 17:42:16 +0200
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-tegra@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <1550928043-14889-5-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 04/12] phy: tegra: add missing of_node_put after
 of_device_is_available
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <00e76c9f-a551-ee83-9cb3-b2c3b8523c5c@web.de>
Date:   Sun, 14 Apr 2019 17:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-5-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FyJJ/5WZETMXL1DnzX0sx7IAwyTcWS43KbCo0403jyntte7+ln5
 wJnJqlObtqvsRv0ifFyQsUfLOpwJZEXxa0r/3dfxG3omPH1y9zDTDH1cxHIK2fbfeTEKd7p
 1MeLFISx+caxIMos5jxFynn/2GkoeF3ke/644zJpa36kLdD+jh7JcxKed5sZ0HHXtK6t/uG
 enVWgHb6nhw/fVNQoEeOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KIeFenlbwMA=:6IIE4Esb2wZkxK4/haAkTP
 wrA86NOXVkBvbpo4niKdlxVtG9E+FwFrq85ljt2+wlTuYcU1xnzNzHEuShNg553jA+CRq6VhF
 q/za6vFKJLkQL8wUwQdQYGiXODgho3NUHK8aFnO+kRta8eebiHzjBe2d7lruUCJvovvX5YlEs
 jz+qcYj5K6iprm9Bu4iu/pFIF06eNdZvPu7xWsGv3zptWbo5WsozlRx7VTVKLalrSuta3vlEf
 O2uvXeS+M/YFUTUcgyevJIhbqdg+kVlOhKwZXFu60kEiy5KUYqEj47QC32e/1/MfZ6YP6PHuE
 rN+Jaco0NB+9cc0SEg8VmjM6F9N74y910T0LG8EWtOX8ZW2LLFJXh+uaR/HNESo2myjqDbMj/
 MIunYETRnVYjTLLMK2QyHAEvaXKjmPI+TpuQHaprOS1x7id1+uomH3kvkqgtooBxFRK2qVlsr
 zj9lwbaO7KBAhk7YWi0ehlSW61aRngWapvenwTTN1Rd0dM05gMrfB1WmRbt5E8rEwePhVC2Z2
 NRiX6mwt8DM0alwh+JGLW73Vt3FtofMsWTiC28U1ZZ+ygjQ6LHuyFxkZmoCTENrdao2nN/gRB
 qAwfvuwrdx9PzAtGIbVzMvnOyTedtwFLS8AxzPKupePGa2iNkhlyb+PYXLJJyQq4+9z0A+3Ed
 kJl+oxQYCUGhVrCDELlbToXg22Z77kvGfE/18VmSm8Ek9hG73LGMAr+L4vUoEE4ENmWLfpqk/
 4h+ebabXP+XnciPBeM9RAdyws/9O45+/WntFRbYBqVSjSn3TZRbHpuH2TBcvd1qQpGxKazU4U
 WyV/5p5f7e1RLoI/GZbJqcZRPxTrp6vRmxcHk/48YL8rK3jsfecRhK0sjl/iYDQ3KIFEdjJyv
 adp1RSlxPPNsrEPLQCEHZ3GOapBYQSgXGj4rCoJMW0/bz+c/CvuWcs13uD1gvVM0+nDSWfbGb
 eJohvXFg83g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -260,8 +260,10 @@  tegra_xusb_pad_create(struct tegra_xusb_
>  	int err;
>
>  	np =3D tegra_xusb_find_pad_node(padctl, soc->name);
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>  		return NULL;
> +	}
>
>  	pad =3D soc->ops->probe(padctl, soc, np);
>  	if (IS_ERR(pad)) {

How do you think about to move this function call to an additional jump ta=
rget
for the desired exception handling?

Regards,
Markus
