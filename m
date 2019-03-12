Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B82084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P++Apy3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCLLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:41:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33694 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:41:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so1649528pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nsoKKTOTUdjtKx2hzum7/ptgzV6Su1VAYTooFm0VVEM=;
        b=P++Apy3+yKXqbkPEqrOBouaxm0Ux84v3IHwFZvi2yP8nQTGTkaFj8vYN+WhsV1ZHyJ
         Q4agFte9SF41+l7t2YTHawQWePKr+bPv+Lx0VHeAjROXxVeI9YUfb6Xv8jmmvgCdMzcL
         Ylp73Sh1/i/0FkJ3Ak9pMxyzBeZ3R5ppetQMRoKRV6YHaQ5w/LsyOnmt0ZH6oera1ECz
         pY6OL9QiUWkniJc4PrxWs2Cgkvuvq3u5LwxKXGk3rhmjBmLt0KK8oFCmOUSzRUKpRQ13
         hi4RXoAUd3wyZ6U/aDg4RR9IVpTIW05NEpeHkEnPe7aB4MK/qvvjHPbtcoKHYc6IsoGL
         yobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nsoKKTOTUdjtKx2hzum7/ptgzV6Su1VAYTooFm0VVEM=;
        b=R4wLHl+p0FcDQHV3kfGg/KqiXKP3SiVQ6bw48cP8IDOmHqxhilxxc7DOG1WIwE1yXn
         8lm4kAOmRJpjSx1i+6ccxG4LizBtgLoVP7NJ/hS8DpXLr8cD+OJy3adoMLvAUZG6E7KL
         y8HYpXOhXNqGRBNVbHkWK/h3+Rs5ViAmvTw+wZjHFYwnzTHXpTYq0F/suUsZchAxb/4H
         AntjwddwsHM5oa7YpHT9H0as7y6ljhdEsWWw1gtJVi0Yg0w0kYEZP6VZV9IAyimTmSXY
         PPNhqupkaRDZj2GsmocG2t7+wAdoZ4qNupGV9S2ou+d6NS1cYY+LQoCmUDZBmqWqDvZB
         ss4g==
X-Gm-Message-State: APjAAAW8JMy3zDwDFGDdJTRwvQynhO1QtHJYg+eOgnsRTgDvYZFBtkXL
        oZ4YMy3Vx6WU/CK3oo6BgwCdnA==
X-Google-Smtp-Source: APXvYqxVc2+Y0HjjrOQUIA5Q154nn8B1ENZ+34v0P/uTClzn2+6Qdlu8hd+BrLoZXstm7xx7nfaDEA==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr34313168pgc.82.1552390910639;
        Tue, 12 Mar 2019 04:41:50 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id m6sm11703047pfa.115.2019.03.12.04.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 04:41:49 -0700 (PDT)
Date:   Tue, 12 Mar 2019 17:11:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com,
        yuwei3@hisilicon.com, gengyanping@hisilicon.com,
        peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Message-ID: <20190312114147.emnt4ed4gpnyibyo@vireshk-i7>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan>
 <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
 <20190312090430.GA28905@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312090430.GA28905@amd>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-19, 10:04, Pavel Machek wrote:
> On Tue 2019-03-12 08:58:02, Viresh Kumar wrote:
> > On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> > > On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > > > wakeup_source_remove() is the counterpart of wakeup_source_add() helper
> > > > and must undo the initializations done by wakeup_source_add(). Currently
> > > > the timer is initialized by wakeup_source_add() but removed from
> > > > wakeup_source_drop(), which doesn't look logically correct. Also it
> > > > should be okay to call wakeup_source_add() right after calling
> > > > wakeup_source_remove(), and in that case we may end up calling
> > > > timer_setup() for a potentially scheduled timer which is surely
> > > > incorrect.
> > > > 
> > > > Move the timer removal part to wakeup_source_remove() instead.
> 
> > > 
> > > I've merged it with the [2/2], rewritten the subject and changelog and
> > > queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> > > source timer cancellation").
> > 
> > Okay, thanks. We (Android guys) want this to be backported into 4.4+
> > kernels via the stable tree. Can we mark this for stable in the commit
> > itself ? Else I would be required to send this separately for all the
> > kernels. I should have marked it for stable initially though, sorry
> > about forgetting then.
> 
> Greg is normally pretty agressive about backporting everything
> remotely looking like a fix...
> 
> But better changelog would help. How is the bug actually affecting
> users?

The Android wakelock infrastructure (not in mainline) is based on the
wakeup sources stuff and that is where we found the issue. A wakelock
was taken due to a bug in user driver and the board never attempts
going into suspend anymore.

If this patch doesn't go into the stable kernels, I would be required
to send this separately for Android kernels and the Android guys will
suggest getting it via stable tree.

And because this fixes a potential issue it was worth trying getting
it via the stable kernel :)

-- 
viresh
