Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E2C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E7720657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="iEwEkuLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfCYWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:08:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43823 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:08:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id 67so8280765oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ceng7MEn+EPPEjmmMzg+oLfKm5kRneybZRwoX4/Yhhk=;
        b=iEwEkuLrMBSz5v9/dHyEPZUwbFpSwKLinA3PRBmhlN9fNjsJAP3GPceGjEPaQG99JP
         puIvSTbQaCQC36yfuDzkoDCXZkGKSh61rY97FinplPDryDWu/RRwlTTVMbw4j82LdK8x
         YoUDk9zxxPEMhfaxtyJJJZjh4r6j8zgKCcLVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ceng7MEn+EPPEjmmMzg+oLfKm5kRneybZRwoX4/Yhhk=;
        b=mwq7CBpGsXxLS8aUBKJEGTwiLgobNHE255AYRdQKXCLMC0KvrzKKRXQg+1fomhE5C+
         VIUSSKZ9x6zdv+8TOQGvntMG/diNiblqb8mD4MxGYEC4Wew+8KhFQA8c5lSuEeaWrYP7
         tO/8dUH0/q0UuCMsPUQM7lCOn1a7nIak8cnj/Ra43+SNp8sE8GnFxGK7Rp+xYfxCGqvI
         A5eplsq1wn7QoRskFCyhnFkoYjF/mZS5R6TynsuSTMyyx+RsKkWdEhDd2FYpGVp9sAll
         Fc//FssT6Pw6BFaCuijnR3Oa7d9QeXyS/i/ZCDS9LfVandnKZMPJHiOqBo15qGT5w1lY
         DJDw==
X-Gm-Message-State: APjAAAWY7cKgrswSnJjJRMCEAVJhwBc8AZZfXy8UBgr1bN0t/kG0HgV+
        PM2KuULkbHnKjt+GwVJ6XVEKGUNBWQFDvK7Ly4sxSg==
X-Google-Smtp-Source: APXvYqzHOM83GRXD+UWdzuZaPmOZegv+xlU7Y/Er/asaSHzFxxZJnImRKhQcd9Tr3C3Xeuxkxjky67bANqPfxH6Zy7U=
X-Received: by 2002:aca:f511:: with SMTP id t17mr12775417oih.115.1553551728518;
 Mon, 25 Mar 2019 15:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <1553440122.7s759munpm.astroid@alex-desktop.none>
In-Reply-To: <1553440122.7s759munpm.astroid@alex-desktop.none>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Mon, 25 Mar 2019 18:08:37 -0400
Message-ID: <CANaguZB8szw13MkaiT9kcN8Fux6hYZnuD-p6_OPve6n2fOTuoQ@mail.gmail.com>
Subject: Re: shmem_recalc_inode: unable to handle kernel NULL pointer dereference
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:30 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> I get this BUG in 5.1-rc1 sometimes when powering off the machine. I
> suspect my setup erroneously executes two swapoff+cryptsetup close
> operations simultaneously, so a race condition is triggered.
>
> I am using a single swap on a plain dm-crypt device on a MBR partition
> on a SATA drive.
>
> I think the problem is probably related to
> b56a2d8af9147a4efe4011b60d93779c0461ca97, so CCing the related people.
>
Could you please provide more information on this - stack trace, dmesg etc?
Is it easily reproducible? If yes, please detail the steps so that I
can try it inhouse.

Thanks,
Vineeth
