Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6697C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D29E20640
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="P56awIi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfJJKlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:41:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33786 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfJJKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:41:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so6822847wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=hYbZOE1JoNz+RsgmurwkZwD0VCWNmaMUpSNgQ1K1b/4=;
        b=P56awIi5VWsNCv0+XM6VyL5UuQ8pBhLrXmLDWwFirV0xxfdcxG+F7R9HtG6FSMK0MZ
         5MIOS6T1xlSulDJYDM4gkAIr1H2rOFi9iO+C9+gN7TtUo3GKcuTIqm8n6jsrBQSZZNQ+
         vFJnLJ37QPix/eLtFAPUIYutSZcdNKcQAyjIZNsx3/JdDe7K4SgObZK2QeWw7nftGy05
         qPmzHWRfmrBc0VoltoX+rGTRwUz7k7oreGQ+2gPigGX+MzPwV2XLGH0gyTKsJF29BLQl
         HnP11IQozXnsMJjehZ9dO48DieTL96DeGepCua3puMhkieNjXRrM/xBCvvyVx+kfWM9J
         7fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=hYbZOE1JoNz+RsgmurwkZwD0VCWNmaMUpSNgQ1K1b/4=;
        b=hOf60B4R9ZvXGwZrOjJlOc/8KlBKxhuuamKUIPLLH82Z8/pBuCGW1mu02ZVrKEYAi+
         GvCoudHdMmCYeLDO7vCLqEQYNAxp3l3i1RfxqNqNo6ENjg6ew2p09s3meHSLCpvlXMIr
         hRpa0aSoNgMjn1vxLqyNVo7yMCrLbx7g5dqqVr2GDFODfdD543QKs7Yp2itq3JkhMWkD
         LZco1HPNwZwmRBn9h62bJrmxey7QK/X0Zm8wPeTx3zHRoB8CDHXOC47xlOTB/x+v8b/6
         McFhsyDnwA7YMyAqE9csyi+VS2i3ySifUsWQk+Me6oUTdoVZCTxacFEEEc8oWA6vTm01
         zb3w==
X-Gm-Message-State: APjAAAXtD3CYUtN1GqSHb7DL0GhbLWaJTagoU8WvghapxC2jfLo08Jf/
        whSII6S3Dac3QU953ZwpeHLg+Q==
X-Google-Smtp-Source: APXvYqyIIo4e4eoNC93zDtMTtTRULBHf81O36ZVITuHV+xgHDdcIMBdVB+cqpXsPZO5Dawn4Aimv/g==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr6473395wmc.24.1570704073234;
        Thu, 10 Oct 2019 03:41:13 -0700 (PDT)
Received: from linux.fritz.box ([2003:d9:9706:1400:7753:8680:b964:812d])
        by smtp.googlemail.com with ESMTPSA id n7sm5651847wrt.59.2019.10.10.03.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:41:12 -0700 (PDT)
To:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Subject: wake_q memory ordering
Message-ID: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
Date:   Thu, 10 Oct 2019 12:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Waiman Long noticed that the memory barriers in sem_lock() are not 
really documented, and while adding documentation, I ended up with one 
case where I'm not certain about the wake_q code:

Questions:
- Does smp_mb__before_atomic() + a (failed) cmpxchg_relaxed provide an
   ordering guarantee?
- Is it ok that wake_up_q just writes wake_q->next, shouldn't
   smp_store_acquire() be used? I.e.: guarantee that wake_up_process()
   happens after cmpxchg_relaxed(), assuming that a failed cmpxchg_relaxed
   provides any ordering.

Example:
- CPU2 never touches lock a. It is just an unrelated wake_q user that also
   wants to wake up task 1234.
- I've noticed already that smp_store_acquire() doesn't exist.
   So smp_store_mb() is required. But from semantical point of view, we 
would
   need an ACQUIRE: the wake_up_process() must happen after cmpxchg().
- May wake_up_q() rely on the spinlocks/memory barriers in try_to_wake_up,
   or should the function be safe by itself?

CPU1: /current=1234, inside do_semtimedop()/
         g_wakee = current;
         current->state = TASK_INTERRUPTIBLE;
         spin_unlock(a);

CPU2: / arbitrary kernel thread that uses wake_q /
                 wake_q_add(&unrelated_q, 1234);
                 wake_up_q(&unrelated_q);
                 <...ongoing>

CPU3: / do_semtimedop() + wake_up_sem_queue_prepare() /
                         spin_lock(a);
                         wake_q_add(,g_wakee);
                         < within wake_q_add() >:
                           smp_mb__before_atomic();
                           if (unlikely(cmpxchg_relaxed(&node->next, 
NULL, WAKE_Q_TAIL)))
                               return false; /* -> this happens */

CPU2:
                 <within wake_up_q>
                 1234->wake_q.next = NULL; <<<<<<<<< Ok? Is 
store_acquire() missing? >>>>>>>>>>>>
                 wake_up_process(1234);
                 < within wake_up_process/try_to_wake_up():
                     raw_spin_lock_irqsave()
                     smp_mb__after_spinlock()
                     if(1234->state = TASK_RUNNING) return;
                  >


rewritten:

start condition: A = 1; B = 0;

CPU1:
     B = 1;
     RELEASE, unlock LockX;

CPU2:
     lock LockX, ACQUIRE
     if (LOAD A == 1) return; /* using cmp_xchg_relaxed */

CPU2:
     A = 0;
     ACQUIRE, lock LockY
     smp_mb__after_spinlock();
     READ B

Question: is A = 1, B = 0 possible?

--

     Manfred

