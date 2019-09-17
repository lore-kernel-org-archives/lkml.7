Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288AC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BAC206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568736958;
	bh=3RfxZ/IZRnYxFC1OVcnqcIb/VSA/1/sfRLUt35vct4c=;
	h=In-Reply-To:References:To:From:Subject:Date:List-ID:From;
	b=P+p/n9nX7+iGGCTTIuKaR11u6quKNUUrKAgnMKENGRTnPd1LA3vXVwoRubMIpsLkf
	 J7jq+VBVCVjdLxXMcNGi0oDNhzDF97C5IUzSyxWhDk3pQZCRDw2pSv2inOOfQrFJ7n
	 yihlHJ8vd1revi7g8eWYTs8j6RytnFn/HNXfOBXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfIQQP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfIQQP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:15:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164C320665;
        Tue, 17 Sep 2019 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568736957;
        bh=3RfxZ/IZRnYxFC1OVcnqcIb/VSA/1/sfRLUt35vct4c=;
        h=In-Reply-To:References:To:From:Subject:Date:From;
        b=tjYxyLWtXB6LY7Ag0wNoqsm17313qW5GXEgwrJ85UOiuibbvz+CbCB9Qvif3Ciqns
         LMOdOUOgXJ5knWaBtpB8dkHrfYn/SgYPGZ1owqnILyN6BRa8ie/HnwHNVrujcap1UU
         kXvi/2lpa5rCxIOf+oaeySHkcV+rHRIUNflCUzfc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568375771-22933-13-git-send-email-gokulsri@codeaurora.org>
References: <1568375771-22933-1-git-send-email-gokulsri@codeaurora.org> <1568375771-22933-13-git-send-email-gokulsri@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        gokulsri@codeaurora.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        nprakash@codeaurora.org, ohad@wizery.com, robh+dt@kernel.org,
        sricharan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V2 12/12] arm64: dts: qcom: Enable Q6v5 WCSS for ipq8074 SoC
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 09:15:56 -0700
Message-Id: <20190917161557.164C320665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gokul Sriram Palanisamy (2019-09-13 04:56:11)
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/=
qcom/ipq8074.dtsi
> index 6a61a63..0ea026e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -431,6 +485,78 @@
>                                       "axi_m_sticky";
>                         status =3D "disabled";
>                 };
> +
> +               apcs: syscon@b111000 {
> +                       compatible =3D "syscon";
> +                       reg =3D <0x0b111000 0x1000>;
> +               };
> +
> +               tcsr_q6: syscon@1945000 {
> +                       compatible =3D "syscon";
> +                       reg =3D <0x01945000 0xe000>;
> +               };
> +
> +               tcsr_mutex_regs: syscon@193d000 {
> +                       compatible =3D "syscon";
> +                       reg =3D <0x01905000 0x8000>;
> +               };
> +
> +               apcs_glb: mailbox@b111000 {

This is the same as the syscon above. What's going on?

> +                       compatible =3D "qcom,ipq8074-apcs-apps-global";
> +                       reg =3D <0x0b111000 0x1000>;
> +
> +                       #mbox-cells =3D <1>;
> +               };
