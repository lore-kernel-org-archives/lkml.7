Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DAA22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWlLHaxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfHTJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:42:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36060 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbfHTJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:42:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so3618816lfp.3;
        Tue, 20 Aug 2019 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UidU2XQuKnxOS0Yo5PZolS3kTrnwW0RYmNfAVAQjxHY=;
        b=qWlLHaxmRUIyjmajrBP+kTripYTlBJvXnZ6g3Xicz9B7rztAMpmcxFg1xIa5xcgnzi
         XNyP5YRyiSoWNze0At7wvwWwEPvDsyrgUh8xj389MUHKqQozAANX6IFyUxnjLvx9xBYe
         yAMp8dfMS1P2IX7XOHQGa9Bx0wQvJNCLealrdE/KPB3h5epJGBbk24dv69dbaGUl1NMG
         cuTXDQprwRnG1Ki/A4yEAicU5L0lhe4f4YNSWdSpJTEdMxNq65w+2wFdUvY6RUgRWK33
         z3d0GdQFgONV2xAwdpNf8VATyJPUrli0hCOcYUtSnKPBIocPovWTBhhbzMz6wZzzJqQN
         zpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UidU2XQuKnxOS0Yo5PZolS3kTrnwW0RYmNfAVAQjxHY=;
        b=goPZTL594CMocNsE6SMAuKoSSXqluK0qpc2K9O5Ub761vYTkvnGFiDL6RUJL1/Qb5g
         acA5X8gCKkdaqgBEiiZ79YjOOKuJoLMhezwVbQED+HrQjp6Bg7r2sVUUk4e5P9t1nls5
         B6NUWD1VQ0jLp9ThGVfQqgTVXwxg7OObn7BGnRQz2Hte30hZ1PDaDpNbDFZT9xu3ZUDD
         gwLGovh00aKZcikXnjU5TId66WZwQSouO+niVT/lPOrtBOXyLIU1tuwe2QhbVkROpVKW
         W5p+ivq+/wIHIP72wNsJ3jXT8Qn41aHiOvVjpwwJU8+w48u9GhnO/qbrd3QNumt1NVN0
         yleQ==
X-Gm-Message-State: APjAAAWjeepGFmYu2gdCip4CeXYBYYUR54aQvc9VZvfWQInu5Rzj6wyP
        bRkG2PkVeetF88N4hAHQKMtgAdjLVDTJAHrwISD7mVT5
X-Google-Smtp-Source: APXvYqxzPmzTQJiIvCXRLieA6g9PLD651NYzBxj5rrwhjOabwvsu73L7l3qOPp7Ix1u/KU0Pez8iSqlIhTzfiNzXSw4=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr14409717lfn.133.1566294159441;
 Tue, 20 Aug 2019 02:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
 <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
 <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
 <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
 <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
 <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
 <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com> <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Tue, 20 Aug 2019 15:12:27 +0530
Message-ID: <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tglx,

> Can you please boot something more recent - at least 4.19 LTS - on that
> machine and let it run for a couple of days to check whether there are 'TSC
> ADJUST' related entries in dmesg?

Sure. Would check and update.

Regards,
Arul
