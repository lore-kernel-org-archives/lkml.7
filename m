Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47EDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0C5206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556518469;
	bh=SOAxGG6GZeLCTGrjv+d6epyp3ZQ92eWV0xtL3mDTcXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvwiMF55i0Vhrvi/F4iAJ4tPF+MEsdq67ZYiyZzAvHFIBMMBxSKQcjobQpf2Ew38S
	 rHbBa4X8+71Mc3W1dkp+4311zSQhlUWNgyzZ5EP7QEIuXElGp8/xH7wblF3P8VNaKM
	 4uVLqmwFslJRSHS9/vaxL5MF8r5sFE1r882QaWK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfD2GO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:14:28 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35217 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfD2GO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:14:28 -0400
Received: by mail-wm1-f50.google.com with SMTP id y197so13925769wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sc8DGDUiOskQDgOKAxSflmLmMKPxZefdcIthvhNNfHo=;
        b=UNlxdEkxc/uqtZLjNad5IEnlqTdmCWpHSW3RAy4qEguRraRbfxu4seUcaiIrB2VAN3
         pQSQNsmXnNjeDHIOU9/AD8BWWsC6KfWSsEHae1ty6I+kWUKx7rAvDFP2XUn1FS9RE2wA
         FAw0pKIbUpNoE0wjQYhMTva7/GsoHtGgle/0oHnpLOrBCBKKrOuTfV31mtkGa5nHTko8
         1eqfX4FSMskWXOkuXjWpTRtnbLdIuCh3rnkJLxHGuxQF+Ilw1Qdo3NLvKvgTfUVx/Gz6
         pRxhWcClLVdV1XDzNnAAijYk84w4B363erPTUkd+7muYcq5ZsZI/hKvJ94zWlEGllW9Y
         lsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sc8DGDUiOskQDgOKAxSflmLmMKPxZefdcIthvhNNfHo=;
        b=cecgSSPPyGZVMBhyjt5flhZbCpnWPnGxuhGsQA73Og/8pgT39duTPA3mI4HfyPhQX8
         AnSegfh9zyqS04X9yRmR5x97QMey3TdJsjzKJb5OInpZTxejDzt0eIvyUZw4H4PbYEzl
         /ofQ0RYyCj2ArixygyXUJiBSFY08/tazePQOTj1owjvqDoyJXb/9TSj0CJpPRvBBN4im
         CmHtaQ9TOaFNg0D6G1SxTivlHtfYIQvSFMUjV0+WES+rDVArCnmEN3sb8shUenYOr8w+
         fYVSyJlf4zCRBGuMQ2hbQPM8bweSRHZ9DV7LL52ZW7tWDl/aGEV1G6Hu6PG09ln4I+hR
         sYpg==
X-Gm-Message-State: APjAAAUS3Sri1B1lIk+KWiB1L3dLJf/9QtMZelB1pzjgohVvuBfTSSsx
        Blf9mKpnsOt7HwO0lJfXSYk=
X-Google-Smtp-Source: APXvYqxOGHXL9XEB8JMs+c/kNIXQeb4zjorRzPBp8YcaqtiJGY5BT30sfFAJfChjqUWRDKboyzAWPg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr7211427wmh.122.1556518466225;
        Sun, 28 Apr 2019 23:14:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d1sm8751465wrb.61.2019.04.28.23.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:14:25 -0700 (PDT)
Date:   Mon, 29 Apr 2019 08:14:22 +0200
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
Message-ID: <20190429061422.GA20939@gmail.com>
References: <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
 <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Li, Aubrey <aubrey.li@linux.intel.com> wrote:

> > I suspect it's pretty low, below 1% for all rows?
> 
> Hope my this mail box works for this...
> 
> .-------------------------------------------------------------------------------------------------------------.
> |NA/AVX vanilla-SMT     [std% / sem%] | coresched-SMT   [std% / sem%]     +/- |  no-SMT [std% / sem%]    +/-  |
> |-------------------------------------------------------------------------------------------------------------|
> |  1/1        508.5     [ 0.2%/ 0.0%] |         504.7   [ 1.1%/ 0.1%]    -0.8%|   509.0 [ 0.2%/ 0.0%]    0.1% |
> |  2/2       1000.2     [ 1.4%/ 0.1%] |        1004.1   [ 1.6%/ 0.2%]     0.4%|   997.6 [ 1.2%/ 0.1%]   -0.3% |
> |  4/4       1912.1     [ 1.0%/ 0.1%] |        1904.2   [ 1.1%/ 0.1%]    -0.4%|  1914.9 [ 1.3%/ 0.1%]    0.1% |
> |  8/8       3753.5     [ 0.3%/ 0.0%] |        3748.2   [ 0.3%/ 0.0%]    -0.1%|  3751.3 [ 0.4%/ 0.0%]   -0.1% |
> | 16/16      7139.3     [ 2.4%/ 0.2%] |        7137.9   [ 1.8%/ 0.2%]    -0.0%|  7049.2 [ 2.4%/ 0.2%]   -1.3% |
> | 32/32     10899.0     [ 4.2%/ 0.4%] |       10780.3   [ 4.4%/ 0.4%]    -1.1%| 10339.2 [ 9.6%/ 0.9%]   -5.1% |
> | 64/64     15086.1     [11.5%/ 1.2%] |       14262.0   [ 8.2%/ 0.8%]    -5.5%| 11168.7 [22.2%/ 1.7%]  -26.0% |
> |128/128    15371.9     [22.0%/ 2.2%] |       14675.8   [14.4%/ 1.4%]    -4.5%| 10963.9 [18.5%/ 1.4%]  -28.7% |
> |256/256    15990.8     [22.0%/ 2.2%] |       12227.9   [10.3%/ 1.0%]   -23.5%| 10469.9 [19.6%/ 1.7%]  -34.5% |
> '-------------------------------------------------------------------------------------------------------------'

Perfectly presented, thank you very much!

My final questin would be about the environment:

> Skylake server, 2 numa nodes, 104 CPUs (HT on)

Is the typical nr_running value the sum of 'NA+AVX', i.e. is it ~256 
threads for the 128/128 row for example - or is it 128 parallel tasks?

I.e. showing the approximate CPU thread-load figure column would be very 
useful too, where '50%' shows half-loaded, '100%' fully-loaded, '200%' 
over-saturated, etc. - for each row?

Thanks,

	Ingo
