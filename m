Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C46C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66562465E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077616;
	bh=+gTot6Xamh4OGcgyY4DjpRJ1fYosJHtz1xkAHFKxRbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M38RdnfbXrCDR8pKw7t/phFoMF5ZdRKZrBdhoLcOgnY2bkCEHB3UOr8W++TeaJ3Z8
	 +gzg0WhRh5UYV+BVhTkB0xYuJajGzI0rPE/D9ivp8lb7u8nV5VjftfmxiT892YEvA7
	 QjCqT5pqCUcIO8GwtcsRTLLEYnWa1W3D+zFtc5YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfLKPUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732137AbfLKPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE1824654;
        Wed, 11 Dec 2019 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077607;
        bh=+gTot6Xamh4OGcgyY4DjpRJ1fYosJHtz1xkAHFKxRbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sw11xTuso2alQAGIBDolsOw0bHY7T2ny29C9ug2xvws4DvrVfPOtrAXPYznEwH+rU
         Vr3YfPDEmE1mNIFGQalHe5chO3DZORFe9s1i7kXpfACAB2/LZuH26aefIH/cv0dW4i
         p4vX5eAJijrLSRohCj5k0JHGFq7ZKG1UdEw7lX+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/243] ACPI: fix acpi_find_child_device() invocation in acpi_preset_companion()
Date:   Wed, 11 Dec 2019 16:04:23 +0100
Message-Id: <20191211150345.937843196@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit f8c6d1402b89f22a3647705d63cbd171aa19a77e ]

acpi_find_child_device() accepts boolean not pointer as last argument.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 59a416dfcaaa2..df1252e22dcfd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -101,7 +101,7 @@ static inline bool has_acpi_companion(struct device *dev)
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
-	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, NULL));
+	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
 }
 
 static inline const char *acpi_dev_name(struct acpi_device *adev)
-- 
2.20.1



