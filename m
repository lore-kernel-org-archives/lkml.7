Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C690C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D166D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567014493;
	bh=8GZQLEfu4KdTxRtz2C1/HIab9yozYv4ALIIMVqjcjQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxMl8RqxvhaW4TnNMgYR801qvl/DeIBJCuzKS02wzaA2FkQrLCEsZo+rvWsU8EnYv
	 6tfdTdtfoLndyWiJRzg7U2WJzM3djhcSSWfqOnmZeoZHk40ySZrywsw1HYmK74mAKk
	 oCLk13++PkRtZq/eQyL8z80T4prT1UBcXmx3eAN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfH1RsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:48:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfH1RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:48:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so687801wro.5;
        Wed, 28 Aug 2019 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvZagx7jvNM6KY8AxfC5tlWqGThqPd8JeCEOU1rlNEY=;
        b=OvefXXdF67oN1ve7spB9g8oHbJcSYfACOpG8lblvcpBe7Lh7kdShyRKdzgsL910ePa
         B5Fr92MPfmSf7dl7UHZDNopidSabiq3zZqM3KSWTcxI0BWcljpiZMqmk4PFSfDMHv1rH
         k6zhx1/jTDVPj9TFLo/ZVyDtpJNH3iRqzQPjv6rCcTgJ6wAeGyNOrlYQ45lyunFZW83l
         4kwAVMCReFGM3kGeoJp+yqlbV90ALRb/t6Ask5GaT+bo2KbW5/V3vVYJTkAdrdp4iVND
         GeSQ0LmWWctlFVsTCxgPv+rlE8tIpnaqhTa2k71QmauiXGvKzVojz/+Cawu1Byj8TEFc
         xolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvZagx7jvNM6KY8AxfC5tlWqGThqPd8JeCEOU1rlNEY=;
        b=bjtTaHK2YrHhg/mS+I05DJWlfsLPQtSei1CBMOTLpVo2iPypgvzgEXhNalLWP2x0Gk
         9zCr20uiUTLOKiNElrP9VFuaexLf0+GJ4OFwt30RgQaNce2TZsNHmEVJSMe2TcMPY7lF
         JsrD4EeS4vJ1lavShiUF0MsUqB/qjgX3mj20Q/V7mX7YggLSyzTWjewV/knd98YQscEZ
         kxW54HXGcmT5hqu/zxQThwyjzFO95j6JDTFV9KOXKNtUVmFWO7k18nrS+53UQA3hDFS7
         Wcu/ZnKbIN62jHxUUJJ4nMc3ygkaF1jlIhm83DGlrKdKPbsovhgEcOIOoNNLt7wAdsxp
         HZBA==
X-Gm-Message-State: APjAAAWdaKA4BMWMLQbv9QKr6EVB02tzfX0YX/iWnwmfeATJqhRXXnlT
        fk8yKg6S2huExIO/24C9y5I=
X-Google-Smtp-Source: APXvYqzsgycsBiPbj0M7dIus4k509ElpquCfjEnXq1G43Yk0i2y0vAowaLgwLoA9RbGXk8TpueNRRg==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr5964621wrq.276.1567014488447;
        Wed, 28 Aug 2019 10:48:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w7sm4298079wrn.11.2019.08.28.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:48:07 -0700 (PDT)
Date:   Wed, 28 Aug 2019 19:48:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [GIT PULL rcu/next] Supplementary RCU commits for 5.4
Message-ID: <20190828174805.GA77166@gmail.com>
References: <20190828172557.GA30541@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828172557.GA30541@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo,
> 
> This pull request contains the following changes:
> 
> 1.	A one-line change that affects only Tiny RCU that is needed
> 	by the RISC-V guys, courtesy of Christoph Hellwig.
> 
> 2.	An update to my email address.	The old one still works, at
> 	least most of the time.
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 049b405029c00f3fd9e4ffa269bdd29b429c4672:
> 
>   MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org (2019-08-26 16:27:08 -0700)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       rcu: Don't include <linux/ktime.h> in rcutiny.h
> 
> Paul E. McKenney (1):
>       MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org
> 
>  MAINTAINERS             | 14 +++++++-------
>  include/linux/rcutiny.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Pulled, thanks a lot Paul!

	Ingo
