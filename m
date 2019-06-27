Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A03C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66020663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S+FOaFSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF0BCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:02:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32869 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfF0BCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:02:24 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so1028510iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LukHuzspVdtsbWmPrQxtJofMfIkJuuBn4KLHq+hXvnA=;
        b=S+FOaFSkDCDJ8fulPJ2UtIixLPm6C3blKm64Y26FpWliH1L0Kug+UoWJSnPzdI0Hcj
         WIpQSV5+lHeemPxtT7Xcm9l2PGDireS9Cy5y9WyCF6nc8MvNf86DT26n4Uj7szEVflXK
         7TdcSck6au5p+xNo79U3stPs5H1RUiTS20Kh1vpGpP8BZLL1aurZbclNgue4GAr053eG
         IbbEFmsd4K4jnK/HKIBOTzUgeV8PgouYszZgI9mVl29aXMFMCPbfE0b+q6K1Srmh1sdH
         CjXuVDZOcP7s9hMhGovvS1kStrCycR0lygvxsnRqkr3dk1iFcCEqAziHpxKtYM1HyLRb
         9oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LukHuzspVdtsbWmPrQxtJofMfIkJuuBn4KLHq+hXvnA=;
        b=IN3SS/hg41KgY2gbAOzhEdV4MlBKFNByeKVHiOawslFUn8kgziPWxRBabLxZFdiG2h
         WD0nGxQ8ijM65mhdkj8EvQ1toBrtlOkS7hnowolwPgfiAQVG3GwPUafOBsLSBiQE0p/1
         IPN18h4V9lXCUb6QiMlUvObm1GWuQ/JeN7ahTzllXdmihNhHbRYbZ8Hlp7/tHpViaVhS
         5y8g9P5/x2wRJ8LuYodeoz8O9ep3Sc+k6XaPt3C+pNoHEC/5hFuTjezUP+qtq+Jj7QjS
         XeI81/S+GBS5/kMmix9ULHvAv/kyPThdhB7kZkrtIbwQZuzpfdRT7zOj5uLynhxNibDi
         7kgw==
X-Gm-Message-State: APjAAAVio1iCI8q5I7f6j8aWeyt3J93rOgrdKTBDwroIBEUi6uihJUme
        hU8Nbx1982SBLbpInmcPGlk+KQ==
X-Google-Smtp-Source: APXvYqxH6d/kyIhVX9FR3/pclmA0eMPc/eQpoi25e5p7JBHqOX5DR5DbYu4JLM1fBKxoY3ScgDchXQ==
X-Received: by 2002:a6b:f711:: with SMTP id k17mr1267637iog.273.1561597343694;
        Wed, 26 Jun 2019 18:02:23 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p10sm1457892iob.54.2019.06.26.18.02.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 18:02:23 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:02:22 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] dt-bindings: arm: Limit cpus schema to only check Arm
 'cpu' nodes
In-Reply-To: <20190627000044.12739-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.1906261759390.29311@viisi.sifive.com>
References: <20190627000044.12739-1-robh@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Rob Herring wrote:

> Matching on the 'cpus' node was a bad choice because the schema is
> incorrectly applied to non-Arm cpus nodes. As we now have a common cpus
> schema which checks the general structure, it is also redundant to do so
> in the Arm CPU schema.
> 
> The downside is one could conceivably mix different architecture's cpu
> nodes or have typos in the compatible string. The latter problem pretty
> much exists for every schema.

The RISC-V patch applies cleanly, but this one doesn't apply here on 
either master or next-20190626.  Is there a different base commit?


- Paul
