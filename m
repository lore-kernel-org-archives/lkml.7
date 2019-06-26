Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB4BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72E2205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gANyKfda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFZDsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:48:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42952 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfFZDoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:44:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id k13so483578pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqmJogVNFsB+g8IvvX5zj4pKPaA/7R5yFx4LbjFnmV4=;
        b=gANyKfdaTg5/MdqZmJB3zBjd0+SwlPrzaWPrUzkCwurzqStTwtxA6W7Ezglr0+ZcKG
         9eCN8IhNomZ3gmueFdxUDDnI92q7+xmSDkoV8Q+y2aKdt9v6JzX7ECWnNoAzZwjIEJY6
         uBgvejbkfXI6KyYweG9b+Xfav4RrlV8zWcSlcnvPRF8Pj94IOxhxpdKvhSYlLG0ifAx2
         ApzCOOyJU/iDqBIQahCwrH4FOpDF8+Bxa974TiDSoMeB0kn8UwDxZBcAZGjHFyrS9AqF
         6Ys8h1EtVT1tPJQIdhBKcTSORSoJ0pehqkmmrT90oehqg4SmFXClQL3EOSpLpGQt4pY4
         Vg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqmJogVNFsB+g8IvvX5zj4pKPaA/7R5yFx4LbjFnmV4=;
        b=ohuupSq1lW4AUdF3zRrWTzpmEMp6ImnjunMHZkFUEwUNfsYDBCyID6DQ1/+UfpG98j
         ECu1XLcOwIuCwPVbr+lKD/G9+Bsc+/hDhmLTznwuKidqfsWTxZq0q2p1AEFjl8MnGZPG
         9uFnpoCaMR+zXlHHt0rqI1uUvuAj0fghdhlVFwlHTfrnbocgctd3WdXweZIV60ySvEp9
         +OV/KOBkxt8UpE3L0SUu13Sz+fwcgOiy9uG3a60yS6k95ZER8P7XFuCAwkyibJ4ZU2al
         5oP+C41ul5RlYObjPaCN52TnA6BGi5t9nMoY2HMGUc57iI+50WmrtvGWbE5T7EahVxdm
         i0XQ==
X-Gm-Message-State: APjAAAUwVF+xcYlZ+u97jVSetSA1/0NM/gqmOGp5wVjX/YDDK4YOFWVQ
        KZU72Typ/JP4grBb9wnuT92x+A==
X-Google-Smtp-Source: APXvYqzB5kIs4zKVnHKkkES7b22zMAzjv6fDHE/nuMQDUGcdoG8vh5I/UyKxYvGsy8yxONWhs9EsNg==
X-Received: by 2002:a63:8a41:: with SMTP id y62mr607190pgd.38.1561520677526;
        Tue, 25 Jun 2019 20:44:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v9sm20038199pgj.69.2019.06.25.20.44.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 20:44:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 20:45:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] scsi: ufs: Introduce vops for resetting device
Message-ID: <20190626034529.GE24205@tuxbook-pro>
References: <20190608050450.12056-1-bjorn.andersson@linaro.org>
 <CGME20190608050458epcas1p30f03f6d448eb962a6af56a4c0b021ef0@epcas1p3.samsung.com>
 <20190608050450.12056-2-bjorn.andersson@linaro.org>
 <ad1c2a2a-91d6-25ce-9dfb-3b386b572ee2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1c2a2a-91d6-25ce-9dfb-3b386b572ee2@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 05:41 PDT 2019, Alim Akhtar wrote:

> Hi Bjorn,
> Are you planning to address Bean's comment on patch#2 and want to 
> re-spin this series?
> I am ok with taking this patch as it is and take a Softreset patch as a 
> separate patch.
> 

I still intend to attempt to implement a softreset "fallback", per
Bean's suggestion - just haven't found the time yet. But I would be
happy to see these patches merged in the meantime, as they do resolve
the issue of failing to being up the UFS link on a significant number of
Qualcomm devices.


I think it's best if you take patch 1 and 2 through your tree and we
take the dts patch through the Qualcomm/arm-soc tree.

Thanks,
Bjorn

> On 6/8/19 10:34 AM, Bjorn Andersson wrote:
> > Some UFS memory devices needs their reset line toggled in order to get
> > them into a good state for initialization. Provide a new vops to allow
> > the platform driver to implement this operation.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> feel free to add
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> > 
> > Changes since v2:
> > - New patch, to allow moving implementation to platform driver
> > 
> >   drivers/scsi/ufs/ufshcd.c | 6 ++++++
> >   drivers/scsi/ufs/ufshcd.h | 8 ++++++++
> >   2 files changed, 14 insertions(+)
> > 
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 04d3686511c8..ee895a625456 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -6191,6 +6191,9 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba)
> >   	int retries = MAX_HOST_RESET_RETRIES;
> >   
> >   	do {
> > +		/* Reset the attached device */
> > +		ufshcd_vops_device_reset(hba);
> > +
> >   		err = ufshcd_host_reset_and_restore(hba);
> >   	} while (err && --retries);
> >   
> > @@ -8322,6 +8325,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
> >   		goto exit_gating;
> >   	}
> >   
> > +	/* Reset the attached device */
> > +	ufshcd_vops_device_reset(hba);
> > +
> >   	/* Host controller enable */
> >   	err = ufshcd_hba_enable(hba);
> >   	if (err) {
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index 994d73d03207..cd8139052ed6 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -298,6 +298,7 @@ struct ufs_pwr_mode_info {
> >    * @resume: called during host controller PM callback
> >    * @dbg_register_dump: used to dump controller debug information
> >    * @phy_initialization: used to initialize phys
> > + * @device_reset: called to issue a reset pulse on the UFS device
> >    */
> >   struct ufs_hba_variant_ops {
> >   	const char *name;
> > @@ -326,6 +327,7 @@ struct ufs_hba_variant_ops {
> >   	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
> >   	void	(*dbg_register_dump)(struct ufs_hba *hba);
> >   	int	(*phy_initialization)(struct ufs_hba *);
> > +	void	(*device_reset)(struct ufs_hba *);
> >   };
> >   
> >   /* clock gating state  */
> > @@ -1045,6 +1047,12 @@ static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
> >   		hba->vops->dbg_register_dump(hba);
> >   }
> >   
> > +static inline void ufshcd_vops_device_reset(struct ufs_hba *hba)
> > +{
> > +	if (hba->vops && hba->vops->device_reset)
> > +		hba->vops->device_reset(hba);
> > +}
> > +
> >   extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
> >   
> >   /*
> > 
