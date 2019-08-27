Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487BAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205A22070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFZSCiB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfH0ErW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:47:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfH0ErV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:47:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id y200so5584635pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZggmcMPjgmDFSK8EEYOInY8FueVBR2R/tMdLkVfa1po=;
        b=yFZSCiB0NW9TOMOMqdidHpwU9VtRg9aI8PKGUtwURiN/LSCSiAG8exF7F0huz7CfIL
         QQrFiClqVQ3U2EjlN2hfiqEZ99GCerlGf1avMwsuZtsJP6VnG/Clqi+NBV7UAwu/KEbQ
         rw6E6odIo0bhJnHBiNd9jASUNaNbxjat/1qiGjGgaydb8GNp8oMcgl2+EZYhgyiE0CsC
         FX2DpA4XR5PCqXzyKQxRJcJEmVKFZgAiwfvzpWXtWVjmtkStQCz9jFTivfjatl41qYO3
         6jTQpp7DHUdMzuU3hk2T9d7A3jxalfb8PjBrFy5mRbisSu3f5tXPGrpTx1bs9e5TBwai
         SpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZggmcMPjgmDFSK8EEYOInY8FueVBR2R/tMdLkVfa1po=;
        b=VPh0DPWtjEg4qMpGO+rqQr5YcAkAInd5k47DLgCyGY5VEWdTKIt4L0ZyAugHyHHY7h
         3g6hEFTDDk3lhMcIrYCJpzia6/dqQ7skU9Usx4dbcfOzNhbYpWo1P306/mPBuUP4LKOW
         6i/8+yOQaMZt9hYlYD0zzmZbD+ACgcQUKDPVzaagDLSQ8gY6WABQ9hZHMkrjlrV0llOH
         RGBhBe+iLbxx/jPHKks8ES7HMDn1vqBhYUBYI/AF1cn835XNJ0YTiSQoZ/jyBO1hJ2Lx
         RMcI5S2dBEbxukdIqCFl7OrQ/Cj1mA0SEb87v72TF6+OGf/IupAJg/ddTxjs9kXgnLCo
         DLXg==
X-Gm-Message-State: APjAAAX01GooidiLTBRt4UHx9IntwAUiWyF9Op4KQd7ciEuCuZiRYkE0
        SyGFRRcWeWhaI4tYMCl9sM9f/A==
X-Google-Smtp-Source: APXvYqyE8chtCs5y/WfhbpCulmRV//9zfesOLjWPH3tkAUvp8citEd3eNp1ZCu7OM1j6VaK7ZpbMrg==
X-Received: by 2002:aa7:9516:: with SMTP id b22mr23967083pfp.106.1566881240912;
        Mon, 26 Aug 2019 21:47:20 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm11778661pgs.82.2019.08.26.21.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:47:20 -0700 (PDT)
Date:   Mon, 26 Aug 2019 21:49:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yannick Fertr? <yannick.fertre@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH v2 2/2] arm: Add DRM_MSM to defconfigs with ARCH_QCOM
Message-ID: <20190827044909.GD1892@tuxbook-pro>
References: <1565707585-5359-1-git-send-email-jcrouse@codeaurora.org>
 <1565707585-5359-2-git-send-email-jcrouse@codeaurora.org>
 <CACRpkdbtPo9dr7E2hZ4=fEWTXappWTaypKJyd9M2jz0tYu7HXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbtPo9dr7E2hZ4=fEWTXappWTaypKJyd9M2jz0tYu7HXw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22 Aug 23:52 PDT 2019, Linus Walleij wrote:

> On Tue, Aug 13, 2019 at 4:46 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> 
> > Now that CONFIG_DRM_MSM is no longer default 'y' add it as a module to all
> > ARCH_QCOM enabled defconfigs to restore the previous expected build
> > behavior.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I suppose Andy will pick this up?
> 

Not sure why, but this patch isn't in any of my mailboxes. So thanks for
the reminder, I've picked it from patchworks for 5.4.

Regards,
Bjorn
