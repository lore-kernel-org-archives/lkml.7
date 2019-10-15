Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73BECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6962067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T2jYhvr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbfJOWpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:45:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42377 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfJOWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:45:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so7909946pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1bUylbnf/ijYUFyNHUOHrR4ReBx5Q/B7TVQ4ppAfqII=;
        b=T2jYhvr6TiadcqROfJ20FGuCM4Knyni6wsNlhfGxDMfXJAqmO2ladct5sVE19s7OCD
         y/xBOe+IFExKYknpQItRxW5zjsCXlDVa2TeOXNqR8JumpobSizb95jd3mLpL+doMVUJ0
         7OoKVGtGysY2GVTTOZHq6p8NfkU+tJqeNWdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1bUylbnf/ijYUFyNHUOHrR4ReBx5Q/B7TVQ4ppAfqII=;
        b=EVfVDYGsUN5v2Xo01Nn9isoBbwUfaF+Wpu402uQ1YAaRhKqBwIayN5/tCVZNXw8v7s
         tec/FJ5HrZpddCTeU1Jqwlm0LQqLgQu/78c3EuxGJnAIiOLmzn7qO/UYvfe70u3/AXeW
         WFD5pl+LASoSNrGoydIpbuw+nK9EgE06acfhN7lEpKh/L/bXmDr/HBsoULJBfhou6JpD
         e+5MI6cNcwYCg3P18VwtALHYRmdKB20K6NZat6D8AByLVM8fV5qb/0ia7Oe2TR4zaSLX
         q+LCVaRyu5b8EPsItQfpE7FnCM/Jnchj8xCIDUVt5zBs5lHp38O2WHDDCUmVWDpf7GqJ
         8cWw==
X-Gm-Message-State: APjAAAWM8HbAdOHFH6enplnwKvvjZAyJ4W6Nq5N2hti+89U6qrafTsot
        gC0ANauvZhamTBvMcFDeWOe4bQ==
X-Google-Smtp-Source: APXvYqx5rLiQZDfHCEtsdvgAeiEL0ltx797XfMMt09+s8XlB6C/EHFEv7HECzEYYXWRWpIkANCaihg==
X-Received: by 2002:a63:2f84:: with SMTP id v126mr40876731pgv.100.1571179541407;
        Tue, 15 Oct 2019 15:45:41 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:45:40 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] memory: brcmstb: dpfe: introduce DPFE API v2.5
Date:   Tue, 15 Oct 2019 15:45:05 -0700
Message-Id: <20191015224513.16969-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few changes for the DPFE driver for Broadcom STB.

The changes and enhancements fall into a few categories:

- some code cleanup
- support for deferring firmware download if the rootfs isn't yet available
- introduce a "new v2 API", which is half way between the existing APIs
  v2 (now called "old v2") and v3

Florian Fainelli (2):
  memory: brcmstb: dpfe: Compute checksum at __send_command() time
  memory: brcmstb: dpfe: Fixup API version/commands for 7211

Markus Mayer (6):
  memory: brcmstb: dpfe: rename struct private_data
  memory: brcmstb: dpfe: initialize priv->dev
  memory: brcmstb: dpfe: add locking around DCPU enable/disable
  memory: brcmstb: dpfe: move init_data into
    brcmstb_dpfe_download_firmware()
  memory: brcmstb: dpfe: pass *priv as argument to
    brcmstb_dpfe_download_firmware()
  memory: brcmstb: dpfe: support for deferred firmware download

 drivers/memory/brcmstb_dpfe.c | 164 +++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 63 deletions(-)

-- 
2.17.1

