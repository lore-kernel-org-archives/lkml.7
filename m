Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550E7C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEBC20833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="W6T6t6m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfEROn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 10:43:59 -0400
Received: from mout.web.de ([212.227.15.14]:58007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfEROn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 10:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558190610;
        bh=BOFSm0zAlRJwIlFt0sFLNq72xZrQ0LNetA5bti57zhk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W6T6t6m5JD0YFEZwE6cW7+bGsNYAxazNhmB3nMFMi3uR5k6Cs5ao4KSwp/H5piYu3
         agY6GHZaW5KhaenYsnG8TsVlaQuTrKcVfSQqSREoSo16jR9wJFNd7cS8+TSQJbRA8r
         PTErPrir+A4Tx01K+vEYY5OoyxvXNQym/2v+pdCc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.109.122]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hcE-1gfGIB3xKY-00urtQ; Sat, 18
 May 2019 16:43:30 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201905171432571474636@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6790f1f5-284e-74b2-8b32-6245ba8e5fc2@web.de>
Date:   Sat, 18 May 2019 16:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905171432571474636@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hvZ/9QgwUIDXJWUUrMezwZYBwbd1Nm3yksCH5XmzfG7bNew7SM1
 /j/P/WXnkI+pic0HXWYVbiRuyEo6hNXgU+FMZVMRmmSHwN86W83ePwZhpzKXO8MgWdguWEF
 yUJzGvFtcODVwWzorWW4yDvy3dkH14O5siecH+7oHAqph62+CUM9IijCIJ/k16Y4+57VEv/
 ryqu/JVGahCyJtRuNr1yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q59TB31NTV4=:HbGcTnC4dhzByO29pmx2Om
 WrhPRIuq0h106Mj1J7Lq5aii4EGXzqUrDc8sTDrVAtR0831JU7L//qvn6Pzx+leBnghXD8UDn
 35bNZsnvSNCv9DA37lrMukNCLv05vhfhYRHzYw0bu8j3m85LWbZtEZMZY6uQj8SpaHv6PiYD/
 TaMsvmeMS2oBokZ/4NsmxoECgVk7tuh2mDgYNB8J6ECdwh3SLZIlYAX5ZaXZNhT4uyW89mJO0
 NYr6AhBkyFMcim+19Ve8GIqLQumYP9ItOfxGRPc3nz/onbeaAAbF/KaDE/eyRcVykwGSxSI45
 z0K17vq+AJuoztVQoMJ3eSyDAoKLifFDh7t/5IHJSclkVNMcbu+XmgUEN8W0/iQPnLzIfSWm0
 w3CpVtHWFEWybQ9r+xxA4ZtvsUmLvYolV8F4cYFJQ1GJO3+T7ZH/XkyJ1KcxuVQkHhn7Oh42P
 EoA2/McU9gRXeFlaJ4pVZG8LeO57bt2kWfT4mJYeSR05w68ybmHhOEsZ8mDW1Qd88r88422Y9
 r7yKYYduxwt+do5mzVwFMYEhSiu8eRPHNR9CsaFUrLBklz61OqCd5WNzNFoUhX/0U6XERyQgy
 AmD7O135GrgwQODPch6nEUuyGUcnmomUUi9Se76V9g66lhQIEaMQH0BzlE6BGB/3n4ZMW5l5t
 47U3VsNWOcMh7kFx99brVhUHlu17chBv2w+xjIkQsncADRileY19W1fRm3mnqysVyZOeXp1Jr
 P9G6plGDyiY5Pt6uY7S75KUPPMtADJz9SrODfO5adaPgAJ2cByQIRBXuKVmcCwwTCYYf4pNwL
 bvl40xEDGObeK11HsmPQssuRhHcUQe7rgIqd46jeJr0+5nbSxjk8K+N/irJn4p4/EIQoVJeCk
 smWWcktL2YRFKNQzdlFvZkVZQS31qOdsLLYVuBxHwYbWY2yQYtuO7Mq92fy21Mxq3HoJ97doq
 EnRmwDNgZJtLk+XYMzAJ/uc8olf8QsHIuUYtffGTziPxiWhkQ58XT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> $ spatch --tokens-c drivers/of/base.c  2>&1  | grep "Tag3 " | grep "of_n=
ode_put() on it when done." | awk -F " - " '{print $1}' | grep  -o "of_[[:=
print:]]*"

This command example points some details out for further software developm=
ent considerations.

1. I find it questionable that relevant data are provided by the output ch=
annel
   =E2=80=9Cstderr=E2=80=9D so far.
   https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae8962=
3313c8e05158a8d/docs/manual/spatch_options.tex#L165

2. The OCaml code =E2=80=9C"Tag" ^ string_of_int t ^=E2=80=9D occurs in th=
ree source files.
   * It is commented out in one file.
     https://github.com/coccinelle/coccinelle/blob/761cf6a1fbbf3173896ff61=
f0ea7e4a83a5b2a57/commons/common.ml#L305

   * These places refer to the source file =E2=80=9Cdumper.ml 1.2=E2=80=9D=
 by Richard W. M. Jones.
     Thus it seems that this code is relevant at the moment.
     https://github.com/coccinelle/coccinelle/blob/175de16bc7e535b6a89a62b=
81a673b0d0cd7075c/commons/ocamlextra/dumper.ml#L1

3. How will the software documentation evolve here?

4. Safe data processing can be performed only if the involved structures
   will remain clear for a while.
   Is the situation partly unclear?

   Should the information after which function calls the function =E2=80=
=9Cof_node_put=E2=80=9D
   should be called be determined from any other documentation format?

5. A programming language like =E2=80=9Cawk=E2=80=9D has got the potential=
 to extract useful data
   (also without calling the tool =E2=80=9Cgrep=E2=80=9D additionally).

Regards,
Markus
