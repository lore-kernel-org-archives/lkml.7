Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EBC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0720651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562768546;
	bh=k0ia/e5jDRvV6wjqKN65EnAw5fE1MKrTQhaHYiyHJDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uJY6hZvL0oeTsIyM66Dla/Diq+Vea1fUICX6mwUvFgFK1JwOk3MLJ7yoD11bfL4Tv
	 rU0IuP5FjGkxcj6zwL2KTMEWXZ3Exh5ZsbDKKKkpZyuc1tJmAub5ypYp+sB6T0/e88
	 WEKCYp5YHdeO0sFxNDH4VcokoSevTBmBBh8rRCRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGJOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:22:25 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:41764 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:22:24 -0400
Received: by mail-qk1-f171.google.com with SMTP id v22so1992945qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppjQH7UnKSNQZiUbygkROUvFgkXUyrf6BJVSCRoD7mo=;
        b=SgcOUEhU3ozGdXF2/sEbHBTindyV5H9yn5U3KQ8IsbT/CcVNeb4FlmmeF80ImehMCy
         iCWrpwPNEdBf5Xo4Z9CX+7l6USQgVuXN/JyWDnER0bITcZEKp+jyE9/wSl58JqOp/HXV
         LK34xwqzEwN99PfMFxXd8JSKb663MlOzp6+Q6QslI+sSsAu6b8aNmcbD7EQOHWdsnMhT
         hAxl/PFZfA4ZboPeLWPU8mVFdJaEXjK1nNZxTxy0fWSWYLk0bqPt2472hMYwSLdFLZVH
         vCcZksmhXRAMo0ddCRYvkUn2jlYD0LOiNIJf23980CgsnQqogYMMQh9zG8f4xybTBElf
         PC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppjQH7UnKSNQZiUbygkROUvFgkXUyrf6BJVSCRoD7mo=;
        b=Rdz+2VHx+q8RM2Suyoak/5v4N74cm5IvtIzmrSMLaOx86M9UC8zUiqev8HSoLmtrQf
         aKm1PHY83yoILMXjSCzeNzukPE0T4ODsbsWNlSwkwMF+00OwsJNkjFCEaxj/o13D3D1P
         ucVd3GMstcR01Ot2A019wJxSEG3F4I3/Mc/9hAvBlTXLd5xDY2GNYY1WfltO1AEUOO7S
         fHm10704J3J94AZqhVCfbNaquljaApC1eMurqM77K8PHl5i4PDxei5tlRuVrYgBTAxZB
         81Z7JY+scgE7HXHZYEW7zNqKcmwR53UcvrtvTScD4HgRxwR9XP9seBTWa6IJOzG1iEIl
         Y/IA==
X-Gm-Message-State: APjAAAXxbPY/Cv+RG+d3EUWEI5WcvuAv+itFyawucqcdDr5TUupptmzg
        saBhfXW0uvRrhc2IOCT2pcU=
X-Google-Smtp-Source: APXvYqySh2dm5C8yTdJddAWW6mq9d2RALMnSitjXV8aWgC+SiV85ujE3R+v6o3tjeE/bGRCMiADtdg==
X-Received: by 2002:a05:620a:11ba:: with SMTP id c26mr21353453qkk.201.1562768543720;
        Wed, 10 Jul 2019 07:22:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id j78sm1069992qke.102.2019.07.10.07.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:22:23 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:22:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190710142221.GO657710@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230144.GE19430@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 09, 2019 at 06:01:44PM -0500, Corey Minyard wrote:
> > I'm really not sure "carefully tuned" is applicable on indefinite busy
> > looping.
> 
> Well, yeah, but other things were tried and this was the only thing
> we could find that worked.  That was before the kind of SMP stuff
> we have now, though.

I see.

> > We can go for shorter timeouts for sure but I don't think this sort of
> > busy looping is acceptable.  Is your position that this must be a busy
> > loop?
> 
> Well, no.  I want something that provides as high a throughput as
> possible and doesn't cause scheduling issues.  But that may not be
> possible.  Screwing up the scheduler is a lot worse than slow IPMI
> firmware updates.
> 
> How short can the timeouts be and avoid issues?

We first tried msleep(1) and that was too slow even for sensor reading
making it take longer than 50s.  With the 100us-200us sleep, it got
down to ~5s which was good enough for our use case and the cpu /
scheduler impact was still mostly negligible.  I can't tell for sure
without testing but going significantly below 100us is likely to
become visible pretty quickly.

We can also take a hybrid approach where we busy poll w/ 1us udelay
upto, say, fifty times and then switch to sleeping poll.

Are there some tests which can be used to verify the cases which may
get impacted by these changes?

Thanks.

-- 
tejun
