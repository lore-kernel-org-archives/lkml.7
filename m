Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0AFC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE76F206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lO6qF6x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfDYU3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:29:47 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53170 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfDYU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:29:46 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so2308438itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeRjZGIi29J9UcGvV4ntvpRnkfTKsCp6AYnhMmfL4PQ=;
        b=lO6qF6x/lsmtbgZV7Bw2GdcM06jup7E4clccinkLC7oVx6jtRxGjeWolacT+lr/2f8
         oUEWqQrVXjfAqipfNz0HRbf108oLI5dZ03xBc8ZWzK2S6+hjw7ZYo3/zGCrFlhQDx/9E
         T+yHpyYho4gisZp2aEMZZtURuZC62A5hRh7ON5uOxwYCLxTAOiESvK/stRcCcmONoPjK
         nXBHASXzEntp/r4hNSR2RsB3e4SgCtVSN1/sTOrRtaGT8XpIIeAlqnTzqxKQveAWz4zB
         84vJH2Ab7t1rA96aTrVHCLO4zJrj2YR+r6jUKFnjnFdlhrUeg790QgMv79o8iy9wvQrV
         jg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeRjZGIi29J9UcGvV4ntvpRnkfTKsCp6AYnhMmfL4PQ=;
        b=LC2ZARfcC8c8ELVMdIFzzhWsR1NF0zj/+kJtVUGxONG5rTQbmeTegk/iYnonE/XgYU
         owoJdj0Hmhms6dmajkhuC7ZIKVew40BKg75PmA+M6iTbnFcDqqG04PovVk4EzCucLIx0
         HLB+Xj4OJ0YG+StXzUoYLKenV2gKIfk3AboPvKo5abzm7WBM5m+2ZOZ9r6Rdtz6FaGv6
         Qh5xDuECdB1DMlDRgJcKu5waQT9cnsAb4qpgv4XGwh6cp6btLudgMWcxNHSbCv6RvW1M
         5SxBE4D2h+FoJZ4cM9xTRebIU52fJkZzavaZU3ofed7nX7NDD5QGdlyKlNaebCCm+Ejs
         kufg==
X-Gm-Message-State: APjAAAVLe63WYNfzP9cqJny03dzDmdWW2ElIIExKztovYFaaF8aBj+Hg
        eoZDv7t3unQvmM18JU6eeP0lSVdM+Th6EBBhXgnSkFSUcM4=
X-Google-Smtp-Source: APXvYqxCCyQ8DGk96WCnOlOChzZ2LUpTOEO0t7U28XHmQuV7D6Ak8m/yQN8PJ18mYwH7ldueo1fA0A+bC6+AwLEozUE=
X-Received: by 2002:a02:c955:: with SMTP id u21mr29477992jao.105.1556224185529;
 Thu, 25 Apr 2019 13:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190424191440.170422-1-matthewgarrett@google.com> <0100016a55209db0-efc46978-fa1e-48be-b17a-fcb6b58ae882-000000@email.amazonses.com>
In-Reply-To: <0100016a55209db0-efc46978-fa1e-48be-b17a-fcb6b58ae882-000000@email.amazonses.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 13:29:32 -0700
Message-ID: <CACdnJuuZ37Bs7NtzdN-AiPhZy7B+EMphutDxxYFTu6k=j1ugqw@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
To:     Christopher Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 8:32 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Wed, 24 Apr 2019, Matthew Garrett wrote:
>
> > Applications that hold secrets and wish to avoid them leaking can use
> > mlock() to prevent the page from being pushed out to swap and
> > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > can also use atexit() handlers to overwrite secrets on application exit.
> > However, if an attacker can reboot the system into another OS, they can
> > dump the contents of RAM and extract secrets. We can avoid this by setting
>
> Well nothing in this patchset deals with that issue.... That hole still
> exists afterwards. So is it worth to have this functionality?

On UEFI systems we can set the MOR bit and the firmware will overwrite
RAM on reboot. However, this can take a long time, which makes it
difficult to justify doing by default. We want userland to be able to
assert that secrets have been cleared from RAM and then clear the MOR
flag, but we can't do that if applications can terminate in a way that
prevents them from clearing their secrets.

> > Unfortunately, if an application exits uncleanly, its secrets may still be
> > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > killer decides to kill a process holding secrets, we're not going to be able
> > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > to request that the kernel clear the covered pages whenever the page
> > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > will only work on 64-bit systems.
>
> But then the pages are cleared anyways when reallocated to another
> process. This just clears it sooner before reuse. So it will reduce the
> time that a page contains the secret sauce in case the program is
> aborted and cannot run its exit handling.

On a mostly idle system there's a real chance that nothing will end up
re-using the page before a reboot happens.

> Is that realy worth extending system calls and adding kernel handling for
> this? Maybe the answer is yes given our current concern about anything
> related to "security".

If I didn't think it was worth it, I wouldn't be proposing it :)
