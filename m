Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C6C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E52089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkGqB8nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfFQMvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:51:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1735443wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5bmkX35OV+Un6bMajgKlhe2VCa9szCQ2ZkSqsLoxX0o=;
        b=SkGqB8nJ/IEWG4IXm6QepVKAPERnunfILKb8Kq1MbhkJjXx3UULfKVudbA72IOKn4f
         G62Fr3PqgKzQKcNsmyBRXyveUf+dHEtdCXtQsE3gTVZVWnfWkldCrMnFs2slVkltx4Gb
         8AATCMbXrzOzWwipup1IO6zK1olLm9TmFGFjp+3h5Yjpcyz6iiNP46kZZ3t5mshsqkkB
         uUfjeYjyZ9Qx603esC/J+weA9ps0NBpcyLjXqm3f6wYZUVQ8smY0LRF+HMW2KQdWf9ZA
         5xqUxmiRTeR1e7KAm+OpIrpAp3jU3t2gdQNZWCNNhR7OlH8K5th6Jk4140PPDGahTHVY
         aqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5bmkX35OV+Un6bMajgKlhe2VCa9szCQ2ZkSqsLoxX0o=;
        b=bL4WntJzDD3NsPNiMxiv5vnExeXON3qgUGJyVsyFgOZnWJ+r3MHPwXmd8msCMFfimr
         hfiaW9Bn4XpTh2j3fic/MIAC0JTjDV795YkAuSnYuZ0bTbmYdnergHuLkuxoQhYsdFsm
         TK/sAdqeofKYQTmh4QTWcLhrcsflJQjAfzAxFiGwYp8nFvRbJpktwhE67H+OI+6rTI5Y
         1Rm1vTHaDY2/WqN6Mx02Zcei4Uys+C5w7+xg6rdli62vjzwAkNEPTbozWOwqcFPLUpYD
         Y2+HmU7pC2FZckoBbW9aaD9eZdlC6TCcj92JQdNuAevopESCSdsGriVOt8G4wYUy41VM
         MGhw==
X-Gm-Message-State: APjAAAVvdqtjnkkQHUr3FETdfBes43uD1WXEIe8+vEi6sbayyZV1d2eL
        jTQbdvozrw2vNSGJLLgiT40vEA==
X-Google-Smtp-Source: APXvYqw7cAvvCpSNGdJ5pbIUQp1AMGTBLl023D9nSX8+bxc3wDDiQnF3ftT8PtAoEjuj1WIEl1FdVg==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr75718744wrq.53.1560775868649;
        Mon, 17 Jun 2019 05:51:08 -0700 (PDT)
Received: from dell.watershed.co.uk ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id o11sm10477852wmh.37.2019.06.17.05.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 05:51:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        jlhugo@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, felipe.balbi@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND v4 0/4] I2C: DWC3 USB: Add support for ACPI based AArch64 Laptops
Date:   Mon, 17 Jun 2019 13:51:01 +0100
Message-Id: <20190617125105.6186-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set ensures the kernel is bootable on the newly released
AArch64 based Laptops using ACPI configuration tables.  The Pinctrl
changes have been accepted, leaving only I2C (keyboard, touchpad,
touchscreen, fingerprint, etc, HID device) and USB (root filesystem,
camera, networking, etc) enablement.

RESEND: Stripped I2C patches as they have also been merged into
        their respective subsystem.

v4:
 * Collecting Acks
 * Adding Andy Gross' new email
 * Removing applied Pinctrl patches

Lee Jones (4):
  soc: qcom: geni: Add support for ACPI
  usb: dwc3: qcom: Add support for booting with ACPI
  usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
  usb: dwc3: qcom: Improve error handling

 drivers/soc/qcom/qcom-geni-se.c |  21 ++-
 drivers/usb/dwc3/Kconfig        |   2 +-
 drivers/usb/dwc3/dwc3-qcom.c    | 221 ++++++++++++++++++++++++++++----
 3 files changed, 209 insertions(+), 35 deletions(-)

-- 
2.17.1

