Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FAC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615921743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBU9AEBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfFMPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:08:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44769 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbfFMOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:00:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so11897266pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GBxc625eYrtbddlYla0FlNTwaicUbHuXFR8fhmI/WsI=;
        b=CBU9AEBTYmLd35er+8PFQ18pl2PQp8t5kGKTFVsuBYsbkBnHUE/M7aS9QmVzELRdja
         fFb31me7CHwIwDe6LOe8/XL/wE2msLCxddm2RQvyobGugc1Jp8Uc5ro2LY6dsCHsnzp/
         5hRJ2/wq0x75/vUF9wTflq6djoES8pVomX4XVHsM49Ya0dksm6SGphGx0lD7McrSXTB2
         uRx2aKTuX49aj8djKZcvktSMAgEKX6h5c9wenL+aQ9NKHOmI4O+v5QddB8q6H56IR67a
         e1WVG850paFkZhNannCTksrAyFftBmeNap8YW3fdH9IHgAgMug5P1hF3nWPVI5tpy11F
         zdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GBxc625eYrtbddlYla0FlNTwaicUbHuXFR8fhmI/WsI=;
        b=Vv7nFvp6hpJiXf0GhoFdPB/ncqWNZB8h8xC/UNTpXQ7vwlMmGNPMH/GoQ5R+NwXG9C
         pMZSMSbXrFeNSWQAclqmaCnW6+NjnywnxwUZV0QNKREWAGXLY6OM3zOkvzqyF7bKonrM
         RqT1CROdiF/G7rhVHv4p01CLFRum+669TrFXMH2yj/jVZDq34YLs1mepWr9lOx/exmdb
         f5EhveoEkRbNn2xLZYdz6ZJa98xOAduiCYuORkVUPV9LqeRenDf2K5Dfj0zTil+j4oIZ
         4r+5Bqfm43xL+/CoS79SNeDivMQKP9De9A8A0k2xVkcduxcY/hK9Qzgy3G29GtVz9mbt
         Pomg==
X-Gm-Message-State: APjAAAX88jmNE1r2ADi4QmQb+Vd48O+6nxnu+oUa/RLhH2i+bbRvh2BP
        +2QAQcZEMGD3LxqoZf4miUA=
X-Google-Smtp-Source: APXvYqyf++okW1hlc0uB1CnomevfviZVVWkruPC1EhA1XU5eAKqFeMKP7a63Fgm/9Jl86UNNB9J7Fw==
X-Received: by 2002:a65:5004:: with SMTP id f4mr31629723pgo.268.1560434414046;
        Thu, 13 Jun 2019 07:00:14 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id d9sm3515324pgj.34.2019.06.13.07.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 07:00:13 -0700 (PDT)
Date:   Thu, 13 Jun 2019 19:30:03 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Use the correct style for SPDX License
 Identifier
Message-ID: <20190613135959.GA4819@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header file related to Firmware Drivers for ARM SCMI
Message Protocol.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/firmware/arm_scmi/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 937a930ce87d..44fd4f9404a9 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * System Control and Management Interface (SCMI) Message Protocol
  * driver common header file containing some definitions, structures
-- 
2.17.1

