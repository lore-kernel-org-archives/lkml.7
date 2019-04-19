Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EC720869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555706031;
	bh=gvXAO1ZiKUsNEZWwNzjQWYssHn9pH4h+JtmmksH3MYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=irM7S4ABUDQJHKDgKvKFVt7fTuC1pde6muswYimBqOYvk+F04I9TNm107LSR9aNBK
	 uRgMZ/iBVrrr8O4nhjPNnw4oiL9322K794QF7+jxyNGc83SzP9a6/C3eVmBK/Hmkdy
	 2VfINemOBcK2pLnIVGZmmfLjUoAe/p5aFrXAx+K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfDSUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:33:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:33:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so1974247wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CztVWPrPdN+j8byarWsnydt1vkDd9oOjkG+ZP2s2Umo=;
        b=tWYSW2ZF9OyfjV+5W7Kp8jhxJjLW2hLw1R1KePjS2zlzw/xOYU8PDDJVHUf0SpjGf7
         IhsCea3m5vX7l3pB6//DfyxuwWeVU5cYLaSXRS0p/j4liC+Bgh25YybcehMrPI/WGV3l
         I7WnElSfguLHb5hyS1VM7JVT2d+Ca61L6oRDxBnk9lsGxT+hw9jeNky+VkxGxRLcIuBK
         oJYIp06xw/1j0M1MVq02ugwC+v9WmkO/LW5V7aBrmdMbVxszB4oFCkm+h+qvjNyNZO9e
         vllu5ayOrJcTO+SQbuDoPcnXNXumYeh88j345FrcQyh69rf7cadKoM+SMsUPlkaVOSgJ
         /fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CztVWPrPdN+j8byarWsnydt1vkDd9oOjkG+ZP2s2Umo=;
        b=TwE+Q9e7WpTMUjfPz/XlV7pW6lKi7mkxhjmaB+Yl3JiiiGDkRtwHpfityBENEtOrO4
         VUs2EGUIMjzXcvneVO7s+2tCq1M5ZCh2bsQPsRF6N0Ze3DsB/GmuoL+iZbYliKcXBISd
         EJuqCLGkEb3u+Sq7OJm3kCTd00TqrmeI6FwRT+bRADOdVCHPk+pVyI8DnO1gwIWUHEov
         M1N3ci4HX0bMnvJ1/7OnAXOorFjbuRrmDBEwKmrs60RAvdZfVF0DpM1G+VzTKoKebMWd
         rqkFRB03bwrWhFQBzaKzHXVcRjYVS77UcFe8mg5TwycGJ+z3+JxODLJRs32mLEEl//Pr
         5ngQ==
X-Gm-Message-State: APjAAAXOUtTZZfhnzldFBOzMUjBFwR5wX9nfoCbpS1jct7t31jqcCsJz
        QbgQpfYpefszIzJRVR0FNaVsS4T3
X-Google-Smtp-Source: APXvYqzOk3UCFyNkj+qEbE4GOjmLnBpdu1LhhI7FH3sBEsXrsMbM3EpSG8Q8tTSdVz9Dga2bs/edXg==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr1985463wru.104.1555663231647;
        Fri, 19 Apr 2019 01:40:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z140sm7296832wmc.27.2019.04.19.01.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:40:30 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:40:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190419084027.GA16074@gmail.com>
References: <20190218173514.667598558@infradead.org>
 <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
 <3514bb97-33bc-3a14-3f15-767682b2f035@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3514bb97-33bc-3a14-3f15-767682b2f035@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Subhra Mazumdar <subhra.mazumdar@oracle.com> wrote:

> I see similar improvement with this patch as removing the condition I
> earlier mentioned. So that's not needed. I also included the patch for the
> priority fix. For 2 DB instances, HT disabling stands at -22% for 32 users
> (from earlier emails).
> 
> 
> 1 DB instance
> 
> users  baseline   %idle    core_sched %idle
> 16     1          84       -4.9% 84
> 24     1          76       -6.7% 75
> 32     1          69       -2.4% 69
> 
> 2 DB instance
> 
> users  baseline   %idle    core_sched %idle
> 16     1          66       -19.5% 69
> 24     1          54       -9.8% 57
> 32     1          42       -27.2%        48

So HT disabling slows down the 2DB instance by -22%, while core-sched 
slows it down by -27.2%?

Would it be possible to see all the results in two larger tables (1 DB 
instance and 2 DB instance) so that we can compare the performance of the 
3 kernel variants with each other:

 - "vanilla +HT": Hyperthreading enabled,  vanilla scheduler
 - "vanilla -HT": Hyperthreading disabled, vanilla scheduler
 - "core_sched":  Hyperthreading enabled,  core-scheduling enabled

?

Thanks,

	Ingo
