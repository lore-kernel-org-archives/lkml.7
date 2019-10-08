Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D33C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB521835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Dfe+1jeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfJHTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:15:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36886 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfJHTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:15:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id e15so12048194qtr.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dxAtTWPQp4TAeXr8xO4IQ/pBkwmVo6wQB+eXQ6x/TLY=;
        b=Dfe+1jeovnFdBVweXsJvOp5BXdxpHw9080gV/0Umo0I2a24FNdmFyl1kiPo4ge+iFa
         XSOQDtE+tqvSG2aazcK/svPTXJbhuIQ1OJ4yekFUkLJCTRR1tySDi5nDjqHuM0NfHc9t
         9jgXyZjdo4nmS8oyHaNOZB7JqN19UiGyG5HPs6wy6+Va5I3J9EynqE3QjgjVSADyXVQG
         /hjCL+IcFA8R6EGs+CdTjpe6rumTcwilrCVAhumrpaLOlv+F/W6Sd4SVNdweiUEpPFCa
         4utVrLXKeyetZXfxbGmeV6XZ7j9PTyjs9yBvdWDJ+YiY7FaHy2jIErDoC9kKpsVo5lF8
         G9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dxAtTWPQp4TAeXr8xO4IQ/pBkwmVo6wQB+eXQ6x/TLY=;
        b=Z4WeiguNOSUvWhrkdJh9nFvwHFHdIp8EaRDJC7R/w9ZLMUwCtqHiMIiCrjrNUW8T5B
         nzsA76Ica8uk5EO6OMjJJ6DiB5yky3O6VvlC+f1eeOhAdWf7PElQJ+dnDDADAT8PYBnI
         blMHUBeBHivgKbyuNtsOX7pSnpxwjIPqITmAx+VfPCZuLj1n1Jq2IDXXloveqRMWCGn6
         lfTcWD2mtvJs1DsLTF1pz12348L2D1Fmg5kkDhVohPeb60f/0Ql4FNgVrs4Tz1oY07Id
         OyjXHUtWSb5vdfiN57nUQ2wV5QYZeIN3cKSOwdxW1S0KXzIhpQ+uIM/vTI/CLBzLQkUP
         HpYQ==
X-Gm-Message-State: APjAAAXT7oFo++MHizWDFPiBXNrhIblRi9sa5tcTRltuHASVs7DC89Ht
        C6Qett79un2nr0v7lW4whSWl5w==
X-Google-Smtp-Source: APXvYqzS0pTRdoYgQCvIqtrfKJbCdPzqZle2A/oqLtOkZCOi7IR/U1Hy7/FKxRoxWdHyuUsA3VINxw==
X-Received: by 2002:a0c:a988:: with SMTP id a8mr7939928qvb.34.1570562110549;
        Tue, 08 Oct 2019 12:15:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f21sm8763054qkl.51.2019.10.08.12.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:15:10 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:14:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] netdevsim: fix spelling mistake "forbidded" ->
 "forbid"
Message-ID: <20191008121457.34b570be@cakuba.netronome.com>
In-Reply-To: <alpine.LFD.2.21.1910080921350.25653@eddie.linux-mips.org>
References: <20191008081747.19431-1-colin.king@canonical.com>
        <alpine.LFD.2.21.1910080921350.25653@eddie.linux-mips.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 09:29:58 +0100 (BST), Maciej W. Rozycki wrote:
> On Tue, 8 Oct 2019, Colin King wrote:
> 
> > diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> > index a3d7d39f231a..ff6ced5487b6 100644
> > --- a/drivers/net/netdevsim/dev.c
> > +++ b/drivers/net/netdevsim/dev.c
> > @@ -486,7 +486,7 @@ static int nsim_dev_reload_down(struct devlink *devlink, bool netns_change,
> >  		/* For testing purposes, user set debugfs dont_allow_reload
> >  		 * value to true. So forbid it.
> >  		 */
> > -		NL_SET_ERR_MSG_MOD(extack, "User forbidded reload for testing purposes");
> > +		NL_SET_ERR_MSG_MOD(extack, "User forbid the reload for testing purposes");  
> 
>  If nitpicking about grammar, then FWIW I believe it should actually be:
> 
> 		NL_SET_ERR_MSG_MOD(extack, "User forbade the reload for testing purposes");
> 
> (and then:
> 
> 		NL_SET_ERR_MSG_MOD(extack, "User set up the reload to fail for testing purposes");
> 
> elsewhere).

So I consulted with someone vaguely British, and they said they'd use
"forbid" here, therefore I've applied the patch to net-next.
