Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F0C73C60
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B770720693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6m5xpfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGIXHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:07:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40575 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:07:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so209551otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDAj6zol3RaVmal+PtZQz5C2j+ZDGvpWtxUxeTzImJ8=;
        b=c6m5xpfxQePOMGTMsYC75i5UBzSjYBhlvZ3MlYPp0JvUpt63L071NtaOtqN98rxKXw
         McPekY6OcxyyirBZhgxqf5Iikis9pDkaaHNoyurXPt9wSrukxTLIZNOFB7Ze0FYL/sH9
         g7df6hKlhMCemc4cyOciGzP9CI2cPCt4Fiv/WViBjvVZYdj0nPJ2QxqXu0JI2ccoYdoQ
         oBpglV3I3RFQY/STUKoB24AhvddmVx1hFd+0KO1VYr/aO3U6O7ZQzHYEDifWltSQgMVg
         FyWqqmYRP6hkGTiCkmys2PtaWZ6rGRrektJaMRMibQ01jEKMABHmf0Np9iBS0prT3/tM
         XGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=hDAj6zol3RaVmal+PtZQz5C2j+ZDGvpWtxUxeTzImJ8=;
        b=EkkglsvMqDAH9qSQGSI9mRMDnxu6gVnFxoFS+XihJIqr206JIcaUll1FtP3FH9vcVG
         4BjPO2EbVVzCTzRNT7/nDOjQ+jas21uDAdoqUAyW+C0ctCcW/nZod8/DYH7jRLCkX4lC
         B+L2zAe8MrvySNBSoeCuRmOS4ItTeg5SERa6oEboNGo2D0H6+m5YEFFVLTv9rdUZTbsm
         +9MUPqM6WZfwqwurbpQQEz0SXmo8i+boOvjUVURw7u9M6ZM8nkXRi2wrc0zkHfovTeJQ
         TQ1QnWmWRVXXOdLwtvooIbv3NaYyVJ1sbg8+U5sKXpjhFWyz8mAVv1liypboV49qz0u9
         8vlQ==
X-Gm-Message-State: APjAAAWTGBbsiWs3nlFDKnXxZEdxMy8juhrWJMFr9Mdj/UIO7ixn3ZOh
        +1EqZxFyFtMCbkxMLhp/bEjjmbo=
X-Google-Smtp-Source: APXvYqx44AfZvFUNQHdYp8jx1vE4YVQXTsj60CNgH+TxZdsEHIMZHlpFqaSGemwRf80J2HkYb6dEbg==
X-Received: by 2002:a9d:560b:: with SMTP id e11mr7098546oti.129.1562713625802;
        Tue, 09 Jul 2019 16:07:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id g22sm198294otn.69.2019.07.09.16.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 16:07:05 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6c89:b9b3:d6b4:3203])
        by serve.minyard.net (Postfix) with ESMTPSA id E963F1805A4;
        Tue,  9 Jul 2019 23:07:04 +0000 (UTC)
Date:   Tue, 9 Jul 2019 18:07:03 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi_si_intf: use usleep_range()
 instead of busy looping
Message-ID: <20190709230703.GF19430@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709221147.GM657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709221147.GM657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 03:11:47PM -0700, Tejun Heo wrote:
> On Tue, Jul 09, 2019 at 04:46:02PM -0500, Corey Minyard wrote:
> > On Tue, Jul 09, 2019 at 02:06:43PM -0700, Tejun Heo wrote:
> > > ipmi_thread() uses back-to-back schedule() to poll for command
> > > completion which, on some machines, can push up CPU consumption and
> > > heavily tax the scheduler locks leading to noticeable overall
> > > performance degradation.
> > > 
> > > This patch replaces schedule() with usleep_range(100, 200).  This
> > > allows the sensor readings to finish resonably fast and the cpu
> > > consumption of the kthread is kept under several percents of a core.
> > 
> > The IPMI thread was not really designed for sensor reading, it was
> > designed so that firmware updates would happen in a reasonable time
> > on systems without an interrupt on the IPMI interface.  This change
> > will degrade performance for that function.  IIRC correctly the
> > people who did the patch tried this and it slowed things down too
> > much.
> 
> Also, can you point me to the exact patch?  I'm kinda curious what
> kind of timning they used.

I believe the change was 33979734cd35ae "IPMI: use schedule in kthread"
The original change that added the kthread was a9a2c44ff0a1350
"ipmi: add timer thread".

I mis-remembered this, we switched from doing a udelay() to
schedule(), but that udelay was 1us, so that's probably not helpful
information.

-corey

> 
> Thanks.
> 
> -- 
> tejun
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
