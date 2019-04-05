Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A255C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356BF21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Qx0Q6PDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfDEL1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:27:11 -0400
Received: from mout.web.de ([212.227.17.12]:51579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDEL1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554463609;
        bh=WQApwz6kDZ3M+CUcMSxy4QqLWXdmL8JXpTD/iaE2Ldk=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=Qx0Q6PDSrKHkMC5RI85mkS9FwgeoorkN3xn0eVd4sAQEF/GVtCFWgZgpkFV2RFmL8
         9C1M0C1vvuGdABqkZgEb9BkCc6BGTJq/46BcnW3UYBlROy/H9tqqMbvX/eFSNt6/Vv
         PI4CraSjM49U9ksryMTYgnpgaBzZR85zzrMWD7AQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.156.119]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6E6g-1h100R0RQY-00y6qb; Fri, 05
 Apr 2019 13:26:49 +0200
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>, Yi Wang <wang.yi59@zte.com.cn>
References: <1551785646-46173-4-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH v2 04/15] ARM: hisi: fix a leaked reference by adding
 missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <844457f9-9e43-be25-8a2b-fc3e2896a729@web.de>
Date:   Fri, 5 Apr 2019 13:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1551785646-46173-4-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27Dig/uNsewOvF+FxVBeH4iVNQEShZT5pDsJgnSXiB51Xa2Uq51
 JF6daJVdbxCTAhh1i5O/v8G/3WYjkXV8IsdJtnCPFQ3FsnxdvUQyMOYFbPuJ4E/nroCAad2
 t9d5Fy1sCGs4AGeiY/RDpzB3D6ntPR0dPGPUnR31/7tzkhffQgwt6Humphnoy+CuRgPX2Xn
 KIP09gNOD5k7Oup6U+RFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Syo/dXBCK5Y=:Br3cu4CcmaGbSYem/PnIrV
 w3el6CaxJjcwfByoE6+Ozap8IDaBhxW3CIoxwMWXESvB8HlI1K4js2c2vW51GOH2+ghU8oIl7
 q/fI3jpNra5bT0V5l8uzy8ixgIvwKAvU+LrQOpWOIFNoE2sveIlk7yguKIMRi0vTLDOHsQ+2u
 xQLVzABhhVSLTReBRmXt3lulbn4Nq1/JycuwtKPKcOn+z3zbH28SE8IzWPqySS/MliJtJ7vfM
 8BZCDarf9Bo6HnU1QiCNqLQkcU/yOtOIPCD5eWj+9vTWKVh5r1PzlPwQL7aHCX2vaGqLLEySD
 0NxCZcbP3dbBdoV/8Db7H8TIABQseLDFciYOD3hqBIbCInHltNncwLZOVKsLFTxPmkSsiIAtj
 K+lZUzp/MTRTM9FsB1pX1bBq6Q3j/C66bKqnK5fpGpXO9cp7JqdFyptg5qxgPtj39PQoRvBjv
 AXMFqMbQHByO/crSLOVvsagsXLJUiKEf7iVXvB2hJ3n1dsKv+siKX/R9YDR7EmPWqXKFA8GIC
 6ypTZ7kObQPa2NiPlW4GI9ZOCPLhgQrV5iZwmOn5iVeY7A4JnBkor27HR7OPz1/NxEFx6OGdK
 yPRWKsTuqj1csScvZjtw0Tdk/2vMfHYQn6LeGSDYd04b5HxGUZ4/MoMODiFbKYa4ayWkhcHTS
 IkDuYlQvYCNfTU/ChJLv0HgDeoXRM1yWwl5Tup2qLtLzSWQKWkvs2D99+xDkn1XEp/1QSiG2e
 uE/RSGDiutaZgvFIlMBi442Pf/aOuYRDrtv+H0L197OVihzjlFzsDVFxRi9xLvTts3rRq9tDE
 huD3hl0SXYeR8v7ZLesQjSKPMCNy+SPYIbsyyStzpIG112jqCLRJi4uXHvnZwkv6LuMvVTQR2
 qpxDLLeHEBQiSAVdnquSENszOd2Ffi4+ARnv6PtwMr/YzA0CIYphVXrX2/FMnaOCCgwL/bzZk
 43QBXuhVCEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -285,12 +286,14 @@  static int __init hip04_smp_init(void)
>  	if (!np_sctl)
>  		goto err;
>  	np_fab =3D of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric=
");
> -	if (!np_fab)
> +	if (!np_fab) {
> +		of_node_put(np_sctl);
>  		goto err;

I suggest to adjust this source code place in a different way.

 	if (!np_fab)
+		goto put_sctl_node;


> +	}
>
>  	ret =3D memblock_reserve(hip04_boot_method[0], hip04_boot_method[1]);
>  	if (ret)
> -		goto err;
> +		goto err_put_node;

How do you think about to use the jump label =E2=80=9Cput_fab_node=E2=80=
=9D instead?


>
>  	relocation =3D ioremap(hip04_boot_method[2], hip04_boot_method[3]);


Regards,
Markus
