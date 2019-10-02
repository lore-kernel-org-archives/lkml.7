Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250CB21D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bfzfl4Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfJBREC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:04:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfJBRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so10687924pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ykB8bkJhKMmUZ0Xthv5ts8vq517vETNk/y8S86nt5lw=;
        b=Bfzfl4Y2j7DTZq/ryToGuhh4/hO2UZwq4rbsM4RInFXgvXv2uhyNQwN7Miscsmxhh7
         cAZPSpFwYmJKAOqG2aSxqB6TajzsoS++RBlbq2GheVWAGLnF6449vmqWHXGnI/66+f5N
         S3083MfWwBwNpX89nkXI/z7iRgCjTMFyuYscU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ykB8bkJhKMmUZ0Xthv5ts8vq517vETNk/y8S86nt5lw=;
        b=uVtB6tTt1Aazi1UR4+BMhFxsQT2QJdKAP32l3nRR7WwWgfPEeKheN9NH11ZDAbISGG
         D33DXDB7vluP+wTYJn6TRnJ3KSrxCrtS7Vqz66g0jPtJo60CVf0hiinAJ2aksr5mb3/n
         HIHQySfJmb8njBf8KAsl+z4mzcWYnj+2eZBgGAvs1zNrDQfxt+xZ3AtgrhzEpia6x13E
         Dto/DWQb1EA9hozMiDs7ng3QleOYzzBCb0yZbl5MzT9mUlr/jwLkq1XubSwpyzFYfwR+
         PdwS89wJWTs2+yubdpOLcZEEkk2FG3+UCLiH6z/jRSClk+9+zBxQoeY/1/eiZHD9fGNA
         Sy8Q==
X-Gm-Message-State: APjAAAU87SPrTEA/Ak/qHtEcxic9eWBo9/AzwUN1cHXzcph//PlCf0XT
        nBNOGZflQ4SBhR+riYRSdfCELw==
X-Google-Smtp-Source: APXvYqzRrYCk7njCsj2ogkupxESt4C9hYLSM5aeLHxsCr6oMMiGlmmvzHh/57rNdpBbOODCdtiWVyA==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr4701165pgn.18.1570035837742;
        Wed, 02 Oct 2019 10:03:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r130sm21943396pgr.13.2019.10.02.10.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:03:56 -0700 (PDT)
Date:   Wed, 2 Oct 2019 10:03:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Message-ID: <201910021000.5E421A6F8F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Kiernan <derek.kiernan@xilinx.com>

Add SD-FEC driver documentation.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Link: https://lore.kernel.org/r/1560274185-264438-11-git-send-email-dragan.cvetic@xilinx.com
[kees: extracted from v7 as it was missing in the commit for v8]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
As mentioned[1], this file went missing and causes a warning in ReST
parsing, so I've extracted the patch and am sending it directly to Jon.
[1] https://lore.kernel.org/lkml/201909231450.4C6CF32@keescook/
---
 Documentation/misc-devices/xilinx_sdfec.rst | 291 ++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst

