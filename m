Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B3C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437221670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hCo3095G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGFI5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 04:57:19 -0400
Received: from mout.web.de ([212.227.17.12]:42925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfGFI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562403418;
        bh=mga3jcoqarNpM03f1VZ9ZEB8Apx+m+Akum97wS1Kp74=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=hCo3095G193LGVFu1cJcDkTvKcTlSSnEtJpxD1eUsJBDOE1qZIgnCnM9+QO+LfuKA
         FNU/CvdgL3bdribx1CrKUYAsWXefFxH+UNs7Iiwhk5RKKvIK7xSYhM9Nd6u1MGXgk7
         biR+RLlsKzHIPE3pgmINNfV4lyBnTRoUKKOzKTYI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.148.45]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsKN-1iWxPF063X-014ykE; Sat, 06
 Jul 2019 10:56:58 +0200
To:     devel@driverdev.osuosl.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ioannis Valasakis <code@wizofe.uk>,
        =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] staging: octeon: One function call less in
 cvm_oct_common_set_multicast_list()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9ce376b1-0450-a0ea-bd4e-2601e4bb8168@web.de>
Date:   Sat, 6 Jul 2019 10:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NkOwAclk4DCSQV8E6147PGV6k3iHPD5NF9siN8y2nxLc9+zewoj
 SGaBEYhPUbkMTc+48Oi5J80Ej1/roaQ8fRjJlMNfSA2Rjg40PN6PuWohv37qZlIR7E1zmAo
 6z/ETj/7xj/ZW7QC9Rg3ekjplwYnLrKiJjmfzXOxrmdQ6BHWtwCHlUenn8E+kCYJ8+PCyYq
 VFaxWYXsIX8Dq0aHE7daw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/P5YyRt/4I=:QP25Q/yAXh7J3ku4RESW48
 RoI9YXNxBvUp5DiQP0RQWqxEq6Ncgy5yYnqLBCEhRuz4sl/0ge06TQdjIB8DR9LnwPLjFP+PF
 IRFpca+ezR17M07aSs3C2oxkKUL3ccREbbtn+J9CfZWdt5EeId7IsQF5xnFN0y9yequiao3DZ
 E9IP+FftbLeA9nfYp5mXAP3H48Cd2nsxbp9PQvf54+oWr3ERcnJE18rHg8moOSPneT0M/efrv
 oEcjRAQCzs9XoyEn25ca1m9PTOsQxVRqj3gGoPG64+pxuka2NQRcinB+eJqbH4H6g3fsLH4pm
 /zv/cT8G4IaU4Lt8XNHeuwekhqUMfxLqnrhoeRO+XBTntFO1pKFqgKbVjKGHtFkiqcUR72xrR
 p71Exr65iUjdufAQ1qvi6qJSHKgpNz/yTL0P3IM/asUhwb478/5Y2aLxYrFCmqyYl54fnFnQZ
 6AHSPY10QApt+jR5CEFlZ1RcfoUHCjNHcCBgyBgb2LSjfp+zDah/t0vi/VH3egZJghggDWvhb
 nScmxbGllmvLHCd2+SPp85CwvDNCJBRB1b+fUJbJdrVx2/xyBhHU156zgIs+vjyvVNFM8fEEp
 TjcosssS10g+9xqzulEwhJjF0IdK5bihYd6WA6NrO6oq5PsIx5OFQQQ35wUaaee5xRvsvcBHi
 Ln79UrwOfQup+iCaM8c+1uaxUwjGE/RS2V3re1CCztVJYcvZcieWVj/w/LtQn8WFLomjIYcHx
 GspzOsK1JmmanlJQWj/myInbWM5LY9JVQ155Us+CbQ5yTPMcAnODQ5LDfPqpslQLEFw0znwsV
 Q1z/86mubAXLJwSgibummoGvw6MOW8HoFOUpVdKG+fbwiMLiwSEMf6SGk2uPLKBsRKj7Q2wA5
 Ni8ssOIbnHbMI5bca1mM3dn68PLQq8Z4Yqi8XHqGJRbPAOo1B4pBTJ0f42+Yo2QE+tpypiMq/
 XJ4Zy+t01sRxcyXhCUDIAlzY99WZ5q95kjdYskeTagBmZyUa1c92rvxi8OaROgzKwyZuKgq0j
 q/ckKVrRMTovX90vNYNnCZzCP6J30X4IssBj9i1lrcNLcRIeNM1td1JpJuMjIp8FDucQMxhSO
 ik/34s3LxDXJXS0jIbHgV1SES78ZFXUlXKt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 6 Jul 2019 10:48:23 +0200

Avoid an extra function call by using a ternary operator instead of
a conditional statement.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/octeon/ethernet.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/et=
hernet.c
index 8847a11c212f..93f127a0b287 100644
=2D-- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -337,13 +337,8 @@ static void cvm_oct_common_set_multicast_list(struct =
net_device *dev)

 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CTL(index, interface),
 			       control.u64);
-		if (dev->flags & IFF_PROMISC)
-			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
-				       (index, interface), 0);
-		else
-			cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN
-				       (index, interface), 1);
-
+		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM_EN(index, interface),
+			       dev->flags & IFF_PROMISC ? 0 : 1);
 		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
 			       gmx_cfg.u64);
 	}
=2D-
2.22.0

