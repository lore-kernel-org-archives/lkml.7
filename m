Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EE1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A8720645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SOVEg3br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfCYWB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:01:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:01:28 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2BBA1EC058B;
        Mon, 25 Mar 2019 23:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553551286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TEVcEoWJI3jUCF89gF7GfVQ+U++gmCNNfcxqYh2m4T0=;
        b=SOVEg3brhRCJJ8yQwGzivskBzfB1ME3cMu2Ef5znUCjDBQJw680scRwSl9IWfve/GlJs5f
        gDX2vlzFGkb/x2tRiisFneoUVgMp/7zlmzA3UFQO3v//pqp9zUGPPE3EzyNvGZ798HBnsu
        kIru5nYu+GP7NDDGNMai+8zvw8Nu/OE=
Date:   Mon, 25 Mar 2019 23:01:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Rui Zhao <ruizhao@outlook.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        Rui Zhao <ruizhao@microsoft.com>
Subject: Re: [PATCH v2 1/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190325220129.GV12016@zn.tnic>
References: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
 <20190323092342.GD23698@zn.tnic>
 <c1a16ab4-72d9-f736-065c-b80858f85b7b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1a16ab4-72d9-f736-065c-b80858f85b7b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:27:52PM +0000, James Morse wrote:
> or even:
> | compatible = "microsoft,product-name-dmc520", "arm,dmc-520";
> if there is some firmware/board configuration that means vendor/soc isn't precise enough.

Yap, makes sense to me. If dmc-520 is a memory controller IP, then it
should be a generic, library-like compilation unit which the platform
driver, i.e., <microsoft-platform-name>_edac.c or so links with.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
