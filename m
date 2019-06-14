Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20304C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9CA217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Egwi3XNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfFNQtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:49:55 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:16012 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfFNQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:49:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id AC7E2299;
        Fri, 14 Jun 2019 18:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1560530992; x=1562345393; bh=LIwM9+9dIB18u+6tFJEox7KnVEIbAhaN9hk
        yl/cMLRc=; b=Egwi3XNQAxx7dDzMNX1XL4gQLSuDNwfnmaviMbNzC+yP2/nJ6k4
        xp0cQ3Pp8rMUajbUGIePrvotrcUiH9HFs5Da86wUOUg0uic/Wc4PzJcLN0FvBsLa
        /H5qYywdEHgIDdBjbMQrYrH2MB/BEmmrJTZj/86lgBeQKoMmUmEnUBVXqaDKOurg
        1K5FOnIL1+5dRBR0bMNC5e+rdSUpQ4wZgl/nI2dYymxzBiV7gtFbAQuy22aYf/K2
        fFecvX+/Lt9OP2JQ1zxKjgavkjcI5TZnti6jouRmtKa0I0TjVUjc0SSZr+uaZ5Rg
        xhVhdt5NgQswMDqHqqFOX9gygSIYWiu09UhD9aXd1MP5d+7sSutsCrGBtfQBnZHY
        mQs+3jpMBy6olxrnkSsODYd+QYuR/kM4/uuSF9zJqHC4fySvu1wKZilQ1k08ON82
        hmn76LKNLxRAuSlNiXA52VSO+6OyXL9YBgo39Vj5vR1Jatr2TgRRb2vW3LtAMNcZ
        nvXj5qcjMOy+ig59AmHdiZgqxpiiT4D0ZsVqTMuF2rOefYZsalWS/SxmIVQkJC9j
        KLTaAb0KiwdYSlk5N5a+RVyTIXnL1/rGoPWCXAHHU1OKVdMk/uDBdMfUmbVa84Kl
        xR+6WwJfympI884LEaIJfXfPRfrCOPsbLoewXVOkl/j0Wgjt6YZ6qo58=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QOVTgGi62AZn; Fri, 14 Jun 2019 18:49:52 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id F41D01E2;
        Fri, 14 Jun 2019 18:49:51 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 9496E2AB8;
        Fri, 14 Jun 2019 18:49:51 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Stephen Kitt <steve@sk2.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: stop suggesting strlcpy
Date:   Fri, 14 Jun 2019 18:49:50 +0200
Message-ID: <2414416.tHVI2ZYGNv@harkonnen>
In-Reply-To: <20190613162548.19792-1-steve@sk2.org>
References: <20190613162548.19792-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In data Thursday, June 13, 2019 6:25:48 PM CEST, Stephen Kitt ha scritto:
> Since strlcpy is deprecated, the documentation shouldn't suggest using
> it. This patch fixes the examples to use strscpy instead. It also uses
> sizeof instead of underlying constants as far as possible, to simplify
> future changes to the corresponding data structures.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>


