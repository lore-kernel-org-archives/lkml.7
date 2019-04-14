Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE3C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BF20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EnHWGSdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDNQMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:12:20 -0400
Received: from mout.web.de ([212.227.17.12]:46275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555258330;
        bh=MC6rHgXpDT9txSGxLou386Gaxa7oimVA7a4ceiwrZJE=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=EnHWGSddTPQ9OU7FvkXsUvOixmNl55M57a+kg7L/zqxXBpsTwG0wqqE9tBtmYmqoI
         HFQYRQuE16+T2BoeScVDlXCeZfL4bxN43IxamT/ZXtfUQeQ1KeSoDIX70OXx7tlzsX
         JCA8hK3Gx7oJUyVZ3jHYBEUmFphPG7NNJlwUqF/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wzV-1gvfhz0W1R-00xvL2; Sun, 14
 Apr 2019 18:12:10 +0200
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1550928043-14889-10-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 09/12] meson-gx-socinfo: add missing of_node_put after
 of_device_is_available
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <80bcfd1f-f7db-5d2a-a96b-4b63d2c97138@web.de>
Date:   Sun, 14 Apr 2019 18:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-10-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Z6reBu5noD8OkgZ1jNHiF0uSwSp0+7xSOBD2F3dfoA0EzPaUpp
 lVVbDFsJrj+MI2SqwTfP54+NMicqc+R9029X5b3gFX5+H21nTKY67F/8F2pc1efvcR5qcze
 2AWw1ufcHOCkpd43RVXbitpSFMbnUtScz9exGqe3MiA2ZD9ZJKglGVfN12xo01Ka07KIwfE
 dz0Veu/i4LekkGSzJupDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3g1NtEsWBo=:rRrrWTZDP6rXB9NeAYRa8f
 7yX5OUL/fgXwqGKv4fyq4/lw1wJLv9Wbmt2WT3LZk7FN+Q9A5EDz9qBGrcF9+wQOt597/L1A5
 W82yUqbJzZGBeTixoIpIhEEWDLvtKHNLtuPMz+mae/mR9bU4INAXuZqRyDyXHwM3yYMOPSmgy
 gyGWvYROyVKHpqOJ/zE1OkzuhD3xiJCn0WZwRyMq6utnNxo0+tyQ/gy79h3RpGeOFcJUyppRy
 cAxHc39lnguSwqQLAlt7qkYeuLgy1bjKy+lNPa6MFXX1ohHXINB4LDUjQ1ID5zeEQcmO2Ygtf
 sAOROcGtyBwAfi1fU8M1FKuME6lol8quiil713YT/vA3c6j0WG8jnkt3IYl4aTEAnkgRJf0D1
 2XmsVlMkIKOwXPtS/C1DUhptLEtJY4K6K/FRhYm87+BEfzpxJWOTYSbglXMd5UuIdEirbqy1I
 S3eKzIU17uBJUTZfyrHa21QefC3MfpvVWc1/0oWSHmjMI5RKZhGkSQHFAQcj0CeGg8Arf1+IQ
 Kro2gEsz2NViFnEEvHUgU3gRu4ejdObKt+80uNj6Ak6zyt6mOrYjacdqs6WGqFn1+5RRorP30
 eO/zbCoN18sAKRCz5sKZqsDIdYiIQ3QsPd8t24KTIfC7ZyyxlnaNu8sLvtrBKRaJg1wO8NNe7
 V6DhXe4O4pHhr2YdWcEozsWd/KdAJ65y/YfOpjd1nN1vv2y/QJfXYinTQL3be7eRSX20xyBiJ
 +MNZamdrbgAbbIgIinM2/TSV32VAUHV4rETQW4A775uEL7iqoHB1n5cquEJX9/6vvxDa00YN6
 SmNhzQxGQ5abdk3/GXjSJdocvXrS0cVrEDExqEZ7R5gepHCu0v2ZqGBbNOhJRWHQIWITDwWh8
 mHGfpl5jqQy4O+Oknk8+VpDdsssa1RkPMEyVv3J4JMW+oMVn1n8TJg7o8ZMBIRKBFusXvLnuH
 8YfrKPyTJ5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -123,8 +123,10 @@  static int __init meson_gx_socinfo_init(
>  		return -ENODEV;
>
>  	/* check if interface is enabled */
> -	if (!of_device_is_available(np))
> +	if (!of_device_is_available(np)) {
> +		of_node_put(np);
>  		return -ENODEV;
> +	}
>
>  	/* check if chip-id is available */
>  	if (!of_property_read_bool(np, "amlogic,has-chip-id"))

How do you think about to adjust the exception handling in this function
implementation a bit more according to the Linux coding style?

Regards,
Markus
