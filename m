Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA0C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068B1216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEwy1HFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbfGHQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:56:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41376 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGHQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:56:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so4900785pls.8;
        Mon, 08 Jul 2019 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h9r+VBBTVWSCdJBffHlUJNCOFtycb1gerbLXlsMiOzY=;
        b=tEwy1HFLIrJ5CWhvDLpbBbZ+CJNNht4hGoux3ys80/gp7vDn6CgdhRPYX2Kfj+kik2
         7A5AWAZkH2tV6SPHyXjGafKxqgwCVjZeiTtkEjxk6V+m1yAjOPaZItx7sai5eH8qlv1w
         cOF3pQ29AoByWfQY/CbZZoI/YzLZeB6ZbkLVAEoH/MIEpeEMPjvUZv/9cABGlwBDCIBh
         NQEBiP52svk5Y1P5mmLBEqjYoI75k/Dp6vh2oYw5uaSpIheDtI82dE3aOgEFy5aTVfR4
         Ki9DrvGBPjchrhQy5vyLRvcK7SNsNcTwlUK4hNjo05JDy0Y2m8AlEm6IMQlKeaCCItBn
         TZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h9r+VBBTVWSCdJBffHlUJNCOFtycb1gerbLXlsMiOzY=;
        b=njSCd295fGMgXzLCSLA1/x0Le1SqDqBB8ZYf/HXVuPSxS860SQrXHe+gvI5luAxs0I
         OpN4e9ZGX2gWCN88oeEbD/S3DWuM9LH0EI4zTAhmaVJTCzLx9n6MnFR1DOzQ6+GRt93j
         MUO9+/X615aoDxklcETeuTjRh9g4eWOpNobAavUBPaci2CDBatvjU6GGdGUyLjO02m9F
         kW5hidoY6UA7uQ52s4opXdxRarhR6zu+mPf45xM7ODOIsTcdAn9eSzaPmo9AxNDxcVNF
         zqld1wu6pD/dn5QnD5Xha5Zl6vnrqaBSNHFE/I2osMnnrXC58SjezMSaI7WlBdx5+k4i
         Va6g==
X-Gm-Message-State: APjAAAUNaDHv9p0a9dLMESAiNG3aEXzK4yAJv3h8j9tosHGRQcyT5WBd
        4waOLU6NKvcA7B3fR3Fv75s=
X-Google-Smtp-Source: APXvYqzHvGmppRrzPEjtQdPhP/3o9PUDcn9diLtmnLjouaYphDPcfrmI2K9TbM9LgJHSch9egv+XrA==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr25722173plk.180.1562605016733;
        Mon, 08 Jul 2019 09:56:56 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id h21sm15908389pgg.75.2019.07.08.09.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 09:56:56 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v2 0/2] Add Sharp panel option for Lenovo Miix 630
Date:   Mon,  8 Jul 2019 09:56:47 -0700
Message-Id: <20190708165647.46224-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Miix 630 laptop can be found with one of two panels - a BOE
or Sharp option.  This likely provides options during manufacturing.

These panels connect via eDP, however they sit behind a DSI to eDP
bridge on the laptop, so they can easily be handled by the existing
simple panel code.

This series adds support for the Sharp option.

v2:
-removed no-hpd from dt example
-added .bus_format and .bus_flags fields based on reviews
-added .flags after Bjorn pointed me to something I missed
-added Sam's reviewed-by tags

Jeffrey Hugo (2):
  dt-bindings: panel: Add Sharp LD-D5116Z01B
  drm/panel: simple: Add support for Sharp LD-D5116Z01B panel

 .../display/panel/sharp,ld-d5116z01b.txt      | 26 +++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.txt

-- 
2.17.1