> ---
>  Documentation/hid/hid-transport.txt                         | 6 +++---
>  Documentation/i2c/instantiating-devices                     | 2 +-
>  Documentation/i2c/upgrading-clients                         | 4 ++--
>  Documentation/kernel-hacking/locking.rst                    | 6 +++---
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 6 +++---
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/hid/hid-transport.txt
> b/Documentation/hid/hid-transport.txt index 3dcba9fd4a3a..4f41d67f1b4b
> 100644
> --- a/Documentation/hid/hid-transport.txt
> +++ b/Documentation/hid/hid-transport.txt
> @@ -194,9 +194,9 @@ with HID core:
>  		goto err_<...>;
>  	}
> 
> -	strlcpy(hid->name, <device-name-src>, 127);
> -	strlcpy(hid->phys, <device-phys-src>, 63);
> -	strlcpy(hid->uniq, <device-uniq-src>, 63);
> +	strscpy(hid->name, <device-name-src>, sizeof(hid->name));
> +	strscpy(hid->phys, <device-phys-src>, sizeof(hid->phys));
> +	strscpy(hid->uniq, <device-uniq-src>, sizeof(hid->uniq));
> 
>  	hid->ll_driver = &custom_ll_driver;
>  	hid->bus = <device-bus>;
> diff --git a/Documentation/i2c/instantiating-devices
> b/Documentation/i2c/instantiating-devices index 0d85ac1935b7..8bc7d99133e3
> 100644
> --- a/Documentation/i2c/instantiating-devices
> +++ b/Documentation/i2c/instantiating-devices
> @@ -137,7 +137,7 @@ static int usb_hcd_nxp_probe(struct platform_device
> *pdev) (...)
>  	i2c_adap = i2c_get_adapter(2);
>  	memset(&i2c_info, 0, sizeof(struct i2c_board_info));
> -	strlcpy(i2c_info.type, "isp1301_nxp", I2C_NAME_SIZE);
> +	strscpy(i2c_info.type, "isp1301_nxp", sizeof(i2c_info.type));
>  	isp1301_i2c_client = i2c_new_probed_device(i2c_adap, &i2c_info,
>  						   
normal_i2c, NULL);
>  	i2c_put_adapter(i2c_adap);
> diff --git a/Documentation/i2c/upgrading-clients
> b/Documentation/i2c/upgrading-clients index ccba3ffd6e80..96392cc5b5c7
> 100644
> --- a/Documentation/i2c/upgrading-clients
> +++ b/Documentation/i2c/upgrading-clients
> @@ -43,7 +43,7 @@ static int example_attach(struct i2c_adapter *adap, int
> addr, int kind) example->client.adapter = adap;
> 
>  	i2c_set_clientdata(&state->i2c_client, state);
> -	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +	strscpy(client->i2c_client.name, "example",
> sizeof(client->i2c_client.name));
> 
>  	ret = i2c_attach_client(&state->i2c_client);
>  	if (ret < 0) {
> @@ -138,7 +138,7 @@ can be removed:
>  -	example->client.flags   = 0;
>  -	example->client.adapter = adap;
>  -
> --	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +-	strscpy(client->i2c_client.name, "example",
> sizeof(client->i2c_client.name));
> 
>  The i2c_set_clientdata is now:
> 
> diff --git a/Documentation/kernel-hacking/locking.rst
> b/Documentation/kernel-hacking/locking.rst index 519673df0e82..dc698ea456e0
> 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -451,7 +451,7 @@ to protect the cache and all the objects within it.
> Here's the code:: if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
> return -ENOMEM;
> 
> -            strlcpy(obj->name, name, sizeof(obj->name));
> +            strscpy(obj->name, name, sizeof(obj->name));
>              obj->id = id;
>              obj->popularity = 0;
> 
> @@ -660,7 +660,7 @@ Here is the code::
>       }
> 
>      @@ -63,6 +94,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      +        obj->refcnt = 1; /* The cache holds a reference */
> @@ -774,7 +774,7 @@ the lock is no longer used to protect the reference
> count itself. }
> 
>      @@ -94,7 +76,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      -        obj->refcnt = 1; /* The cache holds a reference */
> diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst
> b/Documentation/translations/it_IT/kernel-hacking/locking.rst index
> 0ef31666663b..5fd8a1abd2be 100644
> --- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
> +++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
> @@ -468,7 +468,7 @@ e tutti gli oggetti che contiene. Ecco il codice::
>              if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
>                      return -ENOMEM;
> 
> -            strlcpy(obj->name, name, sizeof(obj->name));
> +            strscpy(obj->name, name, sizeof(obj->name));
>              obj->id = id;
>              obj->popularity = 0;
> 
> @@ -678,7 +678,7 @@ Ecco il codice::
>       }
> 
>      @@ -63,6 +94,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      +        obj->refcnt = 1; /* The cache holds a reference */
> @@ -792,7 +792,7 @@ contatore stesso.
>       }
> 
>      @@ -94,7 +76,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      -        obj->refcnt = 1; /* The cache holds a reference */




