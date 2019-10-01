Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8FECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B13A21D7B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aAazoFhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfJALWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:22:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33287 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbfJALWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:22:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so10825150qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=578rfGpVaJDuxC7snTS+bLfPo9Z4aZMc584mEk6xZzI=;
        b=aAazoFhEBUkb7a6kc6EBK5vZNyU/QPd7g1wPK851hNd9PXll71/QWjYAgy++c1NDZ7
         5DF+2K3uojCL8x1eHMPNexjaGyTSquSVzkmG0O6tCQHxOEQZb1zR1CE9D2vpN7ajtqEJ
         2EJOir37LtuYm6D3yZKn7RT0D6nz3+tg6GoXQz0MOztWr/xV06lYFIfkcO22NKcZNhXI
         MEq2ZrK8HJoIKwMyebM7MZItqpvd2oFTSxv8whGeqHp57RUexNp7ti8i7R81djfx0cgd
         OWYRHf7v5lYl5Lxt7QoG+0yYpwfU5Moy8VIby2CsVYpz9Tzdj+xnbCAFnFWdpacdyD8Y
         lVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=578rfGpVaJDuxC7snTS+bLfPo9Z4aZMc584mEk6xZzI=;
        b=f7KBn4GZove3TTPop5xsquASQz20hQ4tiaYYd85UQ0RqbjisZ6rayBAHzlJuCaOzD9
         pBiEugCUZwbsQZk4gvmPVbFHApup5str7LqFIhIaIB9++R6Q7Xan+1HORvM4gUt76ooi
         vCziP/ORNj21nWuJ2NSoQSoLBWlSyDwKIfb1judTqUKlYconxemmisL3wkiuaPba8F6n
         p05yXfHOyTBridAmZrCwJtHAwlojxBv4UFCmQ9MhJLiMHmxqpKlAzilpGHaKIpsMiT2f
         j9pHh3bje7/+Ai8jBG8p3oCPRQ+RnoH0RDVsh//jSFVFvI7VlMc4v5gElAq91b46zVZb
         Q2vw==
X-Gm-Message-State: APjAAAXNL5kXr++o/OX9tmT0SpNr22R4QTkb5TWMGgBntSP4QAxqUxht
        PacAUsXFzGpWS/qIWe6JveXmv78jwLyQLg==
X-Google-Smtp-Source: APXvYqzxrY7nn7ntisLcAagwMn1bJEGRlpPNksCY18M6m16px0m+JLCH0gfU5Jzkh9Y+W0+6TUiKhQ==
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr5444834qki.258.1569928957812;
        Tue, 01 Oct 2019 04:22:37 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 22sm7619884qkj.0.2019.10.01.04.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:22:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
Date:   Tue, 1 Oct 2019 07:22:36 -0400
Message-Id: <AA43245E-9049-49DB-A961-1AFC4A47F68D@lca.pw>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
In-Reply-To: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 1, 2019, at 5:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Does the below adequately describe the situation?

Yes, looks fine.
