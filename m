Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B4C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A7B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FMd6V8/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfEMJKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:10:40 -0400
Received: from mout.web.de ([212.227.17.12]:43793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMJKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557738617;
        bh=8HCPWY7trwroU2CJYBs4UJtG6cJteBG5zMcxivDumUo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=FMd6V8/rrVbZ8NeJQ6f28mWi7Kb+ypoKouzmJAC11ETxOpAf44iqyLoOXIgBPVveQ
         uY8CTqUYuBETRZe6Y7gHQ8bsSebD0eqCEnz93Z1txqowNhzvS3LOpXvFvQRri2/1TS
         qKzGojDJRU9Q5GNwY23ccW91+Or5XlXHT7wU/o+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWS3S-1hBI271u6k-00XbVU; Mon, 13
 May 2019 11:10:17 +0200
Subject: [PATCH 5/5] Coccinelle: put_device: Merge two SmPL when constraints
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
Message-ID: <a29de02f-8726-c487-6d71-30979d153647@web.de>
Date:   Mon, 13 May 2019 11:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qb3tclap+OgFao82eB3ktWUmnzVo7P3Sp5T053jANrElXuANs0Z
 26bJzB93GFWWuHOI9QK0lcxGpSNsJEvbnel+4u5L+p2CNxIOBWxNC+qaSmyrf8eAj3s5+jD
 G9MDsin2fo8vW/wwIrvDvX6+fFGYzIFLAIyv1ee5NUQmfBh2MnSe7R/3n0FStNNf7FlNyZm
 LsYf5WsGEKgdpzP42q2cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4lY+BDeYjzk=:Lv8fPQQlm5/0DptZGMRdGA
 GOAIOkfsT6t7yh/SJ4UQ42CzeXnxzCzNaYW4FxbIuzzvvDdL6tvLheVhWPHS+I+jvds0Qva0X
 b2EANPBanZcn4JHoGrSDPKKrmS6izkDEfd9X1tms/NgBJaDZGCdPO/qjYtApEyTRhEF5UwoB9
 or6SPVhVoFHe2EO6CRSfEJGtJtUwObri6M3GbVCjWcLjwo9uPOy+NEvQzsmuqjpI6ui4OA3z7
 tBIuojEJ0oolN5tQTY43O2LWgLvfXFCPc3NvKHUQL8w3iMVPUCTk1N7uhgR/MkbYZOGbbwdAf
 M1/J22TTQjfU3JFG1KdzQ6pTEBHRiYLo6bHY97ouJ4Qh9SGidEv/pH9hppISr+YDqVXROzm3Y
 gJe4NJN0JEOh7U7gvlj9lkmy7W2/3oDhc4OoE72soyHJhUX5sTjAwwVI70AXXjdjE4anZkjqO
 KNjHkHjkFpgp8zfDSTYckKRKxZUz9fP2SfOZM9UDx63FMOy9jVbr+81UUxrd/suzgxTFEnMwD
 b8k8BY3zGBADMXwuN5opJMWk2/QObSfWLvBtMErQLnAk7FEOjOCjbBTW0mz91pUnTRlyjo2sE
 4qVxlbiqmDYuuI197rmmwJgER0EAofUCDhYzZJ3qwvxZcGIK7b5vFREAodrTjl0D+OcfhRpz3
 MRSc8kimJKxd0+nTg5KaXVp1CJ30zoXr7I80ouo0avSo/Ch8krfxv3Pd+rvFp98ThiVe4YDFH
 CjEvHj0Jgb9nKaxCmrO30WuTjWhjXHJTQYqgVwWM5lYOsyrg6uoV3/de5yLUiH7TR2qNJ8LZy
 7TwgI2bUHekCX0BgppOlAFGTJkCwXlfD2eYrL4XB1eCc3Pnfrk31HzdqoTEj4DY2U9Md6Axb5
 W54vjuuAzPRJ5fw8/UCP+G28abB7fLSS0KlUkRT3M7OLxG8jKrnnUtHdLaQkEFB2nSEsZkZUt
 7420ljeOMOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 May 2019 09:55:22 +0200

A single parameter was repeated for a function call in two SmPL
when constraints.
Combine the exclusion specifications into a disjunction for the semantic
patch language so that this argument is referenced only once there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/put_device.cocci | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/free/put_device.cocci
index 28b0be53fb3f..975cabb97d01 100644
=2D-- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -22,8 +22,7 @@ id =3D of_find_device_by_node@p1(x)
 if (id =3D=3D NULL || ...) { ... return ...; }
 ... when !=3D put_device(&id->dev)
     when !=3D id =3D (T6)(e)
-    when !=3D platform_device_put(id)
-    when !=3D of_dev_put(id)
+    when !=3D \( platform_device_put \| of_dev_put \) (id)
     when !=3D if (id) { ... put_device(&id->dev) ... }
     when !=3D e1 =3D \( (T) \( id \| (&id->dev) \) \| get_device(&id->dev=
) \| (T1)platform_get_drvdata(id) \)
 (
=2D-
2.21.0

