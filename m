Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9BC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CB92080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EFW2CMar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJFXox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:44:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36819 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJFXox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:44:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so7491351pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Db+NewJuq9xBTnsJpKUfmZtRSZSczRlD9ss2URKSPvE=;
        b=EFW2CMarDNX+CDe08d7d90jUqxBgJ56dXrrUtVA64eKS5W/s2PyGt/ioG/268jMG5/
         FLV580dtnZjzj1R1HBDlOibXUCU1aRlZ3g3BjTN6Mkym1711Pehv33aswmesnwT2EJav
         a4LzCXz2nwKX+sdUSStIGsXwsDpxMeybzcEiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Db+NewJuq9xBTnsJpKUfmZtRSZSczRlD9ss2URKSPvE=;
        b=cpYFUezAuqaS2l36bqsS5Ylu4us02ifdOkzwMwBNpXZk+PemBW71HxgDpTuPoeIq/D
         3QtD4mRn4eFM9AW/rfsin3RNub6IqsZ/Jw8vtPZngQKidMVd+XHAuZwWizBFDtQmzerq
         og5NHJzvTNstWh/Lq7G1VeWDZ/1v5U22EN58OvSvARIPXd0eyd384i+MEjR5dJI4erKK
         9siHtdgNtzmK49I1pV4+n7imxkLafGGeOZuTOBu98JNm5/nw5wHkK3fOCtJXan3Ro2+q
         mikW9YPnibQeVALJKU+gU+ItxNKaUgNp3OWYAs4NMrpgGZBGz/7Dbfa0i6eXJyQI05Z0
         2beg==
X-Gm-Message-State: APjAAAX/B8vqeJHOV8i7MfgNsJLiONi32xLADUMdqCHeqA2IcAR8kKzM
        n/v5hWsc8WzXVXYY+TVZ0kNSwh1T1DE=
X-Google-Smtp-Source: APXvYqyiCQIPrme0B2WFaLqwuh9sQyceaZD5oJjwPK2yC9iskOqxsWWOyRaFgUdY6BnXQ8AVqw8oNg==
X-Received: by 2002:a62:db84:: with SMTP id f126mr30458639pfg.25.1570405492270;
        Sun, 06 Oct 2019 16:44:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y36sm2033543pgk.66.2019.10.06.16.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 16:44:51 -0700 (PDT)
Date:   Sun, 6 Oct 2019 19:44:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Describe variadic macro argument in a
 Sphinx-compatible way
Message-ID: <20191006234450.GA2711@google.com>
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
 <20191004222439.GR2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004222439.GR2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 03:24:39PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neuschäfer wrote:
> > Without this patch, Sphinx shows "variable arguments" as the description
> > of the cond argument, rather than the intended description, and prints
> > the following warnings:
> > 
> > ./include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
> > ./include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> Applied for testing and review, thank you!
> 
> Joel, does this look sane to you?

Sorry for late reply due to weekend. Yes, looks good to me.

thanks,

 - Joel

