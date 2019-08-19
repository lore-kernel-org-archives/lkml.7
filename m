Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C08C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241779;
	bh=o7tVJ6A0EFYrGOmxiCVqJd1Rms6vZpxqerY1m9I++AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XqILMWM+jlA5mHhgeXl5Ypj8XK14nac3zEDa16kJKqrJv0wE5ul/XJcRrvurk92I/
	 JMUqsHh1v2euxM9qylTfr2J+HzxpQfqpO8W9rcYHNPFpjaeuQX+6TOkPT76JadJaR3
	 BLqDHxi4SUGSyo0cNCEzoQl1GWOMcKj8JSWY5ykw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfHSTJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:09:38 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41620 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHSTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:09:37 -0400
Received: by mail-wr1-f48.google.com with SMTP id j16so9825350wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eqMhxBvQwya5TIVbKXUGGJGWLWVFO7AHliC0/UBpCtc=;
        b=UJD/sHRf30MtIsBs6GhLqK/i3ozJbg3JDELAXco4LWG7K3zjY0IYbUaOW5GX3WsFeH
         n60BO1cgeVqhDOuo8IBV0093gl/NhJz2LW7v32WJDfpe2n4LdmLdHVGtweuegCZKYj+l
         flX6pnBjB60T8Va51JzEgwb5tIUDdxNAarYvsPELuZjPFrMLnyFhQCcpoHcxxQy07EI6
         LM002Wrf9WZ/Y9qbDQRABFOIMpoPWUE5POXlKeZVxldzEp/mvj77gUzPryWiTWiFoDbC
         hhFSDfF9RNbrSpOz1wGDIFWpx45LpoHORC8Gf/C8EaCJqFVaHns8JyDPcItdxmCLveXf
         m4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eqMhxBvQwya5TIVbKXUGGJGWLWVFO7AHliC0/UBpCtc=;
        b=SL2t2U6jgTaOv7LdXED7fXdc5cFtLrWQPO9f+napbAXeBl0JnZN9vqNbwYoVJc3ilK
         h4W5C7XPU7EsphZwBwlby5OtEg11e+wOBWyYSlhZWPVB3jotSqTD3OmFZ2Utb4XFACuy
         e30BwPj5Yjxb/ZGjcUJZqhPUFXEKO7SGWI6RYwvUNFlOuSmw9phUJjGb7gm+yefW/Qit
         P9T3wTdc6Umvsp3M8U2XpkOC07zGfDcduNLvF9WxcB5/lMbdrKKl2HyjV4HmnLUzX4K2
         IC2x2aRRcOkY1FrLwSdqaKLDFLcnMMne7hzMmKRWiJ/2d1quQCAoaJBkh6avJbSUGhLM
         T/QA==
X-Gm-Message-State: APjAAAWh3LMHcw4IpAh+mhxwu2KRUcDmz8T2ctsPyYnE5K3rpUw1SjiP
        O4/mPm3hFY3snxr+AUwhhGg=
X-Google-Smtp-Source: APXvYqxRajgdFnowJC+Nv6c8bmW5f3GiFXy7dBrKTUjK6e1t9HgZfaAdj21VJFad6lh6b7F3FQwNeQ==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr29136969wrl.79.1566241775816;
        Mon, 19 Aug 2019 12:09:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e9sm14410971wrt.69.2019.08.19.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:09:35 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:09:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 44/44] posix-cpu-timers: Expire timers directly
Message-ID: <20190819190933.GB68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143805.605704599@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143805.605704599@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Moving the posix cpu timers from on list to another and then expiring them
> from the second list is avoiding to drop and reacquire sighand lock for
> each timer expiry, but on the other hand it's more complicated code and
> suboptimal for a small number of timers.

s/on list
 /one list

s/cpu timers
 /CPU timers

Thanks,

	Ingo
