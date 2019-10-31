Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48870CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C5B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWvZD90G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJaMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:07:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35388 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:07:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id y6so4458537lfj.2;
        Thu, 31 Oct 2019 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLdb6BKKsBwdTyCqC3oQr2+bLOSWyaoFNjx8aaET/HU=;
        b=sWvZD90G57wEHYe8Pgdv+Opt8LMv8QJ47fYyZyYAqKyVohLypEc/k5xmxMYQrtVhtg
         c4+Gv2vRm4USOBpQChSEyz9IopS/XX8Nl1yar4DVdPV/s63tDtR0oHYJXqRA6DA/S5Ti
         5QJLHveP0STTYEV8W4SiS2rMZRRbomLtlf3r3x7hKsrL8J5fXJ5yPcKx4qSkYCnygOao
         PYBgSFir3lDNXeZ4NFHEwNj6yQMg1E4ihqoD2GKV5gFuNBcwxomAEOl1gqaw8ejkLIAu
         VgzS0eFF6O9yCe6NhWxr1UoK1QHd182uEFLpuvx7FW1l55L/61MnXJIF7FzMvumAECoz
         7D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLdb6BKKsBwdTyCqC3oQr2+bLOSWyaoFNjx8aaET/HU=;
        b=tuZei9Ej0whXIYZFMNL1Reo5T3TnoTWEUjXE71W+71juRHowwrVEpAM1tcqruWxjL9
         VswSkXXCgYlbruRdXsuAiqmJ3JLIn3H5h5YUla+Lu136dK2IfEt8jM1U5NVmylLSLQdS
         EBvfRIDWOlUMMbJVuaEdWBLJRBoeLS7pUMiMXey9INLj3wSMJsJjiWL41+3ngt8NGXXX
         U7GCOPIMf9UWue2+FSVGhh0oHfW+SOZCt0G+U8litx9mZYb8IaHYmNOKPxj/tgmEWVYT
         slO7in9Bsuncuj9NVq5jLfjY6gW90jxUsEzjltPaePmbWyskx5K6GOemZtXxC/Azr5eh
         f/LQ==
X-Gm-Message-State: APjAAAWSfxbXf9WfON9S9FNGNhl3mhazPNtj0tA7BOjfAZR3Hk7qVpjd
        mSOOmwZI8plVID75rbRtKtpyUIqc0Mj1yf+GsPc=
X-Google-Smtp-Source: APXvYqzouS1Q1he9V4ma5fFVHYkpzWmxxcN5v9/+VSFY+GMtwPnz/Rhj664y3z7SNUmnvg/zabQ+BfeH/1fUBA55JkM=
X-Received: by 2002:ac2:4564:: with SMTP id k4mr3360446lfm.20.1572523633629;
 Thu, 31 Oct 2019 05:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <1572515888-3385-1-git-send-email-peng.fan@nxp.com> <1572515888-3385-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572515888-3385-3-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 31 Oct 2019 09:07:22 -0300
Message-ID: <CAOMZO5DWphRs_ZdDiNPLo0MPo45vBTEojWhYnZyWYF6+t12jxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: imx: imx7d: remove clk_set_parent
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Oct 31, 2019 at 7:02 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Since the set parent could be done by assigned-clock-parents in
> dts, so no need clk_set_parent in driver.

It looks like this will cause breakage if someone is using an old dtb, right?

We try not to break existing dtbs.
