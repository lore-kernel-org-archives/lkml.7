Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63954C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E923878
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pYCKyU6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfICQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:20:48 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:47112 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfICQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567527880; x=1599063880;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=fqzeaPksMJyuHnHhwPB08U08NUH0VZXfjpzcE6LlaeI=;
  b=pYCKyU6j4lczzybrTU7ZeKDOi6iCmaB7rGNo9V25ELF1hP8dr+nifnPl
   b9fXo9VkrwB7NdF9011pFsssSGlPU6DNA8JRDb1cL5hNiGX5wAuDtYj5d
   FOLOKETcpcsV2K1KHjSygfe6zA6BgMPdzHwnct5EIkZP7+OY7TNpGW7HN
   wqaseaKrPchsp4oRs3fdvg1Uxa/be+zJKJl8hkUqnHvsOC4AH2wlHC160
   lRHojSaAEj9P7goStCafPwpms7aDnTyUP/0dvAKqZZ2K6j+ieH3L3gb3P
   KpNOf/Kd3Ucn6JoTkUV8Y41LxC5U8DDYi1e2g5L7a4BcXminT8uVBFBLD
   A==;
IronPort-SDR: W7oc2YKfGT8DGKS2pRxMuJdQ1wo2qIvJ8KfGlUdlDaoNWfcQHLxsLOYenQMrgOnc3MNzg5lBKd
 AY1Fg/v/9W2Mh4SQjoYJcGmUip1vvVetKrhrFqNbk70se0xxzL1G9E4x4Yrw2PqrGo1TNbhqPW
 H5TTFvkOP9JzwGtCS+y+FSnoOeReqlv56ZEDXh5SWLlawdJYDNX1x2MAgs8S3636xZgLc4vljJ
 bWlG6iUhWb3drJGHGFt5HP9WQJJb9kHrMGYRLZkaaps/+KkuaAYUcO0Iy2qSOpjHsOrP9EylhW
 nLk=
IronPort-PHdr: =?us-ascii?q?9a23=3AZGGjIRNgvzvghh1VIZQl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfvyrarrMEGX3/hxlliBBdydt6sezbOJ6Ou+CSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Ngi6oAffu8UZgIZvKbs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMtaSi5PDZ6mb4YXAOUBM+RXoYnzqVUNsBWwGxWjCfjzyjNUnHL6wbE23/?=
 =?us-ascii?q?gjHAzAwQcuH8gOsHPRrNjtNqgSUOG0zKnVzTXEcvhZ2jf955LJchs8pvyNXb?=
 =?us-ascii?q?NxccrLxkkuCw/JkludpJf4PzyJzOQBqXaU4Pd9Ve+2jWMstgJ/oiC3y8sylo?=
 =?us-ascii?q?XEgpgZx1PE+Clj3oo5Od61RFRmbdOgFJZdsTyROZFsTcM4WW5ovT43yrgBuZ?=
 =?us-ascii?q?GmYicH0I8nxxvDa/yfdIiI/w7jWP6RIThmgHJlf6qyhxOo/kihzu3wT8200F?=
 =?us-ascii?q?RXoiZcnNnAq3QA2hjJ5siITft9+Uih2TKR2AzJ9u5EJkU0mbLaK54n3LEwio?=
 =?us-ascii?q?IevVrfEiLygkn7j6+bel869uS06OnreKjqq5uYOoNsjwHxKKUumsixAeQiNQ?=
 =?us-ascii?q?gOWnCW+OS91b3j50L5QalGguE4n6TCrZDVOd4bqrSnDABIz4Yv8wy/ACu+0N?=
 =?us-ascii?q?QEgXkHK0pIeBaGj4jvJlHPL+n0DfShjFS2ljdk2fTGM6b/ApXCMHfDiq3tfb?=
 =?us-ascii?q?Vj5E5Gzgo809Rf64hTCrEbL/KgEnP24fnRFBxxGRaz3OCvXN9n0YQYWG+nAa?=
 =?us-ascii?q?KDNq7W91iS6bR8DfOLYdokuST9Nv9t1f7njDdtiE0ddKjxhcA/dXuiWPlqPh?=
 =?us-ascii?q?PKMjLXnt4dHDJS7UIFR+vwhQjHCGYLag=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HfAQCqgmddgMfQVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BZ4QKKoQhjwiCD5N0hx8BCAEBAQ4vAQGEPwKCWSM4EwIDCAEBBQEBAQEBBgQ?=
 =?us-ascii?q?BAQIQAQEJDQkIJ4VDgjopAYJoAQEBAxIRVhALCwMKAgIfBwICIhIBBQEcBhM?=
 =?us-ascii?q?ihQudPIEDPIskgTKIaQEIDIFJEnooi3eCF4QjPodPglgEgS4BAQGUTpYFAQY?=
 =?us-ascii?q?CAYIMFIwoiCkbmF0tphAPIYFGgXozGiV/BmeBToJ6ji0iMI9dAQE?=
