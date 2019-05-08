Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2095BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3BA2089E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm2N3nQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfEHSKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:10:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40190 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfEHSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:10:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so10290522plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zLWZfJCoIg5TeUT0Jt2rwSpfAhD7R9q7eCYI7YHf40=;
        b=Tm2N3nQ5R4MhS+8rDGVu/boYYfOVT9eIZUs60lgVugsa12xyjFshqIWhczZyFQwzYF
         Ym9H3mmMhQzLUib+TUxO5mS0LpNapV2Zy81WXsYoFwNV+rdA6rOEnixV+TXKtAggW5lK
         QDSEMsjaxPVnY6u3e/z7047pG6rP96Ay9RL1uwxSRF/22zO+7kd1MqxLXfdrrhPThSRA
         mY7VHAWoPNgVv22UCIzmgaNRexxreIebf/jobba8vTVTF9A1vGdOTUvINtIZ8Ly5Xsib
         JDr4j9KfbpUyW4/2fktvOOqSl8/YIGfpKUC/87WCEwPw7Dh3+HZrmyWQrHn3UotZRAP4
         vOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zLWZfJCoIg5TeUT0Jt2rwSpfAhD7R9q7eCYI7YHf40=;
        b=aN6ohe+t1x9moigQaBv+E/fugIPLYeCg3gxEcmHQCPgeNkkVk9wNEZP1IrGjntZ35g
         wrXvJ09o1PEtCJZT5WjVTtUGpUGSa+7j3DIS5weiScopYECIo+nfuU23h1G8m2SU/18+
         pC02vPlPOH9o2/Z2fuYtUsRU1xj0zReKHDTEhV8wLzVzQM9p27oIVaGOiGutaV9siao1
         4x4n97aGVhbvmXogercfTXUJgqeux0ePesClHYOYk1R6VSKCpK+QEpci53zFJZKR7g0U
         TYCGZxKQXyicBbcJrn5XLwwAqshWaeGIFcTEizNZ9wlsd692WBiA2E38o02TzqcKiUVf
         Dklg==
X-Gm-Message-State: APjAAAU0Vva1l+I3ffosaRI7fN7WRVPMDiGPtT2aR4vvacCKlrNmVJwu
        7a604VoKm7cv2uRbU7h37/k=
X-Google-Smtp-Source: APXvYqx2Wb4CB0KCpVy419mUcctEXRtv9dVAdNA+TWZj7LlWHc7EV1/KC6TAZsJVn2A5r991XqqT8A==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr14087995plm.134.1557339023983;
        Wed, 08 May 2019 11:10:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j189sm31400665pfc.72.2019.05.08.11.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 11:10:23 -0700 (PDT)
Date:   Wed, 8 May 2019 11:08:53 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, vdumpa@nvidia.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] Optimize dma_*_from_contiguous calls
Message-ID: <20190508180852.GA2298@Asurada-Nvidia.nvidia.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
 <20190508125254.GA26785@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508125254.GA26785@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 02:52:54PM +0200, Christoph Hellwig wrote:
> modulo a trivial comment typo I found this looks fine to me.  I plan
> to apply it with that fixed up around -rc2 time when I open the
> dma mapping tree opens for the the 5.3 merge window, unless someone
> finds an issue until then.

Thanks for the help all the way.
