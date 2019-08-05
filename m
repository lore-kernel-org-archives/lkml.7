Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA4C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4355C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfHETPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:15:08 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:41192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727830AbfHETPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:15:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 005D552B7;
        Mon,  5 Aug 2019 19:15:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub04_4957d22cc6e16
X-Filterd-Recvd-Size: 2975
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Aug 2019 19:15:03 +0000 (UTC)
Message-ID: <0f56d1fe577707e7804386592e1a5579bfd3abbf.camel@perches.com>
Subject: Re: [PATCH] MIPS: BCM63XX: Mark expected switch fall-through
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 05 Aug 2019 12:15:01 -0700
In-Reply-To: <20190805185533.GA10551@embeddedor>
References: <20190805185533.GA10551@embeddedor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 13:55 -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: bcm63xx_defconfig mips):
> 
> arch/mips/pci/ops-bcm63xx.c: In function ‘bcm63xx_pcie_can_access’:
> arch/mips/pci/ops-bcm63xx.c:474:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (PCI_SLOT(devfn) == 0)
>       ^
> arch/mips/pci/ops-bcm63xx.c:477:2: note: here
>   default:
>   ^~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/mips/pci/ops-bcm63xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
> index d02eb9d16b55..925c72348fb6 100644
> --- a/arch/mips/pci/ops-bcm63xx.c
> +++ b/arch/mips/pci/ops-bcm63xx.c
> @@ -474,6 +474,7 @@ static int bcm63xx_pcie_can_access(struct pci_bus *bus, int devfn)
>  		if (PCI_SLOT(devfn) == 0)
>  			return bcm_pcie_readl(PCIE_DLSTATUS_REG)
>  					& DLSTATUS_PHYLINKUP;
> +		/* else, fall through */
>  	default:
>  		return false;
>  	}

Perhaps clearer as:
---
 arch/mips/pci/ops-bcm63xx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index d02eb9d16b55..a5e4b1905958 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -471,12 +471,11 @@ static int bcm63xx_pcie_can_access(struct pci_bus *bus, int devfn)
 	case PCIE_BUS_BRIDGE:
 		return PCI_SLOT(devfn) == 0;
 	case PCIE_BUS_DEVICE:
-		if (PCI_SLOT(devfn) == 0)
-			return bcm_pcie_readl(PCIE_DLSTATUS_REG)
-					& DLSTATUS_PHYLINKUP;
-	default:
-		return false;
+		return PCI_SLOT(devfn) == 0 &&
+		       bcm_pcie_readl(PCIE_DLSTATUS_REG) & DLSTATUS_PHYLINKUP;
 	}
+
+	return false;
 }
 
 static int bcm63xx_pcie_read(struct pci_bus *bus, unsigned int devfn,


