Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B63C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B0120717
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxoE+Uh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfLQNYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:24:24 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43037 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:24:24 -0500
Received: by mail-pf1-f170.google.com with SMTP id h14so5650947pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HBXv6Gs3P+0i/KNOn2YdFsnpMYPur7Aw9mvLprhquV8=;
        b=XxoE+Uh0AjAd3pbtS2StGPWsJjFRNkJyeJ3RKselW4QJcaMXb+ZnEX5PgtPp9XiHh9
         V+W6jo5aG4hM83VlY3jF53/wNvthAaWgazKeh0W/kZEH8IdsyFiRL67Sol9tLYoZ51un
         sPeAYJL132w/FndU1jZGuzHIBtuNDPwM96HLW8qBmTUf15/PUW5H1iRoEebB2e40scgz
         hqIFRk+QygJkgiFxitLuPEE6WG6j/ZN7LM5L8/tdusjglE0nBNt16Spzqx3JQWJf/X8s
         k0g4geysjOFlV7jre0UG3wPgtK/Fcr+aUh89B/CFU/krk+5JGLlbP4up0zgNDWJUYRtA
         VBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HBXv6Gs3P+0i/KNOn2YdFsnpMYPur7Aw9mvLprhquV8=;
        b=Lz2Uz71CmE8GDD5jR/RyZtVvZSUmi9GtBXt1VlWvyXlzTneO03pte8DqoEKIQ0Qrhm
         IgC/T36mWQoTuD0Bgt4EkqTjiQXA6vR8s2eVUZv9wR4KDClcFT58UPiRzrqw/qZyAfee
         u61I/dRfpH5RQqzaRF72U3EZjFyUR8h7/F86q6KtHEDL7iVfFpYmPvpyhj3dkOvoxCCU
         evZxm0osTdTMVytu+l3bmJdzcJU6AoqQErWDVUz3BfpOnCZukfBxihXho0NIuK6YcGBV
         ByZ4G3oUrtqyRn7GTu/3nin5KS8zo5jvTCiGo9rRK+71aZrQAEBzQZpY/DwZ0u0pWw6/
         35vg==
X-Gm-Message-State: APjAAAXF2nLIK2DlLuq2yqBKWkXLkbG3w+Xbt5aZ/D5dmcFK7ALCExgM
        kzo0QgBo/rnvFsUpAvGHaFcxDlDpP2o=
X-Google-Smtp-Source: APXvYqxi95Sr2LOuuq1q/0lIrPuElPZFBUt8fhDipjA17PKllLPGZZ+tq45wt9LtNo65tcEYS2NbYg==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr24594475pgl.409.1576589063189;
        Tue, 17 Dec 2019 05:24:23 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id p4sm27783708pfb.157.2019.12.17.05.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 05:24:22 -0800 (PST)
To:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        gregkh@linuxfoundation.org, allison@lohutok.net, tglx@linutronix.de
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: seq: a possible sleep-in-atomic-context bug in
 snd_virmidi_dev_receive_event()
Message-ID: <db47108d-3967-6760-3de2-17bf60741bc2@gmail.com>
Date:   Tue, 17 Dec 2019 21:24:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a read lock.
The function call path (from bottom to top) in Linux 4.19 is:

sound/core/seq/seq_memory.c, 96:
     copy_from_user in snd_seq_dump_var_event
sound/core/seq/seq_virmidi.c, 97:
     snd_seq_dump_var_event in snd_virmidi_dev_receive_event
sound/core/seq/seq_virmidi.c, 88:
     _raw_read_lock in snd_virmidi_dev_receive_event

copy_from_user() can sleep at runtime.

I am not sure how to properly fix this possible bug, so I only report it.

This bug is found by a static analysis tool STCheck written by myself.


Best wishes,
Jia-Ju Bai
