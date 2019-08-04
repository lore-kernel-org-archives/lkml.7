Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000EEC41514
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2FF2087C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 02:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP3qwu4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfHDCiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 22:38:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33205 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfHDCiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 22:38:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so35031360plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2kGdFHGIeclWVr2UklHiFu8m0yV1tr6Ja1uSrC9yrU=;
        b=tP3qwu4p8GBWE8MXvyloMEeMxNcfG9oqiL/iohCbp15o7RI7C6M3uxeOcDRICZqIMl
         D6xpXXir3LaQxGqAReCLckgjEbmPhIKBCGmsKGgmOppzCeBu04+zmWaVEBTpt5biT++o
         tNxAS+vC76t+2kCphwNFHOAKjqcQ4sk32yvAU91Yjrc94wj3395xmxr6+Z2fmCutonM+
         Wx3JuG9PRGI7szP0m14/jfDrx33N3ZpoJAG7GiKwEftlEC3SIvcJUEqHhLT1o5nOMcnX
         r+93WWtX7Yix0ZdwLUb0emMD7lRnJzJHHF6A2mFYaGZtDo+yRCHbkmb+xV+Zswg74eLr
         EtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2kGdFHGIeclWVr2UklHiFu8m0yV1tr6Ja1uSrC9yrU=;
        b=ROPx383loFOto/K2lm04Ld89geGXUz4cnS8Yi9OvfeWopOy4DisqIZ1sebIUKgwBFE
         7f5Oj1xGj+gviaZWidG3B23RqeqNIOsA/iP2kcO8jrY/NxKXzuHSSP3buiBDBAYun9OY
         tGoJy9YnLCgFcBjPbFw12zfcx/JiLxoLhCsdUKsAifQL4fxn11NGrBxqFCyJ+de2QWXB
         A2ZHVYE33IVZuTeM4dJ9apmtUdET1Rt3M1gqFaQht5Ik5IUDFlU7kXoV0CWdLe0/PiDM
         pJl3Lt9dzk86qH0oilTivrlhklHyvx0kgsLuebTMXKD8JUMLr+BHOmmF2Rr/heo7Kvmm
         xfJw==
X-Gm-Message-State: APjAAAVBQJ3DRRtGr81UXE1+EUksbKTprVNi0fr7KjLTKJvmarIFe/j4
        +l5rMM36OEgdz60d8lFfbIk=
X-Google-Smtp-Source: APXvYqwCmMuA2B2qY1a0yJbpRj+pAgCYX255arn2ubObJ8hMFVpZIo3GL/aqyY/V2WN9a5lAVmtjqw==
X-Received: by 2002:a17:902:86:: with SMTP id a6mr51950683pla.244.1564886330246;
        Sat, 03 Aug 2019 19:38:50 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id v13sm92909934pfe.105.2019.08.03.19.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 19:38:49 -0700 (PDT)
Date:   Sun, 4 Aug 2019 08:08:44 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Michiel Schuurmans <michielschuurmans@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Make use kmemdup
Message-ID: <20190804023844.GA14043@hari-Inspiron-1545>
References: <20190803174038.GA10454@hari-Inspiron-1545>
 <774ade692f5e64ab1f4fc7b35b9eeae69e11cf71.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774ade692f5e64ab1f4fc7b35b9eeae69e11cf71.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 10:52:04AM -0700, Joe Perches wrote:
> On Sat, 2019-08-03 at 23:10 +0530, Hariprasad Kelam wrote:
> > As kmemdup API does kmalloc + memcpy . We can make use of it instead of
> > calling kmalloc and memcpy independetly.
> []
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> []
> > @@ -1382,10 +1382,8 @@ rtllib_association_req(struct rtllib_network *beacon,
> >  	ieee->assocreq_ies = NULL;
> >  	ies = &(hdr->info_element[0].id);
> >  	ieee->assocreq_ies_len = (skb->data + skb->len) - ies;
> > -	ieee->assocreq_ies = kmalloc(ieee->assocreq_ies_len, GFP_ATOMIC);
> > -	if (ieee->assocreq_ies)
> > -		memcpy(ieee->assocreq_ies, ies, ieee->assocreq_ies_len);
> > -	else {
> > +	ieee->assocreq_ies = kmemdup(ies, ieee->assocreq_ies_len, GFP_ATOMIC);
> > +	if (!ieee->assocreq_ies) {
> >  		netdev_info(ieee->dev,
> >  			    "%s()Warning: can't alloc memory for assocreq_ies\n",
> >  			    __func__);
> > @@ -2259,12 +2257,10 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
> >  			ieee->assocresp_ies = NULL;
> >  			ies = &(assoc_resp->info_element[0].id);
> >  			ieee->assocresp_ies_len = (skb->data + skb->len) - ies;
> > -			ieee->assocresp_ies = kmalloc(ieee->assocresp_ies_len,
> > +			ieee->assocresp_ies = kmemdup(ies,
> > +						      ieee->assocresp_ies_len,
> >  						      GFP_ATOMIC);
> > -			if (ieee->assocresp_ies)
> > -				memcpy(ieee->assocresp_ies, ies,
> > -				       ieee->assocresp_ies_len);
> > -			else {
> > +			if (!ieee->assocresp_ies) {
> >  				netdev_info(ieee->dev,
> >  					    "%s()Warning: can't alloc memory for assocresp_ies\n",
> >  					    __func__);
> 
> Could also remove the netdev_info() uses for allocation failures.
> These are redundant as a dump_stack() is already done when OOM.
> 
Sure will do.

Thanks,
Hariprasad k
