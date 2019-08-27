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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AD72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="B6EgE8HG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfH0I2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:28:38 -0400
Received: from mout.web.de ([212.227.17.11]:39659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbfH0I2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566894499;
        bh=Kijz/kNQrJoEsdqYzBMm40EhNGYcSH4U5H2MUF6P01U=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=B6EgE8HGEjgJJWdg0vDO+HSISOEqLvngIMwVMwpqoynQn+BRzqhHQsBOs0lPjtyFq
         kQuOkHDvAeaRi9df1yyz0TI1XbspBN4utIeO/2z0SLmfSqSspSTyYVfbxjyXlaILP8
         ik55bKC/68R8ol5L/83IyB23l7qFHL6vemzqX8YI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.232]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ltnmz-1iAGVq2oLN-0117Zr; Tue, 27
 Aug 2019 10:28:19 +0200
Subject: [PATCH 2/2] powerpc/82xx: Use common error handling code in
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
Message-ID: <1a4bafee-562f-5eb4-d2bd-34704f8c5ab3@web.de>
Date:   Tue, 27 Aug 2019 10:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gK7A+dxt3fKGGpm2M9nJ9fvVY/qb+NE7oESdQhsqt33simYig0U
 IOgihCH6cngODXnxWog/jvQrwp3bW4mjk4e9ClqHj8p61aqmMqH6Thpxi4nV7rbqpP3i9/b
 Ve5pwUYOYjJFawKhDfHJ41AAB0gcfyCz/cu04O/Zex9ib+ACC396ukX57NB199W9s8mZj9i
 KyKrAETJLhWjDjPf5bJ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M6SUmBwiPnI=:sE/qtOGlc5iIVChoe0kaEE
 r33rWoQ5yqOVUeXZ83LDoNrw8IOeZQ5zJ4k52bqBuux9p2Jfrqs4ysivWxLTw15zfrX2DkiGR
 IbD36DZNsaH/AvNPO/xaU6CR/jrzdmwMCN1g4KhDGoAlrWKe7AM3So/76ZpF+EZOOJ6LADd1n
 w/JmBBY3YLB3KyDNf6B0ekirIUUhCHS8TVTOXVXhHGdFElebvi6zJP93bvJGhtalIzpGhBUpb
 p75VqLcTKjv7S8peYWkqpX4ULuXPqjql4wuOr/Pvby4K1HAreqWnG4T6uqwW93pVpTfsoaQA7
 Gmkg+BOToAoSN9kXvZ5txtWkElBQYgv6qKmuTyu0L8ESPO40PcvKeDO6fnSswfqaLalr+bhRA
 B5TGXOdK1z6pw1rtEiJDt2YtWdvFxAPpEB6JXAK92vEX37VNMeUu1vbJGz7qLHYGkWwA4ltVH
 NewvQQ5MMTwrNLU3skr/EqANKMu7qEJryY/PCEenDA3EMS6pilRK8brRvJxqSmjNkK2Zf2LH9
 o5DDcqLcySNBzGkZPqCoPIIrJtnuOuH9meYRaqIOtWBRHguq7RZpGBgxAg7dHtUXAkyEyOJAC
 ZsFCqd/kuIQ4pcSW3GOCt10r+oVd4uI1AuhUKwR8fS93rlOVXMXftbExHOp2QHzyBtVCNfyMA
 oghgBhCRzWlGYM6tqRuxoDAcJIVfSL+Zxm6/kpGUmfaDwwl9suqf8r3C086BNw3N9b1eMvBvf
 SAp3i0ROA5OKN7iWIGK3jZ7O/UzMjIP/xGq9MmHVx+M+yzDnQBjLI4tha8sLMmLUW7/KmdaqV
 5xxMN0Os5G5n30MyFC8HQDz76jxqCO4httlVJB82csF3o2P7EgKM6k9Vt41Jtn8oCAZGGY5RI
 Jf28qY7B0zaUh0qlR7Xh3JfvgxCkHnJS+YPAs0solOZAEsq22USE+rf7TnFHlGc0r/SYUb4Ts
 7DwXpVnphDYztbCFy6T250OPYwHf0M6NMGDsfp9yVMw4EJQjKnfiAMIVJ4L1uXJ04+F9ZGV4o
 5iftZiH84qFgtXTUwMeuOTXKm5Lxf6b5552ml0aqHYowKE+Ja/sCg+KAKn68bcG1yaUAxoIyD
 eAvHNbzHUwZUazYA9iPXPnOjvlkISCr401gZ1/FMxRjQkoXWh43+OYvyXcFv2E/G8z6DasQF1
 nKAY9jO7wELMmSmSdEBraUmHZURvFVGJD9joYJEwNSldz4/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Aug 2019 09:19:32 +0200

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/p=
latforms/82xx/pq2ads-pci-pic.c
index 6cc054db7043..f82f75a6085c 100644
=2D-- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -129,13 +129,11 @@ int __init pq2ads_pci_init_irq(void)
 	irq =3D irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		printk(KERN_ERR "No interrupt in pci pic node.\n");
-		of_node_put(np);
-		goto out;
+		goto out_put_node;
 	}

 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
-		of_node_put(np);
 		ret =3D -ENOMEM;
 		goto out_unmap_irq;
 	}
@@ -160,17 +158,17 @@ int __init pq2ads_pci_init_irq(void)
 	priv->host =3D host;
 	irq_set_handler_data(irq, priv);
 	irq_set_chained_handler(irq, pq2ads_pci_irq_demux);
-
-	of_node_put(np);
-	return 0;
+	ret =3D 0;
+	goto out_put_node;

 out_unmap_regs:
 	iounmap(priv->regs);
 out_free_kmalloc:
 	kfree(priv);
-	of_node_put(np);
 out_unmap_irq:
 	irq_dispose_mapping(irq);
+out_put_node:
+	of_node_put(np);
 out:
 	return ret;
 }
=2D-
2.23.0

