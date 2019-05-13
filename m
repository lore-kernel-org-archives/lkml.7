Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7852C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8402121019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="R2ejRu+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfEMI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:56:36 -0400
Received: from mout.web.de ([212.227.17.12]:46795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfEMI4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557737725;
        bh=KVkSsGwSpF+WBnfS0iDg4LtaXGEM5Yys2OdR1zsGexE=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=R2ejRu+Ji9Nr9pBgRdjW6k8vppa8tjzU0YbxYaX0BLcqPyaU6VeNCiCY83/ZAU6QP
         17LW2Sq5n+pRpnDud0HY4QcQa7RrFbi0U/4er/pRSLRXGvFzxP5EuhZQyViZt0HUZN
         ax80hLM2U/lNt+nBPn1chi+67WifJX8LGvV7VMps=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpwB1-1go0pW1qNz-00fhIe; Mon, 13
 May 2019 10:55:25 +0200
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
Subject: [PATCH 0/5] Coccinelle: put_device: Adjustments for a SmPL script
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Date:   Mon, 13 May 2019 10:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7FLweG4X7sBgnhgY82wamxc3aoaIg9U3ITgy7hF6tl5f7VCfHgB
 TrdKNuCBt1XCPi7ArnL7ysa3y0E0Rha7r2LUg/IY1/22thnyB39e0eFffZOSr1VMRtMgkQH
 TcoYZC+H9WYgCVanZ/wAAq6Ojf28JKlxYSAfe4WIX0yMnG3+iEZSCiLuNrztnQAMq5a+kJm
 7k9xwYDosMd72yiMgp+VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yk8DqtIE3uU=:TfSeW2MWwP+IeldtrmVpf5
 3/svG2fTzQ9VdqyL2JwVPjAIR9wx+0+aicECEMOFjlf7lBwZlQBHgQ9zvRHtydLWwWaPaWehJ
 8tbeRHEB1X0XMFocNe/uWNbckwncto+lrlPV2y1l6vNJBGoj/8aZWayJQZJpsriG5k2GkPndU
 3xrRCSQfs3V0uosjb7Wq0xpDkUAAM/v2HHiCyhld2x51YOEx3bCF4I6z+SAGAWbZw8kOz15fL
 o+/iyPJGa8RnUQd7byJA6IaN04W276F2Wqzl4/0Rj7JddKnzvDefMrJEmhMV678ITpruEjd+d
 WddnDwADgspl/aPGar1mHS46AFRsVstp3a3waUUONwO+LUSn02vdGHSO/FaZXpnLcBX4f4B7N
 loN81lIc5K4U10KRU1GwTfID432YjEv2vjdgx4tS43+9v2OQHM+2QfnVJ1nthvj26d+MNiDzB
 UA0ttk1YVGT/pdR9eV/kY2iAA0Xeny4Nl/XPz4l+5ThHEfntbyBzK4/fvaCBml6Yy6Gmf5sAe
 YCDqK/ym0utSmgBFD4ACXtrCfeiD2oUPCgJuzwOlYLfk/WY3EL4HBzsdTyrijKCfU02de7XRo
 nrRU8miZcMUCtzU6H16bdLkAxIhiu4m6z+jmjTOvQN9C1B2ha2xGuPOnGcXxHbREESXVNSPvf
 k8iuOZTHAK7UJQG5sqgVURcdknF65kPwnk/tdvtUEBkGXEDGhvH3Ims4W+m0T3rQq4iuLD4zK
 4RoltE/vGRozvamasm6QEbd+ejSm0xGKrfc6ciOQtyW3CrwxCzcCxIXjwTwzXwmMCX2td1WQb
 /z3w18AqKHia2t4X3Hc+HQMuA5BP2deQRstTgZ3a//p06FzaalCfb6/Dkt8Vvaz7F9Ya4yZJ/
 G3r5IPwrMVKrfiQrNFP4RtlwuDxk0EqYKjpYdhzeyfeoBu458vdQN+PR0h+E/5YIwlObQzn5c
 eqmZQdl0q7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some adjustments were discussed also for this script a while ago.
The software development attention evolved in a special way in the meantim=
e.

See also for further background information:
https://lore.kernel.org/lkml/CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCzi=
UWheOQ@mail.gmail.com/
https://systeme.lip6.fr/pipermail/cocci/2019-March/005692.html
https://lkml.org/lkml/2019/3/26/395

I would appreciate if corresponding implementation details will get
another look.

Markus Elfring (5):
  Adjust a message construction
  Add a cast to an expression for an assignment
  Merge four SmPL when constraints into one
  Extend when constraints for two SmPL ellipses
  Merge two SmPL when constraints into one

 scripts/coccinelle/free/put_device.cocci | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

=2D-
2.21.0

