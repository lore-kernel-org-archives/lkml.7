Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC00C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7B42084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmEwRpV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfDJLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:55:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbfDJLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:55:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so1843245ljb.1;
        Wed, 10 Apr 2019 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Md20MqRw/qgfE7+0W6zS0ZMe2x1oQC5nYihLPJw4tj0=;
        b=EmEwRpV96MDybt+mGUQAXNSNOUjVcxOmxPOrxWgbiN34rqnSn7pp82RKfiAUZnN+FT
         v3goH3s0jSoIqQD2RGT7bnaGt6jMeTMbVGzOOqqqh7on1B2vUg2JqFLd6T18WZ1uzWFi
         fKkUFoxsOGkdVgDJF2AzUPobIUc1UpRVgyFcBXfVYRVPmhD5uFYdxy/SKpOE20vOlKvK
         CqQjj4xAuMjQjXd5tX2ihd3CXizLHUkIn/ULk3MIr/L5zyTZz9D9Q5UNFcIAYNNj4iMH
         TokDxGy0R0ptS8nzBaJbXZ+8Hb6rbxb2vhjUkcdUNkA+/piRTKx7iVCfjQrRBXsOlfkX
         BGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Md20MqRw/qgfE7+0W6zS0ZMe2x1oQC5nYihLPJw4tj0=;
        b=a+0D9PDGM7CYQn/fR8ZwT9VHLs2/aphkvC1BYEEsCjq2GECYWYjsz7Q86MVdGVsSQ4
         sJM5u96i7eZfK4dc4PGVHhyu2t9P1o1GGLTJrgRdSBREMmitLYoft+rk+wMDUeeaA947
         aD/pIrnZrScleKL+uv3Qe2ojyBSZP6l87jDkW3NvisIvSdNB2J5Yxko0/IYBdbDnmfDT
         u7rtF7sECsFmgadK4yvEx9uLlde9yXbOzfzvXsIOUQAOjrQ2lcmeqE2yabo25grGBdZR
         utcdp+99UUvk7HHmjOhsHy8QQd4aCb46BP+mBcQeDLSZUa+YksrtVwMSuZFzGzSUVcWI
         Z9lg==
X-Gm-Message-State: APjAAAUR+Pyl+C6yPMFP3SnUpwofRevYR5DWRsA5Qhv7Q+8FVMTWVpVp
        wRLFfA+Mv//8Vbso9acNHOZvOvtQVCNaSfr6gdE=
X-Google-Smtp-Source: APXvYqwUpvtWD0RHCAa36ubUPRuZmkqwVQjhXx1ru+Ld6YHzCTOJ5uSU8VpHtZDAL0KmY9/XYtKSX/RQqu+ZgrOvMww=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr24132359ljc.105.1554897311244;
 Wed, 10 Apr 2019 04:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190408175319.9106-1-robert.foss@collabora.com>
 <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com>
 <4fd506a1-c961-0569-6d39-283758f363d9@collabora.com> <CAAMH-ys-S7miJFCAY9bxrDGTPPT7e7c430-_4+edH8scV_qTwA@mail.gmail.com>
 <550afae6-8dd8-39aa-c7a2-01b27557aa53@collabora.com>
In-Reply-To: <550afae6-8dd8-39aa-c7a2-01b27557aa53@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Apr 2019 08:55:05 -0300
Message-ID: <CAOMZO5Aj+NKOsa1zXfQqsSzqDJGOcza+1wGjdiEytvjAhsnOVQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Wed, Apr 10, 2019 at 7:57 AM Robert Foss <robert.foss@collabora.com> wrote:

> # dmesg
> imx-drm display-subsystem: failed to bind disp0 (ops imx_pd_ops): -517
> imx-drm display-subsystem: master bind failed: -517
>
> This dmesg log is failing to bind disp0 at another point than what I
> was seeing before, yet the result is the same. The connected HDMI
> output is not brought online correctly.

It seems that the ldb failure is due to the lvds backlight nodes not
finding the PWM resource due to the PWM driver rename.

Please check if this patch fixes the problem on your case:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190410&id=728e096dd70889c2e80dd4153feee91afb1daf72

imx-drm should also be fixed independently of this PWM rename change
in my opinion.
