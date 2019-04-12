Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC082C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805452083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z0dMNmf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDLKRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:17:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33673 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDLKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:17:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190412101741euoutp017be6de9cfbb8ea33029c506675aed34c~UsrTydnai1422614226euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:17:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190412101741euoutp017be6de9cfbb8ea33029c506675aed34c~UsrTydnai1422614226euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555064261;
        bh=lN+XnhWEMkQ0fzryrdFbFXtaTrDcCTbeTvxBVv9jmGc=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Z0dMNmf4NbEkAQJARBOl4A/ilqNNA/BZlW3U+8/z4r/BoQYwbfQOLe+rSoUnSE47A
         oWMAHTrdEgwMPFkv67CNakEjXFIx02wcRE1m8UMckB3QLNrP4eJ/KNmzcmCt2BL0r8
         2Xo7hIyOxH1WHLiHhsNMzHFEzXH3kvMQskUV9I04=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412101741eucas1p2140a8c9844465a14dbac25c65b7be925~UsrTV0Sqp0271902719eucas1p2l;
        Fri, 12 Apr 2019 10:17:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.BA.04298.4C560BC5; Fri, 12
        Apr 2019 11:17:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190412101740eucas1p25cb418ef6836d06074d6a2f3fe3b9355~UsrSt1EOK0760607606eucas1p2A;
        Fri, 12 Apr 2019 10:17:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190412101740eusmtrp1bd815be7e526febae218cb161eda0e7f~UsrSf4k_Z2794027940eusmtrp1b;
        Fri, 12 Apr 2019 10:17:40 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-05-5cb065c496b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.85.04146.4C560BC5; Fri, 12
        Apr 2019 11:17:40 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412101739eusmtip2a612d0b6acc790b0db093b99b3f612e2~UsrSSTbay2006420064eusmtip2X;
        Fri, 12 Apr 2019 10:17:39 +0000 (GMT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] tty: remove redundant 'default n' from Kconfig-s
Message-ID: <353e4c44-2c90-f70f-d0e3-47218cf905d7@samsung.com>
Date:   Fri, 12 Apr 2019 12:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87pHUjfEGGzfYWzRvHg9m8WUDR+Y
        LC7vmsPmwOyxf+4ado/1W66yeHzeJBfAHMVlk5Kak1mWWqRvl8CVsbfvHHvBUfmK57vfsjYw
        zpHoYuTgkBAwkZg40bGLkZNDSGAFo0TLDc0uRi4g+wujxNqG7+wQzmdGiZcTDzODVIE0TLi8
        hgkisZxR4sn/P1DOW0aJ/pPd7CBjRQSCJY5uNQFpYBZQl9i27woriM0mYCUxsX0VI4gtLOAo
        MXXlG7ByXgE7iR+bskHCLAKqEpdPvGUFCYsKREj0n1EHCfMKCEqcnPmEBWKivMT2t3OYQbZK
        CNxmk1g34SoLxG0uEpuvLWODsIUlXh3fwg5hy0icntzDAtGwjlHib8cLqO7tjBLLJ/+D6rCW
        OHz8IthmZgFNifW79CHCjhJTztxjh4QWn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaY
        tV07V0KDzUPiws05jJCAjpV4eaubZQKjwiwkr81C8toshBsWMDKvYhRPLS3OTU8tNsxLLdcr
        TswtLs1L10vOz93ECEwUp/8d/7SD8eulpEOMAhyMSjy8G5zXxwixJpYVV+YeYpTgYFYS4Q1h
        AQrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgZCnVPRXw
        ION6zKJjl6R72hlOBnDXsnWVus25uKdaMu3P1M8Fq9NmC/50554352zvz3oLu/SJBwM5Xj6u
        UIufFmAp//K56OZZD3X534b/920VWnd7jpj4p4tZ1m2tJab5U8r7guT0Wj9f+dC72b5cYHdi
        Q0zJkfmRv1/4ck48W2q/asVTy9uLlViKMxINtZiLihMBYgP+NhADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xe7pHUjfEGDw6zWnRvHg9m8WUDR+Y
        LC7vmsPmwOyxf+4ado/1W66yeHzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CXsbfvHHvBUfmK57vfsjYwzpHoYuTkkBAwkZhweQ1TFyMX
        h5DAUkaJX9t+MncxcgAlZCSOry+DqBGW+HOtiw2i5jWjxMLFE5lAEiICwRJ9S16ygtjMAuoS
        2/ZdAbPZBKwkJravYgSxhQUcJaaufMMOMpNXwE7ix6ZskDCLgKrE5RNvwcpFBSIkbj3sYAGx
        eQUEJU7OfMICM/LPvEvMELa8xPa3c5gnMPLPQlI2C0nZLCRlCxiZVzGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgQG9bZjPzfvYLy0MfgQowAHoxIPb4DV+hgh1sSy4srcQ4wSHMxKIrwhLEAh
        3pTEyqrUovz4otKc1OJDjKZAh09klhJNzgdGXF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0
        xJLU7NTUgtQimD4mDk6pBsapa79yiwg0fPUrkPV/OMch71Esv5oXy7XJRX7REpPVb/1R2OCa
        sbLjuiXP1OnFm5RXdhxNnWHaxX42KK1VKnxZTKS9AdN8lu+ak0/e8fRUv+WYu3/L7Bued1el
        iBWLMiv1611m+VXrvMSuad+7opj04wnp0wIy50nppubLf7+Zcbbyj8tGEyWW4oxEQy3mouJE
        AOBArQqAAgAA
