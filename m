Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66338C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE2827875
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5d1tm81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfFCPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:24:47 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:41477 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFCPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:24:46 -0400
Received: by mail-vs1-f50.google.com with SMTP id g24so9432295vso.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Zseq1GZeTqMaMENYkGCy4nd4edGfJrBEbxocT6fFXUI=;
        b=U5d1tm81DWwwhYT2aOwrSvimQ7FC2F1idrQyh3secSIYdt/faQPXZc6i7ibf9FtI1g
         ErDCRIGxNcf6MdfCNk35vinF5q8B5d4gi7hdhXoVNt4IaPUsnFbU19Rkw3Aa0bdTOoqM
         cYzJvrpF/eAgzzFhs6mNF0F8V+Zytk6tjIPPW7Ns0KyxwEYNO5qKYRThH7APIiHf3dai
         S2rnxJpiueDD1BiNC8XtBNpKRVX319qq1dFZZjK0WMXZ2CRtDzvhAGvY20BkhIXofTuE
         bVi/6QmsLKR5bCuBQOfEHjx0O0cYz5O4xC42moamd418S9Rpd9hBc2N99Wj9geU3DgEo
         VXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Zseq1GZeTqMaMENYkGCy4nd4edGfJrBEbxocT6fFXUI=;
        b=btyYmPRpRAUh7YQ7gmNDkUz/r7BVL4bA5nk1GXdw+dGfdlNzfmvRW8/It3os7Luqy5
         Kx9w/AQikuDbQJOkWEtAdvBiSf+1qSIH3kefE0WpXAJhfup4JRupOpF5V7D02bVvnm9S
         ho/dVI9EePMcwLhhx/tn2NgkiGK6YPO1mwfbPvapeOrqCzPOO442KmDdQ1N/zw0C5gWR
         iGI/fmyXZ3XitLLUFqrlbHREROXi6Eo0kWpN2m0IL4jBrjnNOZL86Lkv5cES8fjSd3Ur
         ZBPaAG+x5C9rjsOVFGtn7CCscwXdEIpaugjqeow7XOJquWOU9FQU4Zh40QgvTDI9clAk
         1HPw==
X-Gm-Message-State: APjAAAVf/ibk62f0nL/MqEzDop1WKVsfhPwWQ+87/k9ma6bu10veTK3z
        UF7I7/eO95Luo8vn8kbGCzqK2YDRl/BGR+hbXKgaAg==
X-Google-Smtp-Source: APXvYqz+7Y+FqrheKmfgGO6xhSDbDEGS0G3Mw8mOQLhnYpdBIr2FillGn28kMat6G0UWw+qxiZ6aXG+cEAryoCB7cr8=
X-Received: by 2002:a67:f3c5:: with SMTP id j5mr12977698vsn.232.1559575485636;
 Mon, 03 Jun 2019 08:24:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:efd3:0:0:0:0:0 with HTTP; Mon, 3 Jun 2019 08:24:44 -0700 (PDT)
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Mon, 3 Jun 2019 08:24:44 -0700
Message-ID: <CA+jjjYT6_ZZP5Ucqxvtmcd3d18vAC1LRtruiXojFVaxpJ-HhLA@mail.gmail.com>
Subject: O_CLOFORK use case
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran headlong into the use case for O_CLOFORK and got into a locking
debate over it.

The actual use case involves squashing a thread race between two
threads. If a file is opened for write in one thread with O_CLOEXEC
while another thread calls fork(), a race condition can happen where
the thread that closes the handle misses the out of disk error because
the child process closed the handle last inside execve().

The decades old idiom for replacing config files isn't safe in
multi-threaded code. Yipe.

    int h = open(".configfile~", O_WRONY | O_EXCL | O_CLOEXEC, 0666);
    if (h < 0) { perror(".configfile"); return 1; }
    ssize_t delta = 0;
    while ((delta = write(h, newconfigdata, newconfiglen)) > 0) {
        newconfigdata += delta;
        newconfiglen -= delta;
    }
    if (delta < 0) { perror(".configfile"); return 1; }
    if (close(h)) { perror(".configfile"); return 1; }
    rename(".configfile~", ".configfile");

To fix it, we have to put locks around close() and fork()/vfork(). Ugh.
