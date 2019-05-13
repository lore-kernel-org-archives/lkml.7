Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC72C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833A321479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rRQY5N/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfEMJFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:05:25 -0400
Received: from mout.web.de ([212.227.17.12]:37945 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfEMJFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557738308;
        bh=jtrTYF8ULtsjM8wAgp4wSKoTfYfmnQXS/DVAPfI6gEM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=rRQY5N/5SF/f70up/pR8sWLFjySH+fLZIMMMWE0voXKfkPXAP1ItwD3tW3FZI/jrR
         MjU5+V2DRjIY4TLlHL3HNFNw3pxRuA2bxLhadrx4JEVtqXIHORDmyVMYZovJu6/ikZ
         M7bISruUzImjsD+Iq+Brh2wIp4rEHA5PupLN9mCc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1hW6uw1SBa-00Eyrx; Mon, 13
 May 2019 11:05:08 +0200
Subject: [PATCH 3/5] Coccinelle: put_device: Merge four SmPL when constraints
 into one
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
Message-ID: <6b62ecb5-ab88-22d9-eee2-db4f58b6d2ae@web.de>
Date:   Mon, 13 May 2019 11:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nz5xzp//Z6dJYDz1KvmzWtT9rzafZK2Ooj1MSx2MexRRipeUtdh
 e74PSMkvsEGIxb50Obt0Gy2xPoNo6u3ziBWjwZ8HK5ZWvB6VeaA9WJEtzcFAk48TyvNrssk
 9fi0ywEjF+HBamQID0KjUCuEUnFAxH9F3oTDfQsbk0wzdbL35ozPIQQoR3SEi3LDaOJqlK2
 1v8EEytEdMWtpXxBJIPSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8+6CpDXOpp4=:53wTBdYgsz+Q3/zp+Aw62C
 uH+SP8um78+4O6oWUWbpGpuWkXQ3dNInJ0eIUPrHYSKprUuh568IgWOnboO8O+hkxeFa4uGtd
 X1byo8BQ932OMHq9t9cu5duWjNU0d5P6H8YmIw+IuHpr0Yfbtp1KJYPlR7kfxN06Fq3UJB17n
 G4OLogQouB6HYQJoNvdjCUDDZ/4px8jF48Hoe9LuGVVzssIB8kB6PFRxu+HQDrWggGM7QH2uD
 2PjTisE1HTkaLMjC4h1zqkyAXOc4oWO0884VGNXfZYg9oj9rT0kS5zfZw2lAu2x4+K4GBsrk7
 s3ADtyivTShDs8eXU3CPAjrlDHqdVtXTLINfkP6D0vPli28TfNSUJdtNvfAZVvq19cm2m62vn
 a0pw96fovJ/Pp+ebhT6GbA9JYdQf76yAZPHrl8jU4a20NrbIJmbPbN40fBS/ml1Hjl0x/vhe2
 TsS1qJkpr3Xn9bTBxB6rVBhYJG41c7L95Uw5UYXPVquRyIjbxpZdFtYGfP6YMVrweieht/772
 cnsp7R82Scw8K2UVFfCAHWBwJIMjbsP9LtOtU9HzXzjb2C8ZPqZdtJusl7bNBDjHjApsBH7L1
 W61o+JlC7UoJEeGmm9rmSa+GBBWBJkwPbx7TzFr5gfdj+Ctys/IrS47ycDxLAVdBstXv/zJf9
 W265Lcd+9xzguEHdmKsSGOm1ETeqLgkzdNW9IuaSA6rtNvEXy0dIKdyL9gXS4AcX1fxcMddN7
 RLG5rnvjx6J9RZ7iMwQrsCzfrC6+El8PWxzzir83YIoVkZU6mIly0fz4QGCeQeXbs8OeafiA8
 WfWT/mrJbbvhNgDxaBdI4/MHFCDf/cTj9MU7HaCXQiI426WJbO1aJRQxWVIzDxsqmRqGuEfx8
 imawGgxZDTHeYnnvpsyIUyHxFGG5nKnFc2O2I+YmPnW2JyVFXdnuQJ1hqwgtog50WWmnvEiaK
 yJ5cKGI753Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 May 2019 18:32:46 +0200

An assignment target was repeated in four SmPL when constraints.
Combine the exclusion specifications into disjunctions for the semantic
patch language so that this target is referenced only once there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/put_device.cocci | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/free/put_device.cocci
index 120921366e84..aae79c02c1e0 100644
=2D-- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -23,10 +23,7 @@ if (id =3D=3D NULL || ...) { ... return ...; }
     when !=3D platform_device_put(id)
     when !=3D of_dev_put(id)
     when !=3D if (id) { ... put_device(&id->dev) ... }
-    when !=3D e1 =3D (T)id
-    when !=3D e1 =3D (T)(&id->dev)
-    when !=3D e1 =3D get_device(&id->dev)
-    when !=3D e1 =3D (T1)platform_get_drvdata(id)
+    when !=3D e1 =3D \( (T) \( id \| (&id->dev) \) \| get_device(&id->dev=
) \| (T1)platform_get_drvdata(id) \)
 (
   return
 (    id
=2D-
2.21.0

