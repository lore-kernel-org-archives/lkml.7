Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513AEC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732021537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpsAKtUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGIJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:11:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40792 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfGIJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:11:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so9328342lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LTtPPOn4Ak8eK9FW8AabXZcBEJh0Lnb8xIdmS0/IJU=;
        b=QpsAKtUKi/9eTxa+EeMW6C9efPOxUkmSK+eftMzIKmxy/utKmzJkDuPGkCNljZhsc5
         7iGyYTINlQH1eyfo1fjveiJ4DUGoW55nFZnlng1tG8AIyVg2vFN0ut9eN0lBIMq1EkE5
         f++VbpJFM+hwEokcwO+WXfLlCQwI9IaiH3l1EKg0RMDB27aXHmOLIUwRPhlh6FZ3KSnm
         qSa1D99CUlPAR/fI5sejfEI19alRwKz0FrBuodUW1DWIJEu95TRxrWHXgnLm9HGrVJ1q
         BQZX54uMeqpe7Fe0u9LObF19YHlaNubRtH+zSJfn1UwBuWYpB+mxCouPVukEYPIuEhFj
         14Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LTtPPOn4Ak8eK9FW8AabXZcBEJh0Lnb8xIdmS0/IJU=;
        b=UsGpeprMmCOy/144ieQPss7nGyiVnpaExpzkRFUG2Y8OUoBoi/qYEkLQJIjJamvELD
         i6FvR5SA9NrzzvoJhczRlsz7aQQHvG7ApmgJ7ubN4YKI0IEPCN2MhzxlmjhXqh41TSBP
         PUb2G4p34EkhBq5ILvVJIwmfHjKpymylkFHDklOJ/fTqi1jZADvDlRHke7RjnWGC9VDz
         51nmfWSHxkwUz1AVUeTZvsNe70HgzlI8AcvVOgg+ZlTtBmhtGD0l99spOSUFmv3yc9C2
         1bS8yKgidN4GwPYdv0fOuh8yESQZw61N5Ge0+JckIaTr7XuDwkfdDMvlxhgOKMnKMpRH
         CBvw==
X-Gm-Message-State: APjAAAUHhM6+vsUYr/T0WLIA0m9+/zowHgHy+pRVTu4UdeI/gjV+cucl
        iIavtoydqRRrgbJ90xi2npyG3oeBW5kEs+J6/KnUeg==
X-Google-Smtp-Source: APXvYqwiB3XqZd0MLimd/C9W++RvKxUs5C/lBSsyMkteU5OX/BLh17CZP9xgh8x3if6F4yr2ncjHO1cjnBQHMatTz0c=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr10055087ljh.69.1562663488615;
 Tue, 09 Jul 2019 02:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1561671168-29896-1-git-send-email-opendmb@gmail.com>
In-Reply-To: <1561671168-29896-1-git-send-email-opendmb@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jul 2019 11:11:16 +0200
Message-ID: <CACRpkdbgMyYYm1v4BeFQBCz8jZVLE_0oZiKu5F3Rt6=ccfVnYA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: only adjust sections of valid mm structures
To:     Doug Berger <opendmb@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Peng Fan <peng.fan@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:33 PM Doug Berger <opendmb@gmail.com> wrote:

> A timing hazard exists when an early fork/exec thread begins
> exiting and sets its mm pointer to NULL while a separate core
> tries to update the section information.
>
> This commit ensures that the mm pointer is not NULL before
> setting its section parameters. The arguments provided by
> commit 11ce4b33aedc ("ARM: 8672/1: mm: remove tasklist locking
> from update_sections_early()") are equally valid for not
> requiring grabbing the task_lock around this check.
>
> Fixes: 08925c2f124f ("ARM: 8464/1: Update all mm structures with section adjustments")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Cc: stable@vger.kernel.org ?

I'm not smart enough to say whether it is the right solution, but
I also want to test this on some boards I have. I suspect this
may be part of the problem I have with mounting root on a USB
stick on some early mpcore machines, so I might come back with
a Tested-by.

Yours,
Linus Walleij
