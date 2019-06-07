Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD81C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BC420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559931001;
	bh=Bu+793MjBdgwsS7TNlYKH+X3sGrKTTjIrCWYlqziT+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1cywg6eCZXg3n4yVTZ2umWu6MjzHn5rwNjVorCSm3KJwnrNmZPr3oK79V4AxHPhc+
	 sG90oEXrIbLbenCxj6/kTlciUXPg8P5Txy9i/We9BERQHc9WJcPz5+bn+1vhRMRHrF
	 AWK+Lk2DH9TdT3aM9MUO8MYL8tnKrLHXDh316xSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfFGSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:10:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbfFGSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:09:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so2532994lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZt9HN8cGMdF69JUby4Fl+9oCqt6sT/iSareBA7Fniw=;
        b=Qdo4w0jxKAKwm+D28iUQP+s4tbiCdRXmdUo7XLy5SPAitpxpXbfKyJwkFvnAZgHz9z
         UiISb0kNKNiHNbthtPbmwpMALewaezDpxqw9axhE6qeWe7nwhKpYio286AAO9aMTmJly
         4P0lgor1jtxZNE2o3QJeCD+ZVInUJJhoUSMUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZt9HN8cGMdF69JUby4Fl+9oCqt6sT/iSareBA7Fniw=;
        b=FzxmoOSw0YU4krDdywP5Y/xaIwcU0WcsJLZrqEWTZgTkzb8gFOkCZI3nix3+0fWcj2
         oz8DRyKkzm81xbqEqvuY9nvLkiNqOn5M/q0puBKbVel22VBg+juIDthf6y2yvMXd6LIm
         vbkQLg8pC/YffeI9tpsOZfypWrLyM/T6aOzKu8NK04ZeDr8/6T3PZnLAs4FrJowP+WR2
         muYqBL9E2TYxVcoFf4sx+y3XpObLbcHUFb0TBZ11in8hfzruryNA6DiBCnjWPoMQ6jJX
         UMKrPiEWxSfQrQHxPGt3WHS/1zieprgydYJ8RcfR4jOWnQgvqFLxgxZD8HLE5s1hKRGc
         ZKzQ==
X-Gm-Message-State: APjAAAXXxR4DDjOMdt0ZU1swYzQeM3xlK2W8/PffypNsxyLdxMcQjF+Q
        CKNw/VukDIoZmDxR+Vct9q+ZVJiTx98=
X-Google-Smtp-Source: APXvYqzrBhydtnRtlYmRxe8SwmS4ZUnxWX61awS3UFXnJj57vrKclmMpbecRhQu6VEeplnE60AR+3Q==
X-Received: by 2002:a2e:9106:: with SMTP id m6mr14422866ljg.164.1559930996900;
        Fri, 07 Jun 2019 11:09:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n10sm522233lfk.39.2019.06.07.11.09.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:09:56 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y13so2288274lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:09:55 -0700 (PDT)
X-Received: by 2002:a19:2d41:: with SMTP id t1mr27337806lft.79.1559930995535;
 Fri, 07 Jun 2019 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190607103122.GA22167@redhat.com> <20190607103154.GA22159@redhat.com>
 <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
 <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com> <87imthclyt.fsf@xmission.com>
In-Reply-To: <87imthclyt.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:09:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDgKA52SpzrW_dy76Jx6qxE393xzhiyQQ+rtic399PYw@mail.gmail.com>
Message-ID: <CAHk-=wgDgKA52SpzrW_dy76Jx6qxE393xzhiyQQ+rtic399PYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Eric Wong <e@80x24.org>, linux-aio@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 11:03 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Unless I am misreading things io_pgetevents isn't restartable
> either and ERESTARTNOHAND is a bug in that case.
>
> Is the bug going the other way?

Yeah, I think you're right, and that should be EINTR too.

Or at least be conditional on whether it had a timeout or not. A NULL
timeout obviously _is_ restartable. But I don't think it's worth being
clever here.

                Linus
