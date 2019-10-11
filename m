Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29835ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC97206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570821919;
	bh=98065Bg8MTyfPeB4ywZiFBsrc13EdLd6EYrQt4VTnrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ll/dJJd/gJ0+co3hUJgRS1LoEPbzjaHifQCu4BhjAen6tv1nL06shnNG1FdWVVZRj
	 EduiROepacubcYHG07HFZ4CH6JPjYpdL9+U8Zwoyz29NEX1JFllaXZyskcgWRSWk7u
	 adMvskH0GkRT+zCmiiQhxKxvq3Ycs6+c4WFYXlVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfJKTYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:24:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42027 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfJKTYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:24:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so10863032lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=RKelw3XTZWr2fMIszm4fiPSJKM6JXno/egHsKyWt4ulwFQMu6s8kxaUjF9a1NatARA
         65uN4laUlTdl8ZdvrQailFcDmEk9gIgZTIaz5xoo01WNPvC19FeRMUmzCV3ux4iR0luW
         Hfue3vcmZOaTSmgI2TQ+rRt/J+LpNSEzf8wgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=sEyhiCxQDghgntUqRR5FU26kEiI5BjeUkAqCN7oc2pjt13NP6JcJUT5fK95Ohr49y2
         byCoberDX7k845DxWmvYVHIryswHDPgcK1FeV2s6l3ps6PHWHyQvILRBzP5SQ0ee7Ny1
         6agbf+0v+TX/+Mh60Qg3WfjGkx0yVj3SJP1fArCv3qhKVjVcm0afFL06eM4cTZ3WXPvM
         e4UNcdPAQJe4YVH7tjnCNPIiZdtenvLUg2qhOURK8nHCGJaXjdgPAsu7U7mw9FAj8diB
         XDOSpUU2AXBfT0u5hPLEVZx2bdMBZUZKEHVRqWWQXFaBuEcVvsz/SkZmQ6KupRIemFzv
         uldQ==
X-Gm-Message-State: APjAAAXYc8orCnd1tZbvEaKFIdQbxSdLX5NtOnHDY7pTHul/rpMASFuh
        SG/KTEZYImhSJ4AeiV+o74+XB5gMKGo=
X-Google-Smtp-Source: APXvYqwZ20Lj8/z5KoLIPnbehAKvd3X2DUrfcdSUnMTY89F5tQByF+X9Umk7OmntHduTuwO083vPoQ==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr3164148ljj.27.1570821882363;
        Fri, 11 Oct 2019 12:24:42 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t27sm2149215lfl.48.2019.10.11.12.24.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 7so10889900ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr4366223ljh.48.1570821879742;
 Fri, 11 Oct 2019 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011143610.21bcd9c0@gandalf.local.home>
In-Reply-To: <20191011143610.21bcd9c0@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 12:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 11 Oct 2019 11:20:30 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Willing to do that instead?
>
> Honestly, what you described was my preferred solution ;-)
>
> I just didn't want to upset the lockdown crowd if a new tracefs file
> was opened without doing this.

Well, since they introduced a bug in your code that killed your
machine with the patch _they_ did, I don't think they get to complain
when you fix it the way you (and me) want to...

Fair is fair.

             Linus
