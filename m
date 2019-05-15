Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA72084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fGS0xtCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEOHCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:02:50 -0400
Received: from mout.web.de ([217.72.192.78]:33193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOHCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557903746;
        bh=DSvUzhPEjmUWezNtumqz0pX9aMXDnwl3GPfUZDvFsQc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fGS0xtCwURKEH8mpMGOAVJ9y9t4N4rCtredVJka/borPUpSDhLdN8lnhjy8hi2FPK
         mrL2r1tBMopvnvkQQ0aBPCFaEzQhEf69dskcXDB9b9iBhQJqurcJSzJEt4DTQECqDd
         dcehyAVLwvGHWQYNUiOPg6ajz3KQ0U9CUSAFVLV4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M413W-1gZOIV433S-00rUwI; Wed, 15
 May 2019 09:02:26 +0200
Subject: Re: [2/3] Coccinelle: pci_free_consistent: Reduce a bit of duplicate
 SmPL code
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
 <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
 <alpine.DEB.2.21.1905142146560.2612@hadrien>
 <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
 <alpine.DEB.2.21.1905150811310.2591@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1794c3af-cec4-8b28-a299-400b857f0644@web.de>
Date:   Wed, 15 May 2019 09:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905150811310.2591@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVlhMK/IrcDX1ZN1HuEWn56YifwreD7VOgjvyUT8Qb04ga7qSUl
 3A92d4cF/chl64NR1t4vGVh0Yc0XPJbMw6ZYfsh1F0wtHhJ4+SqhJPzg8Zc0y9oTXN82J3b
 GBgzI2WGYXXO8riIsj1g4XuoPpgaVhH878g72VpwYA/DkoMbasp3byJXEt/qpxqJGT7CW64
 m/85pFEh1ZG36SWfji4Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6x6x1zl11dc=:17NyNuevsmmrDbyu7hRCYK
 BFXQLG81SpRLhUJ8GZu159s9kGh/u/QrHP+UQY9UT141Qq2Io/9t9Rlox2CsHKyVrAlxrr2zS
 XW46HBvzuG8cKGnEwZGmFBKq8KBzHhgL411Xp0wQUgT7LNm5m4b2BxLGctAEO4rf5YRbE+hHY
 wUny7J/aXoWshHa8vT/1BFrTmlYJh/k3v8KcPLjuq2uxnHfwR0kMIQTDym/I0BXJVBJmrsgO+
 ykDe7nBCP9TCIvlG21yixXpSNhI5DfnjTdQ1tOh0mfA4NsSH/h/HwZYqu3VvrOo3m6ZN1Eau/
 enf/CEUJ3Qay/RBXnj3fc5z2VXAQ+q0UGK1KPxT0kVFB77QA1TBgUkyDZg3O0hTDLH1wnLDCS
 t4Ei80llUHTNGDkDbepu2Y2QDXhm6n4csIFUj4yE5iMicCAFBB6CdbszlMc4xZVBcuIzL3tQR
 CFDH9BL+iVH/EVlTWeFwyKKOl6MXABo8L5x7jhlMKz6KW6B/OSDa7yNYtIaBd9MzqnNt7B6mj
 fSDwLRhDp+LCsSILf8p6UKj+1azB9PcKypCy7D5IS+WAqv36JKMI69bumlzhVDs2kpiK1ac3j
 UlsiWCofa0iGmk07Ssltim8y52CRUoizKaGjhxtDQeLyVMZ8E2HbTfnf6ZqNXT2pvGX9u7GpH
 vboddiQ6e4vGWfF2mRtfwJjnJhS7iewDxJ44zpq3lB1HAronc8BIiAcKz1yNLOLiHyUfVKH8J
 to0epfgFFr71scZmuD6bWAP/NcHZjr/ysijmDCQ0PlwEKltdR0N/4qQmvlV2bWHWORVmGd6Eh
 YXxTTGlIMXiOYDuiZWou0NWU1TpoEF8NRBHSKqk/9QvCKp4S3v8m5XDZrwA7dk/uoPb9fY0IE
 yIt3fbiDbXWsWg8QW5YLSKJ4pakEzZ/RRcdqcIGNZtk415vy/JQ2X52dzY8x4AHakfDu1eZre
 SVFj9EL9FdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can different run time characteristics become relevant here?
>
> Internally, they should be identical.

I got other imaginations in this area.

I assume that the evaluation of a separate SmPL disjunction
for the shown return values is occasionally nicer than
the repeated matching for the corresponding complete statement.
It might be that the possible run time difference will not be
big enough for you.

Regards,
Markus