X-IPAS-Result: =?us-ascii?q?A2HfAQCqgmddgMfQVdFlHQEBBQEHBQGBZ4QKKoQhjwiCD?=
 =?us-ascii?q?5N0hx8BCAEBAQ4vAQGEPwKCWSM4EwIDCAEBBQEBAQEBBgQBAQIQAQEJDQkIJ?=
 =?us-ascii?q?4VDgjopAYJoAQEBAxIRVhALCwMKAgIfBwICIhIBBQEcBhMihQudPIEDPIskg?=
 =?us-ascii?q?TKIaQEIDIFJEnooi3eCF4QjPodPglgEgS4BAQGUTpYFAQYCAYIMFIwoiCkbm?=
 =?us-ascii?q?F0tphAPIYFGgXozGiV/BmeBToJ6ji0iMI9dAQE?=
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="5595090"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:24:39 -0700
Received: by mail-lj1-f199.google.com with SMTP id j11so311658ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQBG7+8qdXREwgshOpRDeqr7yPzRJ4NO6awYIAZEeC0=;
        b=gC8ppE9IdU+LF7CGfeV2B4np2ULYHygUUcSyJJykoIyjOD82JPWZ2Zp7bklMLCwXum
         ieAYxFTFRMGo0wuMbQW2qhXsXYh2rLVkJPLefs9Kk452cdNkOI8A7tnYoCyY4zLhkWO2
         Mn5tOtcUentyv6PTPcqc5L6NxbMxz+ZRTZDoOLMFro3+YLKSsnu8nuK2am2yU7CRLyzk
         DdMSpngRGooR7zXmzN+Mkui3mbsX/PlWSAXvDpIsZPEAs2c00NTK0xYfuD+xeTcPgAVI
         DURIEKmpH/fag1AvFnVlHF9/cZzwGbYlsy3e9KxrsIx1D7/2iqsWe3+O9W9ce7QIfT1A
         c2eg==
X-Gm-Message-State: APjAAAVgHaX1wBLVNbFfMzSIEPTZefkUutShWJH387PYVbgSgRFUWB51
        qqAHnd8RY8qrAS9AGc/YxamcsNQqrYSdtKqp46JAGB4p6u8QPQeJTJavulTxO10g/fYyYzSEClS
        ESifd1q1NsdUlZvXBE+/X4bX0mwphBHiVE4C6R0EVMw==
X-Received: by 2002:a19:4347:: with SMTP id m7mr20404400lfj.146.1567527644640;
        Tue, 03 Sep 2019 09:20:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxRS1mmFYV744cbn211ZoqJN/iMCMCNinPRyOyq5wx4V6dEjWLfbi84RindB0KLwdwauiqEicmSQIs3+PaiPI=
X-Received: by 2002:a19:4347:: with SMTP id m7mr20404391lfj.146.1567527644441;
 Tue, 03 Sep 2019 09:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190902221047.20189-1-yzhai003@ucr.edu> <20190903112558.GB6247@sirena.co.uk>
In-Reply-To: <20190903112558.GB6247@sirena.co.uk>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 3 Sep 2019 09:21:14 -0700
Message-ID: <CABvMjLT=WzpzPY+15nyOL9NVkyMzpQNyK+6w_cjde11vJiLBfA@mail.gmail.com>
Subject: Re: [PATCH] regulator: pfuze100-regulator: Variable "val" in
 pfuze100_regulator_probe() could be uninitialized
To:     Mark Brown <broonie@kernel.org>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark, I will send a new patch and check the return value instead.

On Tue, Sep 3, 2019 at 4:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Sep 02, 2019 at 03:10:47PM -0700, Yizhuo wrote:
> > In function pfuze100_regulator_probe(), variable "val" could be
> > initialized if regmap_read() fails. However, "val" is used to
> > decide the control flow later in the if statement, which is
> > potentially unsafe.
>
> >               struct regulator_desc *desc;
> > -             int val;
> > +             int val = 0;
>
> This just unconditionally assings a value to this variable which will
> stop any warnings but there's no analysis explaining why this is a good
> fix - are we actually forgetting to check something we should be
> checking, are we sure that this is the correct value to use?



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
