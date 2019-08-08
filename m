Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17254C32756
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9CF2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUly2egF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfHHDl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:41:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42645 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfHHDl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:41:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so42964882plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CltnQTlt8olc+fDLy2Jnh5hmJd7EG7/QIe5FFgTWxYw=;
        b=gUly2egFnTMEnmQt8hy4Aef/sXt/p2qtK4St243N9Vr8JaIVzaix9GpTB9gDSS6G8n
         VRuJ2gK+MoyQV+7mwOr4R6MqR4Ws4cSm57d5b/k0QfttT7FPqEGGaYmxO9zGVN80KUyf
         Xt7JDRsFKs4Dk255X8jwjb9Q1ycmt/wjj7tng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CltnQTlt8olc+fDLy2Jnh5hmJd7EG7/QIe5FFgTWxYw=;
        b=oDRNGG2xMmub3YbWq/7yzAg4WhweXrn4rcL7bGrXFcNxHkUVKy6ortz1UPvs4TMdfd
         UEr5zU0mGPFLx7rkR6XVhawQB0uUPaxRVQWX6OTvyeYJlhcDrmXXD/EwsZAtU5W3iv4Z
         /U2sG7VZAgVExZqz12cxWpYqaI2TXiK8pzdv02KUqh7WOVOIFvxogCEWSenbtNOvV94Y
         85MeeZQC2eSOg5kHn1VPGLjv32Ei7CFq3UB/yS8tHK/IDKpC8CRv7D/twgk7d5yDsM07
         3hB7X+Y+hyGPgUN+YqwEII+Vi6lqiwH6IkjimH/vY9A0TGrZuK1EiRhF9SFe6/wa1ElA
         J99g==
X-Gm-Message-State: APjAAAXVdna0lb4JyHvmnrMj2hDWmJpodQ0z8KnykD+Y/Iva5aHSwdrO
        m1a5TNn4b9l5JCKFTZiAfgSD1g==
X-Google-Smtp-Source: APXvYqy1YWfA92bvwxrgj1XPwg6/YN6ruDZmL72kWXbICFTwOBsziMdPWNVG8Od/3aZ4K4bRsaZoCA==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4mr10916411plt.13.1565235717808;
        Wed, 07 Aug 2019 20:41:57 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y14sm46425482pge.7.2019.08.07.20.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 20:41:56 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v1 0/2] Remove smbus quick cmd and update adapter name
Date:   Thu,  8 Aug 2019 09:07:51 +0530
Message-Id: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset contains following changes:
- Remove SMBUS quick command support
- Update full name of dt node to adapter name

Lori Hikichi (2):
  i2c: iproc: Stop advertising support of SMBUS quick cmd
  i2c: iproc: Add full name of devicetree node to adapter name

 drivers/i2c/busses/i2c-bcm-iproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.9.1

