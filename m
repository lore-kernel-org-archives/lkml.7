Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FBC28D1B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BEB2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVgCr6vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFFHJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:09:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:09:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so820739pgr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puIXzR2Own0cbDgtZ/rESXOOL8scU6F9mL+QrFjp0g8=;
        b=cVgCr6vnkGfjbhGXEObW1I3eyaTZzs4e6YbdY6IpyHvoRC/cyQjHSlt0gxIth7Hdeu
         eN5d1Xq7g1lwpP9OqdHss8u059osQZKuNhLLZQDMfVeXEnwdfWXX/9x5wMPNmTf8vdMp
         edojQQ/rLLAz+Ma+B+VExLG44vHl79i9L+21ZSA3+/M+XhdLiyrhJh7bfmceA5yyn+O5
         F5U1b3PO/PE12bohPtUqnSdgMu8VX6VQP1ZbADi89a+bsmYX1ZeVg1c7YZy4XHTXQyR+
         K85N7Y+nqqCSKG8JWtn16z8k9ZHBXM5Z3X6Q26+9a4Pz7Z+zIOWyj13pD8cU9hReymQe
         EVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puIXzR2Own0cbDgtZ/rESXOOL8scU6F9mL+QrFjp0g8=;
        b=KP8/rYX7yu3TOWbUQlLbPOydExiSKS4udInbELtvwpGR5VOuwFVOIiYP5L7+OMxqAx
         nkM9YINImBAAZ2lgX1MbBL+LwKlYNs0GK9OoYgyChygWsVtCZ4m/NbRkA0Pp/PclRPwh
         wLYezN95yycLzDPWf1G+H0v8FtP/uKzfY5AmjL9IAu9LqulLaDE1iYCOKUQL/J4D9MQ6
         8naZ/rxK7FvEPm9O3kWuWCu7R1j1DF+eZPM7RSq054mMf1aV7KMIgYFiYgtke0y7Lw9H
         48+URPEAZsupPagMXgU1pq+fRqX682gkaIzzVe4AbHdNCTatJE+G++V+x5xqU56+h1Hp
         SPFw==
X-Gm-Message-State: APjAAAWHwuvRDSh/KUPvJuvnjcinpFQeVKW70YsVbJZ8qNMirOc3oqyJ
        /pgimpQeqj8nlsMDI5PMb4UX8Q==
X-Google-Smtp-Source: APXvYqx349qBmplwQGOq+Bk/EBJps0gB+WxTpibAF0E4c9G3e41oIpAGmhaSWsAhZzds2x83VVRXrg==
X-Received: by 2002:a62:63c6:: with SMTP id x189mr39479895pfb.31.1559804950625;
        Thu, 06 Jun 2019 00:09:10 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x128sm1376557pfd.186.2019.06.06.00.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 00:09:10 -0700 (PDT)
Date:   Thu, 6 Jun 2019 00:09:55 -0700
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
Message-ID: <20190606070955.GR22737@tuxbook-pro>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org>
 <CANcMJZBmgWMZu7Y53Lnx_x3L2UpCmEbFRHVW0SFCXfW=Yw9uYg@mail.gmail.com>
 <SN6PR04MB4925530F216E86F6404FE14CFC160@SN6PR04MB4925.namprd04.prod.outlook.com>
 <20190605060154.GJ22737@tuxbook-pro>
 <SN6PR04MB492521B7D2DB6F3462EDB7D9FC160@SN6PR04MB4925.namprd04.prod.outlook.com>
 <20190606003959.GM4814@minitux>
 <SN6PR04MB49255AF3D92E655E1BBD75AEFC170@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB49255AF3D92E655E1BBD75AEFC170@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 23:32 PDT 2019, Avri Altman wrote:

> > 
> > On Wed 05 Jun 02:32 PDT 2019, Avri Altman wrote:
> > 
> > > >
> > > > On Tue 04 Jun 22:50 PDT 2019, Avri Altman wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > >
> > > > > > On Tue, Jun 4, 2019 at 12:22 AM Bjorn Andersson
> > > > > > <bjorn.andersson@linaro.org> wrote:
> > > > > > >
> > > > > > > This series exposes the ufs_reset line as a gpio, adds support for ufshcd
> > to
> > > > > > > acquire and toggle this and then adds this to SDM845 MTP.
> > > > > > >
> > > > > > > Bjorn Andersson (3):
> > > > > > >   pinctrl: qcom: sdm845: Expose ufs_reset as gpio
> > > > > > >   scsi: ufs: Allow resetting the UFS device
> > > > > > >   arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
> > > > > >
> > > > > > Adding similar change as in sdm845-mtp to the not yet upstream
> > > > > > blueline dts, I validated this allows my micron UFS pixel3 to boot.
> > > > > >
> > > > > > Tested-by: John Stultz <john.stultz@linaro.org>
> > > > > Maybe ufs_hba_variant_ops would be the proper place to add this?
> > > > >
> > > >
> > > > Are you saying that these memories only need a reset when they are
> > > > paired with the Qualcomm host controller?
> > > ufs_hba_variant_ops is for vendors to implement their own vops,
> > > and as you can see, many of them do.
> > > Adding hw_reset to that template seems like the proper way
> > > to do what you are doing.
> > >
> > 
> > Right, but the vops is operations related to the UFS controller, this
> > property relates to the memory connected.
> This is not entirely accurate. Those are vendor/board specific,
> As the original commit log indicates:
> " vendor/board specific and hence determined with
>  the help of compatible property in device tree."
> 
> I would rather have this new vop:
> void    (*device_reset)(struct ufs_hba *), Or whatever, 
> actively set in ufs_hba_variant_ops, rather than ufshcd_init_device_reset
> failing as part of the default init flow.
> 

But such an vops would allow me to provide a Qualcomm-specific way of
toggling the GPIO that is connected to the UFS_RESET pin on the
Hynix/Micron memory.

But acquiring and toggling GPIOs is not a Qualcomm thing, it's a
completely generic thing, and as it's not a chip-internal line it is a
GPIO and not a reset - regardless of SoC vendor.
Further more, it's optional so boards that does not have this pin
connected will just omit the property in their hardware description
(DeviceTree).


So I think the halting part here is that we don't have a representation
of the memory device's resources, because this is really a matter of
toggling the reset pin on the memory device.

Regards,
Bjorn
