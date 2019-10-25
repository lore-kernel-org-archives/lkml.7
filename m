Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF81CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EDF21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="kshr2qIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404388AbfJYGKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:10:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34357 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394263AbfJYGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:10:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so871462wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=urdSZrEfORclk6zL/+g0MK1/k4SMP80YLlGcZvUazOk=;
        b=kshr2qIhGH1DuUvrqG0fFgLfQD827XA+G8f/XiEq0Ilxcg1KMf8hVPn243UErKq4w/
         ZqdcFd/xi6aB9CMpjRGEumXNJcJconNO99nJWY5GGOxOMnweK1Dht1ywjgD72PF89hGg
         wyU5zRBE9SXS9vgASbCv4P1Phu3LYS+hRO3y+D5NyJlmsY66fsuX/M6fCRFWKL+q2UxI
         wqJQ3OG5k5Vv+JWYgfdqdgRZUc9sFGWYZO1DedrcoCOmrJkhtorw4o91ZfH+kpOz/cML
         ce11UnICMKHEzoSBvRmSy63bb3Q3ONY6zoa7MO10UXndnHUe1mrXDDfAMQnJvU0WferN
         bTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=urdSZrEfORclk6zL/+g0MK1/k4SMP80YLlGcZvUazOk=;
        b=POFxa+/ra8cbliw4J41EOgfFWH6w9g+GdvxQ1BRRX1/s0UYZfaKhh7YcnYzv6Q7jEa
         kZBvnxgnUnFGFNOURqhSAFa7BDR8FvBF94zlr9mzhJn6A9Q6Coag4hwpkK9/rQeCGq60
         viC3N63WIE8R+sG1LQM733vWfNNL19sO3c0Wu3a/Rmyrevb4EDVhynE5R+asF2cpvns5
         aLgo+4aIbG8w8nxzBAikhmFxjlIXpiS1BoXQNSsSSk8xNwoGv6SX0LU+LniwepmCt2IA
         dpuFDDzW46d8sNChEXDVIZl4soqNU07gRGqEFythBREQbEGcdVsbCQQk4tx1ln5rPQyi
         OQdQ==
X-Gm-Message-State: APjAAAU/tmjVuVN4ES7xQl3IPA6Oi/GzPKYr1KFfzZMg73JBb+KvDssZ
        mKMgi/7RRFHRpPibvPiXo8OldEQRErfobXfu
X-Google-Smtp-Source: APXvYqz8LkDtEZTzsDKuLH9UrK6btdapTCbVwzfYkAqutNcBUrskoovD+oFz0se0O3wUik65+/qPDA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr1110459wru.370.1571983848501;
        Thu, 24 Oct 2019 23:10:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w22sm1097375wmc.16.2019.10.24.23.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 23:10:47 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Fri, 25 Oct 2019 08:10:38 +0200
Message-Id: <514e7b040be8ccd69088193aba260da1b89e919c.1571983829.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571983829.git.michal.simek@xilinx.com>
References: <cover.1571983829.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1571983829.git.michal.simek@xilinx.com>
References: <cover.1571983829.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Waiman Long <longman@redhat.com>
---

Changes in v2: None

Origin patch here:
https://lore.kernel.org/linux-pci/20191017181937.7004-4-palmer@sifive.com/

---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.17.1

