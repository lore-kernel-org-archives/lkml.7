Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC77920B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810959;
	bh=kRawRg+kLkcMJc/eiEA5SPZ7cOmi0+y1rBmsHKgLpvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YX8GzUwvaObs8bUnxYU+ycBCXr8wq8qQDTNxzYAnZqEVsmKNvnFF/vi2frooPVYOk
	 nf9bsP2a75nuFU27/alirBaE+nEQ5rnfFQu7OIBSLKsB8jYdpNVOY+YyQo5dTSIHsy
	 SiLcPEomAqqYiemld39MTCZq0FkOh5daLINj/iYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfEBP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfEBP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:29:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02BD1214DA;
        Thu,  2 May 2019 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810953;
        bh=kRawRg+kLkcMJc/eiEA5SPZ7cOmi0+y1rBmsHKgLpvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MH8yDFAbQ/MQdKQltm/G6oY6YR/s7PfS11dCxmGfbwJH0ZktZQzjigiOSI6e2rCHu
         NVMDN0EWttQfuqMnucstajBg8GD6eKPlrQz9ETTFTMsxFEAgqnauP5p5dO899Of7x3
         IiTfe4agJSAR7xad4eFw/hAbVH482LN5UCbk10nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Hirmke <opensuse@mike.franken.de>,
        Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 002/101] Revert "ACPICA: Clear status of GPEs before enabling them"
Date:   Thu,  2 May 2019 17:20:04 +0200
Message-Id: <20190502143339.638091641@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 2c2a2fb1e2a9256714338875bede6b7cbd4b9542 upstream.

Revert commit c8b1917c8987 ("ACPICA: Clear status of GPEs before
enabling them") that causes problems with Thunderbolt controllers
to occur if a dock device is connected at init time (the xhci_hcd
and thunderbolt modules crash which prevents peripherals connected
through them from working).

Commit c8b1917c8987 effectively causes commit ecc1165b8b74 ("ACPICA:
Dispatch active GPEs at init time") to get undone, so the problem
addressed by commit ecc1165b8b74 appears again as a result of it.

Fixes: c8b1917c8987 ("ACPICA: Clear status of GPEs before enabling them")
Link: https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1132943
Reported-by: Michael Hirmke <opensuse@mike.franken.de>
Reported-by: Takashi Iwai <tiwai@suse.de>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/evgpe.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -81,12 +81,8 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Clear the GPE status */
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
 	/* Enable the requested GPE */
+
 	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }


