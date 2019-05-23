Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE87C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546292175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XhxlEH5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfEWVSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:18:43 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43887 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:18:43 -0400
Received: by mail-pg1-f181.google.com with SMTP id f25so3768757pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=ujj+o/vSu15Ty+Rp+nrDzMIbmAH9h04AWhMkoHFeyO0=;
        b=XhxlEH5CcI2gyctTFBouWYiONs9yWsT7gutjyiAeCoA+RzSCvddXAyX7Y/iggtzGzM
         BVoaG19+zlam9Hp/Qb5613T3cTqO+IzPTA5gNqY6UUFBT8/XF+po57nzOqTgjD9SaDfu
         LeoqmRPEtETy/ow4uf9uhTPt/btkFFSK2XF4DT49shTiyVckp7nPcCCownFeu1uzNfVx
         NpCW0DCoc5QPh7CYcRUqFNMtRF/MqsNGmDADIJsOYFkbpC8S0vLpQWt1eK1nh/5UHUDu
         a6xQ8MY+52NB/i1hnUoOBQYZMlseF+dPkMAd8gvc+HAPoqEYu+Ci3vFR1YqzP6kgCzRz
         I2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ujj+o/vSu15Ty+Rp+nrDzMIbmAH9h04AWhMkoHFeyO0=;
        b=XRlAMZgZub21a8guoEsRzKF3eD4CckPzhcW9jxBJSqc8epl5he/2MDDnUNyoVsjOz6
         9pahk6Xla3v4dtQjUlpIThDyMQ/4OLp2u2obXRp+kefZ10RIXQ1/TJG2IgyvUWfNgkAy
         kol81T+/WfICuOD3XZ6BjC7YuBqwoMFaQyISbD6XPJ/SdRBACrlJcKGYSWodRgn3gRm6
         uwDiHVy7sCThpwYAvpgeseir9NTbAxcTD63csBdkJkrcSLDBfCdqAE9T7y6jWkackZhs
         73cdg5pFac7/2QPg24jeh5PhYc2RSNAgAvFsE0ote6YSCQX1V12R+/r78OMeXb41iRM3
         yYjg==
X-Gm-Message-State: APjAAAWPsAtlHa8MWIxil3Cn/JlpffAU8jg8Iw6CFV8qk9fglbwDWph5
        LCB4UNl0FNx6UpaDL/UD9Ae3gA==
X-Google-Smtp-Source: APXvYqxqYSViegfFI1nabA3JyoOIBSF4oGxnep+EVvkKvRbfoK6KkHc1EwG9e0TnSv6IsMTaep4ymA==
X-Received: by 2002:a17:90a:cf87:: with SMTP id i7mr4364622pju.72.1558646322445;
        Thu, 23 May 2019 14:18:42 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id t5sm234092pgn.80.2019.05.23.14.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:18:41 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: [PATCH v2 0/2] tools: PCI: Fix broken pcitest compilation
Date:   Thu, 23 May 2019 14:17:59 -0700
Message-Id: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a compiler error and two warnings that resulted in a
broken compilation of pcitest.

 tools/pci/pcitest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

