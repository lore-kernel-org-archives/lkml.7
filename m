Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AF7C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2C218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcwiGo0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390753AbfGWOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:51:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbfGWOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:51:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so20618304pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=wAI/J73/SuEViXJgIx3ykUez6skqEEMGxVLWdHqure4=;
        b=mcwiGo0OGGnJmwu5VoILB9JjAAEwKiRmKy5Mmd7RXzj9gztUWFbEKtOc6GS2tAtuQB
         o/1laoHwe7qm1trcOSkzADOtUNucB8RKLWKbNZQ8ELkEsyHrBkWU3ZHmQiuX1T4rSsuk
         K8xYICMVYZY7/oyotpkOnAkngAxmFjO0cpMCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=wAI/J73/SuEViXJgIx3ykUez6skqEEMGxVLWdHqure4=;
        b=jLobenqpzngrHzmzByZxn3fiMVWCq8TeZvKNKf148sCRK7/BUm4P1MWv83YThqpyaS
         3xoA/BZ4HeD/nHJOMcM+SCY465QFx5NWwJCJd5xe0bMS+YTFSUDJ3OGtB2pCU6EXwgV8
         gg8EVHbdNmgzaSDtZwN+3XTC36Fm1WzsYCt9Udy6r+Pa6MFop3aJO25UmJH7ddISlA5E
         iAQXPl/X+H6MC/MR1t2jx9Ey5Xs+9uHsILHprsaNOjXXm+zYN3mGrZYCbxW6pVIW6Xpv
         BDfwUQanxQJ5VKbksgZLhlWROmBmNtuCNrPoJWz5xK059jsMl0VFMRGbHEdgr8kWg338
         TI1Q==
X-Gm-Message-State: APjAAAXh4tbXs2KRm/zlZAmvLGvDaaC4EBBDLlTuTpW+qLu4ugdKLgIA
        aGiNNHCdxrotURK3Gb7SKQGgOFNIyxw=
X-Google-Smtp-Source: APXvYqxhQml7Fo7GvVBVokUNUbCU97SfpUUqIjvBFdu2bgd8A5/MQr4G8gO8K0I8YLE1r+Mz9DuBBA==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr79624502plp.262.1563893463330;
        Tue, 23 Jul 2019 07:51:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b37sm71455423pjc.15.2019.07.23.07.51.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:51:02 -0700 (PDT)
Message-ID: <5d371ed6.1c69fb81.1ea1c.47f1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722123422.4571-6-vkoul@kernel.org>
References: <20190722123422.4571-1-vkoul@kernel.org> <20190722123422.4571-6-vkoul@kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm845-cheza: remove macro from unit name
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 07:51:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-07-22 05:34:22)
> Unit name is supposed to be a number, using a macro with hex value is
> not recommended, so add the value in unit name.
>=20
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:966.16-969.4: Warning (unit_ad=
dress_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4d: unit name=
 should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:971.16-974.4: Warning (unit_ad=
dress_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4e: unit name=
 should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:976.16-979.4: Warning (unit_ad=
dress_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4f: unit name=
 should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:981.16-984.4: Warning (unit_ad=
dress_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x50: unit name=
 should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:986.16-989.4: Warning (unit_ad=
dress_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x51: unit name=
 should not have leading "0x"
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

