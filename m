Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C825EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6532F2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="hF8OvYHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfC3LH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:07:56 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:31035 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfC3LHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:07:55 -0400
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 8F1FD202ED;
        Sat, 30 Mar 2019 12:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1553944072; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=odAd3TITKxt7qPJm1jEO3r6stnrT/w5T/88ChibgdeY=;
        b=hF8OvYHOreNt6KEWe8hQyjCgBRXGSLgneR/b7ccy+o8Rk49FvTXBL7Vsa28RbfBWhGWelF
        q7IdpUFhopkMuqFItudV2Ec9hgwByDhjpEKUVgWtv/R3l4mmGLPCs9DdiC4ezE0mD+AG8C
        125JjWm5QUcccmOLfDG23RkTVFCcimhFLsuGclRYkAL+UY7XMEUsx0vKesBxnaT32rSIIs
        KVAY7ty6YGwFuKvUzRsQZPHPwamHnPY3OV/wXuRvwQfw3a8f7ohrijWyKHlJOszBxxiWiL
        l6EgTcWkc7cAi6j77dNa0GI6ZV8rTFpjArieylZmHuhKWDV45T2lIEieaL8Dkw==
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id BBC047F4AA;
        Sat, 30 Mar 2019 12:07:51 +0100 (CET)
Date:   Sat, 30 Mar 2019 12:07:51 +0100 (CET)
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <822122908.274859.1553944071609@ox-groupware.bfs.de>
Subject:    Re: [PATCH 1/2] scsi: pm8001: clean up structurally dead code
 when PM8001_USE_MSIX is defined
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev44
X-Originating-Client: com.openexchange.ox.gui.dhtml
Authentication-Results: mx01-sz.bfs.de
X-Spamd-Result: default: False [-2.10 / 7.00];
         ARC_NA(0.00)[];
         FAKE_REPLY(1.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         HAS_X_PRIO_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.920,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.03.2019 00:44, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> When macro PM8001_USE_MSIX is defined there is redundant dead code
> call to pm8001_cr32.  Clean this up for the defined PM8001_USE_MSIX and
> undefined PM8001_USE_MSIX cases.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 7 ++++---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c
> b/drivers/scsi/pm8001/pm8001_hwi.c
> index e4209091c1da..434498a78946 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4625,15 +4625,16 @@ static int pm8001_chip_phy_ctl_req(struct
> pm8001_hba_info *pm8001_ha,
>  
>  static u32 pm8001_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
>  {
> -	u32 value;
>  #ifdef PM8001_USE_MSIX
>  	return 1;
> -#endif
> +#else
> +	u32 value;
> +
>  	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>  	if (value)
>  		return 1;
>  	return 0;
> -
> +#endif
>  }
>  
>  /**
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c
> b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 536d2b4384f8..4a176e60307f 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4619,15 +4619,16 @@ static int pm80xx_chip_phy_ctl_req(struct
> pm8001_hba_info *pm8001_ha,
>  
>  static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
>  {
> -	u32 value;
>  #ifdef PM8001_USE_MSIX
>  	return 1;
> -#endif
> +#else
> +	u32 value;
> +
>  	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>  	if (value)
>  		return 1;
>  	return 0;
> -
> +#endif
>  }
>  
>  /**

the ifdef jungle does not make thinks more readable. I am aware that
using neg is also not good but in this special case it seems helpful
to have only one branch, like:

static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
{
#ifndef PM8001_USE_MSIX
 	u32 value;
 
  	value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
  	if (!value)
  		return 0;
#endif
  	return 1;

  }

just my 2 cents,

re,
 wh
