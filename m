Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8759BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552342196;
	bh=/dZjf6rPJqnIAVCS+xXBMXJDJYRPWIhC47MN4IOonVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kXXY/mVEoUIZHcNiBaebCMtQj237x5Y+eG24IMm4VnpDnIfqhWgLQCs76T6e+P6sE
	 Q2vgSzli7NIJstZF5o7fwpXkV/gI+ScpPTlat+eoEJqwe54/JVSu+W2o+6kxdzx1GO
	 KanTf3WLgEPUe+DL6MwsDV22GPGkdk+FWWbEN1uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCKWJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:09:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45626 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKWJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:09:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so628948otp.12;
        Mon, 11 Mar 2019 15:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJDwMs3RNVoaTah5AWixY+sI71+a+ReCOlP8rTchg/8=;
        b=syoeqlN/e8Wz1t+hlupdv8AGgRo0dWRYxdsxhF+rFqL/SBLAwSQWg4rjehM2JMkXEp
         HUeIzLk2qGQdMJjQlsOECbUtZn8fAAtxemu+tMaYYWy835S/4U8xVa7sSmSgv9dmjxeJ
         rsUhb5obc9pHFu+P13R+RnPbq549dnD2wu/FZ+wFYEwV8DbfciA8TmDcojU9X6sYg9Fa
         q7Oyl26mtBkej8867wd2casOADl+g0Q3YDvKBTSKBvv5ite7L3HVeBhKD0nnhnIuJiwS
         cJjsaNtuGEcQmAFxMJUwC+GFLC78TpvVAW2daQyyx0nSusAecaFVxBCDzKdoQMwBUAyL
         VgUQ==
X-Gm-Message-State: APjAAAVPNdS94eOVL0wabStqVXg4b6MHKQ0su7yfEIM16iQG+rFYKK60
        5Arazp1dZUHV0DV6EbyKPg==
X-Google-Smtp-Source: APXvYqxd6HIAvhbhOVfAGev3OI2HzMBNq0bImEvk2Z4ceffIlebW57ydGIGypdYlPM2uHoiiuGl/Qw==
X-Received: by 2002:a9d:4e84:: with SMTP id v4mr299717otk.27.1552342194087;
        Mon, 11 Mar 2019 15:09:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y37sm2952546ota.17.2019.03.11.15.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:09:53 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:09:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190311220953.GA8432@bogus>
References: <20190311063458.137473-1-pihsun@chromium.org>
 <20190311063458.137473-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311063458.137473-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 14:34:52 +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v5:
>  - Remove dependency on CONFIG_RPMSG_MTK_SCP.
> 
> Changes from v4:
>  - Add detail of more properties.
>  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> 
> Changes from v3:
>  - No change.
> 
> Changes from v2:
>  - No change. I realized that for this patch series, there's no need to
>    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
>    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
>    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
>    created by SCP name service.
> 
> Changes from v1:
>  - No change.
> ---
>  .../bindings/remoteproc/mtk,scp.txt           | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
