Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297812184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfC2PSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:18:38 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:58221 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbfC2PSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:18:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 296D4180A3773;
        Fri, 29 Mar 2019 15:18:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sign09_6802b253b5c1b
X-Filterd-Recvd-Size: 2720
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Mar 2019 15:18:34 +0000 (UTC)
Message-ID: <983c78e8648eb9c21e35eee77a73caccaed1617b.camel@perches.com>
Subject: Re: [PATCH] trivial: MAINTAINERS: fix bad file pattern
From:   Joe Perches <joe@perches.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Vinod Koul <vinod.koul@intel.com>
Date:   Fri, 29 Mar 2019 08:18:33 -0700
In-Reply-To: <20190329145702.1894-1-Eugeniy.Paltsev@synopsys.com>
References: <20190329145702.1894-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 17:57 +0300, Eugeniy Paltsev wrote:
> Fix bad file pattern in MAINTAINERS section 'SYNOPSYS DESIGNWARE
> AXI DMAC DRIVER'

NAK

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -14987,7 +14987,7 @@ F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
>  SYNOPSYS DESIGNWARE AXI DMAC DRIVER
>  M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>  S:	Maintained
> -F:	drivers/dma/dwi-axi-dmac/
> +F:	drivers/dma/dwi-axi-dmac/*

This is not correct.

The original patch added these files:

 drivers/dma/dw-axi-dmac/Makefile               |    1 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1008 ++++++++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  334 ++++++++

The pattern should not be dwi- but dw-

F:	drivers/dma/dw-axi-dmac/

(no i after dw)

Also the patch subject and commit description should reference the
MAINTAINERS section.

So your patch should be something like
---
Subject: [PATCH] MAINTAINERS: Fix bad file pattern in SYNOPSYS DESIGNWARE AXI DMAC DRIVER

commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
added an incorrect file pattern.  Fix it.

Signed-off-by: <you>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..30f5156336ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14987,7 +14987,7 @@ F:      Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	drivers/dma/dwi-axi-dmac/
+F:	drivers/dma/dw-axi-dmac/
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 
 SYNOPSYS DESIGNWARE DMAC DRIVER


