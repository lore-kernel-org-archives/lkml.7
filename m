Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CAA22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUkrIImt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfH2Axv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:53:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42047 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfH2Axv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:53:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so1774472qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFuLPSXOqYYRHIRfYMo/hniJ8qcR6icTtUaOh2ZH2tk=;
        b=OUkrIImth8Y21n3gknnlxegLREWPiorc58UwwYhsf6r7pfLY4bM/O6rQoEEFQhcxaa
         EcmvKHv5lcgISrScS5pcu96qbAJY+ZAapSg83rej52YWDYB+8pr0P52ZhRyuAWi0XrhN
         h+bEpUd1S9Z1MW6qjnb38PgO6LjNWr8xsxAzDdYuqTncfUqgTLI8BSd003Lr+QYwHhbN
         rzxE7VCUXzrKJ5b7qN2DtJzrA8nyIaAXPitt35vb2XKW/qnJYUM3MfCVSACO1kuH9gKt
         n5R4BiEIzv8LIKDNpqekcc+3tv+dsMegwn1padid7BOaZx/nJPq73r/vlVdlro50v1hn
         ukDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iFuLPSXOqYYRHIRfYMo/hniJ8qcR6icTtUaOh2ZH2tk=;
        b=A5lgjJeAsQ80O8qARf2NZ+jBDhNLHC/YhSzxfHA/gpJf7dkBXiD5Il09vFDaBqJDt4
         C9bxNh7k6F3UntrHktYGjhZVzbpDYNz9O/KEcoC4ychyckhx9L2AGEijyYP5CvMRjicb
         7LoJR6Papwgl0eIPyuiF+gm6txnYOpp5xXfWtfZpKOAAWZK/NlUr+yIhDI7SPxhIoxtk
         VTxGEWvM56JtEEoymBQm7KSTqjoNi8nrYh/BL14vpLoM3Rp80vq7a+jE5o7ZQdTN/N9C
         FiMrQ1+MTHlLWNfUXz3ug/CJUNeEDGrPz4YnNgwdd0/Wvs4uHn8rN3YYdhxUtyz4RjMS
         CgOg==
X-Gm-Message-State: APjAAAXTRjVYju4kCNzHWd6NvKuw2S53ElySL/IWB2hXptQLOd95bmJD
        LdxLBVP00uQdO1MN+A51tUk=
X-Google-Smtp-Source: APXvYqwJro8XTnUrId6jjfeNj7asUDs+MQZQXg2NlfxkSe+duV+wG6jXLAi/q6QbsXbL9ZQvSaN0yg==
X-Received: by 2002:ac8:269a:: with SMTP id 26mr7648569qto.186.1567040029952;
        Wed, 28 Aug 2019 17:53:49 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::105f? ([2620:10d:c091:480::b715])
        by smtp.gmail.com with ESMTPSA id q6sm416192qtr.23.2019.08.28.17.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 17:53:49 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH 0/1] Fix race in ipmi timer cleanup
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, kernel-team@fb.com
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
 <20190828223238.GB3294@t560>
Openpgp: preference=signencrypt
Autocrypt: addr=Jes.Sorensen@gmail.com; keydata=
 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 WQ==
Message-ID: <15517bfc-3022-509d-15ea-c2b8e7a91e0a@gmail.com>
Date:   Wed, 28 Aug 2019 20:53:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828223238.GB3294@t560>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 6:32 PM, Corey Minyard wrote:
> On Wed, Aug 28, 2019 at 04:36:24PM -0400, Jes Sorensen wrote:
>> From: Jes Sorensen <jsorensen@fb.com>
>>
>> I came across this in 4.16, but I believe the bug is still present
>> in current 5.x, even if it is less likely to trigger.
>>
>> Basially stop_timer_and_thread() only calls del_timer_sync() if
>> timer_running == true. However smi_mod_timer enables the timer before
>> setting timer_running = true.
> 
> All the modifications/checks for timer_running should be done under
> the si_lock.  It looks like a lock is missing in shutdown_smi(),
> probably starting before setting interrupt_disabled to true and
> after stop_timer_and_thread.  I think that is the right fix for
> this problem.

Hi Corey,

I agree a spin lock could deal with this specific issue too, but calling
del_timer_sync() is safe to call on an already disabled timer. The whole
flagging of timer_running really doesn't make much sense in the first
place either.

As for interrupt_disabled that is even worse. There's multiple places in
the code where interrupt_disabled is checked, some of them are not
protected by a spin lock, including shutdown_smi() where you have this
sequence:

        while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)){
                poll(smi_info);
                schedule_timeout_uninterruptible(1);
        }
        if (smi_info->handlers)
                disable_si_irq(smi_info);
        while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)){
                poll(smi_info);
                schedule_timeout_uninterruptible(1);
        }

In this case you'll have to drop and retake the long several times.

You also have this call sequence which leads to disable_si_irq() which
checks interrupt_disabled:

  flush_messages()
    smi_event_handler()
      handle_transaction_done()
        handle_flags()
          alloc_msg_handle_irq()
            disable_si_irq()

{disable,enable}_si_irq() themselves are racy:

static inline bool disable_si_irq(struct smi_info *smi_info)
{
        if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
                smi_info->interrupt_disabled = true;

Basically interrupt_disabled need to be atomic here to have any value,
unless you ensure to have a spin lock around every access to it.

Cheers,
Jes
