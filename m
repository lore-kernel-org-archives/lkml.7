Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB8C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92471214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GWjOg7hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfI0EI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 00:08:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38247 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfI0EIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:08:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so1075735ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfnW1geNlZntFzHhhafondPp7xi7VUdjL4d8br8k48s=;
        b=GWjOg7hAWeNKEAqI14L4QbbKnwL23NwjZMENto5mq3AH4u9lQk53TtFLJzFWCA6lhy
         AIVyF8U7Euw+hssY2cxq3vjTKHD/P5o3cSCvKiQ2GEZA19LynPWy3hJxnwMtBdh9pSNU
         NIOGzSw9tC/L9i9LVUjQ3VAkZ4zfDzpwUR9gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfnW1geNlZntFzHhhafondPp7xi7VUdjL4d8br8k48s=;
        b=kEVYWo+Zj38yEZ/PlbkinO22oibnUMQyXMnRxqFEXVummjQ0EyWiWBXkRT2F2vuj5/
         N8Gd7gFZwePdfr01WL0Fd/XTY8kNaIafo9Maz/SomCrT23y1Ic6GKTxfvp32E0Qi8I09
         uClcg2QR7pTDGrhXjntIH+em5K1liJXDK3bn/E+Q/EmhFBw9bgAbKTX+67kcIb3Nhabp
         LtiSOqkpZkRhRXcI5bCOHH7euSNkwcZJhYvWpnpFJZglmd5oBA6VviGVV7/r+U82zQGu
         mA6Cma5VZ1t3d6q/S684azrHYGrmNP7/y+VseSOu9DjpHXqCgsm9VVMHwwJLOgAF7jzW
         mTLg==
X-Gm-Message-State: APjAAAVJa85dlG1b7ZBbjr/ww8A0ROQJgcfFKX49MAUHh331FnAsIccm
        yh8cTHWdmIfib50aYIEx4v298xIz1VtAmJMWVlv1Eg==
X-Google-Smtp-Source: APXvYqw2OZIWvwETjzZONXYbNe8XgY+q4gvrEEHI2CyGftmc8pvC4duna15uvkZ0kuBNSgYeV7OiCarPseITa4yAKtE=
X-Received: by 2002:a2e:3201:: with SMTP id y1mr1258100ljy.5.1569557303271;
 Thu, 26 Sep 2019 21:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1547100464-7020-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <3d5497d8-7275-1461-8b59-b3695838be45@broadcom.com>
In-Reply-To: <3d5497d8-7275-1461-8b59-b3695838be45@broadcom.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Fri, 27 Sep 2019 09:38:12 +0530
Message-ID: <CAHO=5PE_Y2sx1pVnG79_JD_AFU8Vtu+e6PfCnBZDVLAcms64ug@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: bcm-sba-raid: Handle mbox_request_channel failure
To:     Vinod Koul <vinod.koul@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Did you get chance to review this fix?

Best regards,
Rayagonda


On Thu, Jan 10, 2019 at 11:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 1/9/2019 10:07 PM, Rayagonda Kokatanur wrote:
> > Fix kernel NULL pointer dereference error when mbox_request_channel()
> > fails to allocate channel.
> >
> > Fixes: 4e9f8187aecb ("dmaengine: bcm-sba-raid: Use only single mailbox channel")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/dma/bcm-sba-raid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
> > index 72878ac5c78d..77ae74663a45 100644
> > --- a/drivers/dma/bcm-sba-raid.c
> > +++ b/drivers/dma/bcm-sba-raid.c
> > @@ -1690,7 +1690,7 @@ static int sba_probe(struct platform_device *pdev)
> >       sba->mchan = mbox_request_channel(&sba->client, 0);
> >       if (IS_ERR(sba->mchan)) {
> >               ret = PTR_ERR(sba->mchan);
> > -             goto fail_free_mchan;
> > +             goto fail_exit;
> >       }
> >
> >       /* Find-out underlying mailbox device */
> > @@ -1747,6 +1747,7 @@ static int sba_probe(struct platform_device *pdev)
> >       sba_freeup_channel_resources(sba);
> >  fail_free_mchan:
> >       mbox_free_channel(sba->mchan);
> > +fail_exit:
> >       return ret;
> >  }
> >
> >
>
> Looks good to me.
>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
