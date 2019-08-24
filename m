Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BAAC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C92221670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566648070;
	bh=JxOU0IXr725WPeNcBzmrDiNn1P8kfgcczMoe1Pv7mFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IOxrDOrGxEBOuXdzTlpAuxcu/UsR1A0EpFCQD1elb3uoGJnTla209KYH4uGNAN5Uq
	 Cp8lIU0ehDC0OJbHNsdsrJ7x52KtHFC1lvrcQ09/nJzL28NpGo1eTOIXLnI13TrWvX
	 nDbW1xft1X7EAwBWkPC/sqWSWBhfWq8P1oiDnNRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHXMBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:01:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfHXMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:01:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so10955591wrt.4;
        Sat, 24 Aug 2019 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SLvUTMTiJDzyjwMeur1g+ElZX7+zQugB4EfcBCyQFro=;
        b=hxnDbR2cTu69lc1mV4YcBS7fMxAa8+YOdlWviSz8oib2QLORRoLRifTkhqQQFBlvbf
         1eSKyo6cHNEqua5Sr0tnI+fx2vGexhgY7ZOM5rnxXzwa1r8+Te0JX7Z5VO9Bb7OjeDjR
         FJ4GRKvKmzTPpmTu+c1KfTm2lZbxbTzbmg1tdM2y62Ooce1q1aHxfaJV2XPHD6L1O0NR
         lI1JmDR6kMS+r5b8SNaahk6w6birWbRnNm0A7jj1eSjiRzcZdsWVDkdTjxsPWXJK239m
         v85+4rznTA1GJc+lUJf7SgioZhWP8/px5g51jNPS50Mmm/0TJeu0GZ7dAqzyB7cTPgYY
         Q9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SLvUTMTiJDzyjwMeur1g+ElZX7+zQugB4EfcBCyQFro=;
        b=sA3MKT41fm/6kXdRkflW0w9IBghiEswlUNJURP8ckPfRYg+vsSDrMH/GQRDtJ0Gj6s
         3sy9jFG0Pf5Vwg7e2UWivXHDY/JyWOGfSBHVTCbWmCLfFJLkkv8znWx5xiXYM/Navouy
         Ed2LzuNm5W2ppywOAv1ZQO0Hw6gIaV6Pi/DoR0AyQCVwKRSHUsFvcj3lv8/SPzT1WTkk
         YNAWr3yPBHSiVJh6u7GHqP2Dy5ykOpWALnjepoU096cJqp1vK52HZGd+8KY6r7jkOS5j
         Lcr6VW1wEuijKYIDroQs5FBS81l/asDU+1RQAuMzKkmMSvKhRgirfs7Pfg9+BEA0lrLr
         /Z6A==
X-Gm-Message-State: APjAAAWuMPGnDi+cFpQgERZ6plRaPM9In3Sv4c6O87jNOpDH0b8Zuri1
        F9WOT7w14t+v5RNaMrRqD3G5z79x
X-Google-Smtp-Source: APXvYqzxzEo+nhDmQUoJUMEOwekmtW5P8rW2JAiFWV1BHHo1yc+2p0BNUVY3qhApiIp14VxcPBSY2g==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr10370755wrj.232.1566648066018;
        Sat, 24 Aug 2019 05:01:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m188sm13605129wmm.32.2019.08.24.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 05:01:05 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:01:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, parri.andrea@gmail.com,
        byungchul.park@lge.com, peterz@infradead.org, mojha@codeaurora.org,
        ice_yangxiao@163.com, efremov@linux.com, edumazet@google.com
Subject: Re: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits
 for 5.4
Message-ID: <20190824120102.GA10758@gmail.com>
References: <20190822151811.GA8894@linux.ibm.com>
 <20190822185429.GA110910@gmail.com>
 <20190822192132.GJ28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822192132.GJ28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> On Thu, Aug 22, 2019 at 08:54:29PM +0200, Ingo Molnar wrote:
> 
> [ . . . ]
> 
> > Pulled into tip:core/rcu, thanks a lot Paul!
> 
> Thank you!
> 
> > The merge commit is a bit non-standard:
> > 
> >   07f038a408fb: Merge LKMM and RCU commits
> > 
> > but clear enough IMHO. Usually we try to keep this format:
> > 
> >   6c06b66e957c: Merge branch 'X' into Y
> > 
> > even for internal merge commits.
> 
> Please accept my apologies!  How about as shown below?  If this works
> for you, I will rebase my development commits on top this merge commit
> in order to make sure I don't revert back to my old format for next
> merge window.

Looks good - but I don't think we should create a new merge commit just 
for this.

> Ah, speaking of reminding me...  There is likely to be one more small RCU
> commit requested by the RISC-V guys.  If testing and review goes well,
> I will send you a pull request for it by the middle of next week.

Thanks!

	Ingo
