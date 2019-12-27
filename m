Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBEC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAFC2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/mUbr70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfL0BYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:24:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35890 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0BYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:24:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so4219057pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bZGwwBs0+6wjFWF5xEm+/9dLXTyLkBQWZ94+6z/JBpE=;
        b=K/mUbr701M92ISU0kMifSC+j0Z/biy7G5mB4E4nvDyaG4m/U43mBEDO+B/BiZFJzCq
         5AJ9Ll+vdNnQjturr7JjSFGAmE2HYkq+cDC6gENPBqiZBsWg8XwUlQm9tO7vYA1cRHhT
         n2HD7XydzDPqnOITnIdoZ2kD13Pvopx37unwWwVBhnyggAZFAKt+TBVS0nQr5WWMR2Wg
         TiDA8PB57nC2x/WcKnkYvycu+NPefQY85lwEItMETKPDuAjyeIqJqjgi8yHDddraIjUM
         yJj9Tjb0iKX9+LbxP1JXuPYAVcRrSspr0LkhFnLvhrmdtFcsjXoz0EgNAmVyV0M7PbvN
         cqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZGwwBs0+6wjFWF5xEm+/9dLXTyLkBQWZ94+6z/JBpE=;
        b=fVbzN/6Q4HTuAyk02PoM/ZFljVr28KmqUnuwIenAIS/RMfnVy9azDISXwyGtG5Usf2
         T+yEaIniFVx5y96tPUBD/ix0JUQrb/IiU71j9g6V2t3N6fUBh8n/0Ia5R8i/jZ1iWi6E
         7H+vRpzzCnYUj33v3NvDBCwmGQTFjg8XbFkfEHraUJcdVVvMngb6qgnSZSwOPLuDiDzq
         13jeV1+r9YBSJ+SauswBGCjL9mhXNgfLyS06KFV3VcHRurl3BsLEkVHE3Q1iIwwFBfOO
         eqYREoKpJc2vWchoMjAoiyzXc9+Mpm0XwkIkE9q3wFB/64L2luEw0WTLURdokNmUgN7D
         cAlA==
X-Gm-Message-State: APjAAAUSeQ95aQx4Fh687p9aKQ+LU6r4oYainrpYkWPMVP6xxH8W3x4k
        +2fRufiKjAMAQcm5j4MiJgSIjA==
X-Google-Smtp-Source: APXvYqzh0FoNDYeUyJDwrPL52Vfp1xeNK2adiqJa8UWMQ6lp0+cUi22UsEt4mkLL5pR+BkRNYUOVXQ==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12mr33713668plb.218.1577409844600;
        Thu, 26 Dec 2019 17:24:04 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n188sm35364210pga.84.2019.12.26.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:24:03 -0800 (PST)
Date:   Thu, 26 Dec 2019 17:23:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add support for SDM845 PCIe
Message-ID: <20191227012349.GG1908628@ripper>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Nov 16:16 PST 2019, Bjorn Andersson wrote:

Bjorn, this still applies nicely on linux-next and works as expected.
Could you please apply it? Or would you like me to resend it with
people's tags picked up?

Regards,
Bjorn

> This adds support necessary for the two PCIe controllers found in Qualcomm
> SDM845.
> 
> Bjorn Andersson (2):
>   dt-bindings: PCI: qcom: Add support for SDM845 PCIe
>   PCI: qcom: Add support for SDM845 PCIe controller
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  19 +++
>  drivers/pci/controller/dwc/pcie-qcom.c        | 150 ++++++++++++++++++
>  2 files changed, 169 insertions(+)
> 
> -- 
> 2.23.0
> 
