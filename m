Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F872C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6162D217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="2PD8SaZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfEJSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:14:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43884 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfEJSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:14:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so6375468oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5U30ojrLveO0inIWQQWVEjYKxtRzBkXH88X7bSSzUP8=;
        b=2PD8SaZYjCX5fOspaHLvF+HDNUNfPqOCRXbzBxnlOalcbNSl2AINgSRjHpgf3gU3KY
         Eja3ACdueZfJ9yGmcuCvicELvwx5ByLlYQZuLrKoBdoFf5EWkK5YmRD54TQ2yeglijrs
         U0TTqevIjlZ+fr4h7nBfaBnmlqQ4NdMPc8Qzq73250yzHbW4jSm8kWXZtOrm+d1Wb1Iv
         YaIVtuwhdFPe8UJo0U2VVwLSfpLJD891ErFam1bAQGIXEbu/JkTToR1dLeXCQpfIOMHQ
         zsRCKc2uPrnGdINNn99KF1I7evMFXELfA3gd6MZlkmyfVE+tlUaGD8ZJJADiJp3dyvtt
         TGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5U30ojrLveO0inIWQQWVEjYKxtRzBkXH88X7bSSzUP8=;
        b=UaZLhq1b82sfVeL40YqtD978yyWCD/MuzWyVLlWnLWCjI4iD/g4aI6XiHiwhu8zQ0W
         BHbh1/iTjZZ6boVkMf1taai1yWrqpCkpxmHtePPedr1k0rbjv/dCvLk3x5lKLL7ogHph
         qcQfiD68LeyNr53F7PxxTDIEkcEbbq0bpCI4eiMjnUj5jr615ZASYQ36BEGhW4pinnbQ
         7nahcbodVu1XWdUDbBRQtQdGa3tHl3EB5mSFWTVpsnZVvVeyjFs99kI9tJISCJa0qgPb
         1YCGTb75tyWO60EOqLOm8NAuRednMdH96BQqd6l5wzW9QPoq/vXQ7DLsZLB1UGIKII58
         GtOg==
X-Gm-Message-State: APjAAAUVDWHMCt2LvoYB782WWh5ixJRO8heCud2FjQ9N53PBmW0qnTZV
        NthxYbSiY08fuvr1IQhfWNgrDSq5bXaeow0Iy7lnuA==
X-Google-Smtp-Source: APXvYqzCkRU/LApt95XEDdDEUgIIw7lC4YzebWLylbbCwywX0NVlDoO/rBv9jia1H70b/HmzgSWapfax4U0jRSj8Wlc=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr2528783otq.367.1557512058405;
 Fri, 10 May 2019 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-2-git-send-email-larry.bassel@oracle.com> <AT5PR8401MB116928031D52A318F04A2819AB0C0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB116928031D52A318F04A2819AB0C0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 May 2019 11:14:07 -0700
Message-ID: <CAPcyv4juGEo=sMX01YuqPY9oYDjBjmRp7GvreNnX8YvKQz=SjA@mail.gmail.com>
Subject: Re: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD sharing
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Larry Bassel <larry.bassel@oracle.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:32 AM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> > Larry Bassel
> > Sent: Thursday, May 09, 2019 11:06 AM
> > Subject: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD
> > sharing
> >
> > If enabled, sharing of FS/DAX PMDs will be attempted.
> >
> ...
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> ...
> >
> > +config MAY_SHARE_FSDAX_PMD
> > +def_bool y
> > +
>
> Is a config option really necessary - is there any reason to
> not choose to do this?

Agree. Either the arch implementation supports it or it doesn't, I
don't see a need for any further configuration flexibility. Seems
ARCH_WANT_HUGE_PMD_SHARE should be renamed ARCH_HAS_HUGE_PMD_SHARE and
then auto-enable it.
