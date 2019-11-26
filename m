Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF13D20835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlptzD05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfKZTt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:49:59 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41942 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:49:58 -0500
Received: by mail-pg1-f172.google.com with SMTP id 207so9505296pge.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=15zl+Qd2phUwLHXSf0W8dzNhE08wTuzt1OowuWwLasU=;
        b=RlptzD05sQPfKEdqN9ncIDMkGSSjPNwd4Sh1EmbOB89KU657sYJiCl1becpAaIl8Kh
         fnc8PdhDIgqLmefynzDkvFwdNuOZVcOPOeZcC9B8ZsdZ7pmLlb/jmtz1yUQnwnL2WoTd
         G02WBjFa47aoUhjBAoZ+QzGXncAGnNqAIxfRRi3zFaRmRcdDEddDRO3ym97a1JQtGaYN
         /v9LrtEX1kQWvFlCSH1HqJBNxqNmWvDTVDRKakP/lc8sZKR8aKyLAz+D90pbeGypLdP/
         fm0RdNrehTT3ch1LICaRZ9LosdNCkFjN9lNh6OLFIb1g68kdSdyVa7gDrtNZGph3ydl6
         cBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=15zl+Qd2phUwLHXSf0W8dzNhE08wTuzt1OowuWwLasU=;
        b=MmDW9glxAi5kTuPRc2x20iAsvqlxJlVZA9cNrhNOeXd3gKWrOMVoAy8no3WYo92Kr6
         7C2Ow/sYXQvVw5AynqW1LPDAcvyC05N5gCaMgtX0i7G0+xEhM2YcyB/FXzO+USHHSxQe
         589tayu1hORGfzRmykAKehzasLTPk9vQfxJhOm5AEE1rhK3stFgAoIdiN8hTF150nGYc
         fQORT69pBgV2sqoOXzuw/bunfy4qbZqnv5KtCDGcCJM2MlHKEgkjD88y04HrqMPK+CxZ
         vARtFIaYvtW+qKA/XfhKdNn6G6bSYkmOlHcy1uw3SmCR/br9CTw/kUvthevn208fUMqa
         Ukyw==
X-Gm-Message-State: APjAAAWuUFqmOtfGt4RHH73qO3ySvADVO1ecSHqG/TK+j1/mST2jDpRU
        gkck0VxdpPVX+3eNLAYg4vfNig==
X-Google-Smtp-Source: APXvYqwdtW1r6IWED9o1iJW79WrWZ43Jde/wxzMDfLa4CNDsYp4vXZZDWyO9wmIy+qse3V3e0kum8g==
X-Received: by 2002:a62:e119:: with SMTP id q25mr44001315pfh.161.1574797797660;
        Tue, 26 Nov 2019 11:49:57 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id w2sm13917852pgm.18.2019.11.26.11.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:49:57 -0800 (PST)
From:   Barret Rhoden <brho@google.com>
Subject: AVX register corruption from signal delivery
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rik van Riel\"" <riel@surriel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Message-ID: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
Date:   Tue, 26 Nov 2019 14:49:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

The Go Team found a bug[1] where the AVX registers can get corrupted 
during signal delivery.  They were able to bisect it to commits related 
to the "x86: load FPU registers on return to userland" patchset[2].

The bug requires the kernel to be built with GCC 9 to trigger.  In 
particular, arch/x86/kernel/fpu/signal.c needs to be built with GCC 9.

Thanks,

Barret

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205663
[2] 
https://lore.kernel.org/kvm/20190403164156.19645-1-bigeasy@linutronix.de/

