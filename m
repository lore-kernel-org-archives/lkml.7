Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A85C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE47233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfHVMFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:05:47 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23713 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731326AbfHVMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:05:47 -0400
X-UUID: 8ad007a033e94d2c86504cb82cb2715a-20190822
X-UUID: 8ad007a033e94d2c86504cb82cb2715a-20190822
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1573296079; Thu, 22 Aug 2019 20:05:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 22 Aug
 2019 20:05:29 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 20:05:28 +0800
Message-ID: <1566475533.11621.18.camel@mhfsdcap03>
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <ming-fan.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 22 Aug 2019 20:05:33 +0800
In-Reply-To: <20190822112836.efodtwu3souq3uwa@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
         <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
         <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
         <1566464186.11621.7.camel@mhfsdcap03>
         <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
         <20190822101749.3kwzd5lb7zinsord@willie-the-truck>
         <e6652176-763d-5298-9e10-8c1fbe1b3c0d@arm.com>
         <20190822112836.efodtwu3souq3uwa@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: F20067B59D18F1DAE1600790624773E385B1897B1B418F35B0B8F7CF6BE8012E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks very much for viewing this so quickly.

On Thu, 2019-08-22 at 12:28 +0100, Will Deacon wrote:
> On Thu, Aug 22, 2019 at 11:57:11AM +0100, Robin Murphy wrote:
> > On 2019-08-22 11:17 am, Will Deacon wrote:
> > > On Thu, Aug 22, 2019 at 11:08:58AM +0100, Robin Murphy wrote:
> > > > On 2019-08-22 9:56 am, Yong Wu wrote:
> > > > > On Wed, 2019-08-21 at 16:24 +0100, Will Deacon wrote:
> > > > > > On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
> > > > > > > MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
> > > > > > > the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
> > > > > > > respectively. Meanwhile the iova still is 32bits.
> > > > > > > 
> > > > > > > Regarding whether the pagetable address could be over 4GB, the mt8183
> > > > > > > support it while the previous mt8173 don't, thus keep it as is.
> > > > > > > 
> > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > ---
> > > > > > >    drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
> > > > > > >    include/linux/io-pgtable.h         |  7 +++----
> > > > > > >    2 files changed, 28 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > > > > > >    {
> > > > > > >    	struct arm_v7s_io_pgtable *data;
> > > > > > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > > > > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > > > > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > > > > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > > > > > 
> > > > > > Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
> > > > > > ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?
> > > > > 
> > > > > Here I only simply skip the oas checking for our case. then which way do
> > > > > your prefer?  something like you commented before:?
> > > > > 
> > > > > 
> > > > > 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> > > > > 		return NULL;
> > > > > 
> > > > > 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > > > > 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> > > > > 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> > > > > 		else if (cfg->oas > 34)
> > > > > 			return NULL;
> > > > > 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> > > > > 		return NULL;
> > > > > 	}
> > > > 
> > > > All it should take is something like:
> > > > 
> > > > 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
> > > > 		max_oas = 34;
> > > > 	else
> > > > 		max_oas = 32;
> > > > 	if (cfg->oas > max_oas)
> > > > 		return NULL;
> > > > 
> > > > or even just:
> > > > 
> > > > 	if (cfg->oas > 32 ||
> > > > 	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT && cfg->oas > 34))
> > > > 		return NULL;
> > > > 
> > > > (and if we prefer the latter style, perhaps we could introduce some kind of
> > > > "is_mtk_4gb()" helper to save on verbosity)
> > > 
> > > I wondered the same thing, but another place we'd want the check is in
> > > iopte_to_paddr() which probably needs the PHYS_ADDR_T check to avoid GCC
> > > warnings, although I didn't try it.
> > 
> > I'm pretty sure I confirmed that "paddr |= BIT_ULL(32)" doesn't warn when
> > phys_addt_t is 32-bit - it's well-defined unsigned integer truncation after
> > all, and if GCC starts warning about all the valid no-op code it optimises
> > away then it's going to run up against IS_ENABLED() first and foremost ;)
> 
> You're quite right, although we live in a world where GCC shouts at us about
> missing comments in switch statements so I think my worry was justified!
> 
> > > So if we did:
> > > 
> > > static bool cfg_mtk_ext_enabled(struct io_pgtable_cfg *cfg)
> > > {
> > > 	return IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> > > 	       cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT;
> > > }
> > > 
> > > Then I suppose we could do this in _alloc():
> > > 
> > > 	if (cfg->oas > cfg_mtk_ext_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS)
> > > 		return NULL;
> 
> ^^ Apparantly, I left the bracketting here as an exercise to the reader.
> 
> > > 
> > > and then this in iopte_to_paddr():
> > > 
> > > 	[...]
> > > 
> > > 	paddr = pte & mask;
> > > 	if (!cfg_mtk_ext_enabled(cfg))
> > > 		return paddr;
> > > 
> > > 	if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > > 		paddr |= ...
> > > 
> > > 	[...]
> > > 
> > > What do you reckon?
> > 
> > Yeah, that's the general shape of things I was picturing - I'm not that
> > fussed about the PHYS_ADDR_T_64BIT thing, especially if it's wrapped up in
> > just one place, so if you do want to keep it as belt-and-braces I'll just
> > consider it a slight code size optimisation for 32-bit builds.
> 
> Ok, great. Yong Wu -- are you ok respinning with the above + missing
> brackets?

Of course I can.

NearlyAll the interface in this file is prefixed with "arm_v7s_", so
does the new interface also need it?, like arm_v7s_is_mtk_enabled. And
keep the iopte_to_paddr and paddr_to_iopte symmetrical.


Then the final patch would looks like below, is it ok?

 
+static bool arm_v7s_is_mtk_enabled(struct io_pgtable_cfg *cfg)
+{
+	return IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
+		(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT);
+}
+
 static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
 				    struct io_pgtable_cfg *cfg)
 {
-	return paddr & ARM_V7S_LVL_MASK(lvl);
+	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
+
+	if (!arm_v7s_is_mtk_enabled(cfg))
+		return pte;
+
+	if (paddr & BIT_ULL(32))
+		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
+	if (paddr & BIT_ULL(33))
+		pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
+	return pte;
 }
 
 static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 				  struct io_pgtable_cfg *cfg)
 {
 	arm_v7s_iopte mask;
+	phys_addr_t paddr;
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
 		mask = ARM_V7S_TABLE_MASK;
@@ -194,7 +212,15 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte
pte, int lvl,
 	else
 		mask = ARM_V7S_LVL_MASK(lvl);
 
-	return pte & mask;
+	paddr = pte & mask;
+	if (!arm_v7s_is_mtk_enabled(cfg))
+		return paddr;
+
+	if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+		paddr |= BIT_ULL(32);
+	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+		paddr |= BIT_ULL(33);
+	return paddr;
 }
 
 static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
@@ -315,9 +341,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot,
int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
-
 	return pte;
 }
 
@@ -731,7 +754,10 @@ static struct io_pgtable
*arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 {
 	struct arm_v7s_io_pgtable *data;
 
-	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
+	if (cfg->ias > ARM_V7S_ADDR_BITS)
+		return NULL;
+
+	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
 		return NULL;
 


> 
> Will


