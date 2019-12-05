Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5102C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88C52464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqs3hhxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfLEPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:14:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46498 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:14:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id y14so1740171pfm.13;
        Thu, 05 Dec 2019 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4KrZ84UljluamxNF+nH5kh1soJy0EOumBh8z5AiXj1M=;
        b=Iqs3hhxMyajp6V6jOD9k8vmFZgFnE7RlH5Y5SIFEW8fHtSiT8WMNdMvH4Orv5qsVnY
         ISzL7S362NFaevFh8wcBCvOnjDMqjeRa3xqLJXIk7QgpiCsap+7/QOAVOCI78pX52ki/
         1iGqAct3hgHONi8QTfRTdMj/DFNsuBZyY8uIzcLhqDydv1LPSqccgf0eayjyO7lLusS9
         Jloht0wmQC3Kwcf6ISB50SO/CZsro7ORzKDPuxdt0ItadsFYasg6pYViQvzfHeJm9phH
         ty6sWpUnWREW4jEYCpVEw8a3W+5Drw2jihWJmNNWDDHx1kTvpoICF8bWE1PV+L42jQfB
         lpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4KrZ84UljluamxNF+nH5kh1soJy0EOumBh8z5AiXj1M=;
        b=mcC94QU52K+vywoybxCj4b21/m4KJ2msHyE9aO4dmH7Q4/2CL2Fuk4hF2KFvOyuhTc
         Vpz6+xJfDvLII/7yth6K6/QoMagAa2j6/JqiZw3ReqiIzohWNCiAmSZsYTWgO1jUcfbr
         50OsxcKO3tEp77TL2vaNEta2iSWmYId1vPI5BKgC/Fba9Q/1pBuCJ0yy+Bew0vM9562g
         W8010R3Jh70BDTr5Q7trVchCcYxlfhhdsGZzYrXH61c0M9IrTJMM8aCDVTAXNyKhlImI
         4RgkRmSebopYhNv58Ufb61Ay0lotGm4Dm2LpxO/6fWBdG+ocLyXZ0WMHnymbQ5cunGxJ
         PFgA==
X-Gm-Message-State: APjAAAV/jbx73FHAJl9XCZcXfHA6wEwDAsB/karpx1vO17CceB1kDQkR
        PhlraicP7GTe0ZRBt30BwXY=
X-Google-Smtp-Source: APXvYqy/oc7fJO2/PLyS5gTXvu0Yq0ItJ+u+B2pLMSWHPIMKM4VcXxZPSU3Y9Rq9/t32w3QA2avRRg==
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr7305169pgh.178.1575558866248;
        Thu, 05 Dec 2019 07:14:26 -0800 (PST)
Received: from workstation-kernel-dev ([103.211.17.187])
        by smtp.gmail.com with ESMTPSA id x13sm13397674pfc.171.2019.12.05.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:14:25 -0800 (PST)
Date:   Thu, 5 Dec 2019 20:44:18 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191205151418.GA3424@workstation-kernel-dev>
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191203064132.38d75348@lwn.net>
 <20191204082412.GA6959@workstation-kernel-dev>
 <20191204074833.44bcc079@lwn.net>
 <20191204153958.GA17404@google.com>
 <20191204084729.184480f3@lwn.net>
 <20191204163552.GE17404@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204163552.GE17404@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:35:52AM -0500, Joel Fernandes wrote:
> On Wed, Dec 04, 2019 at 08:47:29AM -0700, Jonathan Corbet wrote:
> > On Wed, 4 Dec 2019 10:39:58 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > Actually I had asked Amol privately to add the backticks. It appeared
> > > super weird in my browser when some function calls were rendered
> > > monospace while others weren't. Not all functions were successfully
> > > cross referenced for me. May be it is my kernel version?
> > 
> > If you have an example of a failure to cross-reference a function that
> > has kerneldoc comments *that are included in the toctree*, I'd like to see
> > it; that's a bug.
> > 
> > Changing the font on functions without anything to cross-reference to is
> > easy enough and should probably be done; I'll look into it when I get a
> > chance.
> 
> I tried on a different machine (my work machine) and the cross-referencing is
> working fine. So I am not sure if this could be something related to Sphinx
> version or I had used an older kernel tree before. This kernel tree is
> Linus's master.
> 

This is great! I'll remove the "``" from function text and send in the
updated version. However, should I leave in the "``CONSTANTS``" and
"``variables``"? They dont' have any kernel docs to be cross-referenced
with and also make them distinguishable from the normal text.

Thanks
Amol

> thanks,
> 
>  - Joel
> 
