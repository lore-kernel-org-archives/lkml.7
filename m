Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB969C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869642190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CA+DHDAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfKELa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:30:57 -0500
Received: from mout.web.de ([212.227.15.14]:41891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfKELa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572953423;
        bh=v9/3tGIUXP+Rc5WO9HEDBxVSoQQRQxOxc/FWNESEPzo=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=CA+DHDApyhds27DN2CzPLD+7BXBwTIYEw6luj8cgmNwsHm/dJeq/p+7bzdjou+bQ1
         HmZTJYOVCN13mprLgi+FUq86rtWNKFQRhnWoZCrsySEkeNBolHRfai2tqVgUqNO8nX
         cLXECCohlDYD617mW5Pf5Qk4NkdFtzvXMPR3Ibs4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.204]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUEoU-1iJfZ70wd8-00QwxY; Tue, 05
 Nov 2019 12:30:23 +0100
To:     linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <maz@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] irqchip/ti-sci-inta: Use ERR_CAST inlined function instead of
 ERR_PTR(PTR_ERR(...))
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <776b7135-26af-df7d-c3a9-4339f7bf1f15@web.de>
Date:   Tue, 5 Nov 2019 12:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZIYL2Dh89bxgwfXHZn46bFKEDCu40YGgF7ZYP06RA5Xo3NqAay+
 9+FBNAD7KGJBA8C+kgURhnL8TiywTXI1UZX7/D438CBIQXUtrgWmWiUbWoeUDEcXPoXL5ll
 75FpMVV29lBVtjOWyHEEppzTliCshb85+IQvzaiRWQ727ZSve1ax5G+lNy8fjwJN+0kAY8I
 C/lBhwmzE6LF7vjsF+J7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9nnCOMbphkg=:Vxe5SYY3XiLnl5qUzNmQfa
 gc28FlCGWORxnKW7SMSMEBbKr2JXh7nP7/PVJb33VzauSCnrqmAK8WXMy9/bhExH07ZE92az7
 hBT/J/JJezmrct3+S3o9UdtjVaUhyTC1P9TAz9tDtsCVZ2p9lLc5K/fvsGMbd+YbcrTGpB9IY
 eNovvne+0CNPVTcR93/emKMH5y0Cj0SUvH00dYGlhieY37nFHeuAvhP/zCpPFo1YoVAUfNJzj
 yY2Q+odpctCWq6YrgI0IOuiPiSwQJFhsLDfQcPeFaM5ibOkhckhT7PKtXXsCxucP8EJ7W9s03
 W5znAx5KcycMZYsgEMJSRDIZ2uJ+/iyv67piGYj2OR+K88cXhWSieupRgq4NwvZwaXP3RJt+S
 qwAAmPUq3vGPGDObsarDJBEuuIIqY0dg0pANbZuKId5KOzkMFW8JfrS5/yuedIpc8Z7Mv9juC
 U8R6Nj+KJsvDZiYJCH58WjUcld5vV6aQqpAmBDxqI8SFxLBKVHWcXsDZbYACwW1L7KRRMau4r
 I1Gto4kmtiqwj4eUDyUe+BrXp8Qm5oQgNHG53h2/43OB2aAsUDD0UFsydjAZizIKeCqhhuqCw
 zQ0aPbZbKVzIxBCSm3+S7x9T/e0qecyzudrzs+aKttfJCc3sgZhus1xil1cETVp3J5FqnKZ8Z
 1YXVwAA9byJ1tDu3FbtvT5Yov+lOSpitHi7EIDqKe7txIkS9plX6SclOA2E0a5Yu7T7pEi71c
 4YcJbENeRQol6OqEpleAm6vqFLQfgl/SCJzfmSl4iqpz5uf7XvD4FevQn1HlTmKgYyIoN5Xr1
 o6kZnzgPtyNqBbFoHWZzJZRr+2oXdnAbnzv0T4srVzAEDMo+uli7Y+UAYNQbhqttGJHAvn+DB
 WWc9TizGSn9cUGo0p3v5WxQ0JVcrdwGyNlRYfQ8K1UMRfOFMnRwbC91AAWh9DAIj0KzD/ouvk
 ik0kVlaYcgxy1B4pmRHLj3f7z6YB/99LtCp+FNSG9NKJFo/MC3Rz6ZQCmb+GMeDB73EJWuYzZ
 63QrN4W6MgoVa7Wrh64NykpvK16a1c8mChhKRMFsnIZ2L8EhN17Y1esnYi50hUrNqBZSzlzHj
 TnqU2qX/sqoPHED7WcOwNyP1LH9Eg5JKS52ESasRwVgzXE0wzEAsnho4yKXorsT1mQKgAqK/4
 53IujvmeEyaOG4XcyPuw6wiiAcnJ0vcZHoOPgZzhDgSChX6HKboAEWWrgQUFW6oDvC5MYcXpD
 QSDHAv6pRiVOXQ9sgWLIWL0ijF4L7HuRVHkQcZ1lJvhQnC23JngQpjRS7OTs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Nov 2019 12:19:39 +0100

A coccicheck run provided information like the following.

drivers/irqchip/irq-ti-sci-inta.c:250:9-16: WARNING: ERR_CAST can be used
with vint_desc.

Generated by: scripts/coccinelle/api/err_cast.cocci

Thus adjust the exception handling in one if branch.

Fixes: 9f1463b86c13277d0bd88d5ee359577ef40f4da7 ("irqchip/ti-sci-inta: Add=
 support for Interrupt Aggregator driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-ti-sci-inta.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sc=
i-inta.c
index ef4d625d2d80..8f6e6b08eadf 100644
=2D-- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -246,8 +246,8 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_allo=
c_irq(struct irq_domain *d
 	/* No free bits available. Allocate a new vint */
 	vint_desc =3D ti_sci_inta_alloc_parent_irq(domain);
 	if (IS_ERR(vint_desc)) {
-		mutex_unlock(&inta->vint_mutex);
-		return ERR_PTR(PTR_ERR(vint_desc));
+		event_desc =3D ERR_CAST(vint_desc);
+		goto unlock;
 	}

 	free_bit =3D find_first_zero_bit(vint_desc->event_map,
@@ -259,6 +259,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_allo=
c_irq(struct irq_domain *d
 	if (IS_ERR(event_desc))
 		clear_bit(free_bit, vint_desc->event_map);

+unlock:
 	mutex_unlock(&inta->vint_mutex);
 	return event_desc;
 }
=2D-
2.23.0

