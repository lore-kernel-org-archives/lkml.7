Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA2C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 22:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0D721835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 22:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392433AbfIGWpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 18:45:43 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59180 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727008AbfIGWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 18:45:43 -0400
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x87Mjfje020111
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 18:45:41 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x87MjZTR031239
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 18:45:40 -0400
Received: by mail-qt1-f197.google.com with SMTP id n59so11030033qtd.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 15:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=/6kA56aQB2rpYIanrtLDCa2hCGf5VimosArLW5oScDM=;
        b=Apquphsi2yfZGee7Cmq1+mH9luA+Efqm9iM9a3nTmM0xgWkRkvLA0xwOR3iIwZr6IB
         h//NaP7RLucUnn6kjmfYc8qOI5AposYLK5iohlUT/qKT6fKRRJOKTsEQJHml+jx7XMbV
         yAgLz0fiptF6SMLh1B04PBRRhyd8Vvhy6H2oornIxYWvwLevxrE/11Y/iLUcogVkUvaG
         IIO1lThE6SIRwN70zbtjnXdA13ZKlHgbHc8eF5z8FR0H28Z6P/nbs4gLtYQ2Vxuj7Ztr
         ZSIIDigtfmMwoeOEfKABef5YWp2Glx8Q9O+ZVc4o3sfTTp8CipeaC4h/5oD/nbYm/2Lv
         VvFQ==
X-Gm-Message-State: APjAAAWq80XetbPJrZsZn2cZ0vQE6C+Nye8Iu/SXTw1QmYsJEwGwSeoq
        RW/21hel2fHr4dbD+/RRzahwWJ1x+0fyzJ1cnY8ZUWHMRwapWlboTQYiKi3vSonGd3rVCKsH4G5
        d5B4iqD+yAG1HNEBnIAuq/7gpsonEvP2Ixsk=
X-Received: by 2002:ae9:f015:: with SMTP id l21mr15414572qkg.35.1567896335563;
        Sat, 07 Sep 2019 15:45:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCoUfhCNUjzUPYyc+PfkgUSd3QU8LrT71A/JqRfAqS/yaYDJKlaSf3EmKKI6wExKDziiSqCw==
X-Received: by 2002:ae9:f015:: with SMTP id l21mr15414557qkg.35.1567896335317;
        Sat, 07 Sep 2019 15:45:35 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id n187sm4651747qkc.98.2019.09.07.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 15:45:33 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Theodore Dubois <tbodt@google.com>
Cc:     a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: perf_event wakeup_events = 0
In-Reply-To: <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
References: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com> <943813.1567863629@turing-police>
 <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567896330_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Sep 2019 18:45:31 -0400
Message-ID: <972489.1567896331@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567896330_4251P
Content-Type: text/plain; charset=us-ascii

On Sat, 07 Sep 2019 09:14:49 -0700, Theodore Dubois said:

Reading what it actually says rather than what I thought it said.. :)

       Events come in two flavors: counting and sampled.  A counting event  is
       one  that  is  used  for  counting  the aggregate number of events that
       occur.  In general, counting event results are gathered with a  read(2)
       call.   A  sampling  event periodically writes measurements to a buffer
       that can then be accessed via mmap(2).

For some reason, I was thinking counting events.  -ENOCAFFEINE. :)

> sample_freq is 4000 (and freq is 1). Here’s the man page on this field:
>
>        sample_period, sample_freq
>               A "sampling" event is one that generates an  overflow  notifica‐
>               tion  every N events, where N is given by sample_period.  A sam‐
>               pling event has sample_period > 0.

There's this part:
>               pling event has sample_period > 0.   When  an  overflow  occurs,
>               requested  data is recorded in the mmap buffer.  The sample_type
>               field controls what data is recorded on each overflow.

So an entry is made in the buffer. It's not clear that this immediately triggers
a signal...

   MMAP layout
       When using perf_event_open() in sampled mode, asynchronous events (like
       counter overflow or PROT_EXEC mmap tracking) are logged  into  a  ring-
       buffer.  This ring-buffer is created and accessed through mmap(2).

       The mmap size should be 1+2^n pages, where the first page is a metadata
       page (struct perf_event_mmap_page) that contains various bits of infor?
       mation such as where the ring-buffer head is.

So you need to look at what size mmap buffer is being allocated.  It's *probably*
on the order of megabytes, so that you can buffer a fairly large number of entries
and not take several user/kernel transitions on every single entry...

> If I’m reading this right, this is a sampling event which overflows 4000 times a second.

And 4,000 entries are made in the buffer per second..

> But perf then does a poll call which wakes up on this FD with POLLIN after
> 1.637 seconds, instead of 0.00025 seconds

At which point perf goes and looks at several thousand entries in the ring buffer...

--==_Exmh_1567896330_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXXQzCgdmEQWDXROgAQKDoxAAkZ+wx9S0PL9octbbGAiuxv0CpxWngMqC
fEIT+8vDMnOoc15M4RlUUOtSsvsZ3NPjyqY1xJAx3WpW9735VQ3gS5KP/g8Th2r4
qus8R8bYrGyfumYGjMWimSkyxEauElyKHv+WjSmIzsWg9jtc5qdBhlFYuigu2TN7
/9I6WzUsGPxLIp39psSOWJO7YoC8y1DIPeyU9Tk+kUOBBZj76lQ6Z6zIT2Plb7R0
BRBq7wO6LqIiuC8Zg5UkyoyllXs8KNuFCtxMwYxUxeGtQe2i82U2UGQcBPigiv/F
N5Jc4ps48o8xaVs0B+l8KKRJ3B/NmGw9nf1LXBeQgrgLhFxcbnm6q16sPkhiWyK2
diwcL7Xl2hbtAKDTozWWXgg0Iid+Dy9Qt6nQY6Li/XPWEiF4xV9CRED2qv/Y717x
PCCDxTE9JhCng15yPBwR67cjWQYE7hNtxf06ZaaFHAHtiZju6UqCCpAfM9UiUzUh
YEjRkMhAML3fS3G+NwJmjBBc71sBluNMMkPcmdX3E8aEnxkkMzeWN33klN5ux4bE
WHGXAuCHe9wPybfHpbJo/xhHFwYSvAJfc7wKDS/AIiJimn5gGvMaah3e5fWqJLXp
juIlpBc5P0pbJv51TWuuHYjZW4R0yRdpxlNfJtCFV9VPdR15SqQWMBJ5fAG/jdDh
cCc9IpFngjo=
=OaMg
-----END PGP SIGNATURE-----

--==_Exmh_1567896330_4251P--
