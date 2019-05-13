Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2758C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA646206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mBiFrGLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfEMJHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:07:40 -0400
Received: from mout.web.de ([212.227.17.11]:49929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfEMJHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557738436;
        bh=p2JMtjZdrKJWiooeLSimOvpmCziJX5gICxvARfKTUJQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=mBiFrGLciDKM9JCv++tRr2Of7KtBcL12/LxYlMhjLBM0UQqGJjVzVjtUup87tMRU9
         c8T0VrltxZTXwmsy4kdUjP04NXpGsxFyJUE268g7IdpyI9R8dHacx+ZqZ7kA6JMHwA
         k+N42gS9N9ICNrPpzkDgsnMPV3Pjta3vi0SN4VnU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mPA-1gWCtE20Wa-00wYqf; Mon, 13
 May 2019 11:07:16 +0200
Subject: [PATCH 4/5] Coccinelle: put_device: Extend when constraints for two
 SmPL ellipses
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
Date:   Mon, 13 May 2019 11:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEuZTmOt4Ag6FjwzF38i38wt1hU1bkW6mub3oqxdpKJudRGgCmS
 VEAZ5pjPwuNQBA9vbEcKnCgqENZ8hkaoS6ByP5JAk+hx62JKElI3z8iKA72MoSFu7CKTp6l
 RkjG3h/IFEaT76yYIeGNVKZgqexfnpdCJdSvSq2z1hxe2wrBJefJhokcn3D2lvByiV2ch/2
 Tg9Ok6DLB3oArPm9L5M7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFvNYnhkJqg=:3fZW6GMXpLu4t1PO+afhvk
 wP/MIDoaGSAA46qMQTMuq9rT6pn4n37i5hJQzSM7anNyyYJqBnE+1x8h+iedxYYisWJ1HKbQh
 c8WNFtiNxYqRMGVNi/UqXlMOYJay3bNv52y79cTx/8yhoci4A+st9avjlnkLbBEtQUrUWc6le
 AFtmPQ0PFU+Ngy6a7WBLSlAazlfRitQcQDG6twx3AeMjCkk4fXYik79btF0KRpDGeXXdIOVaF
 gTiPuf6ohufX0uWIGGarpOffFNhgwB5QpYADUiFXJl0cZ5mzQcUAtg+5yUjwo3rk9PRxOoTzA
 B5SkEKK+heF1ZiXoTplv8VXpngktVKz4nmxpYcyXIuVhunN1cV9uLpdfK9j7uyxlAK/hifseH
 i565nsFbCo8mXv4MYoLcc5U98J3LNIsvTrn/CuBR8h6ShvFwSwcspAX0l44K08Y2pr59McU2R
 XnpUJ7hOY3sKe8rC4X7fWjpysiLz15zGe3RPFS924ebxqZFKi7GzHsG0l8gFF/dVDWRZREy8A
 b7z3Z7ElLueJy5EVoYdeGrAtED8A1gOtzvcV3biN6CqkSIhL9eM7z7O2gs72bOzzK0M7FjCBm
 JIy0AXuAaWGDIshkkqbgMBSqjiYettwwqBWXqefIC+Wh+DHXQtk05hh8tpgzX8/ngMt2GsN8V
 AdSo8p6KUFoPH+SR2Sy1Pclvh3qvcUDIjeRJlKrbnrhMntBPqudXK2LtL5O9o2p9cExT3NSY4
 mshowisdbwA/FNzqot5KJv9BYdOYr5VFjd0ulCb6w5TC9POQPTIn1aGOZZPJApLp86N52tmWl
 G9xY1y3mtzQNBDn/QJ9FwnSW/pouUhaNRI1iFQiTfUbzrygFeUMHCOLJokc1Ti9JLYiiv9NAW
 gtjaMTnZfX7P/fb+MSNp3P01YCRbY8S0JEVY0BsRO6VtfE0UqkjEzCysSoNXHeP6M26Ybq/p1
 qZiM6vinftA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 May 2019 09:47:17 +0200

A SmPL ellipsis was specified for a search approach so that additional
source code would be tolerated between an assignment to a local variable
and the corresponding null pointer check.

But such code should be restricted.
* The local variable must not be reassigned there.
* It must also not be forwarded to an other assignment target.

Take additional casts for these code exclusion specifications into account
together with optional parentheses.

Link: https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005620.html
Fixes: da9cfb87a44da61f2403c4312916befcb6b6d7e8 ("coccinelle: semantic cod=
e search for missing put_device()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/put_device.cocci | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/free/put_device.cocci
index aae79c02c1e0..28b0be53fb3f 100644
=2D-- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -13,13 +13,15 @@ virtual org
 local idexpression id;
 expression x,e,e1;
 position p1,p2;
-type T,T1,T2,T3;
+type T,T1,T2,T3,T4,T5,T6;
 @@

 id =3D of_find_device_by_node@p1(x)
-... when !=3D e =3D id
+ ... when !=3D e =3D (T4)(id)
+     when !=3D id =3D (T5)(e)
 if (id =3D=3D NULL || ...) { ... return ...; }
 ... when !=3D put_device(&id->dev)
+    when !=3D id =3D (T6)(e)
     when !=3D platform_device_put(id)
     when !=3D of_dev_put(id)
     when !=3D if (id) { ... put_device(&id->dev) ... }
=2D-
2.21.0

