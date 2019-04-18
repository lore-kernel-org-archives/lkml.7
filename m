Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B7AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lSB+4VAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbfDRJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:38:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41752 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387971AbfDRJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:38:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I9bPqI020922;
        Thu, 18 Apr 2019 11:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=oY+qbuR5KQ2JTCEhWmdHC3SIJbwaKs2AJ9531INS5Ys=;
 b=lSB+4VAqAWsyxO8/wcrPRmoBlYzW7wxW9DSD6eJtUud2AXZdjdeT5cdhvxVKkRZJQMrk
 vA5ghnme89Qz7GLF8bU/PqbOE6S0PBZjkMbJnalTmhycsK9ayROSrv3F6HU4rX3NQgDa
 r8SCLl3IJLDkIZJBJ0S0KCCqEThM8no1iEBzFKkHrqxWFCYUBpdBDTiOts9/aA0qFgl6
 VDbC6NPhYhgkYnyP+gY5ZjZZWCYo7ODcgC82QYVOfBpClNm2Gdb86/T/vI7559W0bpfW
 nw1bvs2igFdwXMceUyw6ARjUf7baRve/1FGaaIfrYJhGZXH8ZZ1TbN3hRuFpt8HYIfvW 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6nh4ycg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Apr 2019 11:37:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D8E541;
        Thu, 18 Apr 2019 09:37:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFC8A159F;
        Thu, 18 Apr 2019 09:37:56 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Apr 2019 11:37:56
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
Date:   Thu, 18 Apr 2019 11:37:44 +0200
Message-ID: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds power management support for STM32 LP Timer:
- PWM driver
- Document the pinctrl states for sleep mode

It also adds device link between the PWM consumer and the PWM provider.
This allows proper sequencing for suspend/resume (e.g. user will likely
do a pwm_disable() before the PWM provider suspend executes), see [1].

[1] https://lkml.org/lkml/2019/2/5/770

---
resend v5:
- update collected acks

Changes in v5:
- improve a warning message, fix a style issue.

Changes in v4:
- improve error handling when adding the PWM consumer device link.

Changes in v3:
- Move the device_link_add() call to of_pwm_get() as discussed with Uwe.

Changes in v2:
- Don't disable PWM channel in PWM provider: rather refuse to suspend
  and report an error as suggested by Uwe and Thierry.
- Add patch 3/3 to propose device link addition.
- No updates for STM32 LP Timer IIO driver. Patches can be send separately.

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  pwm: core: add consumer device link

 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
 drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
 include/linux/pwm.h                                |  6 ++-
 4 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.7.4

