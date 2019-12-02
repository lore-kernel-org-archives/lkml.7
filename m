Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F6C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBA02073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfLBNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:02:46 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45796 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727466AbfLBNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:02:40 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2D1f3T015190;
        Mon, 2 Dec 2019 15:01:41 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 8FE4660275; Mon,  2 Dec 2019 15:01:41 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1 0/5] add tpm i2c ptp driver
Date:   Mon,  2 Dec 2019 15:01:27 +0200
Message-Id: <20191202130132.175382-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

*This patch set adds support for TPM devices that implement the I2C
interface defined by TCG PTP specification:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

interupts are not implemented yet, preparing it for the next patch.
this patch is based on initial work by oshri Alkoby, Alexander Steffen and Christophe Ricard

Amir Mizinski (5):
  char: tpm: Make implementation of read16 read32 write32 optional
  char: tpm: Add check_data handle to tpm_tis_phy_ops in order to check
    data integrity
  char: tpm: rewrite "tpm_tis_req_canceled()"
  dt-bindings: tpm: Add the TPM TIS I2C device tree binding documentaion
  char: tpm: add tpm_tis_i2c driver

 .../bindings/security/tpm/tpm_tis_i2c.txt          |  24 ++
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm_tis_core.c                    | 109 +++++----
 drivers/char/tpm/tpm_tis_core.h                    |  41 +++-
 drivers/char/tpm/tpm_tis_i2c.c                     | 272 +++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi.c                     |  41 ----
 7 files changed, 407 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.7.4

