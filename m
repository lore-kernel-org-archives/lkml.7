Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BEC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfCNJBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:01:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfCNJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:01:43 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MC2sF-1hCMao1r9p-00CPPM; Thu, 14 Mar 2019 10:01:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pms7003: sleect IIO_TRIGGERED_BUFFER
Date:   Thu, 14 Mar 2019 10:00:52 +0100
Message-Id: <20190314090118.312040-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1/wqKqH6Pb2x35vhjeXuzv30Pa6M1KHMh+TdBc/rsXhXodVhI83
 1NcgzuUMcizvEjocDfAceyWj+HFaFyojkHA4jVjGM9cwtigUBUYp8MEImIj68oJVwn/pnVF
 XrMr46iBLL0nH/j6Ck/fi0dU/vY2J6NrBb9PANZYUYFxeTQeXVvyizr4lN2H2WSfb5dRoOL
 OnhoLXTO/8MPdDTPwbwmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnr8RDpwZjw=:5nwaqa8c02CYBiN+P2dIB4
 j4mufEt0H2d4k7lxipz3eg7/h5/50PLpk/mueQ/ACakQ8EmDG8EwQYWvHnIRjEsOkjDqzESW7
 TQvoaFoiHR809cDfafC+PX5Vhi+jT9MOYzkWJrpXafH2Tf1DbJGLWso1P7CjdecdPkHlMY1B7
 jTUxIEOccY18JZCFGs5ROvf9OzmK/Nw480xIOgiwYH+8eryX2z3ixB/Q6JnuHyd8rgTYRrDS3
 ODWoV/XewQJo3yprhXzhEbdxVFLRn82ndjdzHWDbTmGpkzM6WdVTGtM3GCOwb4//A7gQNG0RR
 hTWmDyUpKECPEqPgHi/aTjvKOyx+CDeh90Nk1OD8NTGdxIFIlQ3XhPT4Mf2w+HyH/SrVOkU2Y
 Xllje9ZYJK2clNnvDYmUlnyfYGyOUhQqmVdZb1rpojOZcmfvSR32SPiJwwI0/pjNGUaHoS3Jd
 WS38Gvv0TRDJEPjaBN54umDzdGdNWqwF0UGszi+U3KDXPEN0EzPqKdk5vIxErv06NquQDlJcc
 MN5c0FqlbJTxu6HQ0nCapVbMMYbLgIVLPRk/431gXfaMnYXHWvRa1+xBQAYXeNEQd484PbZaQ
 rO+uAwRuHpfS5JJZpQNFiaGFXjRC79lRvxdXvtcRwcbrWs4HWgj4FjKJAfLqMQ5Tq/Vyh56PT
 BmkNiyTLcwr+eY1STmK+VTYUCPsRsXxy4avp6z+gw4+i8yHMEXwj4+ssDvJQ9rBCVu8/NCWUN
 l2ocvB2irIdOMPdQkdjCoEmahIkzIO5kc6v4xA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without IIO_TRIGGERED_BUFFER, this driver fails to link:

drivers/iio/chemical/pms7003.o: In function `pms7003_probe':
pms7003.c:(.text+0x21c): undefined reference to `devm_iio_triggered_buffer_setup'
pms7003.c:(.text+0x21c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `devm_iio_triggered_buffer_setup'

Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/chemical/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index d5d146e9e372..6f253092a523 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -64,6 +64,7 @@ config IAQCORE
 config PMS7003
 	tristate "Plantower PMS7003 particulate matter sensor"
 	depends on SERIAL_DEV_BUS
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build support for the Plantower PMS7003 particulate
 	  matter sensor.
-- 
2.20.0

