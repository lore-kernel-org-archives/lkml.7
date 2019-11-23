Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80437C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507B420706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEVyuMkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKWWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:51:23 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:42251 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 17:51:22 -0500
Received: by mail-qv1-f48.google.com with SMTP id n4so4301221qvq.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 14:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=wuiPMRNrRwaQ1aS4bYGPjb43ErPc7woAZVokEZ9BSB8=;
        b=aEVyuMkm/fOcLQPaCwfQuUt0YB846pz0iDaHQysehKFs5BxNvO2CKkxUKz4sEAEE3D
         7kh1D/bf1Hv/PKHyWc0Arzsbz1OFBF69zC0LNwqJxnKcXSaJutkowII3uMUFxBNef1fO
         xUY3XfM7NkCpjwaXhxuj/dHR4Le+A34jwnjWy8sftvma8uWzJdV6S4SYESr4KyIQQaHe
         RSQyHIvWuWI8etTvpfpsVyU+mPRhaOzCnkwhm/Ke7gr0jY4U2RtFiY1Vqc3eTn23BF03
         FU42CQST/oNyiyBa8ZxQ/fb0cS8z54D8puslu7mWyLotmyfVMcIUKGd6ilpi75jqexue
         NzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=wuiPMRNrRwaQ1aS4bYGPjb43ErPc7woAZVokEZ9BSB8=;
        b=F2W1q16BRHLizhRi3XnbmXrp8yEkc861w7rAIWC6eBEWisCj0GkkU3+qQgAlYVQ16k
         yt3bFmC/Zp2IaALpNq1F3BlO4LX5PB1ZhErDXiCB0jjLFwnFE5hOB63bPSEBVwKxf4+h
         Q+X1AE4GL8gt/JXpdzDOigHRsJQvMc+R18aYu0hS+qL0biMI0Pz7BzUtJHzmqQH8xpW6
         8npa2D1BM/NvdMg0F9RT0vbo2TERV1VXe0q3brTuMRTMAp7iA1FAtHnbph4uXN4wfVQP
         sm4eodPQQ3gHBIHZmkP93ctJaAsuTDRy2jl35tSO0LvstL6tsmo7DNuUoeknOjZq6h90
         6rRw==
X-Gm-Message-State: APjAAAXk3Vq7UGvPfoRQa/ye0wBNTQKMNPCc2QVPBMQmvdULQ996crq/
        HBfIveyEteI1ar7Yaim20//ChD0=
X-Google-Smtp-Source: APXvYqwkUmWPXLa8utJ0HLqXUEksmht/jN2nI6QIDmey0fjVatMroS8Z4SyYkVeUA+OOmHcLWYtBKw==
X-Received: by 2002:ad4:4a90:: with SMTP id h16mr4579679qvx.28.1574549481737;
        Sat, 23 Nov 2019 14:51:21 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id q14sm988220qke.16.2019.11.23.14.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 14:51:21 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Subject: kernel 5.2+: suspend freeze in VMware Player.
Message-ID: <bc51bc4e-21e5-d6a9-22ee-7c1194deefc8@gmail.com>
Date:   Sat, 23 Nov 2019 17:51:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael, Thomas, this is the same VMware Player 15.2 freeze on suspend issue
I have been discussing with you in August.

It has surfaced after Thomas Gleixner's change in kernel 5.2
dfe0cf8b  x86/ioapic: Implement irq_get irqchip_state() callback

It is still with us in 5.4, 100% repeatable on a second suspend after a 
reboot.

I have traced it down to the ioapic_irq_get_chip_state() function, where
rentry.rr is stuck hi.

On the first suspend I can see that for IRQ9 the test exits with irr=0,
trigger=1, but on second and consecutive suspends it is returning
irr=1 trigger=1, so *state=1, and this results in a never-ending loop
in __synchronize_hardirq(), because inprogress is always 1.

I have been usig a "fix" to timeout in __synchronize_hardirq() after
64 iterations, and that seems to work OK (no side-effects noticed),
but of course is not addressing the underlying problem.

And the problem may be somewhere in VMware emulation code, returning bad 
data?

Would you have ideas as to what should be the right setting for
IRQ9 in VM environment?  Edge or level?
And which part of code is reading the "hardware" state from VMware?

OTOH, current implementation is not really safe, as the wait loop should 
have
a timeout, or else it may get stuck. Should I provide my safety-exit patch?

Thanks, Woody

