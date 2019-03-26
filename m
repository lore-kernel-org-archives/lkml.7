Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A621BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024720823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="v3mqQ7mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfCZFnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:43:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38808 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfCZFnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:43:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so5605109vsi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgItU0iuQXmDd8+M01D0UyRQB/txnZWDcxqvXjJC+lA=;
        b=v3mqQ7mrzm5H2aqKTM1Ml93tGUzSg58rJLGu++dhDa/G7LfwLXRvFPKP4y6KorwF1F
         lebTvFFZmQYhF1KNhWArWyTyFpTYYjP1PuYkwUsA5GJDKc0sBoLZnbFbhe0AKj06A5J9
         YsLVp0LJDMVYQlpkifFM1KF0pNU9KeVwGmLzVopMUY5sLp5uXQDlDP6X2pPyWQzTaJyO
         SjDPWkIbSuPaj8mVwaQpFpxTtbFQ9Nc634GnoqXvBuhj+FMcuhbRyjxyTWy+Eoe4S+M5
         Jw3LbveBqkKOmDaNJLR2GNpyd/0PJbNCMnXvvoDx8Bi+stQCNlR0JQOlcpUVPpROv58g
         1Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgItU0iuQXmDd8+M01D0UyRQB/txnZWDcxqvXjJC+lA=;
        b=ZII+jlnMDfjtdqt0zDNwNx1iDDYOlsNaraYqfGgpATW9eulAZTEjUN0UuFmzwZEszP
         iIp5DttowQitVXeekRNvi2sEWygPne8QtP5q5F0rNrzXy7+iA7KktiwbtjFlWBXaNaw/
         HRSKBPK2fpSXqXUe7wTz/HI/HoxTQcL+JLNSn695/1NdyBtJtwstF/fCpW6TATvlCZ0G
         pvb/7ivpFSZgDlf3iMSfKcIDYQlJpNDwQ3VFBBAE9kpJFRQhMWi0gpd6ASwHQf+o+myV
         uGfKbsAMN+BcMBxbdUcCuIvzIiMMqYYQgGcCYMoe6mYUNSIHWthfjPw7FbZ9VeXIgnIj
         k1Dw==
X-Gm-Message-State: APjAAAXbjSoqlFW9z2kRCk2eMTPXbzt3IF0d0an+Y/Oihq+2LXOAXBax
        okefAD1VSDvPWCkgVquZAL73+UFSHKVcZjaXugJaEA==
X-Google-Smtp-Source: APXvYqwOtqIV8FyVT+1C3rEYAZB2M1RbPT4GIPnq4pz88NvXFZAWGsghbHQpNMlFV5SgNLiRjhLFofVZPbL/PAosK7M=
X-Received: by 2002:a67:f505:: with SMTP id u5mr10367422vsn.159.1553578979644;
 Mon, 25 Mar 2019 22:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190326052139.11784-1-vkoul@kernel.org>
In-Reply-To: <20190326052139.11784-1-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 26 Mar 2019 11:12:48 +0530
Message-ID: <CAHLCerOv+HkWskZwoAN+rTFb7kXoNC+DbNd3zRWf0dEdhd3D2w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINER: Fix Qualcomm ETHQOS ethernet DT file
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:52 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Commit 83c177aea4c3: ("MAINTAINER: Add entry for Qualcomm ETHQOS
> ethernet driver") added incorrect filename for DT binding, fix the same.
>
> Fixes: 83c177aea4c3 ("MAINTAINER: Add entry for Qualcomm ETHQOS ethernet driver")
> Reported-By: Joe Perches <joe@perches.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..74c654d89a43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12849,7 +12849,7 @@ M:      Niklas Cassel <niklas.cassel@linaro.org>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> -F:     Documentation/devicetree/bindings/net/qcom,dwmac.txt
> +F:     Documentation/devicetree/bindings/net/qcom,ethqos.txt
>
>  QUALCOMM GENERIC INTERFACE I2C DRIVER
>  M:     Alok Chauhan <alokc@codeaurora.org>
> --
> 2.20.1
>
