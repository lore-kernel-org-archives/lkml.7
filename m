Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE3CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47AB20882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EQBxSWAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfIVN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 09:56:01 -0400
Received: from mout.web.de ([212.227.17.11]:42999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfIVN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 09:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569160554;
        bh=lX6emF+xjsAZLDbG4WIHkDXFQUJXQ8PmDva8OKKoGb0=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=EQBxSWAn87+ihu55I+DwdCCJabdPCkKa7/rtFwYntS2bdA5N215Rd3F+CUzNh93xn
         s7wpI/UrPx86Lt5dRBfcvyW8a6fltYUJzRHR+03VwRabvXs2iE9CV8eyTRaEK/K0BH
         dO68ehF/hi7DI6pLdpXwIWGsIOoLG2KUtlAF8B+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.8.78]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrq1-1hetNb32u9-00brWF; Sun, 22
 Sep 2019 15:55:54 +0200
To:     linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ata: libahci_platform: Use common error handling code in
 ahci_platform_get_resources()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <6ca97aeb-0892-ed0e-a149-b25848adf324@web.de>
Date:   Sun, 22 Sep 2019 15:55:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/4/JbLOSCKw/9J5S3k0+ovryNiywB5oTV3LWxinMqTowLGWW6XW
 B8LTFsJLYcpDGuJJbUXzveI9a7bmWaGI3PkVoQiTfljJwQQp06ea+OYzSncxC/jy3RkIz5s
 Rk/D5O78s1176Eu6V25fAZoxhlAOEkghSG1q1z8i78Z49xwa7CrRBo5JsMpf8cFcko511sW
 ON8roMuYhsyRdb6lD2Xrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uKkoYPDikFg=:8N06mFnT4RnyiF0j/pyk7t
 8Zfh+bLyizrjFV4QeXkIcxQSciTgu4VJkiqBj/gTHpDr7IjetdLkLMankVMLETda0KR+MjrKR
 g/RvimeJiopDsExTyiF8/Gk/cC+Noxob8nMRMnBg3I7o3gXSQmQdMkJa35RqgAKAeal31pqvG
 fVEpAKK8nepG8xGpievF/jlrggrlgBR++lyqIvRgKh2MoFxdk6K7s35Hi+8GG+zBApzb4HCSx
 W5XpVOw75ylx200awJ99l248ISTr0oiTIsVVZI+MvRPsM/sZtbV1P6NaSTrYsqMn0B4dxY7vY
 cUecoxlSLcbEw5xhwDMoyqcfheCSxB7MPkMF9TX51cY+74JxBH2DQHciKuEgEuHkVMPcnMsOu
 Cklidz33On/rvqhb6BdO1JJSu/JELMjeEu4KPiiMY0kStlMb/p96FsdU9G4ScYkyNWXYUnp3T
 91+F71LNv/0DY8wOWnReanL8BR7XA9ATIPZawMncZpY77+LZgdmNSvfbJdhrhfL5FW2hBdE45
 vCGh67Q7n1uGk0T8aPd1vdLzKG29axytWfeuVClzwu13iWEvjdgQZikuPwqu71EoHc5QNj5Jc
 xDC/b5P4poscnIrEbJiihb1ur6UNypQ9kz8t1dFEiu/xhJjgmuw0g0bZjxKF0IEXVQtu8SHVq
 FEzVeOCNXu4HJyoFeVc+YSf28Ij+Djlp0gs23x/iwXGN6cxNukdTi6QXeULvgmGzhpgdKEivv
 txdoHRiNfMlfHmqJskRki2lZajvOdmBYhnacCRAq0ie+NcLu6mq8CfyiwTdf6QfvwtIuNQ3OR
 S4JNXEtTuA5J7wrc6G4WF+IrPuuljeJ9kVWoyLdSLzvnotTIxdt90AOVAOoZDbfweNVZVj9PE
 Q5mg7rLefch45+FfaKVreRxzUCvMxAKCeavWSZ84LSBjFdQU1qpGHVDq7JAxJURRRkhd0wH8M
 cwnn122pzOScmRPgr+5BU8+Ar8TErUTcHsi9ow/WYISVAGa+c2DvHhJ58tZrDzdqRmb0DfD36
 4mgUb5dm/5Uq66fpz1/Xt53N9ChTnMaKUUuRBxInZ9NPRzJa7Xph+GOEz8opIfF5PfZAzVd5z
 VwfEtc15NOPo9/XzPOUSvzp7Jm1bHYQIEG1kHzHxSDwpBPnOu595QnhIjtjgb4U/mndZztdwK
 ZiG//J02iX434NY2xdk31jRvMexxtCnQN99/BdglQUzAwP8ghXHQZQwuyoijJ+NX1YJftOfDz
 MiSezxLtd51k92H9GUvPPS1DoyJdWFEivR7bkrnocybzlyQIDeG+ksW62+X8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Sep 2019 15:42:46 +0200

Convert the call of the function =E2=80=9Cof_node_put=E2=80=9D to another =
jump target
so that it can be better reused at three places in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/ata/libahci_platform.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform=
.c
index e742780950de..7b2e364f3bd5 100644
=2D-- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -497,8 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(str=
uct platform_device *pdev,

 			if (of_property_read_u32(child, "reg", &port)) {
 				rc =3D -EINVAL;
-				of_node_put(child);
-				goto err_out;
+				goto err_put_node;
 			}

 			if (port >=3D hpriv->nports) {
@@ -515,18 +514,14 @@ struct ahci_host_priv *ahci_platform_get_resources(s=
truct platform_device *pdev,
 			if (port_dev) {
 				rc =3D ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
-				if (rc =3D=3D -EPROBE_DEFER) {
-					of_node_put(child);
-					goto err_out;
-				}
+				if (rc =3D=3D -EPROBE_DEFER)
+					goto err_put_node;
 			}
 #endif

 			rc =3D ahci_platform_get_phy(hpriv, port, dev, child);
-			if (rc) {
-				of_node_put(child);
-				goto err_out;
-			}
+			if (rc)
+				goto err_put_node;

 			enabled_ports++;
 		}
@@ -558,6 +553,8 @@ struct ahci_host_priv *ahci_platform_get_resources(str=
uct platform_device *pdev,
 	devres_remove_group(dev, NULL);
 	return hpriv;

+err_put_node:
+	of_node_put(child);
 err_out:
 	devres_release_group(dev, NULL);
 	return ERR_PTR(rc);
=2D-
2.23.0

