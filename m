Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF032C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDC220828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="yHMEur93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLZNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 08:08:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33543 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLZNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 08:08:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so16679528lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX+uD6u26dDFDC626LQb9o9CPegZnPxVtayuH9+QP+c=;
        b=yHMEur933ZoxenJTF/O5tNptMe7y2msn2A4nAJAGHsuHLTSECG/y5MRFeXwBggLWqp
         /gqUCKjAPxCWnGxfttHxQxTr2RA4ccUj3nGztv6us+e2bFB3O6r1xR2yD1cLZH0LtVzp
         ChsZvQzl8eopBmxkxcXv9VU/PN/whUHhS01A2LOp6pkNxxw11O5CDI7yfNbaPUleWeL4
         ejLUj6YVTtb2TFohC6tHr2y2CHtudkODp0kVhuMMNYxD4GMEVxc/L27eOg1VWDEeBApJ
         dcT2nk5ikZMCf8qoCiec2jRp0ShuHC3OXNaaJl2eKI+8DXD4GbCMsHYyeqDiBYk36kT3
         wG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX+uD6u26dDFDC626LQb9o9CPegZnPxVtayuH9+QP+c=;
        b=gOJBr5aH/O0K7WdGXrOe4EgisDRTh+89RIHyeeNjLwWy5EsjMyW0PstfCV/tno0tB2
         i1+AQ9ejKkDW3NM81JRWkg0CJ6NcrOvvbS2Vmu2ZHOv6XiDqEXD05B7/IkypChFZThRs
         aUpItSO0H/xfOcBG2xVZhLAU2KvzUO6F9pzcsOGAr5eJOm7VTXMk6WGs62MsQhyh1BK0
         wc4phbXZaH5hjz9qr95ePsC9znXBzKOGXT43JgkyiEGZmrZ6E1kXJZR4BXyz0Flc4wz/
         rgsCADvx5pQoxSbSMR5OOntUbJlFUyIYKn8E2ySM//0nxSgQvQ2i6AsmVmq8hLqxG2wy
         EKHA==
X-Gm-Message-State: APjAAAVq8tpA2pzIRStrcdwdNBT7PoqxrOZVugXF18ZGgeDj1QvvK34y
        3OdMHuoiIAJY0vIeiAbcqKr2Xw==
X-Google-Smtp-Source: APXvYqxvUQ91Q6j1NhdVDolhqYVyEmWyagtDXGJ4B+gMTFF1SRRbv75fwcnAT7i9EH20MjdxcZEHvw==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr26296295ljo.54.1577365722046;
        Thu, 26 Dec 2019 05:08:42 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id d25sm12356658ljj.51.2019.12.26.05.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Dec 2019 05:08:41 -0800 (PST)
Message-ID: <61e43dcb781c9e880fac95b525830fd384de122a.camel@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 26 Dec 2019 16:08:40 +0300
In-Reply-To: <CAMuHMdV5VtR+vgYKcZtvcz16GPp9YLG_ecAeDsiNCreP4rYKjw@mail.gmail.com>
References: <20191223040020.109570-1-yuchao0@huawei.com>
         <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
         <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
         <CAMuHMdV5VtR+vgYKcZtvcz16GPp9YLG_ecAeDsiNCreP4rYKjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, 2019-12-26 at 11:43 +0100, Geert Uytterhoeven wrote:
> Hi Vyacheslav,
> 
> On Wed, Dec 25, 2019 at 10:58 AM Vyacheslav Dubeyko <
> slava@dubeyko.com> wrote:
> > On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com>
> > > wrote:
> > > > As Geert Uytterhoeven reported:
> > > > 
> > > > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> > > > 
> > > > On some platforms, HZ can be less than 50, then unexpected 0
> > > > timeout
> > > > jiffies will be set in congestion_wait().
> > 
> > It looks like that HZ could have various value on diferent
> > platforms.
> > So, why does it need to divide HZ on 50? Does it really necessary?
> > Could it be used HZ only without the division operation?
> 
> A timeout of HZ means 1 second.
> HZ/50 means 20 ms, but has the risk of being zero, if HZ < 50.
> 
> If you want to use a timeout of 20 ms, you best use
> msecs_to_jiffies(20),
> as that takes care of the special cases, and never returns 0.
> 

The msecs_to_jiffies(20) looks much better for my taste. Maybe, we
could use this as solution of the issue?

Thanks,
Viacheslav Dubeyko.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

