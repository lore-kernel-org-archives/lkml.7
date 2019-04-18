Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE82C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F386214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIz5pksk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390041AbfDRT6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so1573806pfc.7;
        Thu, 18 Apr 2019 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5vClmzB5ruRG5DfpQI3+/6Tcg0frA3QH3vJ0qCG0ZNU=;
        b=LIz5pkskdLDTvf/wpQtdZB/Rdb3xa6hScC/e0SIcu2CaAAmqoolajQgaIxB3XS92e8
         ivmN4MYM6C6JpabkO9zXBwHUAl0bMfvZaTO0KI2ylmuV+yE8C09qbN6uQBtccQ2iUbEW
         6gMp3VbJEjR0iCRLD3tsNHcPZ3UaDn6Dc4bZ2suoddCPXgNAvum5AC04rixylKsRX+Ct
         JimXJmeBemDobvjQo7ZeRetTLLKtLdqIRLc686g4ag58bNpSKMOWtBpc0oiYJDKzsTId
         IKU3mcxm1P9YugE5CL889/DQJrZcO0N3ZHS7XIiwwJY1Llhr5AZGAH6+zQCffXoEGSNI
         phLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5vClmzB5ruRG5DfpQI3+/6Tcg0frA3QH3vJ0qCG0ZNU=;
        b=dLzF+A4PN+fM0dkSLuvZiN254dhMtEcnQHNAqK3hh0VhQdkcX2nc+/Z4U/b5rIGUUF
         ux+EsrLoFgGltE9yjls9aW1GqU+H69fpPNS1VzTvYXTsBzNOO44CyvVTCSFdMYwaHSHs
         qaIzpjMAd/a/GTJjrMPaH3pQ2HYGS0FOTHhzkNyJWpnXrirehD7iwYqTZ2v3QjF97H4q
         acqim/gz6oaytz+cEQNAKaaXQC5KH5BXf6+KA51LJJ/O1UbsxdLOGbooP6yBfwMFzbPz
         GkCrjbzUeD7feIgajP4wYrDXIaXRLHe4p9hA+ahjVKbM82RbaWXOYQWZdp45NExWW27L
         fCfg==
X-Gm-Message-State: APjAAAVs/rZcy//3kcqw7IsBFzDgh89r0AOIDbFxXAqkUaTBJ80CbnHs
        zRqwng7j7gnKXBy2T6Cep6iuhc3acb0=
X-Google-Smtp-Source: APXvYqz9KqL2njowruKOC8kSeVieLJgnycGmub6FNz59l+ivj2LAy9fGa31n4qrBCOJcJJmyVt89KA==
X-Received: by 2002:a62:565c:: with SMTP id k89mr97032823pfb.175.1555617503748;
        Thu, 18 Apr 2019 12:58:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p66sm5820800pfb.4.2019.04.18.12.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:22 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/6] thermal: Introduce devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:14 -0700
Message-Id: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thermal_of_cooling_device_register() and thermal_cooling_device_register()
are typically called from driver probe functions, and
thermal_cooling_device_unregister() is called from remove functions. This
makes both a perfect candidate for device managed functions.

Introduce devm_thermal_of_cooling_device_register(). This function can
also be used to replace thermal_cooling_device_register() by passing a NULL
pointer as device node. The new function requires both struct device *
and struct device_node * as parameters since the struct device_node *
parameter is not always identical to dev->of_node.

Don't introduce a device managed remove function since it is not needed
at this point.

The patch series introduces the new function and then converts various
hwmon drivers to use it.
