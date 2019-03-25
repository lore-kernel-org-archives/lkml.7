Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62641C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BE22087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfCYP1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:27:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCYP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:27:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so6627380pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 08:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQZNWMsZ7MNEncN0KhM7lNVyt8he1JNxzaudZCSqSr0=;
        b=KWl6P95QRinAOlWMoR4OKUHvVkf3BCh2/qd2279Jej9fr/q9N2HrrVnWKU5GcdUz3u
         YBUsHDJQRr3XEQSpKNeCme3Cj+Js4Gg3YjFYDBYvl8KoPnYI7DYDlAe/e4Ml00uw7IWS
         f7EldGE2wzX1dbzO9pUEUcUmai4jjAZKlkEKkD73ppt5wCkJSuC2NhcjzomiIQS255nk
         BSUbJ7bW/hjtJxBxucj4+vX0TfAz2OiHKEUbnzWvtxWaaGSqJfM8jCAAsCW3PPAyiXjQ
         V+wKVrrNcfs+GiLysQglh1isIjJy1h2JSYtOrExIuUfHOYc8WBkNGDtcIayJjqa0E69R
         W5xA==
X-Gm-Message-State: APjAAAWJb1XecqG+tQGk+XpyeHWAp91bSRpKZE5Om7tX2uUjTn+nl27D
        dmsNOH0Fq2v+/pV9WV/3AObNnXQA
X-Google-Smtp-Source: APXvYqydwDtGKEfovUre9Iy/X/FqBlOvQfOGGWOPXb+ryMzBmIrnIr6kAN6VVe21zHigurcy8BZOMg==
X-Received: by 2002:a65:430a:: with SMTP id j10mr6746725pgq.143.1553527623490;
        Mon, 25 Mar 2019 08:27:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h65sm18342356pfd.108.2019.03.25.08.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 08:27:02 -0700 (PDT)
Message-ID: <1553527621.118779.2.camel@acm.org>
Subject: Re: "cat /proc/lockdep" after "rmmod <some module>" when
 !debug_locks will crash the system
From:   Bart Van Assche <bvanassche@acm.org>
To:     shenghui <shhuiw@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 08:27:01 -0700
In-Reply-To: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 17:45 +-0800, shenghui wrote:
+AD4 Sorry to trouble you.
+AD4 
+AD4 I installed virtualbox-5.2.24 on my system (x86 32) and on bootup I got some warning:
+AD4 ---------------------
+AD4 1251 +AFs   42.640869+AF0 DEBUG+AF8-LOCKS+AF8-WARN+AF8-ON(+ACE-current-+AD4-hardirqs+AF8-enabled)
+AD4 1252 +AFs   42.640880+AF0 WARNING: CPU: 0 PID: 841 at kernel/locking/lockdep.c:4132 check+AF8-flags.part.45+-0x9e/0x190
+AD4 ...
+AD4 
+AD4 As no crash afterwards, I just ignore the warning and continue using my system.
+AD4 
+AD4 Later I rmmod some module and run +ACI-cat /proc/lockdep+ACI, the system crashed. 
+AD4 (Sorry I cannot capture the crash log as kdump didn't work on my system, but I can 
+AD4 see some words +ACI...normal kernel read fault...+ACI)
+AD4 
+AD4 
+AD4 Then I walked through the code and found:
+AD4 1) DEBUG+AF8-LOCKS+AF8-WARN+AF8-ON(+ACE-current-+AD4-hardirqs+AF8-enabled) will turn debug+AF8-locks to 0
+AD4 2) if +ACE-debug+AF8-locks, graph+AF8-lock() will return 0
+AD4 3) On module unloading, lockdep+AF8-free+AF8-key+AF8-range+AF8-reg() will run.
+AD4    But when +ACE-debug+AF8-locks, lockdep+AF8-free+AF8-key+AF8-range+AF8-reg() will do nothing.
+AD4 
+AD4 4743 static void lockdep+AF8-free+AF8-key+AF8-range+AF8-reg(void +ACo-start, unsigned long size)
+AD4 4744 +AHs
+AD4 ...
+AD4 4751     raw+AF8-local+AF8-irq+AF8-save(flags)+ADs
+AD4 4752     locked +AD0 graph+AF8-lock()+ADs
+AD4 4753     if (+ACE-locked)
+AD4 4754         goto out+AF8-irq+ADs
+AD4 ...
+AD4 4759 
+AD4 4760     graph+AF8-unlock()+ADs
+AD4 4761 out+AF8-irq:
+AD4 4762     raw+AF8-local+AF8-irq+AF8-restore(flags)+ADs
+AD4 
+AD4 4) The result is: module is unloaded, but some lock+AF8-class related with the module
+AD4    still exist in all+AF8-lock+AF8-classes.
+AD4 5) 'cat /proc/lockdep' will access elements of all+AF8-lock+AF8-classes, and will trigger the crash.
+AD4 
+AD4 
+AD4 Seems the usage of +ACIAIQ-graph+AF8-lock()+ACI can prevent any new changes to all+AF8-lock+AF8-classes and other hashtables
+AD4 if +ACE-debug+AF8-locks.

Hi Shenghui,

None of the rmmod / cat /proc/lockdep tests I ran triggered the above warning.
It would help if you could share the steps you followed to trigger that warning.

Thanks,

Bart.
