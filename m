Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71133C4321B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493F62082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560204534;
	bh=wa2HdHpzK5YZ98vLNvJM2KFuWOFO6C+Fp4cfd/H2ghc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x1hbVU6NfkTH8a68A7Pqoeu5hr8xlPRBQkmhDkrnKcBliaUdhcpHvBs/KHzNjnWKv
	 mAOfpbhRlXN8MPYebmicTLuD1hrVME8skmf+j9QagvFHLVc3Jt5nvNFl4cNurxBFtG
	 ifa9CEh7PJApVKcv3sXO5UCGyZ3zyHdq9JEebRFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfFJWIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbfFJWIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:08:53 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882812089E;
        Mon, 10 Jun 2019 22:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560204532;
        bh=wa2HdHpzK5YZ98vLNvJM2KFuWOFO6C+Fp4cfd/H2ghc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ENEr1pjhpsDiMrdFl6+74MII5XYFnkJwxICsIsV8RVuHesr0AlQ6Ug/z78dXTDm+T
         89Y2I0a/mzkriuLOC9wMp35GQ8PVM/3sdZSM3UYigS7lxPbePPfWYsoUvJaNin9YSS
         Zk/5IZxmg6+AxRba0gfW/Mi4RVmdUfSzYt7lN4jc=
Received: by mail-qt1-f178.google.com with SMTP id 33so4044642qtr.8;
        Mon, 10 Jun 2019 15:08:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVFJ6njCFQM4GvchzTcoSM/ewtVqn3upyVXqCEEpRHSB7WKw+22
        aRGE3bnYnf+P/w1v54f/BEFyCc2Hgo862aL7Ew==
X-Google-Smtp-Source: APXvYqzYXOOjmX8G+khXwwdebIogCYLWvQ9T2R8AhEyK2iWf0s4VXDco+E+jid7s4gmOxWq26X5IXOT0DcFDuZYtru0=
X-Received: by 2002:a05:6214:248:: with SMTP id k8mr26084007qvt.200.1560204531833;
 Mon, 10 Jun 2019 15:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190531035348.7194-1-elder@linaro.org> <20190531035348.7194-3-elder@linaro.org>
In-Reply-To: <20190531035348.7194-3-elder@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 16:08:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLFk3=YN+V=RVxq9xWQTrPA9_0zW+eFrdXkGkCnM_sBkA@mail.gmail.com>
Message-ID: <CAL_JsqLFk3=YN+V=RVxq9xWQTrPA9_0zW+eFrdXkGkCnM_sBkA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, subashab@codeaurora.org,
        abhishek.esse@gmail.com, netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 9:53 PM Alex Elder <elder@linaro.org> wrote:
>
> Add the binding definitions for the "qcom,ipa" device tree node.
>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../devicetree/bindings/net/qcom,ipa.yaml     | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> new file mode 100644
> index 000000000000..0037fc278a61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: GPL-2.0

New bindings are preferred to be dual GPL-2.0 and BSD-2-Clause. But
that's really a decision for the submitter.

Reviewed-by: Rob Herring <robh@kernel.org>
