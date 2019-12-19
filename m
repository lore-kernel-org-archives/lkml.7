Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D4C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE359206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BpYWgUdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLSQcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:32:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37408 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfLSQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:32:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so6289110wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSJhDs+idA5i15qY0cV5g4g/iFY0uQiRgrR8CPqPVSM=;
        b=BpYWgUdRl0eRXOIWAcU433Q43vwSWIlqGYUsv/yFhLn2mUs5YSJMn2aZXab2PwV3B4
         OULs1AAdt70Nxb7nGXYifJWKKv/p/azTb3IiL/CIudz8e3poW4d9EEJnevapQHDrY+2g
         60dqb97fKwdXYmh6+DoI/Z4/H+CMgNEZL8ZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSJhDs+idA5i15qY0cV5g4g/iFY0uQiRgrR8CPqPVSM=;
        b=eYnrQJK4XnOg+LMMk3eiVjIH5IYrP/VA/ge5QAM92sJRU8ofl948IdPezCx1N/Lggh
         zaHwEaKH7sUGBHPA5MfBlyZ5Iw56pFNzE4c+KCE+3SO11eEH5C4tNF+f9475PVjfcTYB
         ZN/617Q/TjG3IqV7ZXG5+aQOPZW1Dr+pJzns65U+m2M6DI6lI4U8FkNdvu/7RBKqQM63
         VUegio+OmWLdBnIKq7V1aY2/1xG+UuXG2KxArngGZMo6ybaW4RJ1up4FXiaK7+POa8ey
         EDxijY4KdD9LrzpfuisYP6W11RrXju9I+ODwA57TGvWuSyTvrfYk8R851dOkAo8Va+MR
         ZQWw==
X-Gm-Message-State: APjAAAUlgvOXxEvIWFLlQNar4aZdRyj+iqj9ygbFIWd4KC+7Aw1XY2BU
        pwPlhnP3PcB23YoHewBnWl4tPTrd0du192Nmy+OwJfUF8Gg=
X-Google-Smtp-Source: APXvYqwxWdg1BrVmDIVN4oLwnu28aYRPTQAChh10jcApQWJojYvRePOj7s8dQvmhClMuLhaFhTvv4w6m/euxO7vbkUQ=
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr10925795wmb.174.1576773139080;
 Thu, 19 Dec 2019 08:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20191216161650.21844-1-lukasz.luba@arm.com> <20191218120900.GA28599@bogus>
 <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
In-Reply-To: <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 19 Dec 2019 11:32:07 -0500
Message-ID: <CA+-6iNxn29WpUrbc9gL4EMTJfZj7FRCeO-_QaUqbjJYd1JAEKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I also see a stretch of over 100 (contiguous) of these
>
> ... scmi_rx_done: transfer_id=48321 msg_id=7 protocol_id=128 seq=0 msg_type=0
> ... scmi_rx_done: transfer_id=48322 msg_id=8 protocol_id=128 seq=0 msg_type=0
> ... scmi_rx_done: transfer_id=48323 msg_id=7 protocol_id=128 seq=0 msg_type=0
> ... scmi_rx_done: transfer_id=48324 msg_id=8 protocol_id=128 seq=0 msg_type=0
>
> which I cannot explain -- perhaps ftrace doesn't work well in interrupt context?

Hello,
Please ignore my previous results; I've switched to using 'nop' as the
current_tracer and the above issue has cleared up.  I now get traces
like below:

          <idle>-0     [000] d.h.   907.608763: scmi_rx_done:
transfer_id=10599 msg_id=7 protocol_id=128 seq=2 msg_type=0
       t1-sensor-1817  [003] ....   907.608879: scmi_xfer_begin:
transfer_id=10601 msg_id=6 protocol_id=21 seq=1 poll=0
         t0-brcm-1815  [000] d.h.   907.614133: scmi_rx_done:
transfer_id=10600 msg_id=7 protocol_id=20 seq=0 msg_type=0
         t0-brcm-1815  [000] ....   907.614189: scmi_xfer_end:
transfer_id=10599 msg_id=7 protocol_id=128 seq=2 status=0
         t0-brcm-1815  [000] ....   907.614215: scmi_xfer_begin:
transfer_id=10602 msg_id=8 protocol_id=128 seq=2 poll=0
          <idle>-0     [000] d.h.   907.616380: scmi_rx_done:
transfer_id=10601 msg_id=6 protocol_id=21 seq=1 msg_type=0
        t2-clock-1818  [003] ....   907.616418: scmi_xfer_end:
transfer_id=10600 msg_id=7 protocol_id=20 seq=0 status=0
        t2-clock-1818  [003] ....   907.616440: scmi_xfer_begin:
transfer_id=10603 msg_id=7 protocol_id=20 seq=0 poll=0
       t1-sensor-1817  [003] ....   907.616474: scmi_xfer_end:
transfer_id=10601 msg_id=6 protocol_id=21 seq=1 status=0
          <idle>-0     [000] d.h.   907.616478: scmi_rx_done:
