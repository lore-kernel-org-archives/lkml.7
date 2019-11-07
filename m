Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B1C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C621D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZUM/7cXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfKGRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:43:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34193 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfKGRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:43:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id e4so2528155pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=i/bPZYpoTgBBA0/FNFZyzs4p1x5dRwvEFsGyW1K155c=;
        b=ZUM/7cXSrgbDE42yKYLMhG25QGuPe992yvgtfqjaqDYXj7+yjfnf3SsTzMw0AJ/BNk
         YwwYE7udeNrqXvEu9r9ZsbUgCHhDEANgkV9C4Aqoad6abD5bjEzSFBCX2ofNmNej9aWe
         3XiwKjGOpqhuiKZMTkiKgtWIPRk3ov+7Aus2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=i/bPZYpoTgBBA0/FNFZyzs4p1x5dRwvEFsGyW1K155c=;
        b=JvAcpK4+bpkpy8cW3qh7kXwEeLFZZHLsPrStbSCd2ukXdghsfdEcMrINeooKUDTi/F
         Vj6w3ukC9HZkgnYevuyxGWbejFTHM+XfQIXN5RZ4H8pIxFPXBQFUe8Yc4yG/YMV3DW8c
         juu8hhdnfAaWQm6Qjtp61R4+f62Z9nOabcOeHscux6lPLuqtadCaxbBjHSWx5cFNUU4P
         IqS6lqlVcUit6f3rRnm1QtwOX7wNKYYr3acl9VYBuOOxJO/FZWKZk5uxmEdH35QPuyEj
         fwctI+RRcK8I8/H1S8NyyhMfBjO4JyTt7ytYuU1xTOEfbO2+jUzD04PW0rSbQWbPGHda
         hJ7w==
X-Gm-Message-State: APjAAAVVKuq5rXILM6HvoGE2GFEEWok/Q2bllif73vdHav8HsTqadZLm
        sL9bFZny0s6uPs94cgO2aHH8yg==
X-Google-Smtp-Source: APXvYqyKl8+9hlEMt2RuqCuK+QVNWgd3w09FeHcCuF7GvMgHbVE+27A0VSv47omCaySvcInXiNiHXA==
X-Received: by 2002:a63:d802:: with SMTP id b2mr5935568pgh.414.1573148627379;
        Thu, 07 Nov 2019 09:43:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s26sm3138076pga.67.2019.11.07.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:43:46 -0800 (PST)
Message-ID: <5dc457d2.1c69fb81.839ab.803b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-2-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-2-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 01/14] dt-bindings: qcom: Add SC7180 bindings
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:43:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:04)
> Add a SoC string 'sc7180' for the qualcomm SC7180 SoC.
> Also add a new board type 'idp'
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I see that it isn't sorted but o well!

