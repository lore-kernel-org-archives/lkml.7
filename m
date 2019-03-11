Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C746C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA62147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dcva41yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCKVL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:11:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35309 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:11:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id z13so200486qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smMkHZ9JhQfb6/mQRtbcBe+zcweWT3OeKffPkYTaNks=;
        b=dcva41yz79DBmbxdi62q2hDd5KunjFFVwMtEIXhRo0y2Ob9tWcI9vUYahMLSc2agDD
         1hVJvgi6SbMGAEJn2gJnoB0nWZNwX2j2ZGvATle39540M+XyP4qwocsJZhcn6YUCTxsf
         xEis5Uz2pqJHVnokDUmexoOV/bVauBtGu8a30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=smMkHZ9JhQfb6/mQRtbcBe+zcweWT3OeKffPkYTaNks=;
        b=fkCx/6JwktGZdlBJo6WhUlt9hStTGpYMYN/tV19kOPIuFkDwUtLgpQ8f1TJXU0lIZ8
         S4PIrV8wWyZeKVZTsk8iuTqd64tFt9Ae5ffHRRufuq2XkBNcrZvvD36iljc7T1Z9ad/V
         32xmZpuMBDJkJccgLE5peebNXngxA5egNJkhX0Ib6GS8m+KDCpifV6xmn+7uWT5sFs+5
         xR95Gjpd7T6uf0qSscsn49KBmdrf10oMZcezAGPcsaJ9wcZJcMd3c1UPdFt9/+uUCqEh
         LetcCTEqx16A6DPDgJ1DI6he/4+K900IWjbSouEZC8FYq+UWphDf9EJllLUApfE0J4cr
         mwSg==
X-Gm-Message-State: APjAAAVIBOq+xhqw1gellQWykwKD0OrlIgUP+tMr1JSlv7QsJsSio6Q3
        LbMIZTZsjV/v6Im34CDh6leHQw==
X-Google-Smtp-Source: APXvYqxhPuKNd77/mnrTTLYNW5WlEYXalbibNjZXhCpLFMDWnTiPawwwmi+VCuY3bg9ERhA+zqSbJw==
X-Received: by 2002:a37:378f:: with SMTP id e137mr26822049qka.137.1552338687026;
        Mon, 11 Mar 2019 14:11:27 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id g82sm3841105qkb.34.2019.03.11.14.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:11:26 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:11:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311211125.GA127617@google.com>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311204626.GA3119@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:46:26PM -0700, Sultan Alsawaf wrote:
> On Mon, Mar 11, 2019 at 01:10:36PM -0700, Suren Baghdasaryan wrote:
> > The idea seems interesting although I need to think about this a bit
> > more. Killing processes based on failed page allocation might backfire
> > during transient spikes in memory usage.
> 
> This issue could be alleviated if tasks could be killed and have their pages
> reaped faster.

But the point is that a transient temporary memory spike should not be a
signal to kill _any_ process.  The reaction to kill shouldn't be so
spontaneous that unwanted tasks are killed because the system went into
panic mode. It should be averaged out which I believe is what PSI does.

thanks,

- Joel

