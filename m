Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D4C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1892075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cKqRG0En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgAIKnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:43:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52027 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgAIKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:43:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so2351482wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1+dHq18C0bFPHtybcse9Vo/A581Ece5LU7fp8OU7MIA=;
        b=cKqRG0EnXT/JJJfM09cUs5fipYn6nyM82sI5CTyQH86aHScCx1yQBYPyLFKjjcKU3C
         FgWGO5HtBUpH/vNHAhStjCPGFeHHzmooHb7nw//gXz2eU+e5zlV7Zck1sOpcbd4olg0Y
         JTHVLTfDigFQtS2VTFg7IuOaTdaOCywrcTe2CTCPb8p3z9q8R/ji9pOhJ0T1MnWWVf0W
         DZ5yFn7f4VMNOuYkVAt3ZKLWbI1dlU3I3uqNOAFF6MVsX+FkMbuIGbUmn/7Oug3uW/3H
         ko3Nvbm2U0klMibnOX8f1boK+KXFiZkki3AhapyQuQdD8OUkAIJMeRNStziOrZJyTUq7
         ZRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1+dHq18C0bFPHtybcse9Vo/A581Ece5LU7fp8OU7MIA=;
        b=fzvZEmfgbJxMizlHfzDRkCZ0UjSpIg9kgJt187BEkzxLE/qIom4ngsMiILgF1fbhak
         M1zJRvQBPgUBa6NfukpTjRYNlMToywG0YIFLX8M/ZJ+kKogEIttbUnc63lf0sUNzNzWQ
         bSHPIOL/XjjDnP2nWzwOb7gNC+VqXSqdnETl40ClkTmv5Kmr4DTBjgsHcjaeJRm9cNpR
         2NT1+MnxZMW8wSxIRtjQ/glBvWInW8YE+vYx8J5q5YySRwW9D44iu1Q7G1rbqE4uQ26D
         fo5Vwg/bKF0otKoaXPayftszHONViQyeyYwI+/c6sN2N02It+Ji5IoDX47yWp7fs7IMr
         9ROw==
X-Gm-Message-State: APjAAAUP4OArcFW3L6B6PN/0Y86/kC1hTirbV1PbRGqePXQnBB6zWOCj
        Cn9fRJXGo3h4x4DbhkCSYiTTAg==
X-Google-Smtp-Source: APXvYqx3mnWFPevVQy8vni2p9aUcio3Y6O/BSZXI7da7LcAZZVbXmt0IU4pY0bgojjO7SfvOboMA4A==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr4068172wmj.96.1578566579791;
        Thu, 09 Jan 2020 02:42:59 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q68sm2587167wme.14.2020.01.09.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:42:59 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v6 0/2] add support of interrupt for host wakeup from devicetree in BCM HCI driver
Date:   Thu,  9 Jan 2020 11:42:55 +0100
Message-Id: <20200109104257.6942-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add interrupts and interrupt-names properties to set host wakeup IRQ.
actually driver find this IRQ from host-wakeup-gpios propety
but some platforms are not supported gpiod_to_irq function.
so to have possibility to use interrupt mode we need to add interrupts
field in devicetree and support it in driver.

change sinve v5:
- add tags

change sinve v4 [1]:
- add patch to update Documentation
- use of_irq_get_byname to be more clear and move call in bcm_of_probe
- update commit message

change since v3:
- move on of_irq instead of platform_get_irq

change since v2:
- fix commit message

change since v1:
- rebase patch

[1] https://lore.kernel.org/linux-bluetooth/20191213105521.4290-1-glaroque@baylibre.com/

Guillaume La Roque (2):
  dt-bindings: net: bluetooth: add interrupts properties
  bluetooth: hci_bcm: enable IRQ capability from devicetree

 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
 drivers/bluetooth/hci_bcm.c                                  | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.17.1

