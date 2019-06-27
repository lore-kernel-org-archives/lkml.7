Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F20C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYhogf0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF0SFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:05:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41027 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF0SFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:05:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so1611368pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ZFHIM+9ACuJTE5JeAEtpKhLckRWZf8AG+zsqIufowA=;
        b=FYhogf0z45V2UHOffa575V4s88hm4x6/QA3IBteH61ORTHx68RMuHYhejlt2KqpXLw
         iszYSJgjoc+J8MNYjUEC5YGeoxp+o4jGUR1m8gIaCM8lK6KSPkceOLezFofUr0v66dIt
         dkQcE9FNnWDNOMyGGNFgwibVXu67jc5S4KQ1XKoOQ3Xjt5VMGhSr7V0L7K6BM609NEBy
         t9F+YJ5isjwswLuThvLZb8FS0LWIHU2LbdO701hCkji6tll5R8bcD+tSf0CoVu+yRvFg
         kTFCVCfoHb1Irfyt6oCb0wvnqKoDLv4uUOsihyli2xOk6RFf6C94ABFMciaXBJ8u5xmL
         q1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ZFHIM+9ACuJTE5JeAEtpKhLckRWZf8AG+zsqIufowA=;
        b=iz4rYmHyP04cvUDibK9kelrTiEME1jJZ17TtWh3Ahs0df/HPxGGEct6H72PIOoKu0+
         qmtp5egsZ28ArZ86n3xSGwE6SE0BWMqCq1G+4MO/ICZ0rim/Hd6ARqcxuYnvzyq2AM2z
         3lPT/TkgHWj5aWQJTVpUumpE1cPitHc8vUA7vyHKdrOQJxU5FuvK8I0u0T3X05G601Pq
         YqLe0vmdCXL7mI/cLantm1eiFY9Cn5njvLDUp2S0yqq1VvzQF6Y+MUO86+VTEjq9+44l
         OfNtk6PFPbuT96E+gMdwl8sg6BZLxe/1FEUGYXtzhStJlJtNzixBsmVs7cSHUklA4YxC
         1bVQ==
X-Gm-Message-State: APjAAAWdaj+GBJhYPxpAEL1VDSYyepfwNTv2mgibTgwRIzx0UBKdqsla
        Cseh87lAuIEwBR7OkUPafs4=
X-Google-Smtp-Source: APXvYqzox8DkrIK20YIRK4bK4hjXsHcTPAOhqjwZBqOsQJGVAhHLTvpzy953y39BuSm2jry+rlP2HA==
X-Received: by 2002:a17:90a:2666:: with SMTP id l93mr7511494pje.16.1561658750919;
        Thu, 27 Jun 2019 11:05:50 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id br18sm5836565pjb.20.2019.06.27.11.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:05:50 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:35:46 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: sdio_halinit: Remove set but
 unused varilable pHalData
Message-ID: <20190627180546.GA3240@hari-Inspiron-1545>
References: <20190626174459.GA8539@hari-Inspiron-1545>
 <20190627063835.GH28859@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627063835.GH28859@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:38:35AM +0300, Dan Carpenter wrote:
> On Wed, Jun 26, 2019 at 11:14:59PM +0530, Hariprasad Kelam wrote:
> > @@ -1433,7 +1430,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
> >  #endif
> >  #endif
> >  
> > -	pHalData = GET_HAL_DATA(padapter);
> >  
> >  	switch (variable) {
> 
> We need to delete one of those blank lines or it introduces a new
> checkpatch warning.
>
Yes thanks for correcting this .  Will resend the patch.

Thanks,
Hariprasad k

> regards,
> dan carpenter
> 
