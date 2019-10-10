Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3512190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfJJKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:21:07 -0400
Received: from mtaout.hs-regensburg.de ([194.95.104.10]:54442 "EHLO
        mtaout.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfJJKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:21:06 -0400
Received: from pluto.lfdr (im-mob-039.hs-regensburg.de [172.20.37.154])
        by mtaout.hs-regensburg.de (Postfix) with ESMTP id 46pnDG5M8TzyD1;
        Thu, 10 Oct 2019 12:21:02 +0200 (CEST)
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 0/2] x86/jailhouse: improve probing of platform UARTs
Date:   Thu, 10 Oct 2019 12:21:00 +0200
Message-Id: <20191010102102.421035-1-ralf.ramsauer@oth-regensburg.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.10.10.101216, AntiVirus-Engine: 5.65.0, AntiVirus-Data: 2019.10.10.5650000
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, URI_ENDS_IN_HTML 0, URI_WITH_PATH_ONLY 0, __ANY_URI 0, __BODY_NO_MAILTO 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CP_URI_IN_BODY 0, __CTE 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __HTTPS_URI 0, __INVOICE_MULTILINGUAL 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __MULTIPLE_RCPTS_TO_X5 0, __MULTIPLE_URI_TEXT 0, __NO_HTML_TAG_RAW 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_IN_BODY 0, __URI_NOT_IMG 0, __URI_NS , __URI_WITH_PATH 0'
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

probing of platform UARTs is a problem for x86 Jailhouse non-root
cells: Linux doesn't know which UARTs belong to the cell and will probe
for all platform UARTs. This crashes the guest if access isn't
permitted. Current workarounds (tuning via 8250.nr_uarts) are hacky and
limited.

Jailhouse now comes with flags inside setup_data that indicate
availability of UARTs, so simply use it.

  Ralf

since v5:
  - Link: https://lore.kernel.org/r/20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de
          alt: https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg07568.html
  - Address Borislav's comments:
    - Improve commit messages
    - 1/2: Use min_t instead of min
    - 2/2: Add __init attribute to jailhouse_serial_workaround 
    - 2/2: Remove __initdata from setup_data, as it it is used by
      jailhouse_serial_fixup(), which can not become __init. It is
      passed over to serial8250_set_isa_configurator and can be used
      after bootup.

since v4:
  - Link: https://lore.kernel.org/r/20190909151030.152012-1-ralf.ramsauer@oth-regensburg.de
          alt: https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg07483.html
  - rebase and test on latest master and resolve conflicts
  - Add linux-kernel ML

since v3:
  - Link: https://lore.kernel.org/r/20190819183408.988013-1-ralf.ramsauer@oth-regensburg.de
          alt: https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg07365.html
  - Address Thomas' comments (and it really looks nicer)
  - Address Jan's comment on patch 1 and add his Reviewed-by tag

since v2:
  - Link: https://lore.kernel.org/r/20190812110650.631305-1-ralf.ramsauer@oth-regensburg.de
          alt: https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg07334.html
  - avoid imbalances of early_memremap and early_memunmap

since v1:
  - Link: https://lore.kernel.org/r/20190802123333.4008-1-ralf.ramsauer@oth-regensburg.de
  -       alt: https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg07283.html
  - setup data version check wasn't really prepared for extensions of
    the structure. Add a patch that improves the checks.

Ralf Ramsauer (2):
  x86/jailhouse: improve setup data version comparison
  x86/jailhouse: Only enable platform UARTs if available

 arch/x86/include/uapi/asm/bootparam.h |  25 +++--
 arch/x86/kernel/jailhouse.c           | 136 ++++++++++++++++++++------
 2 files changed, 120 insertions(+), 41 deletions(-)

-- 
2.23.0

