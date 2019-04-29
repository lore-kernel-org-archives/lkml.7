Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97BC04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1EC2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556553666;
	bh=TE1ewElB1YwLMGITzAatJEBshCwXkGp6DoQ8Uy+WE4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HrmxcoGBA3bdmL9gqyGmZ6DKqoOe6UYsH76VTfxoIyczTfm9r85S1+Gvm/E0QdpLD
	 GHy1lOg1r7m2eRTCwa+MvEYgUxt7af6hT9zCrplP5V7EYgi8pAH6B2i3wRILltNHPD
	 lqj2n3xMCLcvLgoWZEpEBoZO7Tg/fMENEdyENQ48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfD2QBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:01:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37490 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfD2QBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:01:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so15648868wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47R6Zpibyfoy78svmdHN6byC39LAOhbREp9Vq7W8ApM=;
        b=J6WZI/9oZi6DDKY6ako6bYIe0Ho2qjghdiWqUvyAS7l+nRMiKRoF8QwS9JlolG6510
         Q5N5HRulN4x7f8dcPpZl33KYtvLvbzdGSd/3dbgaGUcRzgXw5L1Qf7mUIcJtFZ1+oUSn
         mdW4XoBbzNwcx8pEvJffS3J5si1MuSH4OKvngUBtaFM166ubF70+375GsLojZWBCfWOr
         nhX4md1G6bbEC5WxHgTjR9Gj1ivGp+iSHr17nK9iayfFdLrWFtXsF7za9jkRiyTBvEEL
         +eEjbLwRWQtIMo9uBWDgYiZJrJc9ucIY6foS1IKhzEC/Nsl9ZeuUqKdeE6zweMUf5/47
         IT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=47R6Zpibyfoy78svmdHN6byC39LAOhbREp9Vq7W8ApM=;
        b=Zzt0/9snqvb3x9E3AxCZMnIYLLkIY6v1cwWasJfwbKRw0VyYHADYJcAOY5ulGcp1JE
         UAfkJk68sGgccVSsP+A/jaWRrRNf0T31+fY65+QWkcydCHN7gR/sc98mS9NEUsMxyUuB
         /Ye9DMzqcS9xVgCUcjQi/MTxdnGwPmckJlSysdFsew8VabMWdk09mnK/ILDWYSNQqc4o
         WzCye0wWCycI+6v10JjdQjhg70zMqnH7CQ49OBCdsh1By4SLU0C+DzsuLwlNu7L18C/b
         ALzXk3ODijXgjSzUUOFJO47EuxdsUvX2JfpIw+PfbWjOOU/7Pj5a+xo5fbRpS2+mRrfu
         CXRw==
X-Gm-Message-State: APjAAAXm6/u4OsiJL5roJMXnBmF+kkoG2x652b6kROYdHhDbU6O5lPUt
        YFfWNbkSuhr6U6c3kXgcJAg=
X-Google-Smtp-Source: APXvYqzcpnQflanBpal3y5NxmBtr/1fTly+OrRIG47nJowVPZPtGq8IlWtBEAgYrnNE/BQwVzQb2xQ==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr541889wmh.136.1556553662023;
        Mon, 29 Apr 2019 09:01:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t74sm237110wmt.3.2019.04.29.09.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 09:01:01 -0700 (PDT)
Date:   Mon, 29 Apr 2019 18:00:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190429160058.GA82935@gmail.com>
References: <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
 <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com>
 <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Li, Aubrey <aubrey.li@linux.intel.com> wrote:

> > I.e. showing the approximate CPU thread-load figure column would be 
> > very useful too, where '50%' shows half-loaded, '100%' fully-loaded, 
> > '200%' over-saturated, etc. - for each row?
> 
> See below, hope this helps.
> .--------------------------------------------------------------------------------------------------------------------------------------.
> |NA/AVX vanilla-SMT     [std% / sem%]     cpu% |coresched-SMT   [std% / sem%]     +/-     cpu% |  no-SMT [std% / sem%]   +/-      cpu% |
> |--------------------------------------------------------------------------------------------------------------------------------------|
> |  1/1        508.5     [ 0.2%/ 0.0%]     2.1% |        504.7   [ 1.1%/ 0.1%]    -0.8%    2.1% |   509.0 [ 0.2%/ 0.0%]   0.1%     4.3% |
> |  2/2       1000.2     [ 1.4%/ 0.1%]     4.1% |       1004.1   [ 1.6%/ 0.2%]     0.4%    4.1% |   997.6 [ 1.2%/ 0.1%]  -0.3%     8.1% |
> |  4/4       1912.1     [ 1.0%/ 0.1%]     7.9% |       1904.2   [ 1.1%/ 0.1%]    -0.4%    7.9% |  1914.9 [ 1.3%/ 0.1%]   0.1%    15.1% |
> |  8/8       3753.5     [ 0.3%/ 0.0%]    14.9% |       3748.2   [ 0.3%/ 0.0%]    -0.1%   14.9% |  3751.3 [ 0.4%/ 0.0%]  -0.1%    30.5% |
> | 16/16      7139.3     [ 2.4%/ 0.2%]    30.3% |       7137.9   [ 1.8%/ 0.2%]    -0.0%   30.3% |  7049.2 [ 2.4%/ 0.2%]  -1.3%    60.4% |
> | 32/32     10899.0     [ 4.2%/ 0.4%]    60.3% |      10780.3   [ 4.4%/ 0.4%]    -1.1%   55.9% | 10339.2 [ 9.6%/ 0.9%]  -5.1%    97.7% |
> | 64/64     15086.1     [11.5%/ 1.2%]    97.7% |      14262.0   [ 8.2%/ 0.8%]    -5.5%   82.0% | 11168.7 [22.2%/ 1.7%] -26.0%   100.0% |
> |128/128    15371.9     [22.0%/ 2.2%]   100.0% |      14675.8   [14.4%/ 1.4%]    -4.5%   82.8% | 10963.9 [18.5%/ 1.4%] -28.7%   100.0% |
> |256/256    15990.8     [22.0%/ 2.2%]   100.0% |      12227.9   [10.3%/ 1.0%]   -23.5%   73.2% | 10469.9 [19.6%/ 1.7%] -34.5%   100.0% |
> '--------------------------------------------------------------------------------------------------------------------------------------'

Very nice, thank you!

What's interesting is how in the over-saturated case (the last three 
rows: 128, 256 and 512 total threads) coresched-SMT leaves 20-30% CPU 
performance on the floor according to the load figures.

Is this true idle time (which shows up as 'id' during 'top'), or some 
load average artifact?

	Ingo
