Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E22C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AB9206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0orDhsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfJHPaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:30:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:30:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so19932404wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=457l+Cgh0YGrUvlYdgFiGAo7ttUX93RzVW+DU37+Q0c=;
        b=d0orDhsuPkSm8v6nGrYvlUpBDez/Oy1vw0MygH1fKuj9rsAAIFNwMtcecjGYJ4PU21
         8QM6v+horvUr21q+BbqU6QE8CkSMB/InvrE1mJy6EhwzEqq1ybcKBh4ovhwypdrkjXFN
         K5KvVtbf4FSmKJzxL1burEnR6QYq1hwJ9qnq/jrfSHOq6OWecUnrXwlDbrTpEKh59izp
         6a6LyZr8Ec3lJY2KFbabCegx4cKEClq6b5I5K52bTiobKIk+j11g9NUWTDnG28/1HjNw
         tZSqMLFjIRJKRr4JL0eF6V26hhsD709ju3UeqGq6mLXBQ+xfr/8rm/3Rvq90v3ffPdzN
         pwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=457l+Cgh0YGrUvlYdgFiGAo7ttUX93RzVW+DU37+Q0c=;
        b=b3j8//RXxshTe9dDxZYQU0OIh/LKhAmT7B4wa1/HJGq8d//XaPHuUJ2iPsyBCTxXe3
         WzOpg/XXjsc28L0UZjIyncB89nXEfoF20noRA7kOIqQL/1J8imIMqdPJBp64HHfRR+Z0
         PWJYtusLs/NAysT8fmjFp17RkPBBN/N5mXbpCfUYqUwbj/G+mBHj6vZs5/XpPoFkTmpr
         KERpGgO/rvt2orDF1wwyDWMy9W65PJDq2JFwAtcDNhzQgE01BACs98rUDBzXdpZvtGRj
         6pLnCS0yFZf9wFQrEYcew6qs10GStBdvdfdMGxG7aaBKZJwQWxpx66ECJ7qv5qUWrw3t
         cqTw==
X-Gm-Message-State: APjAAAUWOvr3yAsreb4o+oRKuQqZLVFDMfj9JTuB4x8UL3IIgPaczLJR
        BBjYWDC1pmrRBjJYhogbAJbuLA==
X-Google-Smtp-Source: APXvYqy9Hw4tvvu8KMKh8JT9QxQB4g+iTY1r5B0NvSpsWlz2xKNJhFKjuMLntj7exINwhU565obIVg==
X-Received: by 2002:adf:f507:: with SMTP id q7mr5227287wro.127.1570548605132;
        Tue, 08 Oct 2019 08:30:05 -0700 (PDT)
Received: from linaro.org (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id t83sm5825428wmt.18.2019.10.08.08.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 08:30:03 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:30:02 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008153002.GA21999@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
 <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
 <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 08 Oct 2019 à 15:34:04 (+0100), Valentin Schneider a écrit :
> On 08/10/2019 15:16, Peter Zijlstra wrote:
> > On Wed, Oct 02, 2019 at 11:47:59AM +0100, Valentin Schneider wrote:
> > 
> >> Yeah, right shift on signed negative values are implementation defined.
> > 
> > Seriously? Even under -fno-strict-overflow? There is a perfectly
> > sensible operation for signed shift right, this stuff should not be
> > undefined.
> > 
> 
> Mmm good point. I didn't see anything relevant in the description of that
> flag. All my copy of the C99 standard (draft) says at 6.5.7.5 is:
> 
> """
> The result of E1 >> E2 [...] If E1 has a signed type and a negative value,
> the resulting value is implementation-defined.
> """
> 
> Arithmetic shift would make sense, but I think this stems from twos'
> complement not being imposed: 6.2.6.2.2 says sign can be done with
> sign + magnitude, twos complement or ones' complement...
> 
> I suppose when you really just want a division you should ask for division
> semantics - i.e. use '/'. I'd expect compilers to be smart enough to turn
> that into a shift if a power of 2 is involved, and to do something else
> if negative values can be involved.

This is how I plan to get ride of the problem:
+		if (busiest->group_weight == 1 || sds->prefer_sibling) {
+			unsigned int nr_diff = busiest->sum_h_nr_running;
+			/*
+			 * When prefer sibling, evenly spread running tasks on
+			 * groups.
+			 */
+			env->migration_type = migrate_task;
+			lsub_positive(&nr_diff, local->sum_h_nr_running);
+			env->imbalance = nr_diff >> 1;
+			return;
+		}

