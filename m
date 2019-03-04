Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF55206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GphhOYxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCDSx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:53:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:53:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id z7so5283112lji.0;
        Mon, 04 Mar 2019 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2z4d/eiW5JXfpBSb1QEI8N347NMx4ogGjDq+OJ4hdzA=;
        b=GphhOYxiwYCaOLQy6NCy9Y4zb5B4H+WMlRkJVu9dEw1n3NyyP3d3EtcB8TiLKuLTGv
         GJxv+1V4z00z52V7wgOCgj+SRzt/Mb3ZVecfaBVnwBEiHTbbHmFdmMwKtfknwyhd0mDt
         arBd64pcJ+bEebeQFz08FyNqavSHJmhPTg81ynxTqPa2SrCsbe4uFgYdh0hUCiL8gyNs
         gglpp10VKrcQXAXyVfx4tLuonfE6p5FGV8JEQG7ylMNoB1U/QrBCb5e7qyYRoXATusjH
         QVJs6N4VzhEGkgSi+t3s1ShMbPFyrt24LNVOjjkBMCvk2f4JM9oyvwZa0mHWswAAoRad
         kVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2z4d/eiW5JXfpBSb1QEI8N347NMx4ogGjDq+OJ4hdzA=;
        b=LV2/654PK9rJeU6XsI8kZKcRDCKhfo4Q0+IOsPnIeBG/g10wkYrBU79kATRMQU3mcm
         eiaR0W0lpCCT0DKonW7mSMsTWZkJ6s+UAetSgCi/dOFDna5ZB84nFF03ktgWjqwSd1F2
         TwMM8JQuFxKJ3aHXSOTqSI77O7Ff5aJ1btJEJyCHGhQtfrtU0SA34jq4byeHRE0tZl9y
         O6sa5SLmmsdtbVmPpvvpqBbA3L1XiIiy/pnuAm4TY+te5XGzFXkn1KBXAfx2YCOeQCgX
         OtuVqb/o4CiKl2W3IFPpwqjoe+OFbtIw1htJGv7ij8wibyOWxvcTQieCd5anA6Fg1JFo
         MWTA==
X-Gm-Message-State: APjAAAWzfJz3emzow/6N/bKexjuUhjn++agyUFu9REn/cZ+g8wzarUpy
        oWgLZQexdCTYKDc6aEAeVE3QO5MHvbqCoTGVBC0=
X-Google-Smtp-Source: APXvYqytWhvBEm5rkf/v25A7IThk5Nirx9dFEAtCbdvCaXeQ7R71+cYqvygD1mDclKCNM5wT+EhhN35wsYMABI8r9iE=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr11436729lja.9.1551725634364;
 Mon, 04 Mar 2019 10:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20190304183827.GA6809@jordon-HP-15-Notebook-PC> <20190304184958.GR32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190304184958.GR32494@hirez.programming.kicks-ass.net>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 5 Mar 2019 00:23:42 +0530
Message-ID: <CAFqt6zarwg3NnkbNYKEO-jrdHUw8GwMqUrLDTqgQV3D1dux-qQ@mail.gmail.com>
Subject: Re: [PATCH] selftest/rseq: Remove duplicate header
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.ibm.com>, boqun.feng@gmail.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 12:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 05, 2019 at 12:08:27AM +0530, Souptick Joarder wrote:
> > Remove duplicate header which is included twice
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> That SoB chain is invalid.

I didn't get why it is invalid ?
