Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CDAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpxBYcmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCBP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 10:27:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40977 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfCBP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 10:27:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so375436pfn.8;
        Sat, 02 Mar 2019 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9X2bvxWQfOlwPcF7U6F8svb7TpoV3qGph+U/ksiNDQ=;
        b=tpxBYcmE5K4RBTlqcv0YtbBcbiEVzYPFVpI50/JvtTyp0lkoL+Uf1KAR+nmYDLAxJZ
         9nPSqmgH/Ef76os3lsrlGn061/Xu24zs+JljyMSwq8sSOfYDFXKaZdV+rwUio1PJEbNo
         mmJsXa6qur3y8OJwf5Rnhd/UYaFKHPR9Pw5ZVmS3lKMUmTD0yJfkJrtPuB5ZrUm9Xv5a
         M0Z+WLbHB2pymWnHh/trpmsgGOnn13iBEUdVEpOJccv1VZA3pjnXqlTrUavjg/91XVra
         jACXy/CJtIxEkjXbis0Sz0A3iQtZpFQhnB3C5ygl/zR3z0UHLDgwsbUdENZRvb4FXPH5
         pb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9X2bvxWQfOlwPcF7U6F8svb7TpoV3qGph+U/ksiNDQ=;
        b=qfkk182UC7VXQ0JqmMvGNYe9UghT/eAJGPmeUpIkki/i6+JIur0ttjapII6CI4+v3R
         m03TYuSevIMuLl6Bo/X2aBrEwLm4XNMWwu1q9ZeyXp5A6t3iMvFgtoghpBbkCYGoeLET
         nYWADJYUpvVCAm/g59ELqYiD+0BR2oUE7mw9QUXFY0mxPdyqXpHF8+nAITuZ74yzS53r
         wyJz/Kvx4xL4qXw8MYZxEkZqqFNq/rzTdXURNQaC0M6VnJAxPrjk8vAEPBzjks7rxlFM
         JuYVi5kAyD75yBHOqLVc4m8vSZHnMmRW75EnAmwDM4v3hU+Eah0H2bWSPoEHBrdVB4oZ
         yCEw==
X-Gm-Message-State: APjAAAV+hYXeIBudTecLouknWlEe2YIH1Iiw9tU7rdIW252zevfYuTv7
        Ze8Q3+cX/fQOMXyc/Hu6tQE=
X-Google-Smtp-Source: APXvYqxRiBsHZhQA+7QeKJsGa+sMNDoqrhs7iR+MrCl120arcwjdSJFbTZhBpnEA7TibAWjHJmeLgg==
X-Received: by 2002:a63:3541:: with SMTP id c62mr10052935pga.157.1551540441998;
        Sat, 02 Mar 2019 07:27:21 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n1sm3089271pfi.123.2019.03.02.07.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 07:27:21 -0800 (PST)
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
References: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8fbdcdc0-1f4e-e268-c183-0d65be3d39c9@gmail.com>
Date:   Sun, 3 Mar 2019 00:27:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Tue, 26 Feb 2019 14:49:06 +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
>>> still broken.
>>
>> As requested on IRC:
> 
> What I asked was if you could get your GCC developer friends to have a
> look at this :-)
> 

JFYI, there is a bugzilla ticket regarding this behavior of GCC
at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61502,
which started on 13 June 2014 and the latest entry was on
02 Feb 2019.

        Thanks, Akira


