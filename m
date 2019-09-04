Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291C821726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qj6RRzQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfIDXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:21:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:21:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so326273plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=ULpSeBhDFHW/Z7ALGDxp4P/kWpUMLgBqKrrXb0VWOMQ=;
        b=Qj6RRzQfU3bz20/IIbWSW7pEUG/VayrDOEKhxX6jYW4QID/DaDB6mFdzI/sGD64oY6
         m9yWTXvuG1j0T+eZOi8vCDxYebBRADyBulDjQZEvjT2r32XetSUBQufzrSYAX0slQITa
         ZzB9NBVM9QAnIxsuJ4Pub4DKBRy/lU1wAPVJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=ULpSeBhDFHW/Z7ALGDxp4P/kWpUMLgBqKrrXb0VWOMQ=;
        b=ug8zI70eMdSI96stBR/pB8uHo6PLJJFYQaFjlkcqqB0OYYsN+EhtyoIsaBDDV5xWcd
         MHrV0ofM02WJOBIy/fGL6WV7fGudS4swhgswrMSf4zAGQmOiEYr5qG0kq49JGjWsWfLF
         gpfXuNhFVVriRzt84PaMDRuYgHqUozjU/tXEAJ39vtz1GcSOp+pvrRckupjUc4f8jRsL
         XRhj4VjM5eAflxW8H8jLZ87pzFSgLec5CjfvWRZqyy911xWdEuTnFhJgqnu035jDC5Er
         LPVCmXEVwgaQeXTB+vlscQuiZttAYg5BbRikLyhsTrTmHwM0i8PR/b7vd+VHObeQDCJx
         928w==
X-Gm-Message-State: APjAAAXOa0kCX/Q/Wm/rv2StqV5gyOcuufSiWfS3+rgibLY+CxmobpEw
        hneZyOFR614nKubyTs7Hw3Noig==
X-Google-Smtp-Source: APXvYqwX0L/kKM6d91lqvHvx4evD1/Fc65jO689+1S9fNksh5eYf5k2DOvZ/YB5CrUW5vLdYMLynIw==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr310025plb.84.1567639303914;
        Wed, 04 Sep 2019 16:21:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t6sm188653pgu.23.2019.09.04.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 16:21:43 -0700 (PDT)
Message-ID: <5d704707.1c69fb81.3e1cc.0e50@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904100835.6099-2-vkoul@kernel.org>
References: <20190904100835.6099-1-vkoul@kernel.org> <20190904100835.6099-2-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add sm8150 compatible string
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 16:21:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-04 03:08:33)
> Document "qcom,sm8150-ufshc" compatible string for UFS HC found on
> SM8150.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

