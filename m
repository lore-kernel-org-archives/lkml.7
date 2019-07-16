Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FDC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9620659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfGPUSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:18:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:18:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so22273265wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thWKDiUOGXHrY2jgZy9GeU/jjhBGteD/4QV66t0vG1c=;
        b=dwCRIsk2Qylnyx8hBtqCQSzE5sO6MFO3OOXD0ka7br3ZJfplwdh2v5WzBNDYEIx0+T
         YG4dGn7CQTnjzLj3qvhAJcAdOeRWSA8GM5LpGKTBNXWms0HYFcavCU+Sotsewt8cCsuS
         Gb03BJvkPmVc6pPD2zPPPUZYa0mL3sOiGUlNa1xAto4sNE4eqENdwP1W7QJ8MjZUiHxj
         0p55Ml7S9yZJH5GwIYvZILw439fEB4lNR/jEt6PpVU0cqH02WyJwhq2Iv2NYavqIVAr1
         B9Q2ZUYQc+ieMRc9dH7sZcE8s3nyDUQHdEp2JA05JJUaKID5CNvKEEijlAEAJyQtgYml
         PXuw==
X-Gm-Message-State: APjAAAXpU5DLIXaKdNlxQIDiXBeGUdZpsZfu/jjKup1pBMTY+HjSaj3v
        JYwbQ4Y/SjUJdSwmGNag3a2WNQ==
X-Google-Smtp-Source: APXvYqxul5qMwgx1JzJ7rSlYWQMzOyLqUs6KoQnf/j8HHGaA2wGz/HpKFk+QZwt3RqRfOmPpWxMXpQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr35601974wrj.47.1563308282957;
        Tue, 16 Jul 2019 13:18:02 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host55-33-dynamic.11-87-r.retail.telecomitalia.it. [87.11.33.55])
        by smtp.gmail.com with ESMTPSA id v15sm21479013wrt.25.2019.07.16.13.18.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:18:02 -0700 (PDT)
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
To:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de> <20190716151040.04ef9122@torg>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e245e8ac-d55d-89c8-424a-432e0481cd2a@redhat.com>
Date:   Tue, 16 Jul 2019 22:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716151040.04ef9122@torg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2019 22:10, Clark Williams wrote:
> On Mon, 15 Jul 2019 17:04:03 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
>> Add a new entry to the preemption menu which enables the real-time support
>> for the kernel. The choice is only enabled when an architecture supports
>> it.
>>
>> It selects PREEMPT as the RT features depend on it. To achieve that the
>> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
>> well.
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Excited to see this Thomas. Now I can start planning to build from a single tree
> rather than an RT tree off to the side of RHEL :)
> 
> Acked-by: Clark Williams <williams@redhat.com>
> 

yeah! We (Red Hat) are committed with maintaining and testing the PREEMPT RT
mainstream in the long term. Including the development of more tests and formal
verification for it!

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
