Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7712E2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wXkyyjJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfCVNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:46:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41238 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfCVNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:46:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MDkBf7020840;
        Fri, 22 Mar 2019 08:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553262371;
        bh=6lnw42xQnd59r6q9kzhZH91/lwsxa1AtSiFWswwaN6Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wXkyyjJItBr86WhrUr1sbK/W2hdFsWQ8CLFe144jRet9seJLU/95zvsR0W3MUGOCM
         rLyrI5eqRVaFoE4exUSefVws3GBx5xJXsr9m990vaVN04Mn9va1j0SKXky1r0VVfGx
         qKYY9rLk/jghBaIWIbdTBKhWfV75/O254DC/rfhA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MDkBOw047180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 08:46:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 08:46:10 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 08:46:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MDkAkb004810;
        Fri, 22 Mar 2019 08:46:10 -0500
Date:   Fri, 22 Mar 2019 08:46:10 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20190322134610.GG25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
References: <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <20190321130133.zllt5pqbrhiecoch@flea>
 <20190321164138.GB11121@kroah.com>
 <20190322124622.GB25852@uda0271908>
 <8a5e34c5f24d63a7735ae86ccd340f6b5f66959d.camel@bootlin.com>
 <20190322133608.GE25852@uda0271908>
 <8bc814b508ef86214a9913b4fdb9c13681934a7b.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8bc814b508ef86214a9913b4fdb9c13681934a7b.camel@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:37:24PM +0100, Paul Kocialkowski wrote:
> > > 
> > > > To summaries my comments on this again, since it is minor in my opinion,
> > > > I won't spend time to solve it myself (in a near future), but I am more
> > > > than happy to review and take any patch which solve it. 
> > > 
> > > It is definitely very much appreciated that you are open to accepting a
> > > fix for this issue even though you consider it a non-issue :)
> > 
> > I believe in previous discussion I have expressed I am open to a
> > solution ;)
> 
> Indeed, you were always open to seeing the issue solved :)
> 
> > but I don't consider "it is a non-issue", it is minor in my opinion,
> > then I don't have time to solve it myself.
> 
> Right, sorry for over-stating this!

No worries at all.

-Bin.
