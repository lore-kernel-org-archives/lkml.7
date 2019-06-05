Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E12C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8452075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMDtt3o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfFEGBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:01:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40047 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfFEGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:01:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so11779386pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XhgXHLObV5Vbqo0Ol1dr/K9C6PfbnIr6P+CU31xn0uk=;
        b=JMDtt3o4OpRyNKqkIsA2AAl8veHAMN2+KlqcyzaxHwpNI6+UJ79YrJx/oC0KuKGwN4
         uLEguOKwpu/0TSXjxpVrV9ohcTpmW1vkIcHcIVFgf/wP1efqPouTguYWm4hBw/s9V3XE
         aw5GVUVx5BjtFgTryP1pejwqui5+CG9DuIUr2Ev5/THCjVKRvJBSeEgLJSQ/KuXmabKK
         8imeg+KY2S7LywceHrI7pk9u1toSQeENkXq3lHGZjPFcoLpEOYr1s0TZGtu8CjO/sgnV
         mzVHrj+TjeVEHvdU1/i3c4QDrjusE5znnwztyeYOiLl5Loaz8upXQeqBR5ZaH4KbdnXP
         iplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XhgXHLObV5Vbqo0Ol1dr/K9C6PfbnIr6P+CU31xn0uk=;
        b=tqfmwrO4s4chrHgB553UK0nuQ9kZkHeM4ecn7NhRrcVD0V5sfBPcszsElZTn7lMV4i
         7SIdPbi1Jov/0BVfviKMwFJitMYy+8apjzlkVLkmexb+/3ejL8XClzCMRbUAGYFy9Pd2
         lauR7WH3thtgfrzdSYPvj6y3YTRdHweK24xxApc4V7W69OgCQP2WKjRaz9jw7O8f32/5
         LJxROIvIJlXHDAogtHcHhOqpoGVxmyVsFWTmB3tqpYqaCNAdU5riXfl3mpWuYKQrSFJC
         osQT9GBSLud6JMywJ67sp4HBMFSGhnrtHBDvl5rFb95t03x3OjqfYlvCXCgRrvL+jzkc
         WIBQ==
X-Gm-Message-State: APjAAAVg2ThNkoVNpvlP/UcEkWtgdTEj61b83ikmgzhj9VEwnvSVIERY
        R3NlbhanCu3VIblWrT3YeWF95w==
X-Google-Smtp-Source: APXvYqxRBdu6ErpFV+5gKRxDXyTrGYM8duUS6m39Y3koDFw3q4yhtgHG0ERg3ih11MGWr8lRBc13xA==
X-Received: by 2002:a17:90a:2ec9:: with SMTP id h9mr43058272pjs.130.1559714469980;
        Tue, 04 Jun 2019 23:01:09 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q22sm2332383pff.63.2019.06.04.23.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 23:01:09 -0700 (PDT)
Date:   Tue, 4 Jun 2019 23:01:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] (Qualcomm) UFS device reset support
Message-ID: <20190605060154.GJ22737@tuxbook-pro>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org>
 <CANcMJZBmgWMZu7Y53Lnx_x3L2UpCmEbFRHVW0SFCXfW=Yw9uYg@mail.gmail.com>
 <SN6PR04MB4925530F216E86F6404FE14CFC160@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925530F216E86F6404FE14CFC160@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 22:50 PDT 2019, Avri Altman wrote:

> Hi,
> 
> > 
> > On Tue, Jun 4, 2019 at 12:22 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > This series exposes the ufs_reset line as a gpio, adds support for ufshcd to
> > > acquire and toggle this and then adds this to SDM845 MTP.
> > >
> > > Bjorn Andersson (3):
> > >   pinctrl: qcom: sdm845: Expose ufs_reset as gpio
> > >   scsi: ufs: Allow resetting the UFS device
> > >   arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
> > 
> > Adding similar change as in sdm845-mtp to the not yet upstream
> > blueline dts, I validated this allows my micron UFS pixel3 to boot.
> > 
> > Tested-by: John Stultz <john.stultz@linaro.org>
> Maybe ufs_hba_variant_ops would be the proper place to add this?
> 

Are you saying that these memories only need a reset when they are
paired with the Qualcomm host controller?

The way it's implemented it here is that the device-reset GPIO is
optional and only if you specify it we'll toggle the reset. So if your
board design has a UFS memory that requires a reset pulse during
initialization you specify this, regardless of which vendor your SoC
comes from.

Regards,
Bjorn
