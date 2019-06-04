Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A48C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC0624CDC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OdHiOYGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFDGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:36:51 -0400
Received: from mout.web.de ([217.72.192.78]:58019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFDGgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559630195;
        bh=/w9rjTK0RzikEznX9AVP97sePVJr+2TH1a4kD1LhRv0=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=OdHiOYGiR3KcJOw7urclukgnO8Q2+7u6s4+wHMoQSGCENBbUY+ByIbMblFy2Ad91s
         Dwe19vGV60KcQCk6pwwmmzdl9MmZ9rG+YewR4eL42rGxAlKnaLxf8W53D+QAmqj4GF
         Ks9ivE9aZjIBWbsobomoIJ4bb3cUyS0kVomEdJPA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.105.210]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1jI-1hPHcJ07jU-008uzI; Tue, 04
 Jun 2019 08:36:35 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201906041350002807147@zte.com.cn>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1bc40e20-d4d0-77e6-67d6-2230e8026ef0@web.de>
Date:   Tue, 4 Jun 2019 08:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906041350002807147@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++FI3r5RANqKAd+pWeOmLdXSSfwIfvnBG317hr74qE5IysUvkYn
 g+nfecSVh9NIEmS4Xt440kFxT5ues0GjrQ2bqic9IhAQW27jEQpiDn+vU9epFV6kEWVfW6M
 7ZpI8bJozxIcpx1uBEIunn1REs9td/v1o4c/MNxy9jBMsA5+Slx2nCbk8ZEBFEIlIFYCEsW
 GChiS6fb3iGAUyrGbkAkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bzMkCDXAcDM=:FayMUI2ccD0Iapt7tB4Cyc
 rlP65XAgrDuPyquc6cckxjwa11qO8AWFC1LObKjF/ARH/1U/p7+LXufcMhopq5iJphJXCwXm2
 Lc36Y2fOh/8OgHuF50sLbKYGkzVlRDTiMM56Sr6BvZmxasDxGHYBoPxo3b4e7Qj/3jSHWemnJ
 JQk3bj/q3KilvKkjzrzePuNi8scexR9I25xEwO3cVrboYWIyf4llTNUeR3I16xTXomPcDFEW4
 tYub/5Fg7KnXe4rSN28pOFsKaS/Tcy0j/u4D9DaTZOSaZKHI/pbvAzLxvaCYQurrABjOR/lJS
 h5G2lT/+c8a003nBfWgt6X/V+Mce9LJnNHZd9sOV7ag6JJfZcQ1VBXHFUrM7YWG+BNe2+SPla
 H1LDVyjVUYQ9ER3MmoR7mpE/50sd4b5tFsO+6Fps9icBT2pWy8Ck8nzODLP23FAc/MSABAjlx
 IGmgbRL4ytLubDzMfNbWcS8p7+bVfP/7tXJUIPZvWvckfGhuYaSLYAndE4Rn4v/7KxHshA95t
 l6Jp4RipJe02adeY+0C7fFOf28E7KMBeDQ0WMskAdQI7+3Qdhq9HJWIIgW+blp5dXnpTGXqVJ
 Lxxa4NdXexU3gN9HdHLl7F529qN0lvuy+e2ShZfGdi9U9r4iybJy5F2TvTEJSq6D11uUoDvJA
 iaP6AoCrx2t39iJIOffROm6yJGLXGKjLbkDmLZB8Zhyp+RUu3NDK8HZ0lZmGJc1YisPHV47aP
 QrV1VlcFxrpLpkCU9/52kA+6+b5u6Qn/k/y63A35U6Mr19d73z1jPdgcFVaLbc+jWldVsUzKH
 hvUGHht+mU64kkNieX+OLCEDelyZSfS0TJAeQoWVLiG8+2CU/z4Zc0AF+rJyYmO1phIdKQMG4
 Q6djf0I/pxJ11eSMPJWoFRD1XpAcYWZY9EV1dyz1GJ0EWbCH1XpJTnmlO/cmDIcGiwX9a5iui
 ZLlpDzrtkOSn1/kYQ1nshLPKVg9CsO5EhCpoGVY62OMa3hn9hQmEz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We currently use the following Ocaml script to automatically
> collect functions that need to be considered.
>
> @initialize:ocaml@
> @@
>
> let relevant_str =3D "use of_node_put() on it when done"

I suggest to reconsider this search pattern.

The mentioned words are distributed over text lines in the discussed
software documentation.
Thus I imagine that an other documentation format would be safer
and more helpful for the determination of a corresponding API
system property.

Regards,
Markus
