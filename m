Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E69C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B282070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUuDgzjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2BAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:00:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2BAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:00:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so257997pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5okW6g2VapWq+966zCYvvEkTXlL5bw9tVSxlg7ghy+Y=;
        b=YUuDgzjEuJMlWW4Q7SU3Nwqb9mKmP8inZ7fTn8526il+ecMkkCKinaV5fhtcohgMms
         8tQs/rulsNffA0rbpzc0ANiUa57KQCw7VMPFTRqrS4d3JJ+99G/Nk6lJ1nCoMlXDgsLM
         bZdDe7hx2ecOU2dlHCuN6vqcbfs+qwTKP1GxAt+beJWErt10s7C2dk3qnxTrmb+ElFVA
         HmwbGFspPbvFjnJC6dXVb5fjK+iUXLVYTnJuh/9fnL3EXc2u/eoQipDU7aGbPZY82ZCM
         x+tw+Qv2CZ3ULihn65VrHSiADLAQuy5kHfeqbfL4u7iy1O6JLeFk39Wj0KKflIGYIyox
         sOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5okW6g2VapWq+966zCYvvEkTXlL5bw9tVSxlg7ghy+Y=;
        b=hOG81LsJUtOAlx2jbDdyXAaY9D0v8WBLx3w2bhV82GvHG1I2t8v96PJfjBFo2la6aN
         O+OJD/P0m43cKBrbF81h/o04mKyINW5FFkpUpTmmuF0triSN8BhSqFwSog5O5mMS2pAF
         q2wH86WoYi2FswiNZkgLoFKEA9Y7sVKKA5vVwmTFmCAi3C6d6biGfnoTym/+OkSiEMR7
         V2wM0T334fUBZTsOqOIJ/02R7QA0GfAs4cnyhmGh/LLNGnb0jmBe7KvZ56Zt2A50Jl4K
         oar3i73wp/vmZ+v41/uHu8YVIHRwN0seTv4YR0iXz71ukjD91gXXLdMaLJoIPlWXlOlA
         a/lA==
X-Gm-Message-State: APjAAAUIab388CSS2/w5jP9pbMKiZCiSxdd+rD+pxggnOaobysKvvIiq
        MRCQFAMCDcxiAXAVLtJqUVoLv+p1o/M=
X-Google-Smtp-Source: APXvYqwLe9mfrNT7kmddfcq3cOHoZhNyk/rZbdgG0+dKzVdRNnJ5+snM6mVlWtpLxJZWw1Q1w/2BIA==
X-Received: by 2002:a63:f703:: with SMTP id x3mr132423383pgh.394.1559091641061;
        Tue, 28 May 2019 18:00:41 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p64sm19050426pfp.72.2019.05.28.18.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 18:00:40 -0700 (PDT)
Date:   Tue, 28 May 2019 18:00:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Qualcomm PCIe2 PHY
Message-ID: <20190529010038.GB3923@builder>
References: <20190502001406.10431-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502001406.10431-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 May 17:14 PDT 2019, Bjorn Andersson wrote:

> The Qualcomm PCIe2 PHY is based on design from Synopsys and found in
> several different platforms where the QMP PHY isn't used.
> 

Kishon, any feedback on this or would you be willing to pick it up?

Regards,
Bjorn

> Bjorn Andersson (2):
>   dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
>   phy: qcom: Add Qualcomm PCIe2 PHY driver
> 
>  .../bindings/phy/qcom-pcie2-phy.txt           |  42 +++
>  drivers/phy/qualcomm/Kconfig                  |   8 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  drivers/phy/qualcomm/phy-qcom-pcie2.c         | 331 ++++++++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c
> 
> -- 
> 2.18.0
> 
