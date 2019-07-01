Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF7C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8495D20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Wc1QujpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGAUYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:24:46 -0400
Received: from mout.web.de ([212.227.17.11]:40595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfGAUYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562012678;
        bh=tZE31hsTLdrJnV7HFtrizemEn4FOklI4Y6SQ6r9qf+Q=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Wc1QujpZQoGk5WABxcQ/ouUbXbSszW/5EQOx2+hIGCRvRX33+L4ApBMHyo4NHBJqd
         K6ur91X67N4roRASRDKMxEdlHK4pYtERwfyuA1jFZo4sf+B94IxW2VLfNU89NseO4j
         UbRm7IExMHUD3a1j7L6xjSfgGVDTybb8GjgCc3+Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpw6t-1iDp2H1WPH-00fltV; Mon, 01
 Jul 2019 22:24:38 +0200
To:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: Use seq_puts() in possible_parent_show()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5961554a-6416-48ea-44e2-d8e3c7576af0@web.de>
Date:   Mon, 1 Jul 2019 22:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6UeTsNBdPLOA+5HJ4v7LkjqQ6mPvqpDJ4ZzZkFCzGOYjBTRhsgz
 y1FEUuCPz+DdKdU+/GSE+FPp6rgXQbQYBN7vNXs1EnotYsaG0PvzdIH90Z8ULOmgzknAXta
 zDXvGciS28QsvAsveFyMQaT7gQbPXOSVdA+fJa2F5gMiyaP4EYr5zAQam9mhEUeb5gJ90yo
 p3tUJ3FahvypEkcHebwog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nx3iW4owouA=:oUjlNMtC7N2uPMQWtfYkpT
 OLmvdPl97HrZsoF+AQldC45VAS0BZK4AEV2uZn1a8PZkXTepSBVmsXp43diR1moYahIn7Wh+Z
 RY4+BRlExwhgVpyU9Wpc5IIc9cFmpgEBAeNr49K/P7kDggAcpHDn+/qc4fKRYLYqohUyC2saA
 WPVRPXlFPPLjJu6EpdDCywzjRsYH7AGrCcin8EvopQFcu3sHB9bFsMFADRQVBOLodcZUYu0hP
 4j632TykhvSGOyjDHcRcn59YRNBwIr5BHw6PRrEcTlW75BZQ8Cp1jz4E+rGAedik1OD1fpy4d
 YlRhyBcMyQs6Azb92NPuBDupZwcz3Fyp++rbGWelSjWhCF5HOJmRfv69qWzWsMx9quobv3O8C
 3FPirLoA3BIEK+JcDVziSGWoKMNnnK2pSQmfSNR7kNxinEz37NSmoHzeu1EbAP4FLHQHNDtRk
 aaRZMJrO4qPq7c85HFcQ4j9f/U7l7YPWrnx5O8TowalmDpuEOgIuXlU1Je5Szsm8gDWBpc917
 icttGFZ83t7FsLSKCvA9aI2+xVfckVMCMxSmTNRBnK/M5yIWLih+iVi7g9lidZrdUDTlArIbp
 67HlekizDWhaFIQRywWMKzBIfd3hQkEzC/mhdBdu1cdioFimmt4CAXLrfQN7joLN7h1BhymKh
 EDrEUx+9q4fG3jl/KDUKLQIXoQZ8FNBoBC9NgAHOiiPjBc9vDA96REFFTuYbxrqr0jumy1eqt
 P7XuS9PhbXvRyKOoTVSA1hZRyBJUvptcjqfwsX96PLykPG9pTBEKysTpRofWP99bSWq+4j8wj
 JlGTIDWW300ZNbKvFTBHl0UE0/St7Y94JtSQ1GlvAcQfAqNaO1tW6/geAB8Ic8TQErGCogJS5
 7QlzZa3CrqdWNcPLQ7woSOSRNhQjdVKMGnnw5Y6phcqPw/eX8NtiGTTACIJA4VEBr+AuymjFv
 U8d+/kWEIBjsCYf7e/JuLn139grIiVbOKnIbk8HGMTSVb9yLHsyyu9bgmetPP+dwzV1eSiMei
 07p7g+56leVb47yHHZ8hG7wWX4CZ6c3XSHPwuzw9NSjL2+seq86muxFIPJjpEE61iBHM4m/HI
 WwvFP03vKceFhiaAM3wK9aCKjhhmvfFmdpt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 22:20:40 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/clk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index efa593ecbfa9..140afebeb238 100644
=2D-- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3013,15 +3013,15 @@ static void possible_parent_show(struct seq_file *=
s, struct clk_core *core,
 	 */
 	parent =3D clk_core_get_parent_by_index(core, i);
 	if (parent)
-		seq_printf(s, "%s", parent->name);
+		seq_puts(s, parent->name);
 	else if (core->parents[i].name)
-		seq_printf(s, "%s", core->parents[i].name);
+		seq_puts(s, core->parents[i].name);
 	else if (core->parents[i].fw_name)
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
 	else if (core->parents[i].index >=3D 0)
-		seq_printf(s, "%s",
-			   of_clk_get_parent_name(core->of_node,
-						  core->parents[i].index));
+		seq_puts(s,
+			 of_clk_get_parent_name(core->of_node,
+						core->parents[i].index));
 	else
 		seq_puts(s, "(missing)");

=2D-
2.22.0

