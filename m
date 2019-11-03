Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF9BCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F602080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s3PlJFZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKCMb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:31:56 -0500
Received: from mout.web.de ([212.227.17.11]:45055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCMb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572784297;
        bh=ByqX8/BbJJMQuJK30TWcd8h/CfuGh5FVHwsdxMU69s4=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=s3PlJFZP1G8E/gDRogfCOmlepuzW6IpSlaRaWpCFvGVG2NKarRA7rhSGHP0Unh9cL
         0QXxm94nCvrQo4A36F84IFTGMqHEhw3EXE8y3m6BFXsOqNyGui8iJckkmkhNdDBYe5
         DM7Qdhwl4lVD0qjM3ZD4NWNhIbGGET/feUY3D1LM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.72.216]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrdd-1hpyPg2TCz-00bs3n; Sun, 03
 Nov 2019 13:31:37 +0100
To:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_powerpc/papr=5fscm=3a_Delete_unnecessary_assi?=
 =?UTF-8?Q?gnment_for_the_field_=e2=80=9cowner=e2=80=9d?=
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <389022fc-71b0-7952-3404-1da136dbdfd9@web.de>
Date:   Sun, 3 Nov 2019 13:31:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TyXkMJhJt2mjD37pIwKvEn2qwm2H7VRI+BJefISVZ6piVGVXM5v
 CmKZQMb2hks/JwPQygp9zzlxMCFvJlmj/Cpcp4wy5aGOKncLkFJCrNWHBgE2cOf5oYRiSs5
 foUry41e2BGV9yidaolQIh29OPF+fWyYLbHU1RmjmxXYLfam/rybqt+Vg4bdFBHg1uJW0/z
 ZLXBM0vS8KGUBpY6LXbEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOxMcFlvvJU=:NtRdSJrL/ExtCmL716gTFl
 QppktYDM9VoxZyxUOLjYYiQn2sFytJmGY03Hv95PYW488xS6pyV/kZdGY5I/69IuaGA3nFbfu
 2/co1mPblwU+A4Q6kWkY4FGJWv0DjTGqcBC91eu+CxjcEIoRG/CZQYYNaC6pjByhd+Xcp02ry
 TjYYdhazm5hiTWbWBAKf420zVFU6dSqG+VJj95AEM+U58wFECqFj9emBEL+vmD6yy8EGdueXR
 4A2ckdhEj3D00uaEsh1n5nVuRtwlFAddBFsI/p8vQWFtzQRL1li0XJvzyzQPvmqc5cYPkEJI+
 koza/WLzQtPb2ULwi3C/x8fG51IPNPT+q5BPFi5PY7JlNBwNeDquY22kCu3K3aAIuWfEL1yQ+
 NFfD5ftwnFLP3PiUh7VHAUgcod3twZpMMzfvjvswRAgNJDYAAH8QavUIKq0t2xHDm3fCStRU9
 fIsi4859TZDIzP1Tf2e++UdbKMVBYXoPjD7jPo2jiFEyMtk9uDzapIAQEOYKgqEIJEzIN9mqf
 mr0gia/CoawpmzWskRuAYrWR74DoSTq9mbsGLPaRol/IYWS2iwu3IWewP8qdYuWi4LJXkYwKX
 tkyK4ltBWv5Y2dIWXInWtoqNrEAtwrcM9a91H53Ml9ZsfX0nuH4yfVTCX9z+L+8ZBA6PGoIxL
 zJfO+Z+K5i9j4WktYmBcUGTXv0ZCt4zO5n9I7F/LStfPR9NA/PiDxXsNYWBO6wUeAc77pQ7Cx
 ppNvIXvFvQbHGN57eT+P1vRnRFChcaOtGNkh2bf7xZ14m9axw0ajhsxy23WGvE6BNhfBfXPMt
 IENY5JXf9AiM294pGma3vu8vePbsblBNjIFGACwLgUFSyyqmMqHyA/cxvLX3MEg1WYF8b8yn6
 3/ztQ5sHa+kizPQGQeliDTwi5g2rMpDPGP29ZeEzV2FXw8B7KDAoEx18c3hd+MW49wpxba/82
 6LwOcwytSAMpUCy9vjTn4fnbutCuRv375aBB8dLt+vFoIg4zHf+nzMTmoAr7+9vrp9ygCo8A7
 bx1XCxJlh+IGboBlrrecpRCfjLjy0L+LWrTSM7urMJaAuIYNepZ+2S5qvi2rjzlcnH+dRpmol
 6cFx7zsY+kcNlQm3iAnnGC0y/3dckMYYZsuvV4AvfHxTmYtERRxczWvoqLg/OJO8q4yzUxa5w
 JD0t+M1vFW/bmJuXdI7jzS6sG0js/zIKDE7CZsLMxWZTq/oYegZvmXNJPHWF6M+ASV+ACtZPT
 WKUNjPpKmDM2cQcUO0lPOkODz5xqktpftLQydXrDZKj6DwNkWtNVHuw9Cw4M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Nov 2019 13:23:13 +0100

The field =E2=80=9Cowner=E2=80=9D is set by the core.
Thus delete an unneeded initialisation.

Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/pseries/papr_scm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/plat=
forms/pseries/papr_scm.c
index ee07d0718bf1..f87b474d25a7 100644
=2D-- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -513,7 +513,6 @@ static struct platform_driver papr_scm_driver =3D {
 	.remove =3D papr_scm_remove,
 	.driver =3D {
 		.name =3D "papr_scm",
-		.owner =3D THIS_MODULE,
 		.of_match_table =3D papr_scm_match,
 	},
 };
=2D-
2.23.0

