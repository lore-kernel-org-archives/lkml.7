Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB34C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F6B2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLnQadxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbfKGRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:53:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45632 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfKGRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:53:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so3014667pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=Z1meOcmCHhy99P4fXRI3J73L34xiXqPe78fR6qMJPVs=;
        b=QLnQadxuoANQOJKtrxBWYRplFZhr5y7KH/jL1HZUfqjnpptx33kh5lUmPKfYMd9YVQ
         bARtBN/NJhls2KvlTsfvyJOrlg7c5GH8m9iCM6lxowKjhJid9PCt9TaX3CaTIAuI5u2X
         BavZrRK9riPOwopN+0xpaTTIfWJCOzob10/DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=Z1meOcmCHhy99P4fXRI3J73L34xiXqPe78fR6qMJPVs=;
        b=bKaeMnc8lTV817l9ZYAea/vd+7JpheaVelk5CIyw6xVJWv5nEx+Am6Jihf0bs7DlTr
         Y6WIKbRl+ZCqgk47ucPZXyTZH3YxPd7ebUIsuEacEbHPQTY0UvNXqpFgg4ScgbfOieZD
         NLvlqIHlQmLsJYmLTlo9K6WV8WtKAFWx8BdoK3zLiFUyIO2RlrNmHNYw1vxB4RpFnl79
         I8gSD3uKEi3Ido2nTwyClN3tsa9ogld/VgMLoDntgIjKUExu9SFMnzu3RrbdE/c98CpZ
         VZEItIgTFzDghMlNHzXpDX+aQyNNEfDMljI35Hso+IltSR4TABpiiJtgNhKOBi5Eu3I0
         2rKQ==
X-Gm-Message-State: APjAAAWxlIPD/jEZlz8z7+x20Qf7LpvooLeAKwsab53WwjtcmFdo5mX4
        gdwz3U5UULalescva+Z74lbx/g==
X-Google-Smtp-Source: APXvYqy2MPJnmW/pfuOQlOn68cLFkoKu7z0z/loK7nPIfMNOZ6qnq8Gov2lHnZCxa4/yKRoi7GNTAQ==
X-Received: by 2002:aa7:83c2:: with SMTP id j2mr5709899pfn.225.1573149211214;
        Thu, 07 Nov 2019 09:53:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z1sm2579247pju.27.2019.11.07.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:53:30 -0800 (PST)
Message-ID: <5dc45a1a.1c69fb81.62b3b.65c6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-7-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-7-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 06/14] arm64: dts: qcom: sc7180: Add rpmh-rsc node
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:53:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:09)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index 61250560c7ef..98c8ab7d613c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -387,6 +388,24 @@
>                                 status =3D "disabled";
>                         };
>                 };
> +
> +               apps_rsc: rsc@18200000 {

The node name is non-standard. This has been a problem since sdm845
though so it would be nice if we can invent some new name for this that
is standard at some point in the future.

> +                       label =3D "apps_rsc";

Can we remove this property? The value seems minimal given that we can
use the dev_name() and get the address in there instead of using a label.

