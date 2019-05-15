Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7CCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1C320873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557938335;
	bh=hPbnBRH7kCZPz8f4gdgt2sAJzOxSJsIZRVM5Dcf+dPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EIjvxslYhrpKVzRCS8WpLd4m1Zhxci4tCg6tadI452PHKuJdppX74Zea7OJV6hTmn
	 9stepYpc7h13bruRfXc8jJOZ8gfonQFtDjQcd6He8XTE0JHpO5j8XQC83yhbUUuBgg
	 GjIiRVcOlE1XcMU9Yuq/Qz7G8MxVNajmgkqbTPgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEOQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:38:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfEOQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:38:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so233736wrl.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmoLstyrX5SLQdrmaaUilBAAKw4Z3IDgWuQj6+HHIVY=;
        b=ZXyt0aHoEfKMngybDczX4LgXjJilHaAVBehq7iHLI928LMJg/Mo77t7RhH+Fid7fz+
         70iEi/Xh6B7Psrr012PZodaXIKwhO4+VLZOIay02nK6g+h+L4RlET/AdPWht/v8MqwOX
         G6ps+DzJ7ZfzT0AKamM44t2rVTAmWNp20XKX2NPpyGIR06KQY3vdapfgkoD1f8AZlNw0
         gPPpCxqxNE4vZgLdg3hbyuvWqTUmHQyawOOZ2sGA+i894ecOoTanWpQI6yCyjH7qundY
         zd6jjzGfQYj4tGWRC3X9QyToU7E2edZ+dG4kbVX10jSc6deTnnpkLgikU6vjEzF9LM1n
         6s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmoLstyrX5SLQdrmaaUilBAAKw4Z3IDgWuQj6+HHIVY=;
        b=jDFdmAvaw3fx3B0t05VH0vYq/MO6IKD65PGsQnyOnscrp4dyISpCd2afJ69rfGOmzv
         dETYVf3blXkoyezyQH8Us1VQ0mMCKlhSXw7MGi33JnWqPuGn6JjIWgzOkH5GjRsIXgNH
         np6lEOy2S6xgF/o1Uc40KcOMrXImfwXSUczQRj/NpdrtZuUxujBghXNbpLzYVJpB7P5c
         ycJ876B3ZYRTp9MdYBOR0StFB+aQMXx2hZXwaZ/8J2OVIjcQKEXXxBJ25396bwIQfKLZ
         SZwtZaJ53dXAMma3NoSCd8UuYx79RzcCtb/Pv4of+xDEM1oYah52+iotPZyXpIYNkhax
         SaMQ==
X-Gm-Message-State: APjAAAUFyfpWGTTl6zNZ8zjE/dN8PMyoAdBA19bBFkMXTkOU69A4RfPV
        3wJiNqDfsRYP8Mf5WjFML9Y=
X-Google-Smtp-Source: APXvYqz16kMv4hY39Cf4p4dbnSUODS9PBEbZYArD1wcwlAcKSfAqHGoeqXG5pioReqFm0K4Q6ytdYA==
X-Received: by 2002:adf:d089:: with SMTP id y9mr9381599wrh.239.1557938332532;
        Wed, 15 May 2019 09:38:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c9sm1516008wrv.62.2019.05.15.09.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:38:51 -0700 (PDT)
Date:   Wed, 15 May 2019 18:38:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/19] v6 multi-die/package topology support
Message-ID: <20190515163849.GB94029@gmail.com>
References: <20190513175903.8735-1-lenb@kernel.org>
 <20190515085551.GB2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515085551.GB2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, May 13, 2019 at 01:58:44PM -0400, Len Brown wrote:
> > 
> > This patch series does 4 things.
> > 
> > 1. Parse the new CPUID.1F leaf to discover multi-die/package topology
> > 
> > 2. Export multi-die topology inside the kernel
> > 
> > 3. Update 4 places (coretemp, pkgtemp, rapl, perf) that that need to know
> >    the difference between die and package-scope MSR.
> > 
> > 4. Export multi-die topology to user-space via sysfs
> > 
> > These changes should have no impact on cache topology,
> > NUMA topology, Linux scheduler, or system performance.
> > 
> > These topology changes primarily impact parts of the kernel
> > and some applications that care about package MSR scope.
> > Also, some software is licensed per package, and other tools,
> > such as benchmark reporting software sometimes cares about packages.
> 
> I still think having a 'rapl package' be a 'die' is weird, but if that's
> the way it is specified in the SDM then so be it.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter, I'll queue it up in the next couple of days, for a 
tentative v5.3 merge.

Thanks,

	Ingo
