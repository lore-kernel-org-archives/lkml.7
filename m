Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7020206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLWGaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:30:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:43120 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfLWGaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:30:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Dec 2019 22:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,346,1571727600"; 
   d="scan'208";a="213827426"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2019 22:30:07 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 0/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller
Date:   Mon, 23 Dec 2019 14:30:01 +0800
Message-Id: <20191223063003.26579-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

Thank you Vignesh for the valuable review comments and guidance,
sorry for the delay since waitting for the merge window to rebase
and send it now by one-shot.

changes from v3:
spi-cadence-quadspi.c
 -- static to all functions wrt to local to the file.
 -- Prefix cqspi_ and make the function static   
 -- cmd_ops, data_ops and dummy_ops dropped 
 -- addr_ops kept since it is required for address calculation.
 -- devm_ used for supported functions , removed legacy API's
 -- removed "indirect" name from functions
 -- replaced by master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_OCTAL;
    as per Vignesh susggestion
 -- removed free functions since devm_ handles automatically.
 -- dropped all unused Macros

YAML file update:
 -- cadence,qspi.yaml file name replace by cdns,qspi-nor.yaml  
 -- compatible string updated as per Vignesh suggestion
 -- for single entry, removed descriptions
 -- removed optional parameters 
  Build Result:
   linux$ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml dt_binding_check
    CHKDT   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
    DTC     Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
    CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
 
changes from V2:
1. Supports Octal mode as well. So its 1/2/4/8-bit wide

2. Please be consistent with function names. Start all functions with
   cadence_qspi_. If need you could have a shorter function prefix like cqspi_

   Also, this and few other functions below can be static and they are not
   used outside of this module.

3. Could you please keep polling routines from original driver
  (drivers/mtd/spi-nor/cadence-quadspi.c). If you really want to improve
   these helpers, please do those changes in a separate patch later on in
   the series. This will greatly help in reviewing the code.

   Also, I see that you have dropped many inline comments in the code.
   These comments are quite important and I suggest not to drop them unless
   they are no longer applicable

3. s/docoder/decoder

4. Please use cqspi_wait_for_bit() that uses readl_relaxed_poll_timeout()
    here. There are couple corner cases that above code does not take care of.

5. Why do we need flash type specific handling here? Does not spi-nand
   driver provide appropriate dummy_clk values? Why is the driver always
   adding 8 dummy clks always?

6. Nope, no custom handling or interpreting of opcodes in driver.
   Just set addrwidth to quad in CQSPI_REG_WR_INSTR when op->addr.buswidth
   is 4.

7. This was wait_for_completion_timeout() previously. Have you tested
    interrupting the sleep and verified that driver handles this case correctly? 

8  rdid_length harcoded values are changed as generic

9. Please get ride of all flash type specific handling... There should be
   no need for it. IF there are gaps in then lets discuss and fix it in
   spi-nand and spi-nor frameworks and not in the driver.

   spi-mem user should just take spi_mem_op template passed by the core and
   execute it. No assumptions wrt flash type or opcode should be done.


10. Decision to use STIG was INDAC mode can be done using:

if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
        if (!op->addr.nbytes)
                mode = CQSPI_STIG_READ;
        else
                mode = IDC_READ_MODE;
        } else {
        if (!op->addr.nbytes || !op->data.buf.out)
                 mode = CQSPI_STIG_WRITE;
        else
                mode = IDC_WRITE_MODE;
        }

   No need for rdid_length etc.

11. This is a big gap and there is lot of code sharing that can be done b/w
   INDAC and DAC mode.

   Looks like driver isn't quite close to being ready. I suggest you also
   take a look at patches for spi-mem conversion of cadence-quadspi driver
   in U-Boot as well:

   https://patchwork.ozlabs.org/cover/1176362/


12. Please dont add any new DT properties, there is no need for them. See
    how this was handled in existing driver and reuse it

13. Slave DMA was never supported and is not needed.

14. Octal?

15. NACK, should be GPLv2 and no need for boilerplate text below when SPDX
    Identifier is present.



Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  spi: cadence-quadpsi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  147 +++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-cadence-quadspi.c                  | 1172 ++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.h                  |  245 ++++
 5 files changed, 1573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
 create mode 100644 drivers/spi/spi-cadence-quadspi.c
 create mode 100644 drivers/spi/spi-cadence-quadspi.h

-- 
2.11.0

