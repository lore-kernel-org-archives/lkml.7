Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E30C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF3E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeRnYqWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEFJwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:52:16 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41300 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEFJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:52:14 -0400
Received: by mail-ua1-f68.google.com with SMTP id s30so4422732uas.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sK1AW46uFm51k7mgTa8btpLaGMbzfNDj8ewiwbIYzZk=;
        b=HeRnYqWwxPUpFC+wvfGu3tZiVy2frYO9St/sbs+uJklMjxVucVdmn6QY7a2+duAoK/
         CqMSO5pHO/0IBK3D6Tpy6f0G/HE1XfBgnM34QQ0mL/CnT3ZIDWkGKeuHqmeTpEnI1fUj
         L0UIqDi/D+qQKexFaE5pI/zS76L4gE3ICEmmi6oh0dGwmUiZ7YoG7SbDNHc3hTdqhSB+
         5jZNYuELm8guM30bxvc0vNWiXNkStWGJG+gZtS9e4UDYrXmeMv3vJ+faoezgMsvXua5V
         aywxibcehAlF3e56cgi2jV+BUUePYEXnNM8PS1BWfmacr8nBZ637YpdzLsM9pBN6SQ2i
         cvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sK1AW46uFm51k7mgTa8btpLaGMbzfNDj8ewiwbIYzZk=;
        b=aNn5omqJN9esKtUmaEUbmOpc5IkreYBrYEKLepQ0zk2xF8yn/HSP2apRp6UzvjjqQT
         vV5OO9QSAWkyrlQMYu9ut28BCTidWjlHB4lhme2WUqT4VDMBmGvCQqQnirvYM9N6z/Es
         QTwa+ZSMi+/zqTfsLvYdBpBHOT4C0Ookc8nL1r3DpEYfESJVwH4kiE4ImPl0SAsTheLW
         3zf+6VJhFuJgHV1ObxLjJNeWgrwYzI8dPjE2bbNl0fhbJgnpE2NL3YqbeY/qybUoJtCn
         bv9QFsAx3CiZs6TLjD8Nq4DKbfqkGEO+5bAyi1JcKG6QxMW1KbHSpmgDZYaxAIRFpUIF
         WvZQ==
X-Gm-Message-State: APjAAAXFO2DJOt3pVl0SqTumPMhOz2Mq7IuFaCXtVQIJb0QQ+V2FG7SL
        U96COUHjU47AUtOvGSlgDZ9Uw3FUlOHr39+icvcnbg==
X-Google-Smtp-Source: APXvYqwRjSSrQqdAGdNhhsMUNgKYFkiN8aJTLBYaPDU00ethSrpubRCAgZGaRAPkoFFQeWvQTDbGYAQff6V2hFR7nzc=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr12246383uar.15.1557136333748;
 Mon, 06 May 2019 02:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190505055858.37509-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190505055858.37509-1-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:37 +0200
Message-ID: <CAPDyKFrcFo_zCy5q2VkUP+SxOTogmAsys-X_yBrARLE1dTcqqw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: add DT bindings for ls1028a eSDHC
 host controller
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2019 at 07:57, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
>
> Add "fsl,ls1028a-esdhc" bindings for ls1028a eSDHC host controller
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in v2:
>                 as alphabetical order to update dt-bindings
>                 update the commit information.
>
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 99c5cf8507e8..edb8cadb9541 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -17,6 +17,7 @@ Required properties:
>         "fsl,t4240-esdhc"
>      Possible compatibles for ARM:
>         "fsl,ls1012a-esdhc"
> +       "fsl,ls1028a-esdhc"
>         "fsl,ls1088a-esdhc"
>         "fsl,ls1043a-esdhc"
>         "fsl,ls1046a-esdhc"
> --
> 2.17.1
>
