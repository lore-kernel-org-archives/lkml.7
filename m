Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9584C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0320665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKuFgTPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404449AbfFMQxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34774 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfFMDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:04:53 -0400
Received: by mail-yb1-f195.google.com with SMTP id x32so7215790ybh.1;
        Wed, 12 Jun 2019 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4yHV5hE4KckaIirIQ/R8gyWLdNXI5pu5jh88n3sS9g=;
        b=CKuFgTPLjVAXFWQBRcPatwLsNbyh59gXifauuRKs/laXGNPFnttL5thIZp5SBfkkJD
         zG3lukslvRrH/s8Vp8womxZ/SeTnH5qEV4fjLvlj7dIBRxgUeW9X1HxRoM3e0d1wFXIz
         ioRMfMMZIrX57VwrbDA1EvwfdG62/I1bIiNUHFfh1t1/8kvLUffRI4yq/8G4RJkzt5OW
         Cn1fqRwU/3uOkqyHPkR6fNWmMRy1d5VuRfBo1KIWXN5UJYBTfm7iOZOdw6R2JMgfMUoE
         lRrzGpGmHPr5qWqD4eIdXGZAAFY4XtSE6vtORmyujFeU9tU1DQLbvlKWJ6x4g8HV7mMl
         zH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4yHV5hE4KckaIirIQ/R8gyWLdNXI5pu5jh88n3sS9g=;
        b=ueysnbZ2a9mlGACXTxt/awJj4tvOep+TO+H3wOr8oeybc7TPzb2Lof9P1jg9N12M7J
         6pwuZK37fOqgEuA+naXBdCxMJfmBeF2/l5TKLM77wWDJSbOV6o0DKT+0QHDjEHz/SBVD
         SVWv2veAtpxGlm02cHpmeMF/6mH1FI9eQnecmY72TEz1q+PsUyC2PLW6Xo11bf4KoHHY
         PUf61+T5yxJCk99lVCzhcWYTD5XtKysKYB6es8s9SqNB2ETGUZKjRmyXMyden3+gxWJk
         N/LtycNpunT7BJbER3eaUoKw6J1rBLZ2Pbx8lb0Xkfij/hAN+3EgRwIOLuhFoRApnv7+
         HC3g==
X-Gm-Message-State: APjAAAXVo6gMbkupfig6hVIi5FGM9nAEqPrweBviwVwkasJc+mnIfcP2
        5ws13zIRbcurX/LsGwfTSw==
X-Google-Smtp-Source: APXvYqzrRjBqIuqi8wFrFxy1arDKGOt9jUy7e15FS7FNRDotOceQfw82KUC8WjLIIg4cB2t3Hkt+Gw==
X-Received: by 2002:a25:8008:: with SMTP id m8mr22025561ybk.157.1560395092225;
        Wed, 12 Jun 2019 20:04:52 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:04:51 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 0/8] platform/x86: Huawei WMI laptop extras driver
Date:   Wed, 12 Jun 2019 23:04:06 -0400
Message-Id: <20190613030416.25807-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
* introducing debugfs
* code reformatting

This patch series introduce new features to the driver and also moves the
driver from wmi_driver to platform_driver. This move is necessary because the
driver is no longer only a hotkeys driver and platform_driver offers easier
future extensibility.

The patch series introduces a WMI BIOS interface that brings on new features
and enables controlling micmute LED through this interface on supported models.
It also enables controlling battery charging thresholds and fn-lock state.
These features are controlled through the HWMI WMI device present in most of
these laptops.

Currently, micmute LED is controlled through an ACPI method under EC.
This method ("SPIN", "WPIN") is specific to some models and wouldn't
work on all Huawei laptops. Controlling this LED through the interface provides
a better unified method to control the LED on models that implements this
feature.

The behavior of hotkeys is not the same among all models. Some models
require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. Fn-lock inverts the
behavior of the top row from special keys to F1-F12 keys.

A debugfs interface is also implemented to support unrepresented features and to
provide debugging feedback from users.

Ayman Bagabas (8):
  platform/x86: huawei-wmi: move to platform driver
  platform/x86: huawei-wmi: implement WMI management interface
  platform/x86: huawei-wmi: use quirks and module parameters
  platform/x86: huawei-wmi: control micmute LED through WMI interface
  platform/x86: huawei-wmi: add battery charging protection support
  platform/x86: huawei-wmi: add fn-lock support
  platform/x86: huawei-wmi: add sysfs interface support
  platform/x86: huawei-wmi: add debugfs files support

 drivers/platform/x86/huawei-wmi.c | 754 ++++++++++++++++++++++++++----
 1 file changed, 665 insertions(+), 89 deletions(-)

-- 
2.20.1

