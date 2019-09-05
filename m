Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C611C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C482173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMOXcAZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfIEGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:53:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37263 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfIEGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:53:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so1092095pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=X6bK3rfbzFX8967fDBi6v6AmnIt9qDTHKSROdx1Ey68=;
        b=TMOXcAZIxeJNHBrueuJKwf8rRmgsDchSIH08Y8UYbPEz8/ML1fe//YAgKorZGuVkQt
         +qg5tcl4ej3ySxjgGRvHzBszSWI3B8fTOPg6An0WVOwYX1yLkB5tXFC1ASCSCrsLfNvB
         BCGbTcmoeOcIO7DH/TWi+MXOPrCLE1R49vndg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=X6bK3rfbzFX8967fDBi6v6AmnIt9qDTHKSROdx1Ey68=;
        b=RELxIZbiS1/JBRwyaiKrEYTTzvvhesX47x59YsA9rmvpt81K5GNF0Y7tuTPMD9eVrR
         SPJDV6QoEUTefLaxeEVwzpIC8i6AEUxhakU6FHoqNlJZxUOdhJbO7xjnHUoE2fON80hd
         wZnuu3fnMy0bSsZY3X8SnKbhDuSO90RofpQzFSt4YMI9hTaWNHKheMnzgUktpjnaJ4nv
         2/ZDNowehmxIczrhQcxSJYC1jzn9Wv3Ce7Ifp0cHNpKcHrPaleCqjHlG1hJbzTHbgo/B
         aKiF5QQALFFn6PLy7Y9u+rxm5hVQiIrgNI2uixl/Vhd9rO2IY3/A8WoT9jq97KaEb7vB
         plJA==
X-Gm-Message-State: APjAAAUDyA/UZLCmnzT5twclx4SXJVI406tZlqgG0YapgbSH8bQhvwlG
        rMx+Ny18OaaU/XsTrIW5pNBYbg==
X-Google-Smtp-Source: APXvYqzTMrxxPrIHi7PSBcBRZ/WFPRHu9P1fN0ROt0DOaHqZK/np3NsB3NYUIyyL3/gMBfrIsrD/wA==
X-Received: by 2002:a62:1d8a:: with SMTP id d132mr1938054pfd.187.1567666416741;
        Wed, 04 Sep 2019 23:53:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c15sm1254784pfi.172.2019.09.04.23.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 23:53:36 -0700 (PDT)
Message-ID: <5d70b0f0.1c69fb81.f862a.40e4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190718130238.11324-3-vivek.gautam@codeaurora.org>
References: <20190718130238.11324-1-vivek.gautam@codeaurora.org> <20190718130238.11324-3-vivek.gautam@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jcrouse@codeaurora.org,
        rishabhb@codeaurora.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/3] soc: qcom: Rename llcc-slice to llcc-qcom
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 23:53:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2019-07-18 06:02:37)
> The cleaning up was done without changing the driver file name
> to ensure a cleaner bisect. Change the file name now to facilitate
> making the driver generic in subsequent patch.
>=20
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/soc/qcom/Makefile                      | 2 +-
>  drivers/soc/qcom/{llcc-slice.c =3D> llcc-qcom.c} | 0

qcom/llcc-qcom.c seems sort of redundant. Would have been nice to have
it named llcc.c but I guess the ship has sailed. <sad face>

