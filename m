Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43FC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E98C2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMpsHV9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfGZD0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:26:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33886 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGZD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:26:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so17819876pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfhbltO6FtqY+nhX3A4c4C7VpTkM+5+6ovBigThYvB0=;
        b=mMpsHV9ElNPYpaobsGlXivKLT7vbB0JAEpP7GYdEvTMn910AvbCidJ3JVjpj7Zt5xO
         NEOiwgKk5owsCRQ7JkP48WP0iwfQ2o6QqoIaqaz1po699V1Y9BXGHQuhLc/DUx5rra87
         0g3MLd0ArNNknkZsiNP+WkvbwMvBPl8CQTPN+jMd32AG50a3q9CehG1Jm/i+x4+pMVNL
         OJHm7YoiI9V3/xFI7qakp9Fup0NPV7AX3zRuGEfnnOLSZdQ+13e45e4i/f6C4NBIrn89
         t8HdpdLCqdmV7DzVH/uD++SKlZZ985zB/po5Nwnm5fMAGO4MKGuhjMzRoFJLL9HgF91v
         ShXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfhbltO6FtqY+nhX3A4c4C7VpTkM+5+6ovBigThYvB0=;
        b=Q3Xr/PZORVoP2MZGKPIQaW8ws2XDt1rafaWpxhJfZWob6yEOKC3r1vt3b/A3j5XTq/
         0nzGRCIzhtDLGtoFeVICQ5Rd++5voUIAQQ8K/8L+TB4l4IdbeCZGDdKbMq9n0lofb5hf
         yyiMViAVgP/7b3aa7fha/cIdM4m3wl78NZmMwG1O72DQijjlRYhDxzwERDG+QSzQ4Nvw
         zyUnfXdkopGucXsWuxV+ed1MfIb8F0j286U9xSXr0s4SHp1mbIfeKlWdscFltHKWRsES
         1I6CftnrhFAvoO1+SQdr/N0XlupmSDcwJarn3P8rZpj6fqSCdXW4K1V2yYpxk2Es3miv
         bmRw==
X-Gm-Message-State: APjAAAUMDlZHmhMbyaeRuGNKw8XKLk4wPcLYwYXe8+4CO9jnZQPOKD/d
        qV/2/iKqoMcPlIHF+5c39D3F5Q==
X-Google-Smtp-Source: APXvYqxTg6RaVRHtF9c9R4BCNa8UgHa7F5aWitP9SzEaN+tdcNZSH3RKI8L0lLXVfubPFM9Nx2djIA==
X-Received: by 2002:a63:de07:: with SMTP id f7mr51786968pgg.213.1564111593449;
        Thu, 25 Jul 2019 20:26:33 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id y12sm59772600pfn.187.2019.07.25.20.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:26:32 -0700 (PDT)
Date:   Fri, 26 Jul 2019 08:56:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Rafael Wysocki' <rjw@rjwysocki.net>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Joel Fernandes' <joel@joelfernandes.org>,
        "'v4 . 18+'" <stable@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Don't skip freq update when limits
 change
Message-ID: <20190726032631.rflrl5wxgbphqxyf@vireshk-i7>
References: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
 <8091ef83f264feb2feaa827fbeefe08348bcd05d.1563778071.git.viresh.kumar@linaro.org>
 <001201d54125$a6a82350$f3f869f0$@net>
 <20190723091551.nchopfpqlmdmzvge@vireshk-i7>
 <CAJZ5v0ji+ksapJ4kc2m5UM_O+AShAvJWmYhTQHiXiHnpTq+xRg@mail.gmail.com>
 <20190724114327.apmx35c7a4tv3qt5@vireshk-i7>
 <000c01d542fc$703ff850$50bfe8f0$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c01d542fc$703ff850$50bfe8f0$@net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 08:20, Doug Smythies wrote:
> I tried the patch ("patch2"). It did not fix the issue.
> 
> To summarize, all kernel 5.2 based, all intel_cpufreq driver and schedutil governor:
> 
> Test: Does a busy system respond to maximum CPU clock frequency reduction?
> 
> stock, unaltered: No.
> revert ecd2884291261e3fddbc7651ee11a20d596bb514: Yes
> viresh patch: No.
> fast_switch edit: No.

You tried this fast-switch thing with my patch applied, right ?

> viresh patch2: No.
> 
> References (and procedures used):
> https://marc.info/?l=linux-pm&m=156346478429147&w=2
> https://marc.info/?l=linux-kernel&m=156343125319461&w=2
> 
> ... Doug
> 

-- 
viresh
