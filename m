Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ADBC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735A5206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXdL/rij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLXStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 13:49:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42885 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 13:49:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so15619807lfl.9;
        Tue, 24 Dec 2019 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lWn5lG1lm71cwDo15yx9m3Zo5kwANx7q2As8ujx/+8M=;
        b=BXdL/rijyVZCACaMXJD0dON+UYD7AWBhrRNXvpLvby8tHu3kIC/vQgf+nDvupD3ORA
         wF0GxTbPYQLye/oZE04zLXZ8so0QiRHQeSJVW5jtbVyghCEDjgCFXEJ6lBv7JX6xX5GD
         x3gooA/KHSkBahceOOg1HO4eVx0ndOcId0FRmUAc0VCzMWtdpukzaWh0d0Rij2+53kWU
         xISo0e1KOpUG0C7TO2GkVpJtvf63aGaDOwwLRF9HlO4qN7w9Tc9eFar17akS1pUmejEL
         sT2NQwyLXe1Q6tn6Z63Zxjo7aTtndzXPNxtNZMHMqgt3B3wq8fMZdNcruBdxP8PE/IH3
         h5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWn5lG1lm71cwDo15yx9m3Zo5kwANx7q2As8ujx/+8M=;
        b=ZhwjedrKJxnYiCxHxfxsdyXY4ROzBcINW9lzooe41JSi1pF5FaDVjHNdLMO3BHFE4T
         bBq871UA20tUuIVGzqBBxO/XC2yRJReFjpbmGfh5s9+pzInlf2X9r7Kw5LqQS91pAIqg
         ff2faXj1DJHignwrX6QoYj93yiRYoEVpFNqWDdCcyv8PBCpbcH5e68ddjwDuufEmh0n1
         qNEMd+28CH8zat55nvtRCS2PiL4J+Ca/uVPB0kkdzryDWIFHyOPFg/w2i0+HZoOb59Yv
         eK5OrxeADWoP9JVrB1fdWhHdJuiajPMNl0FCkHq3Hm28QC/jIHRU0LcQYdGXCL2ib0vj
         nBxQ==
X-Gm-Message-State: APjAAAVv5Chz+bLzIm6lqjPm39YG6XOvQ6So6+YjcI5iISd8ShE17ORq
        nNe0MjvvRr/3goEcUiiaoCb2fMqHrHM=
X-Google-Smtp-Source: APXvYqwoWhSsy+1/t4bgnaW4ctju9iEb5ctRYbTMpHNAblSqYOqjz0OPVcCOe9L4KURxzBFWKktWWg==
X-Received: by 2002:a19:c210:: with SMTP id l16mr21640528lfc.35.1577213390894;
        Tue, 24 Dec 2019 10:49:50 -0800 (PST)
Received: from pc636 ([37.212.210.43])
        by smtp.gmail.com with ESMTPSA id z7sm12351936lfa.81.2019.12.24.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 10:49:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 24 Dec 2019 19:49:40 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20191224184940.GA16346@pc636>
References: <20191220125624.3953-1-urezki@gmail.com>
 <20191221232117.GA67625@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221232117.GA67625@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel.

> 
> Hi Uladzislau,
> 
> Your patch is based on an older version of the kfree_rcu work. The latest
> version is in Paul's -dev branch. There is also additional work done in that
> branch as well "rcu: Add multiple in-flight batches of kfree_rcu() work" :
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=e38fa01b94c87dfa945afa603ed50b4f7955934b
> 
Ahh. I see there are some differences and my baseline is wrong. I will
double check and rebase on Paul's -dev branch.

>
> Could you rebase your patch on Paul's -dev branch? The branch also has an
> rcuperf patch for measuring memory footprint automatically (memory footprint
> value is printed by rcuperf). Although I'd say try to use the latest version
> of the rcuperf patch by reverting that and applying:
> https://lore.kernel.org/patchwork/patch/1170895/ . I can then add your
> Tested-by tag to any future postings of the patch for rcuperf as well!
> 
I will do that and run all tests based on the latest code base.

Thanks for your comments.

--
Vlad Rezki
