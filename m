Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067DC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 04:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A04233FD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 04:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391792AbfHWE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:59:55 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:49885 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391664AbfHWE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 00:59:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 73D998368F05;
        Fri, 23 Aug 2019 04:59:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm80_39106449b3b1d
X-Filterd-Recvd-Size: 2482
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Aug 2019 04:59:52 +0000 (UTC)
Message-ID: <59c7ff8f2306069095503b72824714e369a378f8.camel@perches.com>
Subject: Re: [PATCH 10/12] phy: amlogic: G12A: Fix misuse of GENMASK macro
From:   Joe Perches <joe@perches.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 22 Aug 2019 21:59:49 -0700
In-Reply-To: <6d7abb4d-fe68-8d02-d985-7214118be126@ti.com>
References: <cover.1562734889.git.joe@perches.com>
         <d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com>
         <c6cabf9c-7edd-eea8-3388-df781163cddd@baylibre.com>
         <6d7abb4d-fe68-8d02-d985-7214118be126@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 08:11 +0530, Kishon Vijay Abraham I wrote:
> 
> On 22/07/19 12:53 PM, Neil Armstrong wrote:
> > On 10/07/2019 07:04, Joe Perches wrote:
> > > Arguments are supposed to be ordered high then low.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > index 9065ffc85eb4..cd7eccab2649 100644
> > > --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > @@ -66,7 +66,7 @@
> > >  #define PHY_CTRL_R14						0x38
> > >  	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
> > >  	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
> > > -	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
> > > +	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
> > >  	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
> > >  	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
> > >  	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)
> > > 
> > 
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Shouldn't this go to stable trees as well?

The macro define is unused so it doesn't have to go into stable.

> -Kishon

