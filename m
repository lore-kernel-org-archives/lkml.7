Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A10206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLPdLSeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391004AbfIERds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:33:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIERds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:33:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so2194657pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=QOU2fQSnEMLrYzBWOEmTCGpu7kl2KoRGYPyXWekRxFo=;
        b=nLPdLSeZYkCdXYg47Zk8yaMIeE+E7vOm69Gu3zUn2kx8md33AAfro52hxkxX2stB/o
         WZbR4YaWa7z0PLGI5OkJUNCAeYHYn43jqA19pbqd19b6rvoRCdz1i3mI68/sl7CH/tiG
         /UCTKOdiJmyzTZoREfUPUxqxDdxgyXQC9hYtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=QOU2fQSnEMLrYzBWOEmTCGpu7kl2KoRGYPyXWekRxFo=;
        b=GhodCO/TUg39pTWdvU+S+49th6tnSiC01VPHIplLbN/Pcc8XhXgV25AFlX81r/HUrZ
         zKPEnfNfy5A1nw42OLgokD7wmC9xDar2+OpK/mA8nuiN8cVjsOmyAd26IJjxUrbzEJpo
         CIJYUx2FGNeaRvyxthUyWR8miBWlOIG85RcWbDmg/dd5iCUhryUyPWrgb4sDIcPzi9QP
         zi8JJ9Ot0ko7PoAWbyO3Elo7s08JRSLj9gPdcuPzbgTCfGfasofFdcNMz2MCi0wL/oio
         rODmfzC7cJo+mT24o+lq3GWR8YdrRaHd80MK6DrzLoiuoMW5kSw4CQXtYAvJyuuZ/peb
         zecQ==
X-Gm-Message-State: APjAAAVR322qFoASfCzKcY+lA4kV9IFg58NC/HRsOMpBxkAaOnSfZrYG
        jic9dhng4wcwTkiyy8yQOMp9RW8/zDM3TQ==
X-Google-Smtp-Source: APXvYqz+0+yaaxJQM5pVlU26kNn+3QA/1QGN/LfY5TdaWbV7kBX334BYFDDtUf5aA8ZfofZhnEcc4w==
X-Received: by 2002:a17:90a:356d:: with SMTP id q100mr5201262pjb.53.1567704826899;
        Thu, 05 Sep 2019 10:33:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g2sm3739214pfm.32.2019.09.05.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 10:33:46 -0700 (PDT)
Message-ID: <5d7146fa.1c69fb81.8444a.8f49@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190823081703.17325-7-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org> <20190823081703.17325-7-mkshah@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: Add rsc power domain for sdm845
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 10:33:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2019-08-23 01:17:03)
> Add rsc power domain to enable sending sleep and wake votes
> using generic power domain infrastructure.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Can this be combined with the previous patch?

