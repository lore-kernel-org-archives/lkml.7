Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10152C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="TFX6C5Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfFMPRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:17:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35551 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbfFMNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:22:38 -0400
Received: by mail-yb1-f195.google.com with SMTP id v17so7821257ybm.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=heTVmTA1VC7+Lv8ssRiXzCfaW/u+s8AFPCxrnLoG20c=;
        b=TFX6C5Y4JreIdr5ZV52Pg4p+F418M647OuPDyzeXbDSVvH+R/5Zoee93Sla1Lbup67
         qYBcxQCxAoz75kNfrbjm0/gm+TxtkkLbeHpFdOfnEUJvqkn41wKMKN57rJ1abwxwd0W5
         14J9HQSzXRuEFr9RLx8R0j7X7OcO9bbPnoTysdrOpY5WFLIKh1UoypwO+7yFa3628eyS
         ra5v07Dnlg9G5UyLWIHo783FIGtJolo3QERz2/FXUBpleUnBA7dpPEW61OMWl45KlaBP
         3fZ4nxGd6/3E6pCI0rtaVh16owpZTDRzYE2kKtxOjBDQSnTgiUdIH6SXvhGgrcdoWB8K
         FOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=heTVmTA1VC7+Lv8ssRiXzCfaW/u+s8AFPCxrnLoG20c=;
        b=fdnYowD12VG+hN3LI8uRtAY+0ppbPysXj3FbAYaDGMYfVekQkPV0yIwKTaiIs99P2K
         pqi4Al31Z8oyIt8UhOSqqQhWwgvWC8UA5P9fs+n4DrRa4g8iaarSlw22oX7MzrBdy8Vm
         rwB51qQLVXaXyLVfigw93jOal8LQM+ocECG1J61cGfSuxrqWKsYSQ+0Y2MQMUwF1vEba
         AoKPFwaoh5axufJril+ZWCYgyEl4CtAoFh0WmrVmONkAYkMOxmhEd1EJVxKNsyuuq3MV
         J8ofLaIbUL+YMx7TMPRURmpyWYOXAQ8oKNinmGWK85iXMaQjRR6JpSOIFY7JPMyFLIXZ
         v19w==
X-Gm-Message-State: APjAAAVEWLZ1ejMKOa/eyOLGpZ/8ocbhgkGOpT/0PSL7neFuv5RCjnmx
        IQF/4ZX0Bza6p4yL5VYM8sCLAw==
X-Google-Smtp-Source: APXvYqyuV0U+ZNI/ZQHhffAIzXID47tvMONU2SVXHb7+Z4fbsGfcAyNC9oPmga8HohImAuiCY+oKtw==
X-Received: by 2002:a25:6089:: with SMTP id u131mr12942461ybb.14.1560432157816;
        Thu, 13 Jun 2019 06:22:37 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id f206sm759183ywf.77.2019.06.13.06.22.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:22:37 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:22:35 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kelvincao@outlook.com
Subject: Re: [PATCH 0/3] Redundant steps removal and bug fix of
 ntb_hw_switchtec
Message-ID: <20190613132234.GA1572@kudzu.us>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 03:09:41PM +0800, Kelvin Cao wrote:
> Hi, Everyone,
> 
> This patch series remove redundant steps and fix one bug of the 
> ntb_hw_switchtec module.
> 
> When a re-initialization is caused by a link event, the driver will
> re-setup the shared memory windows. But at that time, the shared memory
> is still valid, and it's unnecessary to free, reallocate and then
> initialize it again. Remove these redundant steps.
> 
> In case of NTB crosslink topology, the setting of shared memory window
> in the virtual partition doesn't reset on peer's reboot. So skip the
> re-setup of shared memory window for that case.
> 
> Switchtec does not support setting multiple MWs simultaneously. However,
> there's a race condition when a re-initialization is caused by a link 
> event, the driver will re-setup the shared memory window asynchronously
> and this races with the client setting up its memory windows on the 
> link up event. Fix this by ensure do the entire initialization in a work
> queue and signal the client once it's done. 
> 
> Regard,
> Kelvin
> 
> --
> 
> Changed since v1:
>   - It's a second resend of v1

Sorry for the delay.  The series is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon

> --
> 
> Joey Zhang (2):
>   ntb_hw_switchtec: Remove redundant steps of
>     switchtec_ntb_reinit_peer() function
>   ntb_hw_switchtec: Fix setup MW with failure bug
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
>     for crosslink case
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> -- 
> 2.7.4
> 
