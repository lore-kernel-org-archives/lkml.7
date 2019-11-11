Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6D6214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497695;
	bh=whj7LZBqF3gxyM5GfVvToA8R3A+JBFrbIyG1RZB1At4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A5AQv1ZxAu8Ddhw8fhcFUiHMMy5v14dL9BI59rp7WytBJE1WtuRkJKqzuyQ9YCx3t
	 43dU0tX301Qf9gZrk3jvh0FSgD/ZvXlKN1Jh9cEy2BpYslOx4rcixk/15xrkNdosak
	 SBTcq/+xgJzHMvu5IHsjJ2Lm52x5+WZk+RkDUStM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfKKSld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbfKKSla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:41:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF11C21925;
        Mon, 11 Nov 2019 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497689;
        bh=whj7LZBqF3gxyM5GfVvToA8R3A+JBFrbIyG1RZB1At4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtztTk0+Yq9ZIXF6eJXdbQZXUa2p533vXbF8uHx+bJZRqdLdLkSZQZDZnyjjQ7A+/
         gS12DdSTx0krfCAfFP8/MMDFzWYLMpbhLiwCXJpk9tfYu0D9VM4efdNIcOrXsGXhsZ
         bnheKjArsDXgqtsMI+C4S+NwRMMlAdSbbWU5XSuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 028/125] soundwire: depend on ACPI
Date:   Mon, 11 Nov 2019 19:27:47 +0100
Message-Id: <20191111181444.620454183@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

commit 52eb063d153ac310058fbaa91577a72c0e7a7169 upstream.

The device cannot be probed on !ACPI and gives this warning:

drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
not used [-Wunused-function]
 static int sdw_slave_add(struct sdw_bus *bus,
            ^~~~~~~~~~~~~

Cc: stable@vger.kernel.org
Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Link: https://lore.kernel.org/r/bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soundwire/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
+	depends on ACPI
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data


