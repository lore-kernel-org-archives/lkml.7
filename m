Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C432206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wxabqZ17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDJClG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:41:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDJClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:41:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so472309pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmxJbcmpcRKolt0y4TtJCgsfV3S1RFujMG9xLTLcYAU=;
        b=wxabqZ17O7Yoh0ZoMWH4H8f+kWm3Dm89RpFDf0lUxKk9f5VNaeTPz8GjUA2q/buX2l
         yTdXCNs1RS0KX9nKZlAgqyvJ3Obbuhjgluwk3ESIK8xvIvLNa5s+w1HLSBIZqPHfITEW
         IWFP74uQ621MNPP+GpdAaC45r4SJAtZCCWbP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmxJbcmpcRKolt0y4TtJCgsfV3S1RFujMG9xLTLcYAU=;
        b=nYsQjYMD6NOrmXk0uFxCbh488GQ6znTrR21qQzrJucZldxHhkaEcfb7CSt9kPl+pR/
         OgTa6BFbBEwicFurD9rzDhw+EYcP8Doxc8fEGENSNl4AJMxoIhGsEuGeBOFhQOhTdwDh
         puTULmA7s8/E5ibDwjqUpINcYspGPt+A9GmMfuSHb6u4U6Hc+H21yqbrK4O+CIdFeYj2
         g+Rn7BC+wNWut8W0JJ8wJ/TBwOVM96XEJBb9ywbsETiL6cXr9O9rxo4Sn/BwWEPWz1AV
         UiNnaMMHrxFl504rpukZPa1sC/2Nm3viowSc1GHV5RjJfRd/vAaZFObZUqo4E6IBv8tD
         n89w==
X-Gm-Message-State: APjAAAWco+HhIuANIIQebovO6ntQIrhXDwKp/OekBaXKSoMbGOK8kqRp
        4bCMVIJx/eYGC5JhQl9cuCLlcw==
X-Google-Smtp-Source: APXvYqwQDWHPVG/bw0qpfLEUQFZQEnLHAx9yhix+t0KlreZAr2Y7Y075wzP3mw5Z/bPDdnMg6CTgpA==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr39701425pff.35.1554864065313;
        Tue, 09 Apr 2019 19:41:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e13sm55441280pgb.37.2019.04.09.19.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 19:41:04 -0700 (PDT)
Date:   Tue, 9 Apr 2019 22:41:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] module: Make srcu_struct ptr array as read-only post
 init
Message-ID: <20190410024103.GA104423@google.com>
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <20190410011418.76408-2-joel@joelfernandes.org>
 <20190409223820.511e3671@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409223820.511e3671@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:38:20PM -0400, Steven Rostedt wrote:
> On Tue,  9 Apr 2019 21:14:18 -0400
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> >  /*
> > - * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> > + * These are section names marked with SHF_RO_AFTER_INIT so that
> 
> I'm curious to this much of a change. Wouldn't just making "section"
> plural also work?
> 
>  "Mark ro_after_init sections with ..."

Yes, I will change it to that and actually this comment change should go in
the previous patch so I'll squash it into that.

> Other than that, the two patches look fine to me.

Could I add your Reviewed-by in the respin?

thanks,

 - Joel


> -- Steve
> 
> >   * layout_sections() can put it in the right place.
> >   * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> >   */
> > @@ -3314,6 +3314,13 @@ static char *ro_after_init_sections[] = {
