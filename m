Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E919C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556E021582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1lvp6e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfLRMZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:25:44 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:34241 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:25:43 -0500
Received: by mail-pj1-f52.google.com with SMTP id s94so1205804pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 04:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5X2o0mtDaERgT2mi7QtDjqxir4Hltz6BheIiDggcalE=;
        b=C1lvp6e1959g84uBTVL9ZEeOP3twcpBoXR1aBegCslQX3dQTehr1X8RgrlPR6fqSI+
         gSJRj+dwhgzYLtJvWQwZxBPxyhoPq4K6yXQ6hxr/i7MgLw2bWv7Lj3K7hZUfh2Ce9xZF
         sHveRKWXluiVMfnQr1pThWf2cssgtcWAMF3eIcTirAOxRmONLiI+xKsGiPXbVQdz4KfB
         9jtzDRdtjiOSzHrMsDvI82k28SgmtfZhAdNgIfnop7jD5BsvhpxUyW70o9qeC6EtGqmQ
         Z/Hkj0twHrFPcwNb37HZtQIEVhvcTx1yFGQgFtSdCLvhzTvbdglPoFUMroEheCr7nM12
         6VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5X2o0mtDaERgT2mi7QtDjqxir4Hltz6BheIiDggcalE=;
        b=UpQlHlUT0aRQMu7O8P0diGnC6JeaxgBZJZV+m+/A3mUDfuwzj9CQTobmBihkilH4WB
         UGOkZbhMnbpbFrHxd8WBgHMoWsBJKIyrZHnizsxJoRrjQ5Oois7cMBjMRrWeZkUPHiRD
         BkBZvx8N/NV8WTNvgyvpgBb0e4E8px9YIo+93qAaiRIAG3zzP1hJ1/D94FXGglidj/Q9
         iAAcxR6mg89x3yNsJz3lQB78PBvgsUmcLfEkwyQ8OJSBxzQ321nWiuj1SR7IKt1d8YKr
         DWXArP+GN4B/E0lN+NUEzPlFCTXBffboct3hCGKp20Khpw3iNdjQU0+B2gblDWAvs2ON
         gf0Q==
X-Gm-Message-State: APjAAAUcC7RUdSzirNNHv8nsTC3dYT3AB74rIbwNxuKfal4/wS9JnCqu
        VqjlfTJoaFx4B4FF3sxJtumjm8+0LWEgNg==
X-Google-Smtp-Source: APXvYqwbC1IbmRPDA7MJjUt4vm4EWmMotYWecwAI3UiaYVbgeJ2IHzaMRJUsXUkN30ZyxejyzmfAlg==
X-Received: by 2002:a17:902:aa96:: with SMTP id d22mr2499281plr.218.1576671942944;
        Wed, 18 Dec 2019 04:25:42 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.103? ([2402:f000:1:1501:200:5efe:a66f:8b67])
        by smtp.gmail.com with ESMTPSA id g18sm3115695pfo.123.2019.12.18.04.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 04:25:42 -0800 (PST)
To:     perex@perex.cz, tiwai@suse.com, allison@lohutok.net,
        rfontana@redhat.com, tglx@linutronix.de
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: ice1712: a possible sleep-in-atomic-context bug in
 snd_vt1724_set_pro_rate()
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <5d43135e-73b9-a46a-2155-9e91d0dcdf83@gmail.com>
Date:   Wed, 18 Dec 2019 20:25:42 +0800
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

sound/pci/ice1712/quartet.c, 414:
     mutex_lock in reg_write
sound/pci/ice1712/quartet.c, 485:
     reg_write in set_cpld
sound/pci/ice1712/quartet.c, 876:
     set_cpld in qtet_set_rate
sound/pci/ice1712/ice1724.c, 687:
     (FUNC_PTR) qtet_set_rate in snd_vt1724_set_pro_rate
sound/pci/ice1712/ice1724.c, 668:
     _raw_spin_lock_irqsave in snd_vt1724_set_pro_rate

(FUNC_PTR) means a function pointer is called.
mutex_lock() can sleep at runtime.

I am not sure how to properly fix this possible bug, so I only report it.

This bug is found by a static analysis tool STCheck written by myself.


Best wishes,
Jia-Ju Bai
