Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E610C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036312184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rPQK7y46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfH0I1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:27:02 -0400
Received: from mout.web.de ([212.227.17.11]:43343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbfH0I1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566894408;
        bh=Q3RzmFGlafLwrZMdhMfy6OReR7/knZfbcIt381IISEQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=rPQK7y466tE3EHkeQh1Yx1fj+gG2ziBYhMKN51NGfyc6eaeJFmQEOX8nsCbCDXPQK
         vlErZKK+6xK41jTQUWVV9H0AgFci/6H+f1sFrQcSlXAFzOzCg5giFZZ6jvEcQr7Hqr
         o7GizH7lB1NQMhImKJ6ih1MSOcWIt4m/J0IcIJv8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.232]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkyIj-1ialdK33pt-00anjT; Tue, 27
 Aug 2019 10:26:47 +0200
Subject: [PATCH 1/2] powerpc/82xx: Delete an unnecessary of_node_put() call in
 pq2ads_pci_init_irq()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <lkml@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9c060a41-438b-6fb8-d549-37c72fae4898@web.de>
Date:   Tue, 27 Aug 2019 10:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GSUID08LZurS7CQHIu10OnBtmTflRlh+77SCgRUzkqFza7LvP3P
 l6NdK9cjnWOYY4NtA9h2c5Lo9ghp6rGbB3eby/PaNOj5DCxi09EgmvKxuiLVvXvPo1WYReg
 LaQJ933/gQYL+QctiYNtCMKvgeTggzu3I3HRhjSQ4FN57apMcpAd3jXa0ORVM0wZnGGpVL9
 HdyX5XRR3MGF5pCHJYvTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6n+zhB3LMis=:slif90W6VPvdv128QXAjSb
 fSDe2jaVXJm2AW+O8Sr4kaBUNMxcuc1OXYm6uL2dRUm/Q6t6tAIgWxn8N0W4zfcFb/b/xVDTH
 tIK/Rm39HFnFuK17mhAuIcVqin/mcFk0irGWTTT31GG2FZcb+toKqP6iQku+D0383hiPlKWr2
 XOIxnlPG/FX0iF6KV6WbW5CJbE4NVNrMNaUXUCT8Kymfxvbf26CeLm+56CEEJ9c7Ep0SNdYDb
 Fxz77K6RfuOhqOo2KvYn6spXGLG6hZfRLgB/OVtdh3xRUlvvIzEVtXRNIGdZz9+dTuzYNXuuZ
 OS6S8eAUPS84IH/9MJKiMiy2c+GrNPsWYcM9Q3SBvT2gW9hLT60pyPFZzLZ5HYGtW7fUViOOh
 DLr/s9Qu5vUoyOwP9F+V7KM4Tc9kq/t6gXrUaT/jdZCGC6+un5qteaXnvuISiEHjvDbWg2fY/
 kxBz2Zxj8if5vfdLlg7Aa6rmJFVyptn6OSi3Iqu7dQzJGPnniLMhoYsDbTuLzGI+sJMGM8koI
 5cznIeupDTeMjKnhGRyILT6Ef2PusMBQtDtWHRn9czNBuwedoZ1Imr9o6d9B1+QOli0e/vJpG
 Zbceg5VI8MTGWsMVPeHlxQ6SlgVhCA9Oyk7PzkijXWEc1Ak0ijYVUMtKHvZ3J0OPLAajIjyFf
 13xr96tg8ywKYtGkDuyzzQc+KCRGKimZgxyV5DeYdry1M5Q171uIqqZVFUEe4HJPl7WliNuGI
 G1Ae7Gb35is5BIY8xvWoFWwedEnzSGWF0J9j8qXX98OVvm2xwSBn+A/8Ai2CJbygTAxAQTvEI
 u8lKoQd58p5tvHMFt5H5S6mh0LiggSNE4FgX23zULEXYlZyi1aj+WhwcURPG2vpxTWHKvNQyV
 /Gegs+LyL1/7ImLgfh1kvTFN6xbzgKpr7GRsjYOcgFr4RSLHx/PSGYFf+vU6Wt4lWaa4UAgrd
 8u7yOyRV75Rs66cpLuC1dDpazCl5c0GAJ7Th2yyWqcx0cn9zi2K+gj5WSWm76WcAYQcDXCLPt
 23d6fiOC+TyNL7J6xatlJTEADpC6Dq+FKvY1rQtJveYNDE5giBTEyHWVG1zn/uw7B11uxAsC+
 bQJZXSonHfWsyeZb9m6TK6VM/7irl398uG16AVpDR6tYF6SPLAXZ1EHn4wgF/+Xr217df5MYU
 SOqqKQyltAM+EA/Cp39NUm+mKUt9gyjmb182wdbl2BEVOMpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Aug 2019 08:44:20 +0200

A null pointer would be passed to a call of the function =E2=80=9Cof_node_=
put=E2=80=9D
immediately after a call of the function =E2=80=9Cof_find_compatible_node=
=E2=80=9D failed
at one place.
Remove this superfluous function call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/p=
latforms/82xx/pq2ads-pci-pic.c
index 096cc0d59fd8..6cc054db7043 100644
=2D-- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -123,7 +123,6 @@ int __init pq2ads_pci_init_irq(void)
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,pq2ads-pci-pic");
 	if (!np) {
 		printk(KERN_ERR "No pci pic node in device tree.\n");
-		of_node_put(np);
 		goto out;
 	}

=2D-
2.23.0

