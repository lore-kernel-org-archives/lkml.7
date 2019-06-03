Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F86C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC227B56
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS6Q74II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfFCP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:56:54 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51483 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfFCP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:56:53 -0400
Received: by mail-wm1-f54.google.com with SMTP id f10so11783077wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cc2qpruDakPhVR/+oGLp9bzGzok2vGK8TIr8IQJeQhA=;
        b=NS6Q74IIv8QB4krMkgs4Z9IVQ/L7pYBS4KAPNrffZl4NiBWlyDQAr1i6n+6dpjkb6/
         J6+wbDcSx5kPgyhGffeJezsXhLGEATG2LG3i/lmQ/khNcy2524DTjZYwWtIQIeQ4Q3z3
         gBEp5SBWEF1RqoYuKRrnC1MKr8iUx9jqiZfJQFcU4Xaj5CIBbUEY19/xmpI2NT0/bVI9
         5hhWJhy1oEn7lWPpShFUTp0ELu5cEaYp7KZAwIHR+zL5w8Fq+cEv4We5oa7GfP3GIM2r
         jQYBAfp9oZHjQGbfeU4s3mJnnaArSRMtfth/iRRZW2hcSm0ZP3SLZLPINAUGEq3xsohH
         OsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cc2qpruDakPhVR/+oGLp9bzGzok2vGK8TIr8IQJeQhA=;
        b=EG2dbwlMbSgx+9rJBfE0V8bLOhBOshVi8ILRLZM37k2TmAwa9K028welVwTr2KmcEk
         6W2yfBcf02qpnlhr3I+6a2dy0WB1BeUWTowey94qqu/TBi0WI03I4h9T97dBtVFAWILZ
         3/7Jo3e/Ba8F9yR16rvWcXn0xj4WAMcBGyOf5qfFXH998M9Z73+ixru2PaPP2GMeFfQw
         QgmHDvOdaWFolKzoyal0U3bQZKQOny6oqgZKtGfKGc4gOM1y+PZsVogZ+cRdwOYz24Kz
         kGW0VvRINOIw+6Cx3GptqFzWyIKJjnOMbtXcR6jRoYkH1UQTEgEK1Cnrz/lj8z7Sfppb
         UyEA==
X-Gm-Message-State: APjAAAXgTW42YhyATTugIPRx7n1Wx5bi4T6KrziD35cxgYB2FuVorTkz
        7Vmx7FyIvxWZTQJnVSlach8=
X-Google-Smtp-Source: APXvYqwPX2H3IGUwFLIGuTkeFVAZmiMTYEKzIO9oj3HMpTK5kDSaWvjvgjHW/1K1E5HU4gukgGcRjQ==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr15319505wmf.66.1559577411337;
        Mon, 03 Jun 2019 08:56:51 -0700 (PDT)
Received: from [10.17.91.220] ([91.199.104.6])
        by smtp.gmail.com with ESMTPSA id f2sm3881449wru.31.2019.06.03.08.56.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 08:56:50 -0700 (PDT)
Message-ID: <b8c50bcb9335c93c3c730d55b6a9415d5f1fdb2a.camel@gmail.com>
Subject: Re: O_CLOFORK use case
From:   Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
To:     Joshua Hudson <joshudson@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 03 Jun 2019 18:56:49 +0300
In-Reply-To: <CA+jjjYT6_ZZP5Ucqxvtmcd3d18vAC1LRtruiXojFVaxpJ-HhLA@mail.gmail.com>
References: <CA+jjjYT6_ZZP5Ucqxvtmcd3d18vAC1LRtruiXojFVaxpJ-HhLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 08:24 -0700, Joshua Hudson wrote:
> I ran headlong into the use case for O_CLOFORK and got into a locking
> debate over it.
> 
> The actual use case involves squashing a thread race between two
> threads. If a file is opened for write in one thread with O_CLOEXEC
> while another thread calls fork(), a race condition can happen where
> the thread that closes the handle misses the out of disk error because
> the child process closed the handle last inside execve().
> 
> The decades old idiom for replacing config files isn't safe in
> multi-threaded code. Yipe.
> 
>     int h = open(".configfile~", O_WRONY | O_EXCL | O_CLOEXEC, 0666);
>     if (h < 0) { perror(".configfile"); return 1; }
>     ssize_t delta = 0;
>     while ((delta = write(h, newconfigdata, newconfiglen)) > 0) {
>         newconfigdata += delta;
>         newconfiglen -= delta;
>     }
>     if (delta < 0) { perror(".configfile"); return 1; }
>     if (close(h)) { perror(".configfile"); return 1; }
>     rename(".configfile~", ".configfile");
> 
> To fix it, we have to put locks around close() and fork()/vfork(). Ugh.

fsync() / fdatasync() before close() should fix it, non?

I was under the impression that any of those two became mandatory when
ext4 came along.

-- 
Mihai Donțu