X-CMS-MailID: 20190412101740eucas1p25cb418ef6836d06074d6a2f3fe3b9355
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412101740eucas1p25cb418ef6836d06074d6a2f3fe3b9355
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412101740eucas1p25cb418ef6836d06074d6a2f3fe3b9355
References: <CGME20190412101740eucas1p25cb418ef6836d06074d6a2f3fe3b9355@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/tty/Kconfig        |    3 ---
 drivers/tty/hvc/Kconfig    |    2 --
 drivers/tty/serial/Kconfig |    3 ---
 3 files changed, 8 deletions(-)

Index: b/drivers/tty/Kconfig
===================================================================
--- a/drivers/tty/Kconfig	2019-04-12 12:13:09.102141672 +0200
+++ b/drivers/tty/Kconfig	2019-04-12 12:13:08.766141664 +0200
@@ -84,7 +84,6 @@ config HW_CONSOLE
 config VT_HW_CONSOLE_BINDING
        bool "Support for binding and unbinding console drivers"
        depends on HW_CONSOLE
-       default n
        ---help---
          The virtual terminal is the device that interacts with the physical
          terminal through console drivers. On these systems, at least one
@@ -313,7 +312,6 @@ config N_GSM
 config TRACE_ROUTER
 	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
 	depends on TRACE_SINK
-	default n
 	help
 	  The trace router uses the Linux tty line discipline framework to
 	  route trace data coming from a tty port (say UART for example) to
@@ -329,7 +327,6 @@ config TRACE_ROUTER
 
 config TRACE_SINK
 	tristate "Trace data sink for MIPI P1149.7 cJTAG standard"
-	default n
 	help
 	  The trace sink uses the Linux line discipline framework to receive
 	  trace data coming from the trace router line discipline driver
Index: b/drivers/tty/hvc/Kconfig
===================================================================
--- a/drivers/tty/hvc/Kconfig	2019-04-12 12:13:09.102141672 +0200
+++ b/drivers/tty/hvc/Kconfig	2019-04-12 12:13:09.034141670 +0200
@@ -25,7 +25,6 @@ config HVC_CONSOLE
 config HVC_OLD_HVSI
 	bool "Old driver for pSeries serial port (/dev/hvsi*)"
 	depends on HVC_CONSOLE
-	default n
 
 config HVC_OPAL
 	bool "OPAL Console support"
@@ -74,7 +73,6 @@ config HVC_UDBG
        bool "udbg based fake hypervisor console"
        depends on PPC
        select HVC_DRIVER
-       default n
        help
          This is meant to be used during HW bring up or debugging when
 	 no other console mechanism exist but udbg, to get you a quick
Index: b/drivers/tty/serial/Kconfig
===================================================================
--- a/drivers/tty/serial/Kconfig	2019-04-12 12:13:09.102141672 +0200
+++ b/drivers/tty/serial/Kconfig	2019-04-12 12:13:09.070141671 +0200
@@ -370,7 +370,6 @@ config SERIAL_MAX310X
 	depends on SPI_MASTER
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
-	default n
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
 	  Supported ICs are MAX3107, MAX3108, MAX3109, MAX14830.
@@ -653,7 +652,6 @@ config SERIAL_MUX_CONSOLE
 config PDC_CONSOLE
 	bool "PDC software console support"
 	depends on PARISC && !SERIAL_MUX && VT
-	default n
 	help
 	  Saying Y here will enable the software based PDC console to be 
 	  used as the system console.  This is useful for machines in 
@@ -1110,7 +1108,6 @@ config SERIAL_QE
 	depends on QUICC_ENGINE
 	select SERIAL_CORE
 	select FW_LOADER
-	default n
 	help
 	  This driver supports the QE serial ports on Freescale embedded
 	  PowerPC that contain a QUICC Engine.
