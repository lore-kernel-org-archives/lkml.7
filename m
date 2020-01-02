Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5724682
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NeQ0wlWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgABPvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:51:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgABPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:50:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so17955430plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GENgxy63AoFh0BOCNtfVuuosVUuHdXo2BMjGfPBx85U=;
        b=NeQ0wlWu2/J9YrsMzVzL356bbSdO+ZmN/0IIDuy3ylBBEr7HeytLMVfEVMUZZBBItS
         P7oLojGDB8mtDu+bn2YMnegrMj6jNYQlu7CaxDWUT/BerQOW/QeoG/H3eGOB61nf18cO
         u/WUzd0VSsxDwILlr8knphL4BvaRaAGgl5BZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GENgxy63AoFh0BOCNtfVuuosVUuHdXo2BMjGfPBx85U=;
        b=Qa8lwcznmKWBtJzxOkr/RwI/UfKWj9cI9+IYD5OLsSc6/w69gFyXT3oHviTGMfWUCB
         vHFUIetAc8ScSkKcAykS2Lvm1HxG1s5eRhdZabBERuOrH+qGl+SYwaTHI2FTzyl99z8C
         1ezgjrRuvekYpe+/sEza2C6Jv6ZcMl94K4F8Yt8ZzcKHU+ECam0UROqszLVjDgk1hY6V
         Jq5zNMez7BRRdMMBjEOS9zLaO1GK52LRaNxGS9qB2DVT/9ELXY0RrkwZ7Lbz+Bwa4n9c
         sqzC0PJP6sIfYSHel7f5XuWZEY7+jESlbVhNbxYe/RKFKSyPsVQZTzWKY88eEiDIhPPl
         KBQQ==
X-Gm-Message-State: APjAAAWnbDsdls4uIZsYIaU9ZR4LjRmwcdCZMxfSfevu9uX9O88q2dZg
        adoXYMYHR17njhH2sgwswzl03pGWo79BrA==
X-Google-Smtp-Source: APXvYqzZLp15lKkIt+gXEryl82JVrBpljCNt2vLi8pxbdDuPNo67f7PZs++G25Ux0Hx5EFFPcVqPkg==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11mr86055304plb.147.1577980258866;
        Thu, 02 Jan 2020 07:50:58 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2sm11499420pjv.18.2020.01.02.07.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 07:50:58 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vasundhara-v.volam@broadcom.com, vikram.prakash@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH INTERNAL v1 0/3] Devlink notification after recovery complete by bnxt_en driver
Date:   Thu,  2 Jan 2020 21:18:08 +0530
Message-Id: <1577980091-25118-1-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 This patchset adds following feature in devlink 
  1) Recovery complete direct call API to be used by drivers when it
     successfully completes. It is required as recovery triggered by
     devlink may return with EINPROGRESS and eventually recovery 
     completes in different context.
  2) A notification when health status is updated by reporter.

 Patchset also contains required changes in bnxt_en driver to 
 mark recovery in progress when recovery is triggered from kernel 
 devlink.


Vikas Gupta (3):
  devlink: add support for reporter recovery completion
  devlink: add devink notification when reporter update health state
  bnxt_en: Call recovery done after reset is successfully done

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 14 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h |  1 +
 include/net/devlink.h                             |  2 +
 net/core/devlink.c                                | 62 +++++++++++++++++------
 5 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.7.4

