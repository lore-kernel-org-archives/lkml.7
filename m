Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53714C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071152075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IKVUBcz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgAINR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:17:26 -0500
Received: from mout.web.de ([212.227.15.14]:53577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgAINRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578575807;
        bh=H/fsRroKuS7Xgd5EvW7+3X9Jlrp4RB0PxIVhW0E8Lw4=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=IKVUBcz/OwLBTqEnNC4yaGpt8jQtSEBOwY2VzvTiAmk03+lcW1pDsqGlBw/cjvBYZ
         +AozzPWaKPkeu0IKbtACnSbcrb8ihCnRnsnJffRsOaSTQCS5oDR8BT5le4zrHw63aW
         MGMKk+tZMixGEcVoLevW69To0x1oK91GIUue68rU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.1.10]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40na-1jfzbh1UHq-00rZ83; Thu, 09
 Jan 2020 14:16:47 +0100
To:     yangliuxm34@gmail.com, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuyang34@xiaomi.com,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <27225bf0ec9b4e2f3d313456aee75e294361d550.1578561009.git.liuyang34@xiaomi.com>
Subject: Re: [PATCH] trace: code optimization
From:   Markus Elfring <Markus.Elfring@web.de>
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
Message-ID: <4f4bed1d-9dc0-0665-4b61-8afc9ebf8201@web.de>
Date:   Thu, 9 Jan 2020 14:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <27225bf0ec9b4e2f3d313456aee75e294361d550.1578561009.git.liuyang34@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdNdtRt5Em4m6UC26wtrgHbUBrqGbXHSv2EeVy3RJmk6IadsB1G
 3qswSieAV1K7gY2JA8ec0Rz1YzJG+WGKzysu4FCcZ8Ni2PODDZZgpqbXl6flzXZG2lgieLp
 IGNJ7nBe/tjlqL12Mgsn1Wx9lNhHv1uw4SNcw96S+rwfSUg22vhlt6BjTic+oQajcQcMmWH
 Jo3DpqrUKb0YiJSZO3tcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4LM9FE8fsA=:A2Dfv4Z7A840dYDo0i3Kce
 tL2gBdD6271damqoVrMOczBSqOB5KxQeWc6DD29a8RYSi4VHCHsLl8NtYXYh2rFla+wUHpLhP
 qGYp8Jt6o/yVdMaeEGywzTk3FMYaYfl2uJ1xwEPoaWF780iHFjWwTw70qrHQG9QxndekCue9A
 vFC9CXMd/0pHE2LyTbR/yVU9mOcipVEF6qwj53hDQ6tvdSQlxZcNFR0zMJgnhXi6i+msJ7nji
 hLRMUZeK0e4Nwgg2DagGTXhwyXYs+v/FgnNr+O4hoxW6839YFeX7sYKhGUeFi484VGOY6shtP
 091gFOSolSZkuYvWZzPquotxGk7qpOmQiFM5z2LZdvjL+FhZ+V1TyQVFQapn1O6NN/1D+q0nJ
 gltqoUWd+ogyJmS2XdxoVi7CStXeWMsMKzpFf+K8p8u+jNj8IIu2Ms5E+3Kzfxcck9ZnWcQge
 TBzwnOvXitXLr4VRJA0WXXLQRATE+PuSrAjDrMxVHfErdi++voFS6Ixv5OF04hd8TJhlaqFa5
 8rD1RW6CXTOyU49frXQGWPzjK2NVMQv6FNnpyIYf6bDWguZO+qYQiCLFEUTnhi1iVNpoeYP/h
 loKrJfHgemvLKRlAlW6NmpazXClBb5mWARk4fOI5cGGVcaUc350l4l5iQtohylZRa7fKXXfdI
 DBNNZm/XKVkaPIZXblgC7YPAYLt1mhEBtM4lsmFIa5OXlBJDBTSx1cZjGIcgnK2jP5V7eKH0r
 d0qCKzZ6ZM0rb6G2t8YK5gmH96vhdZ2t630Av45ImKUyo551w2/+cvGZpgfdtGyWzxySy33U4
 Zfcj/rtr0OyA63Wbp1KkoqXtyZQny3s+VjGtS2Qu3cCKtRHPeWvYMtu2woBU7FW7sDb/Q8ZhL
 zAlgijwIizJC3V26YTMZph8bEbkXCksNQ06A8mTUrrLnAfjSEbcPVCaBA+M16UvhTRwmbLYXp
 A0d+byVosqdXJeZLNNSw+TrCFAQOyqJvOZwsy3eX4WKnaajiDLnw5ClqrlCKPtvds+SoZEIT4
 ooApYQWuLyX+OMosTt78GsAN/Hqyq7/UBNe2z1dZk+by1dR91EC/KISHGxHpTQNFKs2PkSpAG
 LvV2o+vJUxcfTDT1PLcedoWvrUddD4IYbLG5xk+mfJqYdmcm1l7J/qRWdBtP3NN7ATq/vPdzg
 QxOMunmG8yFVUuwPC/RQgLIqHfd9H0L68y2HJF8EbZJX7bWyA11BncidJpGvrHjaWzRphOotS
 aPEzHUp5zOukFbMyY5/ete02ooM6Xflnkd4TBxaNAbV+dv/jsmLUGTD3b14E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> use scnprintf instead of snprinr and no need to check

Will a typo be avoided in the final change description?


> Signed-off-by: liuyang34 =E2=80=A6

Will this information need also an adjustment for the desired specificatio=
n
of a real name?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db07f636fca1c8fbba124b00824=
87c0b3890a0e0c#n458

Regards,
Markus
