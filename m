Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE27C24680
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781072;
	bh=x88hTkT5ZvJPKah2VvdrZDLkwYcGhc0fgga42mM7isA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=th7tX51hvQtSeaA41j4lvV9qSY8z1c/Wa8K6TDsteBwaCiEg+sk1KOTYwAs5bUywg
	 ZbKutDPdx7QwFgTWWkHyZpypJgomfaE5Pan5d3tU8qXQeRihdSSkR6WSzn73gVephS
	 Ay7jtVTi3OWlbN3wkuri4iZBzOI7oPbRrEXUKjpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfLSSob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:44:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbfLSSo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:44:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A10324685;
        Thu, 19 Dec 2019 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781065;
        bh=x88hTkT5ZvJPKah2VvdrZDLkwYcGhc0fgga42mM7isA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJJau3xsB4Km64OFNc/m66jmcmcawETsuVwlVvldAz0Y7BxKvALI7OBP9JQQ5h0Ky
         dm0wiB2s7icQTSJoT7v6DpQSiutwVmBfVLQqMyKDTnuoRcEQDrfPYpX0FkzOnr8rof
         TfVgZ95MmrJWWTDaIKsz6dirJN+03Hhmm+FQHXL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 041/199] ACPI: fix acpi_find_child_device() invocation in acpi_preset_companion()
Date:   Thu, 19 Dec 2019 19:32:03 +0100
Message-Id: <20191219183217.213974885@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
index 719eb97217a3c..5670bb9788bb4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -77,7 +77,7 @@ static inline bool has_acpi_companion(struct device *dev)
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
-	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, NULL));
+	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
 }
 
 static inline const char *acpi_dev_name(struct acpi_device *adev)
-- 
2.20.1



