Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B1C17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7402184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqlemseb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKLADo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:03:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbfKLADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573517023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bsoa/zduDjdjsB3b7JEy0vJUwhAm1R/rZnjwwyCHBSg=;
        b=eqlemsebaEDOTyT9rJy/zvl0872dwmqpWi8/ZEiYbRwfmgCOAxE1nbWmyincGWc68KD6jk
        kyZYhRb+X2QjP33JTPTzYEbwmwbRk/d6vrQIyfoVKXYNG7Znmdd9LwKBgSgzDW5UQA23aa
        CKqWirpQybQebGnjdZaJgAHQhcO1UIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-DZiGzyTcM0mQ0OcBOivYAg-1; Mon, 11 Nov 2019 19:03:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2832800D49;
        Tue, 12 Nov 2019 00:03:38 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-116.phx2.redhat.com [10.3.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86A8E60852;
        Tue, 12 Nov 2019 00:03:38 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: [PATCH v2] tpm_tis: turn on TPM before calling tpm_get_timeouts
Date:   Mon, 11 Nov 2019 17:03:37 -0700
Message-Id: <20191112000337.18898-1-jsnitsel@redhat.com>
In-Reply-To: <20191111233418.17676-1-jsnitsel@redhat.com>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DZiGzyTcM0mQ0OcBOivYAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With power gating moved out of the tpm_transmit code we need
to power on the TPM prior to calling tpm_get_timeouts.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()=
")
Reported-by: Christian Bundy <christianbundy@fraction.io>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v2: fix stable cc to correct address

 drivers/char/tpm/tpm_tis_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_cor=
e.c
index 270f43acbb77..cb101cec8f8b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_=
tis_data *priv, int irq,
 =09=09 * to make sure it works. May as well use that command to set the
 =09=09 * proper timeouts for the driver.
 =09=09 */
+=09=09tpm_chip_start(chip);
 =09=09if (tpm_get_timeouts(chip)) {
 =09=09=09dev_err(dev, "Could not get TPM timeouts and durations\n");
 =09=09=09rc =3D -ENODEV;
+=09=09=09tpm_stop_chip(chip);
 =09=09=09goto out_err;
 =09=09}
=20
-=09=09tpm_chip_start(chip);
 =09=09chip->flags |=3D TPM_CHIP_FLAG_IRQ;
 =09=09if (irq) {
 =09=09=09tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
--=20
2.24.0

