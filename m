Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F244C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0634623407
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpBtAe0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHaDr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:47:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41148 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfHaDrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:47:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so4197939pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvj22pKsTnN55dr342mORvtOeCDZfEMR6FT1RYtpiQ4=;
        b=MpBtAe0awJ1+HulguMUZ+P7g0cX3vj4PqDf92ZYfTchSs71weYGGlctQPeHwLoYjz9
         Eo3czEO4PDKIgifu3aZpJrQnzAHHrXDqS4mkQyV+yXgL8paUGLF+6L2dkgdjZJi1BfnH
         mcZ5Lcf01VM0vcDeD3LTcWckqMMylSbJd6JXzmry6cYUp3lfe2UESZS1Zgiw2//4L6UD
         oq7U0NKs9YU3/QCOjysK+ASvi8ofh0ONSaXwGatz3slUaq8XGrj8ORFY8K6CzWhlA4r5
         1m8GT2N+d4rpfs7XlR9S31ylTTULpWWfANQN977BKysViQo14b9/O4JYJsOK9DyD/D3M
         QI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvj22pKsTnN55dr342mORvtOeCDZfEMR6FT1RYtpiQ4=;
        b=Q5DrzKWXbpjdOiQHUZgXkQugSJeX1ghyIrnVEQjitJdd9y+cTug79feWht0H2j7ccJ
         o4rPbB9AEa/2/zSbSCtJLTCXmTDzJs/8PNJfbRoQk735urIza/bTHB+0SE2Oeg685E4n
         4VEezQKvbLQ3TlTHqRBCpnLZkRYC3xRWqEO+Bq/xRm4arXULxhnse9wX7gz8InOYv7he
         89hmYdHtXJobuRGwmCPn3xF1BYNoWdMKjFWhZE3dKyXeTHH/1hS7F6J1sSGkgq8Q/ZBM
         i97oB39mHUNkygHxPbtzoXKO6cUVjELZw7HMrU5JJTRJH3pu/grLbiW65wQQRR2adRXV
         0Wxw==
X-Gm-Message-State: APjAAAXLCx7HyIU55eV3rAuD4QGlLkqECpsgR6lKZaziTyxMWVRgYjEZ
        r3irpy5LfJu1ZKIW8uKTu2S2iuB11xA=
X-Google-Smtp-Source: APXvYqyYh830X5nmk422I7s0sLXWmH4x90+uW/Fk2xfjbXPS32+k26ISBqqb7UcVro5gFB4U7tLNKA==
X-Received: by 2002:a17:902:d717:: with SMTP id w23mr19358805ply.321.1567223274931;
        Fri, 30 Aug 2019 20:47:54 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id s24sm6724794pgm.3.2019.08.30.20.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 20:47:54 -0700 (PDT)
From:   P Sai Prasanth <saip2823@gmail.com>
X-Google-Original-From: P Sai Prasanth <beowulf@dell-inspiron>
Date:   Sat, 31 Aug 2019 09:17:48 +0530
To:     Joe Perches <joe@perches.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Fix checkpath warning
Message-ID: <20190831034748.GB23177@dell-inspiron>
References: <20190831022515.GA4917@dell-inspiron>
 <3dc5ac616a3c2bfc48b8b3dfa1213532610b6431.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc5ac616a3c2bfc48b8b3dfa1213532610b6431.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-30 19:58:09, Joe Perches wrote:
> On Sat, 2019-08-31 at 07:55 +0530, P SAI PRASANTH wrote:
> > This patch fixes the following checkpath warning
> > in the file drivers/staging/rts5208/rtsx_transport.c:546
> > 
> > WARNING: line over 80 characters
> > +                               option = RTSX_SG_VALID | RTSX_SG_END |
> > RTSX_SG_TRANS_DATA;
> []
> > diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> []
> > @@ -540,11 +540,10 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
> >  
> >  			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
> >  				(unsigned int)addr, len);
> > -
> > +
> 
> This same line delete then insert the same blank line
> is very unusual.
> 
> What did you use to create this patch?
> 
> > +			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
> >  			if (j == (sg_cnt - 1))
> > -				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
> > -			else
> > -				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
> > +				option |= RTSX_SG_END;
> >  
> >  			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
> >  
>
I have used vim for creating this patch. Upon checking, there is an extra tab on
the new blankline which has been added. I'm sending an update immediately.
