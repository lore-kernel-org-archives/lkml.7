Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064F21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkFo0+n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfIRJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:58:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44172 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfIRJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:58:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so5195137lfc.11;
        Wed, 18 Sep 2019 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/vmDNFly4J1uivAFT0W2AkS7owll1FKiHSlevnMsJk=;
        b=hkFo0+n7Wf7x8vAqxxQVe4zwDImf0yEQRrMKLg0KkpZGweBs90sShq9FtwqDZ3DXSs
         Q0WL+scZU46CJZv55oluwDGj945KUD9O3WUiEVlfjQolm3SrOg8a/YrtCdJ1/Sh3ERjd
         A7HO9rGujHZunfjZr+xPN1cpfqqKFkjVfNNg0+te++5aJEd10GF2BBQn4OZ33FcBvu6i
         OD+m487t7nQT7XtvvU0SYyMmeNnM5SbBy++IQhQO6fVIiA2cRalsGczO47ZXjdPMpt8c
         aYHBj5IlYB2HVJq6o6pdtlUrxIU9Vv9Q3KaxYWUZFlKgW1iQCAEdb4zZcc8jOXsQtH6v
         Y0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/vmDNFly4J1uivAFT0W2AkS7owll1FKiHSlevnMsJk=;
        b=hq15VP/t5ZMsc+7D6qBSeaQJyNb1qVOIBCbYLn5MGiHVasy0DCNn5RIBHXHjUFvANo
         1tqSxrRJXPiFtcKVgMZfgf7C/54UUtKAPR303C6fDjwGSl7IOBbei/GvO2cLqGkqVbGo
         bu+BJ4y0ybVxwbmG2Yccr8cKGRcx6KipHcD2o9nh0BKFH8HecUdZJwGD0+S4Tok9k+84
         3+09nKlHmPechZPGw6ueIDmdLpq8SZYZNTBIVU45aWmEWtR0Y9C8jjsOyp7jfYhwip11
         S0h6/cCiA/AH9MH0yB2kvGbclxzeMPYbGHhmbvRS2assQp4rqB6dfxhEP7tzKowHghuc
         zRtw==
X-Gm-Message-State: APjAAAWyin+4Zxnc+USmo6vc55tIi7gLq+fEXE0wwO3rwjmgwG1jmOtp
        HU2MNSezXgBB3k3UME2bAcA=
X-Google-Smtp-Source: APXvYqy1bisaEnjLQTM5Y9V9cKKDQsvyDPutwEjsVl4CYMNWC7ax6qBolxaUtdtMU5SjfebT0ucbEA==
X-Received: by 2002:ac2:593c:: with SMTP id v28mr1608329lfi.11.1568800699282;
        Wed, 18 Sep 2019 02:58:19 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id b7sm930059lfp.23.2019.09.18.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:58:18 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 18 Sep 2019 11:58:11 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20190918095811.GA25821@pc636>
References: <20190814160411.58591-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814160411.58591-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Recently a discussion about stability and performance of a system
> involving a high rate of kfree_rcu() calls surfaced on the list [1]
> which led to another discussion how to prepare for this situation.
> 
> This patch adds basic batching support for kfree_rcu(). It is "basic"
> because we do none of the slab management, dynamic allocation, code
> moving or any of the other things, some of which previous attempts did
> [2]. These fancier improvements can be follow-up patches and there are
> different ideas being discussed in those regards. This is an effort to
> start simple, and build up from there. In the future, an extension to
> use kfree_bulk and possibly per-slab batching could be done to further
> improve performance due to cache-locality and slab-specific bulk free
> optimizations. By using an array of pointers, the worker thread
> processing the work would need to read lesser data since it does not
> need to deal with large rcu_head(s) any longer.
> 
> Torture tests follow in the next patch and show improvements of around
> 5x reduction in number of  grace periods on a 16 CPU system. More
> details and test data are in that patch.
> 
> There is an implication with rcu_barrier() with this patch. Since the
> kfree_rcu() calls can be batched, and may not be handed yet to the RCU
> machinery in fact, the monitor may not have even run yet to do the
> queue_rcu_work(), there seems no easy way of implementing rcu_barrier()
> to wait for those kfree_rcu()s that are already made. So this means a
> kfree_rcu() followed by an rcu_barrier() does not imply that memory will
> be freed once rcu_barrier() returns.
> 
> Another implication is higher active memory usage (although not
> run-away..) until the kfree_rcu() flooding ends, in comparison to
> without batching. More details about this are in the second patch which
> adds an rcuperf test.
> 
> Finally, in the near future we will get rid of kfree_rcu() special casing
> within RCU such as in rcu_do_batch and switch everything to just
> batching. Currently we don't do that since timer subsystem is not yet up
> and we cannot schedule the kfree_rcu() monitor as the timer subsystem's
> lock are not initialized. That would also mean getting rid of
> kfree_call_rcu_nobatch() entirely.
> 
Hello, Joel.

First of all thank you for improving it. I also noticed a high pressure
on RCU-machinery during performing some vmalloc tests when kfree_rcu()
flood occurred. Therefore i got rid of using kfree_rcu() there.

I have just a small question related to workloads and performance evaluation.
Are you aware of any specific workloads which benefit from it for example
mobile area, etc? I am asking because i think about backporting of it and
reuse it on our kernel. 

Thank you!

--
Vlad Rezki
