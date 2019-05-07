Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92D0214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edCfTr60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEGTiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:38:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32791 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEGTiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:38:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so9187713pfk.0;
        Tue, 07 May 2019 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sC/+NY9vNRdIe9N8awakKaLNDu11yUQCUMakYQMWUBk=;
        b=edCfTr60W9kD+WVkXBcM19S0e2usB7m+SrxnRi1Qi+/QHbw6c5vE75E4uK0zW9FJ3u
         hscskKOYoBfaGOf2pGnIigDj8CjnnOK6VpfQUYFDz56BOlujpguZUhLVtnKhRujUde9q
         onWgRfe3beZ+enpnR8U901oLW15LyzB4HDBMlf+4Cuo9e/ZRr7WMFSjIdNlJRPxxQ7XJ
         y3JU6v3vuM5+vh2uJqGmAbybj3BkfZwbgFEFixMtcgq7K8MWlHgBm5N+HepbThduYXUN
         iTWMPLIgg2+t28s5ghdrSLcTR/sPHGYMwkYJVbsDZUtUKs/Qzx4VJuNDfONTXNuYD5Rf
         G6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sC/+NY9vNRdIe9N8awakKaLNDu11yUQCUMakYQMWUBk=;
        b=MR3k5V9NBmebwx5DmX9XrhChts6EzTHZliYAxrX4TmAgFY5RC9zQezBlOW74Qm990W
         64NSVoZwRuaVfILuSelbVZk+jdsDEuAN3q7tLDScFvjl0r8xWy7pcXSt4dFKeLHwk8Qw
         nv0PUpEwcvTpG3w9lrZ9rH7R4VwAk4/kiK9+JErxutgWsI6Pc8FJYJ2Egeo98a5LqAUv
         NIroHOBJgSjCJ9MTomI8cgqa2iG9fEiXtQ5ZceZGXqd1f2pSCrQjesKI0SWiBdOq7reI
         vngJgAp1Qjp+NFoiuF8vMdEcMdMtis8845XKCR6rQ60ZtKVJSwfs38SmapE5RyYfSxlt
         O4UA==
X-Gm-Message-State: APjAAAWswBye4dpNuARk0Aj9twNDID3S2cexj0LMmAAorEWMXJeQnq/b
        4WnAedNlI5OMk5SNdUAv+FfTqlJN
X-Google-Smtp-Source: APXvYqxwRJZ7Dy7UxedXvqeozShpNdo8JgcXtCXvnqrOfuid/1+Qr8Kk+wFyhVz0N7aIPSx6FwcSjA==
X-Received: by 2002:a63:2ac5:: with SMTP id q188mr32742805pgq.388.1557257894294;
        Tue, 07 May 2019 12:38:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l21sm5964658pff.40.2019.05.07.12.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:38:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 0/3] hwmon: scmi: Scale values to target desired HWMON units
Date:   Tue,  7 May 2019 12:35:01 -0700
Message-Id: <20190507193504.28248-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Guenter,

This patch series adds support for scaling SCMI sensor values read from
firmware. Sudeep, let me know if you think we should be treating scale
== 0 as a special value to preserve some firmware compatibility (not
that this would be desired).

Changes in v2:

- added a helper function in kernel.h: __pow10()
- made the scale in scmi_sensor_info an s8 type, added defines for
  checking the sign bit and sign extending with a mask
- simplify computations in hwmon driver

Florian Fainelli (3):
  kernel: Provide a __pow10() function
  firmware: arm_scmi: Fetch and store sensor scale
  hwmon: scmi: Scale values to target desired HWMON units

 drivers/firmware/arm_scmi/sensors.c |  6 ++++++
 drivers/hwmon/scmi-hwmon.c          | 30 ++++++++++++++++++++++++++++-
 include/linux/kernel.h              | 11 +++++++++++
 include/linux/scmi_protocol.h       |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.17.1

