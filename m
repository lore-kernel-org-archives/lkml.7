Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B26C46477
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96982082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOamw89o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437722AbfFLQUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:20:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46893 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405705AbfFLQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:20:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so11280365ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGnqd9Lnz73Nlt6Cpd3RXZr+OtcI19F6L4MTrB8lLC0=;
        b=rOamw89o4BmOG4JNJsRrr9BwFaZsYUeeixxAWB3fLjpUS4o1qi7xp98nu7jQP/nWVI
         uK0WAHLscIq0hxWfnKOBQgdoIEKEFWtftt4M9pgvKM51Ge0C3clly+qCXa151h6JW2oi
         TmvXuHU2Kd6LsuZ6xTQkLGol/MT/K0MQuuSp/7vK2S74namjvp92dXKyc73/0nTgNOIX
         vKoy1bkZWZLcCUT35OpQV0hkoWR1dsCRdr0fTJepkOgjeKM4w9z89b+63AAPlpWH43Kq
         /1Hz2dm2h8N2OPoIIu+xqL39ZPrMeulAv2aq1JyLr1rGPQ3ZKWKq/pq/tjSW0xwAzCeI
         rlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGnqd9Lnz73Nlt6Cpd3RXZr+OtcI19F6L4MTrB8lLC0=;
        b=AgxxzwpTNVYrF0ljwZ82upes5Glb25qMvsETPI4jdwe7Fz7hWkmMw9FFz5ibTyCFnr
         zMROn9MX4zTg+xr4+5I6xvlp7G908AZkYsO7EwfvyY1jBdRUp8hwX3HYRMBby3ISMTXT
         ttFcX6gDlbCT6ws88S8j899VyG+4Iz/rG6ibCCiWonytzx5ZO/CsGT24W1s2+i7NpStY
         yDPDb1oiqZWGYue7nCNIrGvprC9v+6CEvoDqAh4N26PsZg07aMB3NjpEDpXbQF4eCqsG
         ePEBAqnT9lFOYDvCrfuTaNFc6KcwBHn2bmHluxvYCMXHsdFH4EgdIkfTh68RzLCFuQls
         N2Gw==
X-Gm-Message-State: APjAAAVUNTOHK1O01zGrEo/IR33LIZj/Tl1jkjRsfoLzUKulDtym9qfg
        1OJFEGoJl8yKlXkPsBUvG02ucw==
X-Google-Smtp-Source: APXvYqxHp27rb9u7Mkr3fPhsqguW1pahuY6EWwWefytPIt0BcqEHjy+t596UW+bnpbFXzDWojKMZ6g==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr14742955ljk.152.1560356451323;
        Wed, 12 Jun 2019 09:20:51 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id 25sm48477ljo.38.2019.06.12.09.20.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:20:50 -0700 (PDT)
Date:   Wed, 12 Jun 2019 18:20:48 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: msm8996: qcom-qmp: apq8096-db820c fails to boot, reset back to
 fastboot and locks up
Message-ID: <20190612162048.GA30551@centauri>
References: <20190610134401.GA12964@harukaze>
 <20190611171225.GA21992@centauri.ideon.se>
 <20190612131735.GB11167@centauri>
 <20190612140911.GA16863@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612140911.GA16863@harukaze>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:09:11PM +0200, Paolo Pisati wrote:
> On Wed, Jun 12, 2019 at 03:17:35PM +0200, Niklas Cassel wrote:
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > index cd91b4179b10..22352e3b0ec5 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > @@ -1490,7 +1490,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
> > >  
> > >         ret = qcom_qmp_phy_com_init(qphy);
> > >         if (ret)
> > > -               return ret;
> > > +               goto err_lane_rst;
> > >  
> > >         if (cfg->has_lane_rst) {
> > >                 ret = reset_control_deassert(qphy->lane_rst);
> 
> Hi Niklas,
> unfortunately, it didn't help - i added a printk, to highlight when it failed:
> 
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1489,8 +1489,10 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>         }
>  
>         ret = qcom_qmp_phy_com_init(qphy);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               dev_err(qmp->dev, "qphy initialization failed\n");
> +               goto err_lane_rst;
> +       }
>  
>         if (cfg->has_lane_rst) {
>                 ret = reset_control_deassert(qphy->lane_rst);
> 
> After several reboots i was able to trigger the phy init failure again:
> 
> ...
> [    2.223999] qcom-qmp-phy 34000.phy: Registered Qcom-QMP phy
> [    2.224956] qcom-qmp-phy 7410000.phy: Registered Qcom-QMP phy
> [    2.228798] ufs_qcom_phy_qmp_14nm 627000.phy: invalid resource
> [    2.237271] qcom-qmp-phy 34000.phy: phy common block init timed-out
> [    2.240315] qcom-qmp-phy 34000.phy: qphy initialization failed
> ...

I still think that the above patch is correct,
even though it didn't fix your problem.

If you try to disable the two other PCIe controllers:

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 943f69912074..95900fe99f89 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -455,12 +455,12 @@
                        };
 
                        pcie@608000 {
-                               status = "okay";
+                               status = "disabled";
                                perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
                        };
 
                        pcie@610000 {
-                               status = "okay";
+                               status = "disabled";
                                perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
                        };
                };


Can you still reproduce the reboot?


Kind regards,
Niklas

> 
> these are the last lines printed, before rebooting in fastboot and
> locking up there (as before[*]).
> 
> So, as far as i understand there are two distinct problems:
> 
> 1) sometimes, qcom-qmp-phy fails to initialize
> 
> 2) and when that happens, the failure is fatal and it led to a reboot & lockup
> in fastboot
> 
> 1: https://pastebin.ubuntu.com/p/rtjVrD3yzk/
> -- 
> bye,
> p.
