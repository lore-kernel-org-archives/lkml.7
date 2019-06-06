Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4932C28D1B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3e+gR3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFFHRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:17:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41713 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:17:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so929463pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcWZk37MluweMWQW5kURRUWLOOrFjT2oPnVPPLPHyMo=;
        b=O3e+gR3QjxlY+TukOifhxUhwrU3NQR9N60NyUoUy2uHUzeQ5KzKmm22cgKDvq9AaJa
         HBGqpO0VEYMp0+DsxlKagVVxBG5mngX5vhbyuBCbFEc64bWcpGSZDbONnglt4HCdyMTT
         gAHr9JUL56oourAFBSHRUZ9hJubAKsm7DjmHYvMrHhbisgdNMH1KQPc6GjAxwEudVouO
         pIGF8m/RYSGkUtvnQN1fVj/L+5Vo8t7aUAykze+iK61/eKcNXTCaWI9ACCLz8IPMvXGu
         RYrFpq+7LQ5/u4AA76LNdgSRPpHxDsxfDMtgnN3FfsGb5M9viJKACY2o0B8cEH2hfUAa
         rbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcWZk37MluweMWQW5kURRUWLOOrFjT2oPnVPPLPHyMo=;
        b=NwiAnbGLBlOuhTwNUUJ4izX/p4kULQUUIyojaBTSYlSzorWmo+auclaGzM8Qo8gHyG
         dEi5F0fyBM4eu2pypsQkggylvJenoFFM1g9XRJC4nIift7IJAhcVHWEM+3g6ZxlrDdUT
         HKWSdEJurt+6svMTTh2QP69NsnACCPSOL8o4qiAnAUoc8iXGSYdFa3wXr0na9NKb32Xy
         uI/Esaj2MLcsnPzVVhxmUnoDWkXVCDQUvsWTZruOQ9JKvwSzfVRZu4RA/NF0hBrut3Rw
         PVrFMxG46Ktz+KrIlMNt3Kg8qiDkaiOtaN6f8dQzhFkui5iuQkrBsgxgos+Br1jBdlQr
         fYhA==
X-Gm-Message-State: APjAAAWY7UstHuyU1M6cvLq3oNVDNx4UYr2BfIKAJInXGSFmOe0eF7g7
        KEgLQXtv31iR9xo0mJY4VQrxhA==
X-Google-Smtp-Source: APXvYqwJj7EcN4AJ9SENmqHf4hWfVQH6OLhC5JBuOCIoK19YSarjdumJo7ny/lpvNb23GM0WxHXIZg==
X-Received: by 2002:a17:90a:3ae8:: with SMTP id b95mr13710133pjc.68.1559805462753;
        Thu, 06 Jun 2019 00:17:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm1058689pfd.120.2019.06.06.00.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 00:17:42 -0700 (PDT)
Date:   Thu, 6 Jun 2019 00:18:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] scsi: ufs: Allow resetting the UFS device
Message-ID: <20190606071828.GS22737@tuxbook-pro>
References: <20190606010249.3538-1-bjorn.andersson@linaro.org>
 <20190606010249.3538-3-bjorn.andersson@linaro.org>
 <SN6PR04MB4925FC3F1001326AA218DF21FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925FC3F1001326AA218DF21FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 23:36 PDT 2019, Avri Altman wrote:

> 
> >  static int ufshcd_hba_init(struct ufs_hba *hba)
> >  {
> >  	int err;
> > @@ -7425,9 +7460,15 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
> >  	if (err)
> >  		goto out_disable_vreg;
> > 
> > +	err = ufshcd_init_device_reset(hba);
> > +	if (err)
> > +		goto out_disable_variant;
> > +
> >  	hba->is_powered = true;
> >  	goto out;
> > 
> > +out_disable_variant:
> > +	ufshcd_vops_setup_regulators(hba, false);
> Is this necessary?
> ufshcd_vops_setup_regulators() was just called as part of ufshcd_variant_hba_init
> 

Yes, so my attempt here is to reverse the enablement of the vops
regulators (hence passing false). But looking at it again I see that we
should also do ufshcd_vops_exit(), so the right thing to call here is
ufshcd_variant_hba_exit().

PS. This initialization sequence should really be rewritten to first
acquire all resources and then turn them on. This mixes init/setup
sequence is really hard to reason about.

Regards,
Bjorn