diff --git a/Documentation/misc-devices/xilinx_sdfec.rst b/Documentation/misc-devices/xilinx_sdfec.rst
new file mode 100644
index 000000000000..87966e3aa5fe
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_sdfec.rst
@@ -0,0 +1,291 @@
+.. SPDX-License-Identifier: GPL-2.0+
+====================
+Xilinx SD-FEC Driver
+====================
+
+Overview
+========
+
+This driver supports SD-FEC Integrated Block for Zynq |Ultrascale+ (TM)| RFSoCs.
+
+.. |Ultrascale+ (TM)| unicode:: Ultrascale+ U+2122
+   .. with trademark sign
+
+For a full description of SD-FEC core features, see the `SD-FEC Product Guide (PG256) <https://www.xilinx.com/cgi-bin/docs/ipdoc?c=sd_fec;v=latest;d=pg256-sdfec-integrated-block.pdf>`_
+
+This driver supports the following features:
+
+  - Retrieval of the Integrated Block configuration and status information
+  - Configuration of LDPC codes
+  - Configuration of Turbo decoding
+  - Monitoring errors
+
+Missing features, known issues, and limitations of the SD-FEC driver are as
+follows:
+
+  - Only allows a single open file handler to any instance of the driver at any time
+  - Reset of the SD-FEC Integrated Block is not controlled by this driver
+  - Does not support shared LDPC code table wraparound
+
+The device tree entry is described in:
+`linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt <https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/bindings/misc/xlnx%2Csd-fec.txt>`_
+
+
+Modes of Operation
+------------------
+
+The driver works with the SD-FEC core in two modes of operation:
+
+  - Run-time configuration
+  - Programmable Logic (PL) initialization
+
+
+Run-time Configuration
+~~~~~~~~~~~~~~~~~~~~~~
+
+For Run-time configuration the role of driver is to allow the software application to do the following:
+
+	- Load the configuration parameters for either Turbo decode or LDPC encode or decode
+	- Activate the SD-FEC core
+	- Monitor the SD-FEC core for errors
+	- Retrieve the status and configuration of the SD-FEC core
+
+Programmable Logic (PL) Initialization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For PL initialization, supporting logic loads configuration parameters for either
+the Turbo decode or LDPC encode or decode.  The role of the driver is to allow
+the software application to do the following:
+
+	- Activate the SD-FEC core
+	- Monitor the SD-FEC core for errors
+	- Retrieve the status and configuration of the SD-FEC core
+
+
+Driver Structure
+================
+
+The driver provides a platform device where the ``probe`` and ``remove``
+operations are provided.
+
+  - probe: Updates configuration register with device-tree entries plus determines the current activate state of the core, for example, is the core bypassed or has the core been started.
+
+
+The driver defines the following driver file operations to provide user
+application interfaces:
+
+  - open: Implements restriction that only a single file descriptor can be open per SD-FEC instance at any time
+  - release: Allows another file descriptor to be open, that is after current file descriptor is closed
+  - poll: Provides a method to monitor for SD-FEC Error events
+  - unlocked_ioctl: Provides the the following ioctl commands that allows the application configure the SD-FEC core:
+
+		- :c:macro:`XSDFEC_START_DEV`
+		- :c:macro:`XSDFEC_STOP_DEV`
+		- :c:macro:`XSDFEC_GET_STATUS`
+		- :c:macro:`XSDFEC_SET_IRQ`
+		- :c:macro:`XSDFEC_SET_TURBO`
+		- :c:macro:`XSDFEC_ADD_LDPC_CODE_PARAMS`
+		- :c:macro:`XSDFEC_GET_CONFIG`
+		- :c:macro:`XSDFEC_SET_ORDER`
+		- :c:macro:`XSDFEC_SET_BYPASS`
+		- :c:macro:`XSDFEC_IS_ACTIVE`
+		- :c:macro:`XSDFEC_CLEAR_STATS`
+		- :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`
+
+
+Driver Usage
+============
+
+
+Overview
+--------
+
+After opening the driver, the user should find out what operations need to be
+performed to configure and activate the SD-FEC core and determine the
+configuration of the driver.
+The following outlines the flow the user should perform:
+
+  - Determine Configuration
+  - Set the order, if not already configured as desired
+  - Set Turbo decode, LPDC encode or decode parameters, depending on how the
+    SD-FEC core is configured plus if the SD-FEC has not been configured for PL
+    initialization
+  - Enable interrupts, if not already enabled
+  - Bypass the SD-FEC core, if required
+  - Start the SD-FEC core if not already started
+  - Get the SD-FEC core status
+  - Monitor for interrupts
+  - Stop the SD-FEC core
+
+
+Note: When monitoring for interrupts if a critical error is detected where a reset is required, the driver will be required to load the default configuration.
+
+
+Determine Configuration
+-----------------------
+
+Determine the configuration of the SD-FEC core by using the ioctl
+:c:macro:`XSDFEC_GET_CONFIG`.
+
+Set the Order
+-------------
+
+Setting the order determines how the order of Blocks can change from input to output.
+
+Setting the order is done by using the ioctl :c:macro:`XSDFEC_SET_ORDER`
+
+Setting the order can only be done if the following restrictions are met:
+
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+
+Add LDPC Codes
+--------------
+
+The following steps indicate how to add LDPC codes to the SD-FEC core:
+
+	- Use the auto-generated parameters to fill the :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>` for the desired LDPC code.
+	- Set the SC, QA, and LA table offsets for the LPDC parameters and the parameters in the structure :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>`
+	- Set the desired Code Id value in the structure :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>`
+	- Add the LPDC Code Parameters using the ioctl :c:macro:`XSDFEC_ADD_LDPC_CODE_PARAMS`
+	- For the applied LPDC Code Parameter use the function :c:func:`xsdfec_calculate_shared_ldpc_table_entry_size` to calculate the size of shared LPDC code tables. This allows the user to determine the shared table usage so when selecting the table offsets for the next LDPC code parameters unused table areas can be selected.
+	- Repeat for each LDPC code parameter.
+
+Adding LDPC codes can only be done if the following restrictions are met:
+
+	- The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as LDPC
+	- The ``code_wr_protect`` of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates that write protection is not enabled
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not started
+
+Set Turbo Decode
+----------------
+
+Configuring the Turbo decode parameters is done by using the ioctl :c:macro:`XSDFEC_SET_TURBO` using auto-generated parameters to fill the :c:type:`struct xsdfec_turbo <xsdfec_turbo>` for the desired Turbo code.
+
+Adding Turbo decode can only be done if the following restrictions are met:
+
+	- The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as TURBO
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+Enable Interrupts
+-----------------
+
+Enabling or disabling interrupts is done by using the ioctl :c:macro:`XSDFEC_SET_IRQ`. The members of the parameter passed, :c:type:`struct xsdfec_irq <xsdfec_irq>`, to the ioctl are used to set and clear different categories of interrupts. The category of interrupt is controlled as following:
+
+  - ``enable_isr`` controls the ``tlast`` interrupts
+  - ``enable_ecc_isr`` controls the ECC interrupts
+
+If the ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as TURBO then the enabling ECC errors is not required.
+
+Bypass the SD-FEC
+-----------------
+
+Bypassing the SD-FEC is done by using the ioctl :c:macro:`XSDFEC_SET_BYPASS`
+
+Bypassing the SD-FEC can only be done if the following restrictions are met:
+
+	- The ``state`` member of :c:type:`struct xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+Start the SD-FEC core
+---------------------
+
+Start the SD-FEC core by using the ioctl :c:macro:`XSDFEC_START_DEV`
+
+Get SD-FEC Status
+-----------------
+
+Get the SD-FEC status of the device by using the ioctl :c:macro:`XSDFEC_GET_STATUS`, which will fill the :c:type:`struct xsdfec_status <xsdfec_status>`
+
+Monitor for Interrupts
+----------------------
+
+	- Use the poll system call to monitor for an interrupt. The poll system call waits for an interrupt to wake it up or times out if no interrupt occurs.
+	- On return Poll ``revents`` will indicate whether stats and/or state have been updated
+		- ``POLLPRI`` indicates a critical error and the user should use :c:macro:`XSDFEC_GET_STATUS` and :c:macro:`XSDFEC_GET_STATS` to confirm
+		- ``POLLRDNORM`` indicates a non-critical error has occurred and the user should use  :c:macro:`XSDFEC_GET_STATS` to confirm
+	- Get stats by using the ioctl :c:macro:`XSDFEC_GET_STATS`
+		- For critical error the ``isr_err_count`` or ``uecc_count`` member  of :c:type:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+		- For non-critical errors the ``cecc_count`` member of :c:type:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+	- Get state by using the ioctl :c:macro:`XSDFEC_GET_STATUS`
+		- For a critical error the ``state`` of :c:type:`xsdfec_status <xsdfec_status>` will indicate a Reset Is Required
+	- Clear stats by using the ioctl :c:macro:`XSDFEC_CLEAR_STATS`
+
+If a critical error is detected where a reset is required. The application is required to call the ioctl :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`, after the reset and it is not required to call the ioctl :c:macro:`XSDFEC_STOP_DEV`
+
+Note: Using poll system call prevents busy looping using :c:macro:`XSDFEC_GET_STATS` and :c:macro:`XSDFEC_GET_STATUS`
+
+Stop the SD-FEC Core
+---------------------
+
+Stop the device by using the ioctl :c:macro:`XSDFEC_STOP_DEV`
+
+Set the Default Configuration
+-----------------------------
+
+Load default configuration by using the ioctl :c:macro:`XSDFEC_SET_DEFAULT_CONFIG` to restore the driver.
+
+Limitations
+-----------
+
+Users should not duplicate SD-FEC device file handlers, for example fork() or dup() a process that has a created an SD-FEC file handler.
+
+Driver IOCTLs
+==============
+
+.. c:macro:: XSDFEC_START_DEV
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_START_DEV
+
+.. c:macro:: XSDFEC_STOP_DEV
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_STOP_DEV
+
+.. c:macro:: XSDFEC_GET_STATUS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_STATUS
+
+.. c:macro:: XSDFEC_SET_IRQ
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_IRQ
+
+.. c:macro:: XSDFEC_SET_TURBO
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_TURBO
+
+.. c:macro:: XSDFEC_ADD_LDPC_CODE_PARAMS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_ADD_LDPC_CODE_PARAMS
+
+.. c:macro:: XSDFEC_GET_CONFIG
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_CONFIG
+
+.. c:macro:: XSDFEC_SET_ORDER
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_ORDER
+
+.. c:macro:: XSDFEC_SET_BYPASS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_BYPASS
+
+.. c:macro:: XSDFEC_IS_ACTIVE
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_IS_ACTIVE
+
+.. c:macro:: XSDFEC_CLEAR_STATS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_CLEAR_STATS
+
+.. c:macro:: XSDFEC_GET_STATS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_STATS
+
+.. c:macro:: XSDFEC_SET_DEFAULT_CONFIG
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_DEFAULT_CONFIG
+
+Driver Type Definitions
+=======================
+
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :internal:
\ No newline at end of file
-- 
2.17.1


-- 
Kees Cook
