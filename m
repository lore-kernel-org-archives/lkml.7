Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94825C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6560421902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nItXvxpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCUOKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so1387797wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKR2ry9Kf+772GXoMUfOS03woz+3HGRRU5O9Myeetk=;
        b=nItXvxpH/suEh110Hfru4LtdyjRdx+SrguVFY6oijS1tPOWqnWdDLxsxFmhWcVd5ES
         25eeCBVLDyOp0lPTjfYq8wdnCmX0gEV15LqAQqSI8/WkoeEPr+9lxB+viB+TRlyRE908
         PAd8PJdh7IRyPnGGQRbwX0+BXbWQ6fiXmnq7eBZ6zLCE6QWWoMUZVbOojq06AD7e+l+l
         p/cTT1DXsNAKZx0RD1D2Tbum1ydqX/+VzApDK9QlBMuheHSE2pENtZQBvZq9m/1vqsHY
         fZeeWRGH5QGCifWJVGfyx+kxEoPQSZyEJl/wAal7pEJ9fl8ychasoD88ZfrmDJvnNuaZ
         4p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKR2ry9Kf+772GXoMUfOS03woz+3HGRRU5O9Myeetk=;
        b=NQEHPMy/xGPCqShjIvrU7pRGl/CcAfJ+GlS0YwcYie0WavaXZzmhTUKo1wKaca2ShC
         GiVm9yY6lNu/FA+H6lca06S6JAb7qZuyXShEdQ21R+De1UQE2qqttVbyebcehZhMkr0M
         FvttG+nwjpSI3xb64NeIBqS184OvRJYcSAQdgU5V7HkXgmNDiS71Zqsc5L4nRaF3Iz17
         9pk7s6CTsdEB9oeNaXFkuxYTs7ANyFXv5AUxoDMAqOyOfvV6798F0yk+WRYqH5EK/9OB
         7vZiQL6CDr1AT6yw5PVbUQWicAF6mSGhnUEFnII7TkIz1kLHcM8ADXKwe1WO/Uy0RE6n
         r7Fw==
X-Gm-Message-State: APjAAAXK6NtKE539H/E0sFQ/hsDFsB5nTSCP3zEZm1OpB7O/opGmpM7k
        sWdgtvEWNYT8sV3Iwe3o+lknNA==
X-Google-Smtp-Source: APXvYqyzxu9UndF9yM7NlYAH8o6Nh1OcJdlPsymBTRjgGjg4dlNo7aqzXsPmwR6A6UEaQJ6bHx+wug==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr2927843wrs.126.1553177415519;
        Thu, 21 Mar 2019 07:10:15 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id z14sm7513921wrv.78.2019.03.21.07.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:10:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] ARM: da850: enable cpufreq in DT mode
Date:   Thu, 21 Mar 2019 15:10:06 +0100
Message-Id: <20190321141010.19612-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds cpufreq-dt operating points for da850 boards supported
with device tree (da850-lcdk, da850-lego-ev3, da850-evm) and also
includes a fix for the da850-evm boardfile which checks an unset variable
to determine the highest available frequency for cpufreq.

Last patch enables CPUFREQ_DT in davinci_all_defconfig.

Bartosz Golaszewski (2):
  ARM: davinci: fix cpufreq registration on da850-evm
  ARM: dts: da850-evm: enable cpufreq

David Lechner (2):
  ARM: dts: da850: add cpu node and operating points to DT
  ARM: davinci_all_defconfig: Enable CPUFREQ_DT

 arch/arm/boot/dts/da850-evm.dts         | 30 +++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts        | 31 ++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts    | 30 +++++++++++++
 arch/arm/boot/dts/da850.dtsi            | 56 +++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig  |  1 +
 arch/arm/mach-davinci/board-da850-evm.c | 12 +-----
 6 files changed, 149 insertions(+), 11 deletions(-)

-- 
2.20.1