transfer_id=10602 msg_id=8 protocol_id=128 seq=2 msg_type=0
         t0-brcm-1815  [000] d.h.   907.616526: scmi_rx_done:
transfer_id=10603 msg_id=7 protocol_id=20 seq=0 msg_type=0
         t0-brcm-1815  [000] ....   907.616559: scmi_xfer_end:
transfer_id=10602 msg_id=8 protocol_id=128 seq=2 status=0
         t0-brcm-1815  [000] .n..   907.616588: scmi_xfer_begin:
transfer_id=10604 msg_id=7 protocol_id=128 seq=1 poll=0
       t1-sensor-1817  [003] ....   907.616628: scmi_xfer_begin:
transfer_id=10605 msg_id=6 protocol_id=21 seq=2 poll=0
        t2-clock-1818  [003] ....   907.616660: scmi_xfer_end:
transfer_id=10603 msg_id=7 protocol_id=20 seq=0 status=0
          <idle>-0     [000] d.h.   907.616665: scmi_rx_done:
transfer_id=10604 msg_id=7 protocol_id=128 seq=1 msg_type=0
        t2-clock-1818  [003] ....   907.616673: scmi_xfer_begin:
transfer_id=10606 msg_id=7 protocol_id=20 seq=0 poll=0
         t0-brcm-1815  [000] d.h.   907.618782: scmi_rx_done:
transfer_id=10605 msg_id=6 protocol_id=21 seq=2 msg_type=0
       t1-sensor-1817  [003] ....   907.618829: scmi_xfer_end:
transfer_id=10605 msg_id=6 protocol_id=21 seq=2 status=0
         t0-brcm-1815  [000] dnH.   907.618834: scmi_rx_done:
transfer_id=10606 msg_id=7 protocol_id=20 seq=0 msg_type=0
         t0-brcm-1815  [000] .n..   907.618855: scmi_xfer_end:
transfer_id=10604 msg_id=7 protocol_id=128 seq=1 status=0
         t0-brcm-1815  [000] .n..   907.618873: scmi_xfer_begin:
transfer_id=10607 msg_id=8 protocol_id=128 seq=1 poll=0
        t2-clock-1818  [003] ....   907.618890: scmi_xfer_end:
transfer_id=10606 msg_id=7 protocol_id=20 seq=0 status=0
       rcu_sched-7     [000] d.h.   907.618898: scmi_rx_done:
transfer_id=10607 msg_id=8 protocol_id=128 seq=1 msg_type=0
         t0-brcm-1815  [000] ....   907.618934: scmi_xfer_end:
transfer_id=10607 msg_id=8 protocol_id=128 seq=1 status=0
         t3-brcm-1819  [003] ....   907.618958: scmi_xfer_begin:
transfer_id=10608 msg_id=7 protocol_id=128 seq=0 poll=0
          <idle>-0     [000] d.h.   907.618974: scmi_rx_done:
transfer_id=10608 msg_id=7 protocol_id=128 seq=0 msg_type=0
         t3-brcm-1819  [003] ....   907.619005: scmi_xfer_end:
transfer_id=10608 msg_id=7 protocol_id=128 seq=0 status=0
         t3-brcm-1819  [003] ....   907.619013: scmi_xfer_begin:
transfer_id=10609 msg_id=8 protocol_id=128 seq=0 poll=0

And with V2 having the added xfer id allows me to more easily post
process the above with a script and highlight messages that took too
long (round trip times > 3msec get a double asterisk):

     10585      0.02 ms  proto=128  cmd=8  seq=0
     10586      2.16 ms  proto= 21  cmd=6  seq=0
     10587      0.87 ms  proto=128  cmd=7  seq=1
     10588      0.02 ms  proto=128  cmd=8  seq=0
     10589      0.05 ms  proto=128  cmd=7  seq=0
     10590      2.15 ms  proto= 21  cmd=6  seq=1
     10591      2.19 ms  proto=128  cmd=8  seq=0
     10592      2.13 ms  proto= 21  cmd=6  seq=0
     10593      0.03 ms  proto=128  cmd=7  seq=0
     10594      0.02 ms  proto=128  cmd=8  seq=0
     10595      0.02 ms  proto=128  cmd=7  seq=0
     10596      0.02 ms  proto=128  cmd=8  seq=0
     10597  **  7.16 ms  proto= 20  cmd=7  seq=0
     10598  **  7.12 ms  proto= 21  cmd=6  seq=1
     10599  ** 11.58 ms  proto=128  cmd=7  seq=2
     10600  **  9.28 ms  proto= 20  cmd=7  seq=0
     10601  **  7.60 ms  proto= 21  cmd=6  seq=1
     10602      2.34 ms  proto=128  cmd=8  seq=2
     10603      0.22 ms  proto= 20  cmd=7  seq=0
     10604      2.27 ms  proto=128  cmd=7  seq=1
     10605      2.20 ms  proto= 21  cmd=6  seq=2

So I do find the extra msg id helpful as well as the extra traceprint.

Regards,
Jim Quinlan
