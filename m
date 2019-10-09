Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A5ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87B821835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinux-us.20150623.gappssmtp.com header.i=@archlinux-us.20150623.gappssmtp.com header.b="KLKMdMzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJIHSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:18:51 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35109 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:18:51 -0400
Received: by mail-wr1-f41.google.com with SMTP id v8so1400378wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=archlinux-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=TiNDWTtk2uKC1AzF4yMLeYYctvJHg7/7iKFSYlemv/Y=;
        b=KLKMdMzNPKJXMv+x9JRT6Be+ViWnc7GqPneU0lxeNWuJ/Gx0eATUM593vYkaalh1BM
         au6CMne8VM+cNVLDm+FHC/mfAxqQCff+PZ/t/oojvI4qIWQKFpKgrPSxAmWq3+wubKqf
         w+V01JagsYXS4LWdwOcduPPIeKr/ZkfxA8x8G44bw1BYCLe9CrUsgwMCuEGpgyvILOZI
         NJkgNu7HJxCAFmm2R1sOExWug8BErBUgRc3/SDm5ouVAtvUE2fx2dEtAQBu1O5jx54Ti
         so4NtwDp6QK9tLqIlENriFjnZb6iBdNl8zsm2cv6S8T8C5q5AvRa/zRo8nJKKXncSM6p
         CfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TiNDWTtk2uKC1AzF4yMLeYYctvJHg7/7iKFSYlemv/Y=;
        b=TGn21NZadXhzVP50kuZK77T6H2PEEK1+6C2a0aB3zFIafWA+y+tVjOV32y7m2/lviW
         CvrKvPqyb1Q4LdxzFol6suRR+5Ync3GzxXFRHZ4QHXDdRashEW3QmLRmtjFhXZQo9q8L
         OxNeeTo7zNN5xhlQwoW2LBCLSzzhGF3XRdg8feEyhRi6p8Wp60HRn81tUAgtkNuDt2LG
         hWwcpmL7+DO4gwISv6G2fpN3XFXy4aGnY1Z/wjJp5Oswxvm015HuZ86VZ8KzPgIH2jPD
         7TwxBHjSuP+/R3jIC8qU3FClJCyZ3oIHZcaOTvETaVyQGG31G0R8Ql0N776yy2QuY3R1
         ii4g==
X-Gm-Message-State: APjAAAUpbEjjXLnGZ/kEvnFBnGJIbnB9LiCZvAtiUQOsF9WEkQMlrFpz
        6ilWFB+gt+xjcOHmfsLJLbhbvHqW4TkBwMkq7UeO4zuoUYk=
X-Google-Smtp-Source: APXvYqx1hsKleJAEafk2d6mfhaNBUpK04PlQiZonvDHDE6O3pctlth6FvZZ2/f+uIPhzJHMjf+0jyj3VXDq6mL+m1Pg=
X-Received: by 2002:adf:9221:: with SMTP id 30mr1682706wrj.126.1570605525581;
 Wed, 09 Oct 2019 00:18:45 -0700 (PDT)
MIME-Version: 1.0
From:   John <graysky@archlinux.us>
Date:   Wed, 9 Oct 2019 03:18:34 -0400
Message-ID: <CAO_nJAYi-bjbtuXGFiwwomaS_PzB9=2w17AH21Jp_z4Swx4RbA@mail.gmail.com>
Subject: Failure to distribute distcc jobs compiling kernel versions >=5.2.0
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the kernel using distcc since version 5.1.16 works but
versions >=5.2.0 fail to distribute jobs. This is true compiling
5.4-rc2.  Whatever is causing this breakage, it has not been
backported to the 4.19-lts series. I can build 4.19.78 with distcc
working just fine.

distcc v3.3.3
gcc v9.2.0

I am not subscribed so please CC my personal email address with any replies.

Example compiling a recent kernel on the distcc client:
distcc[22629] (dcc_readx) ERROR: unexpected eof on fd5
distcc[22629] (dcc_r_token_int) ERROR: read failed while waiting for
token "DONE"
distcc[22629] (dcc_r_result_header) ERROR: server provided no answer.
Is the server configured to allow access from your IP address? Is the
server performing authentication and your client isn't? Does the
server have the compiler installed? Is the server configured to access
the compiler?
distcc[22629] Warning: failed to distribute
scripts/mod/devicetable-offsets.c to 10.1.1.102/5, running locally
instead
distcc[22635] (dcc_readx) ERROR: unexpected eof on fd5
distcc[22635] (dcc_r_token_int) ERROR: read failed while waiting for
token "DONE"
distcc[22635] (dcc_r_result_header) ERROR: server provided no answer.
Is the server configured to allow access from your IP address? Is the
server performing authentication and your client isn't? Does the
server have the compiler installed? Is the server configured to access
the compiler?
distcc[22635] Warning: failed to distribute scripts/mod/empty.c to
10.1.1.102/5, running locally instead
