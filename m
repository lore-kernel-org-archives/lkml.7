Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE52C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FD220706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mxx1kbGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLNSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:43:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfLNSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:43:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so1222624pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QbzwIxwiBFo2cffoX1L047KjXjiOr4rf4SxlZuAhMrY=;
        b=Mxx1kbGm0XFApeOmkSnbAtCAJM74EDCCF8bxEFFLrIiHYpH99UvvEkjQ4pgCeSK8IA
         ZEsHxCPSZEgTrksBJIT61B+gw9G5fs89J4RzYKG0pv3u4t+rEoAgfq/azFGYLkSBa18+
         5Syf7b5XnU0yWLcR0GQmoFbNKZsZ1xd3qfLPSGGCyqoRiHCtnvYlJhtqz7pf/ZRj3Qi3
         gcghiGyr28AfdNoOfIGJxr+WLyD2LcE3FEVMIaRmSXtzNKBCzD+Ff/tM02BL2B3cIKbR
         WqQb7TQnNM4WErVb/MNbQD7F9cgZ+N2g+xH+6Ppt30Pr+ObJM/WR+w19vM8dDb4WQPox
         UK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QbzwIxwiBFo2cffoX1L047KjXjiOr4rf4SxlZuAhMrY=;
        b=ZyPd39MaZdUTpgpUlVEUkmdtOyelDBW3BisJOFM43Y796aI7raWUhC1y1DYghLcDwu
         Axti1UjfGPhmq5DuzofSm3lpRhM2j1Yw94LjoyRgxOBrWU7CkHGtxRrtkceVXm1kbtMS
         wBzuSodqgyFr1271y1OtuYpx2IBG/s93jbbp/TNnTmxs89MH/FRZWHWfNp9x5wAE3N+O
         2681Tx4boAs9/kT8rTF5+lVbHRAYfUQIqxpDmMrvXKvwdBGHfNKrNJLYigDstmyORiQN
         gJGGw3qRfszVwVSLXUqzAPdkpX0DojNoCZeQzQVqcIblsmj2R/H0+Mg2oKNGgK2w8l1c
         gvGw==
X-Gm-Message-State: APjAAAU597kG/EWpKse7OtiCi68qkjJPxQfxuAtrN/LpgvLbvkTceGp8
        qRhM8/3xVYyWhX9NbJXcFMuXIAg9h6S7dQ==
X-Google-Smtp-Source: APXvYqzRVHXJbkaHToZpXQuBbgfNfNrwyA7GnRMI4cTusCicSSlssbKOJWnBtTcZWc4BIUpjcxob9A==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr6986201pgb.306.1576349021449;
        Sat, 14 Dec 2019 10:43:41 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m15sm15216850pgi.91.2019.12.14.10.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 10:43:39 -0800 (PST)
Subject: Re: [PATCH v3] io_uring: don't wait when under-submitting
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6256169d519f72fe592e70be47a04aa0e9c3b9a1.1576333754.git.asml.silence@gmail.com>
 <c6f625bdb27ea3b929d0717ebf2aaa33ad5410da.1576335142.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1f0a9ed-085f-dd6f-9038-62d701f4c354@kernel.dk>
Date:   Sat, 14 Dec 2019 11:43:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c6f625bdb27ea3b929d0717ebf2aaa33ad5410da.1576335142.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/19 7:53 AM, Pavel Begunkov wrote:
> There is no reliable way to submit and wait in a single syscall, as
> io_submit_sqes() may under-consume sqes (in case of an early error).
> Then it will wait for not-yet-submitted requests, deadlocking the user
> in most cases.
> 
> In such cases adjust min_complete, so it won't wait for more than
> what have been submitted in the current call to io_uring_enter(). It
> may be less than totally in-flight including previous submissions,
> but this shouldn't do harm and up to a user.

Thanks, applied.

-- 
Jens Axboe

