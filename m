Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5802C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BE220657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+F8Cins"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbfHAXDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:03:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43064 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbfHAXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:03:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so51500792lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKJQ3o/xe4euaxMLqg6sEdazdDGbb6vYhhjnqdoAQ6w=;
        b=G+F8CinstN1tstBZ1Wc+MIGYTqiQBsRyv3dT3cNguh93vm1NWq2BW71NQXGC3MOTD1
         ct7aR/9p8SQQAfDwJEwXOyhUHx5WmunPZSfIekIJgIoIOn40YrCmanxP5xybl8o6qEDT
         1JOUu3niSbmYw4vfeVKhwCRK9b7Mq7HvNkuxBJGsE/3hz5Osa2sjl+HlVC18BnAzWcKz
         fSlXu9ZafmfYd+ggMsz4i7kvEys14QS3xuKi6nsbFfhfcBifYi6PnHQIehfn0AjLb0L+
         gYCntQC1ar6c2QebIikoAHRDh1oCnNbMvo+sgZDbR0eXGAPcinwmJHp2DpBYLBkdwkQS
         ohJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKJQ3o/xe4euaxMLqg6sEdazdDGbb6vYhhjnqdoAQ6w=;
        b=GWcWvO+Fl2ziAwnfQHqaSoA084ETSeJfBb0Lx4H9Y8p2yGWf3oRClNZaH8VcEdrBpr
         6NtEdSTW8hJfFdXviVJ3zZV7vpdN+Nl/RO131YdQb3Y94yMDa0dKz1UNrRY53lqmrtDf
         JvoIpg2Pe5ai7jCqQcEjcK5A9zuzFMWfgCXj77r7YgkAgMhHBVfIMbThsBQCjLp5KLBK
         223axlVoCRVlPDCYXrAdc8PBHDbg0SYbPcaLGbvlEVZwoRFBmgeLbeyahQPDzB7pQNul
         Xkt126teiH2Fhi4E9vz7X8WxgbOeBBt5J0cUDvFlzzB0iUcQWew4448AA896pf20lQ5b
         Ta0Q==
X-Gm-Message-State: APjAAAU6ZN3JFoE3L5MBRUIAYrCLlWlVuYQckXEbeY+OA3P8wEtZp4hh
        1H+qeqtnBgIzSx3G9dy2zL0=
X-Google-Smtp-Source: APXvYqx08xbPIu+Oy958A2gHc7LgO/pq+nGDUyrjMSKMCau3vM8Pe1eeoYX3I+Fz99hckKnfUiTMJA==
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr52325109lfp.61.1564700609078;
        Thu, 01 Aug 2019 16:03:29 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id i23sm14814962ljb.7.2019.08.01.16.03.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:03:28 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 2 Aug 2019 01:03:20 +0200
To:     Joe Perches <joe@perches.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        akpm@linux-foundation.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org,
        "yamada.masahiro@socionext.comhange-folder>?" 
        <toggle-mailboxes@rikard>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190801230320.GA3711@rikard>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:27:38PM -0700, Joe Perches wrote:
> On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > as the first argument and the low bit as the second argument. Mixing
> > them will return a mask with zero bits set.
> 
> A few things:
> 
> o Reading the final code is a bit confusing.
>   Perhaps add a comment description saying it's not checked
>   in asm .h uses.

Comment added.
 
> o Maybe use:
>   #define GENMASK_INPUT_CHECK(h, l) UL(0)

Sure.
 
> o The compiler error message when the arguments are in the
>   wrong order isn't obvious.  Is there some way to improve
>   the compiler error output, maybe by using BUILD_BUG_ON_MSG
>   or some other mechanism?

Not that I could find. BUILD_BUG_ON_MSG can not be used if the macros
should be usable in e.g. a structure initializer (this seems to be the
whole reason BUILD_BUG_ON_ZERO exists).
