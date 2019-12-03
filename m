Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48369C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181C520803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuIo8VeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLCTPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:15:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39106 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:15:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so4386724oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=lafntJiNlmWCYo13nqKdB9qR0UEgFYTF/L3CIbqSaLY=;
        b=zuIo8VeP5UtQBdmdGgI9QzpnqoNFtNe+jshtpKx9yk5eBlA68LvToJO4mrDmojcaOO
         eT9ctB54w+PilvXt5C1Tw4lDlPkBBL3OnU7PH5u6NCn/+exPUvfxVjldm5rpSe1olWWk
         m9Lp7LYYsfFCyxaV8wL5dByh8cBGqzcGdReCVE4JX5eSy5TTe5yndRUCXcLKgXKBqOWj
         fkyCzToM8ycczAmW3vV8v7aV9Yl1c4Gga73gw6LtRqTznxfSLNYmu8G/hpZ54N9FATaa
         4bUvoA4nmJ+g1sJxRuXAXs1nYDx+FtEEkepi7lfb/9b21zFOGWaYBDalZwSnPuQ+NOmD
         8iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lafntJiNlmWCYo13nqKdB9qR0UEgFYTF/L3CIbqSaLY=;
        b=W2ZNjvK2uxxDeTw22gqO9hvtyWM94nI2GZgty6mrAgLWhUtJrWN+2WTXpW91QaYnzW
         TS2+I0V1PTUxvhb2mY8qEUl7PR4j45SgNHsSjGOTlXg15kJX1g6FiXYw/YfBt7/lXtMq
         IxPm6XlIS/KkTTojrqA7FuqfdkpXOLMsDSNUICF7KxPWCTJRx3cqRkg4LUKUxhFLopj4
         QFKaPAxd36/oTdI5h5VYsInK/AyxJU0trZEIuT/n2B7oLpCQOvxUEBW2eFJw3UNyi15W
         7EBfW9EsD+hSXzgqOzAFwOfMwIZVqncMFsXSRF5YN8aSeME2Rfv/pbArlIgysaRUCQuV
         E7sQ==
X-Gm-Message-State: APjAAAWjCSalVizmAGBkbCv/M2HGzO1ddY2KmS67V7HaxkfsGlYhM2pX
        E03ScdZ0Z2sUoStMsQeEOhnK4gD5cu4fY4+guKto9Q==
X-Google-Smtp-Source: APXvYqxRc6YpEOWsflaFLH/iefzshas5iiJ2Hm4M70Kyg/yBxw+aarRgl3j2vd/jp15O4CNmbHEu7xTkh0VmgUBQmoE=
X-Received: by 2002:aca:ab95:: with SMTP id u143mr5088256oie.128.1575400517743;
 Tue, 03 Dec 2019 11:15:17 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Dec 2019 11:15:07 -0800
Message-ID: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
Subject: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With today's linus/master on db845c running android, I'm able to
fairly easily reproduce the following crash. I've not had a chance to
bisect it yet, but I'm suspecting its connected to Vincent's recent
rework.

If you have any suggestions, or need me to test anything, please let me know.

thanks
-john

[  136.157069] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000010
[  136.165937] Mem abort info:
[  136.168765]   ESR = 0x96000005
[  136.171862]   EC = 0x25: DABT (current EL), IL = 32 bits
[  136.177229]   SET = 0, FnV = 0
[  136.180320]   EA = 0, S1PTW = 0
[  136.183502] Data abort info:
[  136.186426]   ISV = 0, ISS = 0x00000005
[  136.190302]   CM = 0, WnR = 0
[  136.193316] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000175f7e000
[  136.199814] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
[  136.206666] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  136.212295] Modules linked in:
[  136.215397] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
 5.4.0-mainline-11225-g9c5add21ff63 #1252
[  136.225390] Hardware name: Thundercomm Dragonboard 845c (DT)
[  136.231111] pstate: 60c00085 (nZCv daIf +PAN +UAO)
[  136.235971] pc : find_idlest_group.isra.95+0x368/0x690
[  136.241159] lr : find_idlest_group.isra.95+0x210/0x690
[  136.246347] sp : ffffffc01036b890
[  136.249708] x29: ffffffc01036b890 x28: ffffffe7d7450480
[  136.255077] x27: ffffff80f81f0000 x26: 0000000000000000
[  136.260445] x25: 0000000000000000 x24: ffffffc01036b998
[  136.265810] x23: ffffff80f8e40a00 x22: ffffffe7d7719e30
[  136.271175] x21: ffffff80f8f16520 x20: ffffff80f8f16180
[  136.276539] x19: ffffffe7d771a610 x18: ffffffe7d71d1ef0
[  136.281908] x17: 0000000000000000 x16: 0000000000000000
[  136.287274] x15: 0000000000000001 x14: 6f3a753d74786574
[  136.292644] x13: 6e6f637420383637 x12: 632c323135633a30
[  136.298007] x11: 0000000000000070 x10: 0000000000000002
[  136.303371] x9 : 0000000000000000 x8 : 0000000000000075
[  136.308737] x7 : ffffff80f8f16000 x6 : ffffffe7d7450000
[  136.314099] x5 : 0000000000000004 x4 : 0000000000000000
[  136.319465] x3 : 000000000000025c x2 : ffffff80f8f16780
[  136.324836] x1 : 0000000000000000 x0 : 0000000000000002
[  136.330198] Call trace:
[  136.332680]  find_idlest_group.isra.95+0x368/0x690
[  136.337528]  select_task_rq_fair+0x4e4/0xd88
[  136.341848]  try_to_wake_up+0x21c/0x7f8
[  136.345735]  default_wake_function+0x34/0x48
[  136.350053]  pollwake+0x98/0xc8
[  136.353233]  __wake_up_common+0x90/0x158
[  136.357202]  __wake_up_common_lock+0x88/0xd0
[  136.361519]  __wake_up_sync_key+0x40/0x50
[  136.365584]  sock_def_readable+0x44/0x78
[  136.369560]  __netlink_sendskb+0x44/0x58
[  136.373525]  netlink_unicast+0x220/0x258
[  136.377496]  kauditd_send_queue+0xa4/0x158
[  136.381643]  kauditd_thread+0xf4/0x248
[  136.385438]  kthread+0x130/0x138
[  136.388706]  ret_from_fork+0x10/0x1c
[  136.392332] Code: 54001340 7100081f 540016e1 a9478ba1 (f9400821)
[  136.398493] ---[ end trace 47d254973801b2c4 ]---
[  136.403162] Kernel panic - not syncing: Fatal exception
[  136.408445] SMP: stopping secondary CPUs
[  136.412440] Kernel Offset: 0x27c6200000 from 0xffffffc010000000
[  136.418417] PHYS_OFFSET: 0xffffffe140000000
[  136.422655] CPU features: 0x00002,2a80a218
