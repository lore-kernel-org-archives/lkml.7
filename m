Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4244C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="STWh/0wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfCYGyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:54:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfCYGyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:54:54 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC9BE1EC02AE;
        Mon, 25 Mar 2019 07:54:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553496892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LpYxhVlfV2gEX33wV6ozS41lCPpjrz6TfKLaI6w0DWs=;
        b=STWh/0wQCrqwcWm8++Mv75iFq985KBxk9fW2UIzE9jzeS4H/PeIAVTo5GUx3nsNnkuzS59
        3DWXY9nWcoWC+Geg2GaXQLj2/O4PxEs4VY5m1hTHyUwlYawz302mAy/2WyOoncQ8Brp1zV
        EcdwslK0NW/UjdMzrOKk4QP8AyRGFlA=
Date:   Mon, 25 Mar 2019 07:54:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
Message-ID: <20190325065453.GC12016@zn.tnic>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
 <20190312092842.GC28589@zn.tnic>
 <alpine.DEB.2.21.9999.1903241705460.8028@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1903241705460.8028@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 05:16:17PM -0700, Paul Walmsley wrote:
> Looking at the Synopsys,

Look again at synopsys_edac.

>  Highbank,

Yes, that one and octeon.

> PowerPC 4xx, and

also a single ppc4xx_edac driver.

> TI EDAC drivers,

There's TI drivers, plural? I see only ti_edac.c. Also, per-vendor.

> all of those are clearly for IP block error management, rather than
> platform error management. Has the upstream guidance changed since
> those drivers were merged?

There are others which are per-platform and work just fine this way:
xgene_edac, altera_edac, layerscape_edac, qcom_edac, synopsys_edac...

The problem with per IP block is that if those compilation units would
need to share info or communicate, then that is impossible nowadays and
you'd need to build something on your own.

Also, the EDAC core supports only one driver.

> The core issue for us is that we don't have a generalized "ECC management" 
> IP block.  And I would just as soon not fake one in the DT data, since the 
> general DT guidance is that the data in DT is meant to describe the actual 
> hardware.

Look at how the others I mentioned above do it.

> Would it make more sense to put this driver outside of drivers/edac?

If you're not going to need any EDAC facilities - which are not a lot,
btw :) - you can do whatever you prefer.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
