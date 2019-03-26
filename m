Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB990205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g9RXC4DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfCZXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:48:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39937 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfCZXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:48:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id b11so2375361plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUNSkFvC28g1YYERPeLkJKVqnPzuzp5TZaeLTSrsMDo=;
        b=g9RXC4DKPe2v958xxRkorVROvuAOfRCyhcraMUjZNtWEznZzSAlfoeQwL11UZ5uN4X
         w4Upd3O2EFErcc5hqQcoJHETS2Vw8uo29xk4G/0CmAnGa8Nd7VUujQOxvkHnIHxBQlgC
         5I7rnvA7PAHih2gzAcs1sJtdM2OJoOkuHi2Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUNSkFvC28g1YYERPeLkJKVqnPzuzp5TZaeLTSrsMDo=;
        b=bIjJ3dF8TLSbtFUqT0R/6qDzgZ5G4cbMjnu9jNGhPHJdmyyZZx32f305oIfJ5NryXJ
         4SHC7q/bwhVzM4PTA9xHrq22Hvb7Q9aj8+hucwkNL/xLFSJPTo6Jf7tsNROLtcMonGPL
         otzaY6gGhlFydJhIke3zHaB35TEh9WAN2aAkgSGpeVLO+RjOaVqjmAktoIMnd9nl1hq9
         d+rBeDxZIYxMdfT1gsBlXfBG9SuhGpopyZ/uIzzeilFpkpnjakbm8lmbWFV+X6CcUFzs
         B8OhNHDiGYkUxsWkwVZjAg6BRqrv/jZoqdAPtk1zlhVchAzVevmqKzrLS/q6zy6XFI1M
         QOPQ==
X-Gm-Message-State: APjAAAVpmEyjK8atebqeUvJB6fOpT+zDFi3NURjqPJn+KU7L4uJaSj/0
        2dp7PDUVJSmWmkes9ik4BPHNqA==
X-Google-Smtp-Source: APXvYqzfXi4AACJEiMPViAw59k3gB5uQLmCnIAlRhC5+0axPeA8TnJJq+9V2eWOdRz47wmv3Y4mHJA==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr14709175pll.255.1553644137292;
        Tue, 26 Mar 2019 16:48:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e2sm33012503pfa.64.2019.03.26.16.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 16:48:56 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:48:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
Message-ID: <20190326234855.GA108868@google.com>
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com>
 <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
 <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
 <20190326160140.GP4102@linux.ibm.com>
 <20190326183549.GA162738@google.com>
 <20190326184013.GA114492@google.com>
 <20190326204613.GS4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326204613.GS4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:46:13PM -0700, Paul E. McKenney wrote:
[snip]
> > Any way, I will just add back CPU0 forcefully to the cpus list in my testing,
> > without checking for the online file existence, and see what happens :-) If
> > there's no smoke, then I'll roll that into a patch and send it out.
> 
> Sounds good, especially if you include a few of the uniprocessor tests.  ;-)

Yes, I will do those as well. Thanks for the reminder :-). Let us wait on
merging until then, then. I will reply back here about the uni processor
testing tomorrow.

thanks,

 - Joel

