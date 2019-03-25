Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3220693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qp/vUUcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCYVrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:47:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbfCYVrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:47:32 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94C561EC0428;
        Mon, 25 Mar 2019 22:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553550450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N2kG+OvDK53RnL3J3VC/ntnRTrFWxo/9muYMeT6SK4A=;
        b=Qp/vUUcLUTJcf4ZPZKWTXI4D1N/hQ//kZcbvWHk79ZYv/9fuStKmKyPWoPZZ1rYquuoAOF
        jd7W0bRxYQx6ur8eiEgQZmUhiuisc4IdLw/AW6DpUZT+9T9fQjC8QvLrkDfQ1p91zZpkpZ
        oDLfzhe931LwIkp2y9srY+5XoLtk6tM=
Date:   Mon, 25 Mar 2019 22:47:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
Message-ID: <20190325214731.GT12016@zn.tnic>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
 <20190312092842.GC28589@zn.tnic>
 <alpine.DEB.2.21.9999.1903241705460.8028@viisi.sifive.com>
 <20190325065453.GC12016@zn.tnic>
 <alpine.DEB.2.21.9999.1903251211190.8028@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1903251211190.8028@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:18:39PM -0700, Paul Walmsley wrote:
> All of these drivers are for single IP blocks.  Mostly DRAM controllers.
> There's no "platform EDAC manager" IP block in these cases.

Maybe because they have RAS functionality in one single IP block. Others
like altera_edac, for example, have added support for more IP blocks
with time.

> So the EDAC "platform," if there is one, would be Xilinx Zynq, not
> Synopsys.

We have IP blocks sharing between drivers, see fsl_ddr_edac and
skx_common, for example.

> 2. We could create a platform driver for the "SiFive FU540-C000 EDAC"
> reporting platform that wouldn't map to any hardware block, but
> would call functions exported by other sources of EDAC data - most
> likely drivers living in separate directories. If, for example, we
> wind up using a Synopsys memory controller in a future product, we
> move the Synopsys code into a separate library, and move the Xilinx
> Zynq-specific code into a zynq_edac driver, etc.

Yes, librarizing is something we do already. So if you wanna share IP
blocks with other vendors, you can abstract it out into compilation
units like in the examples above. And then those compilation units can
be linked into a platform driver.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
