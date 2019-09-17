Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B06FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C54206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d69BRr0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404495AbfIQHqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:46:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41012 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfIQHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:46:31 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so5265898ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r390VayBj/3xi39RJHDAEzLS1ApSogHRMpyEDeFIW8U=;
        b=d69BRr0xyCV3c6m95lJoLGl50d5Ex2yqBOKw46rMtzmuV+Rwa2hW6rI6MP3zGZWCPJ
         PqIuE8ISWyF/nAilyQbnrrZCdoF2Wp/tzdsqdPKrpeMPGuLtcmuDTUONwR1pCJh5iggB
         P4e+ZNnTSwRYWzLJdcoe3g7iiH8ekCwtPMrto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r390VayBj/3xi39RJHDAEzLS1ApSogHRMpyEDeFIW8U=;
        b=mtir4dy57OBFoGKRtCnSwFKIOlPkDXgVgAMTTWWxirzSFgTly0xlYbduHB2t9/DpS2
         Ok/XqLwn2oHQISKjXXLj+CwsrAJ3hhCqODjHtmgJ6rQMxtL1+h4H2ztrGBRrGlQwd29e
         bW01O4DZtDprcGyYHQ8cxuB3GY/cZk5s1FmTA5HG+ApjZUUeFOCLmud2OOdd+CwAW19p
         ux8laWoMm+1mBb98GcM1V7Hzf64XURP9b2JKK8PsMxKf5fWZJ5l8wVdWWPPhSDMkbCOb
         Y9Gpr6INyLHbnexx3QWiR7v3r2tZ+N5DuWNv51uiWBXJZanjISxZQlTIWLBaIV13pqwK
         ztTQ==
X-Gm-Message-State: APjAAAVh+IL2f+scvaSjMntEmcVpt0LGHiM6Q3nS8g+ziXYbsUHXzed8
        9APgAefqHf1K3bEX562Stw00UY4VZsVOXcyly7VuzA==
X-Google-Smtp-Source: APXvYqzThDNp3uLhZD6yQ/WCujicMU9B0P8cMPS1zdRMUKzEUMRMi+zP6x28grxRopNvWCakybIIt5ptAYCVqLRZcYg=
X-Received: by 2002:a02:b388:: with SMTP id p8mr2684640jan.77.1568706390957;
 Tue, 17 Sep 2019 00:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190916235642.167583-1-khazhy@google.com>
In-Reply-To: <20190916235642.167583-1-khazhy@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 09:46:19 +0200
Message-ID: <CAJfpeguRPTRyb9eaEsKXmv2xsfJfy4vrNp05RNiL8AuqbDwkcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: on 64-bit store time in d_fsdata directly
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel B <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:56 AM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
> ->d_time"), as the additional memory can be significant. (In particular,
> on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
> this can consume significant memory.

Applied, thanks.

Miklos
