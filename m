Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D5FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CAA20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="teFd2WnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503002AbfJQOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:48:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33124 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502979AbfJQOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:48:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so2136831qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vUJT2Qh/Q7E4yV5kXGaSdEDPkzP3Re2T3Ac8dtJnz60=;
        b=teFd2WnUU2jy7DXS8CqLyIcajpF40OQ5fc9H3SGfalFHeNPJIfvYzMT0s1vS75yGB7
         cNS1B+AnAwU41yRMfDdc3p2vNYg2ygg/1xscEAKYXycKkEE08DV5KQB3RguY5aX2a3NX
         eS/NCECfnNL6GbqFgK97YAw80JnEWtxVFyoAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vUJT2Qh/Q7E4yV5kXGaSdEDPkzP3Re2T3Ac8dtJnz60=;
        b=ed4R71Uzu5zHW4r/I1fmld97J+MibU/2WOVKnS1r9boD9NYSfSEvVT1WMpO5NXjP8S
         g6ewXDNYF6dmeP7YDLjpkL2Bhb3ldzI0FvuQFbQGd2/jm2z8Y0FX1B2r5Lgy4p1NKhGz
         OhEeMe+QMSqD2v9aTfqAFEPuoDyc/AWgJci3vuOQzUAFzvx5cajQ5KI2b7/24UMT3UKc
         Kl+hZ2sEKAVc1oqE/XvxAL8WNXa+TGIgvH7MvoEGNjTgJDrUZFms3tk7OipZjhK7ubdK
         70l9NCwoTBQ3tdfVEvsI5fs4RDhmkqV3m1bhKKkGGuhqhaYedCAt4Pu6qhLYEku79Pcs
         OrKg==
X-Gm-Message-State: APjAAAW7mPpGfZAJ/reL+MECZjOy7h/RRVeThoc8aGmEeY9AlKluWPur
        ev8Vz5xjLFYPN/W3kEdyb2PKBQ==
X-Google-Smtp-Source: APXvYqxebP0akxMPP2wAUUOeB7/IWHZ7DQyZW4MDIfdmVe+Eis/SfqpcRGSxVQbAO1uKi9Cn5cxg7w==
X-Received: by 2002:a05:620a:98b:: with SMTP id x11mr3646910qkx.257.1571323722496;
        Thu, 17 Oct 2019 07:48:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::b253])
        by smtp.gmail.com with ESMTPSA id s16sm1039070qkg.40.2019.10.17.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:48:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:48:41 -0400
From:   Chris Down <chris@chrisdown.name>
To:     linux-wireless@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20191017144841.GA16393@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IWL_WARN seems excessive here since this can happen during normal
operation. Every time I connect to a new network with 8086:24fd I get
this as KERN_WARNING on the console, which mildly distracts from other
more pressing messages. For example:

    % sudo journalctl _TRANSPORT=kernel | grep -c 'FW already configured'
    403

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5c8602de9168..ac7ecb76d964 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2264,7 +2264,7 @@ int iwl_fw_start_dbg_conf(struct iwl_fw_runtime *fwrt, u8 conf_id)
 		return -EINVAL;
 
 	if (fwrt->dump.conf != FW_DBG_INVALID)
-		IWL_WARN(fwrt, "FW already configured (%d) - re-configuring\n",
+		IWL_INFO(fwrt, "FW already configured (%d) - re-configuring\n",
 			 fwrt->dump.conf);
 
 	/* Send all HCMDs for configuring the FW debug */
-- 
2.23.0

