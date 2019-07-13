Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD8C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466D2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfGMUWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 16:22:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:47468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfGMUWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 16:22:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 13:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="169238922"
Received: from mwajdecz-mobl1.ger.corp.intel.com (HELO mara.localdomain) ([10.249.128.127])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2019 13:22:18 -0700
Received: from sailus by mara.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hmOX3-0000J8-6W; Sat, 13 Jul 2019 23:22:09 +0300
Date:   Sat, 13 Jul 2019 23:22:08 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>, kishon@ti.com,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <20190713202207.v7t2t3r24amctxvf@mara.localdomain>
References: <1562923580-47746-1-git-send-email-prime.zeng@hisilicon.com>
 <20190712072145.gr3dbfvdfgrye6yi@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712072145.gr3dbfvdfgrye6yi@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:21:45AM +0200, Maxime Ripard wrote:
> On Fri, Jul 12, 2019 at 05:26:04PM +0800, Zeng Tao wrote:
> > The phy framework now allows runtime configurations, but only limited
> > to mipi now, and it's not reasonable to introduce user specified
> > configurations into the union phy_configure_opts structure. An simple
> > way is to replace with a void *.
> >
> > We have already got some phy drivers which introduce private phy API
> > for runtime configurations, and with this patch, they can switch to
> > the phy_configure as a replace.
> >
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> 
> I still don't believe this is the right approach, for the reasons
> exposed in my first review of that patch.

I agree.

The very reason for having PHY type specific structs is to allow configuring
the PHY independently of the PHY device. This patch breaks that.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
