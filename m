Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B08C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4152070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XT/KAgcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfHLJD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfHLJD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:03:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so13620615wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oQqv3HKn5X9fi3n7gSw2yD56p7It536oUztZrAky7F0=;
        b=XT/KAgcVKFFCQth007TWwBNO9LWTZQD3fCd6fX1J6a75gcjK89Fy19ldAtXmIxlRpd
         1fo0fGubHLj/kW7BowE3h4ZmKDZ7XqMly+O78bFdxAWKIWN/y1+qn0I2C/ntS1uu9kcy
         Z5iO6k0pxcSvZNQhmFTaaKw3/4pcpXzWGj3mJZLX+aXuABabDkZ8ISfroQzUbX+INKso
         85Goz3nFgtfYp+43Q99OHrkIeXimEDGV7kDda8YREVAVa5d9kW0kzmbkJOzYrk3eK9Dj
         QWfIBAW7aWpI4SJLUmTY5/L3X8FDh4utCSMTRTr/nAKIBZzvQgBBfRrbDUsqeAhuZMY7
         0Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oQqv3HKn5X9fi3n7gSw2yD56p7It536oUztZrAky7F0=;
        b=XVC0GaazpivSWBdzAoan+7Bd0Y3sB76q42GNc5obwFe6yQNrWRUN41ml2I6H+eBWkE
         EbWHa56QsfS/1OCU7mUPWUZwcWk4FgOuLDW1aPbasq4eFM55dBpUCDZltZ5YeLD4niKz
         ZoKgpXzHZALA7TKS5uEKFy54lYre/+MSzkHAbqSPj6SHPrJ0q+1TfglkGsp9Q27ljbwZ
         RGnEW8yPyk0vvW2Xb4aDCE1llYv588fHiqzewK7QwCMBt6JuC3mGZwm/6gAei4exbQsI
         pHGv4uKqfUPkY3b4psuO3/CI3lHA0J8cKIUG4Gu4StGsROZm+Zx9C1M78Y9g7mG2HbVV
         dLjA==
X-Gm-Message-State: APjAAAXhF0Vs8FW0gt1PK3a6F5MwpDOjd6PSN9DS7Qq0Lrwq/D0DKPBc
        QMn5++VJjENen9TDmXITbt4xQQ==
X-Google-Smtp-Source: APXvYqw/vNb8GyWF413p/M3Z6GK+ZIDq7ow6/dzuSJIrUUiOZe3IteZqK0lpv+/L5yonOVy4ngkPSw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr37792391wro.337.1565600636610;
        Mon, 12 Aug 2019 02:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id g8sm12659927wmf.17.2019.08.12.02.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 02:03:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [GIT PULL 0/1] EFI fix for v5.3-rc4
Date:   Mon, 12 Aug 2019 12:03:29 +0300
Message-Id: <20190812090330.5779-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2:

  efi-stub: Fix get_efi_config_table on mixed-mode setups (2019-08-12 11:58:35 +0300)

----------------------------------------------------------------
A single EFI fix for v5.3:
- Fix mixed mode breakage in EFI config table handling for TPM.

----------------------------------------------------------------
Hans de Goede (1):
      efi-stub: Fix get_efi_config_table on mixed-mode setups

 drivers/firmware/efi/libstub/efi-stub-helper.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)
