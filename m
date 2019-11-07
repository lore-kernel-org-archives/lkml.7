Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD8FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7836E2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R067KCbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfKGTmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:42:40 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36303 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfKGTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:42:40 -0500
Received: by mail-wr1-f52.google.com with SMTP id r10so4471490wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eHOwx0jzmH8mt6XjKcTSl/TXZSGE6ccgpSUgvl6Ivk=;
        b=R067KCblVySi1CTXlLvc+26w3wkMXR+xoYs1LRG5xJJZTsNK3Z8m1BGrBrcVR2THjp
         ELRpnmMdimzcPQQZb7+bPC3qQ6WyAWfhHbxxAFvHFj64u9UZK4dHuvCeKlJFnpv51eUu
         VLWz8zTI9dBGD7gYwLAmwisu/poa5xjX36xQTQTSdkZpC51l8gUAq2HF+9vkiGUlnvIc
         t+i/IMD7I9Pn/WXbCVLgNEwd2IQGBcu4iUQ/WTXmx+JZFsCChbVKWSX4cxaAE/66rWBj
         JD2l94ZfT17YLsn7I3hRUbi4qmo5svbYIQvz+XNwTy/m6n5pJGRf+tR8tvuM3H5OUje1
         X03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eHOwx0jzmH8mt6XjKcTSl/TXZSGE6ccgpSUgvl6Ivk=;
        b=m3iGfDRMQNN4lM/YSERlTwat8QqF+4tJM6ugY+vP4MKF2DSCOiG3tAnETTd4Kd0eRJ
         ha6pYj/2KxGT+ngzqtr6t5qr7gHofyKRiwxCepU0JwL5ctlN3zOERkaMJTRZW25kAHU1
         E3ELBG02tX8BQbxfTDXPYUZimyH+JQVUzLWT0VI+JFJa1xXRcqbbOpLDG2v+aQAtsNwr
         edRjtbebGkR6KEsKDKQBZDLMzLGIhOPo2h/gWQfYDfKDemQbwZvoTHmH83PP+SS/c0nS
         8/nEZG0rBq1oAZkhyDRMlOITe2Tq7KJHdRXRWZQx1KLUiOgLsssbVEoKHDoW2gK6fKPq
         VZaA==
X-Gm-Message-State: APjAAAUmgrQ9u/scpMefq+iFkQDj4t0r/xtpskGd/Bcfs7XPOSKNm6tF
        w6O1wUI/v2ZJP+2E7rY4Hs9teg==
X-Google-Smtp-Source: APXvYqy1XGuko3Jtc2M1JjxAD8FgmlCqXhPsumxqciRVSrgjBLlbuEhM0pgn3SGoNdFH+/CJq+iacg==
X-Received: by 2002:adf:e346:: with SMTP id n6mr4087345wrj.234.1573155756363;
        Thu, 07 Nov 2019 11:42:36 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id g184sm4332978wma.8.2019.11.07.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:42:35 -0800 (PST)
Date:   Thu, 7 Nov 2019 19:42:32 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107194232.GA58063@google.com>
References: <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192753.GA55494@google.com>
 <20191107193134.GJ3079@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107193134.GJ3079@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 20:31:34 (+0100), Peter Zijlstra wrote:
> Thing is, if we revert (and we might have to), we'll have to revert more
> than just the one patch due to that other (__pick_migrate_task) borkage
> that got reported today.

Fair enough, let's try an avoid reverting the world if possible ...
I'll give a go to your patch tomorrow first thing.

Cheers,
Quentin
