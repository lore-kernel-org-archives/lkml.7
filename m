Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB05C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664DF20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AQTNdj3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDIHag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:30:36 -0400
Received: from mout.web.de ([212.227.15.4]:44667 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfDIHaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554795007;
        bh=3blj3qQj6gDv6FwbzoCF4Zd/5j9+2DhSp8FmX3zzWFg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AQTNdj3HaOyRYRQ3kMAimotRFVv3pa7W/jNofkRrBNrFidelB80Eu0hIX+WlRp22y
         53Z/M2dB1x+AxPDUi0WecVU9+8AAkixl+WE61dk71lJPLpSBRc4UsGi6Pw99YOmTlj
         RTuPAt8+EDNXiQhw67DX83IqIoq71aKy2ThSqm5w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.175.183]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfRiT-1gYPtW2tSb-00p5Oi; Tue, 09
 Apr 2019 09:30:07 +0200
Subject: Re: [2/2] ethernet: ti: eliminated some duplicate code.
To:     Wen Yang <wen.yang99@zte.com.cn>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>
References: <1554788881-22647-1-git-send-email-wen.yang99@zte.com.cn>
 <1554788881-22647-2-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <e05a0f06-1e1f-58ee-ebab-fdc035d91dc4@web.de>
Date:   Tue, 9 Apr 2019 09:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554788881-22647-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7UjPu3OUO3KsJ9WqT4VA3oSIh5D+DoO4nHe8RPpfglYVjITM+cj
 /m25uK6UX9SLeAQgTYyqXFjgXRfDLjGC3is3fnDgVUYwjYweCBqafM5XNMpCbO7+2spISfH
 ECS2Fy9Q7eeZ4+6+HlPxPkGFK7DGfoscqgiSTDmG2BK/GlDEdCY4HEqdatXfQ5q6y/fUaik
 qFCUMwsALCxfuMC4vCu9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIKUNmjPOYI=:T0kQhujyqQXnIRpRiD57jf
 iS20u2v05Vce4ng0vq0DYek19FjIolcJvubdnojmqz5r50OUC8V3L42qF+/hGfSqWx+hqo5Cj
 HByeSu3lcg8B/3bLcKEklg5U/+nsC1CsOxF8Ikvmrn066JLz30arT4h7t44r7SGhdZGWvbdkR
 Jg4IUiPJknLYNl6kIUjmxjW5Gpy4trgZJkRngITnVdXe3kvIalOjPnh9SDzOCnuYue34SQma2
 3Ptq44EcZD1BqoUWB6ymuE2lADvG0wM0PrWRc5rJgiNhUrgRcKTIHn3YI5c4XncdKh3oMMOhy
 CW+vbBbLD205wubkISdhjVSIBdCRYy0f/EAU7LW7lW67MxlcZ0rf0d+eGntXWEEsKG/7qUDl2
 PrU2W8YNbetg84slPs+SfegCtJVisxjNLpXu/LO/ZpbIzIO6ZgXVNNuU4KSETkBM+hSOMRiRc
 QVrfrogF03uJ6L3ojByE5vw1arc+DFO7Bli4sf1BqKuR3eLqXwZGVCHSR5TQ24L3wAcW69yzi
 Yn5XZvn66UInKW+eKhoqxXAbyosU83YaRvVS8fCJrRtk5YXgqQ9wydDFpmN/20r5khcxhf117
 hjRkXkTJjMOn79lvIF3lsWvZxjcsZY54p9m78qA2zhyzK0Gszlk3AFcuFhHDoyDJNHAjFh+Ay
 vAEgw0imHzuAwYjmcog/b13DkF2/OTmWlrGV52YzclbtzOt7ZEjL9HjqBEAAKuGJeMspQMHjr
 x9GPSw50II3A95YfbDLiDIID/w+92YmoZyKOQO7wm5OUmJlqH09JjuBfYr5KlV2MY1AY82pnS
 ZwwEc2pjd7RZlfpmXL/nSOCo2cID/u94WeL72dDyf6P4Aw+W2QdWqaq8rRsGQavdzAfrRHvO/
 8jsjDDV4KiWLA4ZaYvzzcFIB/jFud2yUSBDK+yREUbJ10hnujdjlzX8iFGNA2wWMPGJU+wshd
 I7/gOZ6IWFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Put the code that obtains device_node and the code that
> uses it tightly together to remove duplicate resource
> cleanup statements between them.

1. Would the wording =E2=80=9Cethernet: ti: eliminate a bit of duplicate c=
ode in gbe_probe()=E2=80=9D
   be more appropriate for the commit subject?

2. I find that such a change can be provided also without combining
   it into a patch series with only two update steps.
   Otherwise: Why did you omit the cover letter for the updates
              by this small patch series?


> @@ -3651,22 +3651,18 @@ static int gbe_probe(struct netcp_device *netcp_=
device, struct device *dev,
>  	if (ret)
>  		return ret;
>
> -	interfaces =3D of_get_child_by_name(node, "interfaces");
> -	if (!interfaces)
> -		dev_err(dev, "could not find interfaces\n");
> -
>  	ret =3D netcp_txpipe_init(&gbe_dev->tx_pipe, netcp_device,
>  				gbe_dev->dma_chan_name, gbe_dev->tx_queue_id);
> -	if (ret) {
> -		of_node_put(interfaces);
> +	if (ret)
>  		return ret;
> -	}
>
>  	ret =3D netcp_txpipe_open(&gbe_dev->tx_pipe);
> -	if (ret) {
> -		of_node_put(interfaces);
> +	if (ret)
>  		return ret;
> -	}
> +
> +	interfaces =3D of_get_child_by_name(node, "interfaces");
> +	if (!interfaces)
> +		dev_err(dev, "could not find interfaces\n");

3. Can this error message trigger any further software development conside=
rations
   for the desired exception handling?


>
>  	/* Create network interfaces */
>  	INIT_LIST_HEAD(&gbe_dev->gbe_intf_head);


Regards,
Markus
