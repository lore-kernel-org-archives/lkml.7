Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E123400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lqfcfkmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfHVTZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:25:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34825 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404387AbfHVTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so4018727plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=LqfcfkmpyJUSc2aXfZWs3W0xMRRcheys90Q7EO54mjpiPWnL9sBnbv8XMLomSSx8O9
         9ktpA4rZhdplpQ4ro5QS7HE4S//9qBDE3luw1BnSeewiMlF5fftt+LT15Sit1z7GBMmo
         yaCcSKkt+tggxjuspHuFaMogtb3SCbr2pE7Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=WAU3yQhQqs06QolixXIxP3Qf2NYto7UCBpik30pjvdmNFGXnz8klM9ZZ7zW7vpFhrl
         SomAp52IYdnifRFdEZD6p3srdZvKhpq2ZjyLHeE13LakuDOt6MZHjAt/8e41LNBScq17
         yA6fOsWa1KgTebPnaxZzXAcpxHTgwGdiZM01g8gBYXJBFK75GqmOo4k57qS/5nz8Uamq
         AVztdxpNlFZV4I1Zo5yT7uvGYzOkReyMQ+qSo8D58fQXhI7moEKfKdcGMgNjC4mch3zO
         E1EZew03wwO/5bYqzme+oMWUj8zMJulb9TQN4U0tqBtM7Vhdyj2NVyoVZ+3IQfkDmRZZ
         eI6w==
X-Gm-Message-State: APjAAAVMtVtLa5WJTJe7wq5R29Fl8TLU5xVrDNvaOvt3OGgk1CTb5VXt
        glP+4tYPl/f8ltc69sL1S+EQPA==
X-Google-Smtp-Source: APXvYqxTvONL03yjcaj7MsrmAUaBSFUgWDAcWsFUDtXLuMO0GvKeUtS496WfXIlpijUGpqlrHgo0FQ==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr441791pls.213.1566501924580;
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 7/7] MAINTAINERS: bcm-vk: Add maintainer for Broadcom Valkyrie Driver
Date:   Thu, 22 Aug 2019 12:24:51 -0700
Message-Id: <20190822192451.5983-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom Valkyrie Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08176d64eed5..6eb2e3accf1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3456,6 +3456,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VALKYRIE DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

