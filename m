Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D5ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D44D21D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbaRKl9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfJBRDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfJBRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so20534363wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PokOnzm+oPBOfuUNXGxhTnYV86Xe9IUth6ohOE2Moc=;
        b=lbaRKl9Sw32KcoJuKhy42btRwwnIf5qJkXgklbtMtdTbbKv9pfLbW8DQBaa9xY5ueH
         mmbRwytKylLFYjmSQZTewjfV8VsUpRx3BTL+xqyuRXVafUDmdiCQwyN3rSl8WcqN95Iz
         kEt0DMUYERZOm/UNlapCkAufqsyg+s2LwOVIiBtgDyHRALMfem6bQFzj6rvW6bTNTQrK
         chCtI4XLB6lJZAuPsb8nnelrEJPjBDa4btRcSPvvNoI6U7StdRMeAEiqS9g0cTY+LkUb
         vRoX7QmBpMW4QJw0JDclENNx4D1okrRBxnYuJyl2qTuwqd9bB+ET/kBayqgR2YuoLRPM
         AdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PokOnzm+oPBOfuUNXGxhTnYV86Xe9IUth6ohOE2Moc=;
        b=gVJzrEL+kWp4DddaAmzzdynevlHLRmFkhccysCLlmJLUMnqAMUk4f6riiig8qENv1a
         vU4RP9YhkrLxlvuNn4QVHO8FOxToyDEEOWO0KGrxx70xYTP5SUs7J99RUKRWahWUGh8R
         2DW1yO687BV0lBZW6cF80sBNKiE7LvraJETl6aTvf491FKLcn+JHFt37TlGKBKeZ9A3/
         1VfyFwT2Au6gfrAXB0BLsw5HYrMvhYs0zerA62dloNKduw3EXuHUFco0r3YU7hC54eoF
         fF7oD8odbrzNS8KUM5FgV74v5nf9QjgmBafOvHsyoj70sf7CHD3CwKToAbi03CH/U4zY
         Vb9g==
X-Gm-Message-State: APjAAAXJ1sxEhZtNNQnoznfZXWD1/wE3yDjQrglKgTYx8IFRBuAMITke
        9d+AYtjegDbGGVvaCXr3Q53+ng==
X-Google-Smtp-Source: APXvYqw9MCV1O+7Aq+XDMSajGWDzKNaYl4/YugE0KOmsVoSAQ8Gzis+ttdbZXeFqTIP6ndQafnLeAQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr3787044wrm.114.1570035830342;
        Wed, 02 Oct 2019 10:03:50 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:49 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 1/7] efi: cper: Fix endianness of PCIe class code
Date:   Wed,  2 Oct 2019 18:58:58 +0200
Message-Id: <20191002165904.8819-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

The CPER parser assumes that the class code is big endian, but at least
on this edk2-derived Intel Purley platform it's little endian:

    efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
    DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017

    {1}[Hardware Error]:   device_id: 0000:5d:00.0
    {1}[Hardware Error]:   slot: 0
    {1}[Hardware Error]:   secondary_bus: 0x5e
    {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
    {1}[Hardware Error]:   class_code: 000406
                                       ^^^^^^ (should be 060400)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index addf0749dd8b..b1af0de2e100 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -381,7 +381,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
 		       pcie->device_id.vendor_id, pcie->device_id.device_id);
 		p = pcie->device_id.class_code;
-		printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
+		printk("%s""class_code: %02x%02x%02x\n", pfx, p[2], p[1], p[0]);
 	}
 	if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
 		printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,
-- 
2.20.1

