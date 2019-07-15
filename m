Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02064C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF2621738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJokrS+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfGOVWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:22:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40273 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfGOVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:22:00 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so36495316iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdOTdZc5CyeYXsr7PKqimgFx+Tc5tMirB8c0EaxZfps=;
        b=eJokrS+qweBYwEYADF8KXz0DydkvuxL7otsgtyRyCanPQKsKOfn3u/uDhYyLSBfVwa
         Q5MQRIquyye74WtDNDemfSmWLMYiTpUK1MhSsguWyGjTy8Pcgvoa9UUCOSFxzt1qDVQX
         XZ9seouy0h2ch6g7KFchGKAjF7seWmOZBzX3DijQpcGtF2UdWlgoiMqDlawVCpGm8GVw
         qcO7104wiEL4VfTuYGIjBmyZdY0xfTkyCO9mlQ9YWeRqBzFdRYpjJ0G1udbNEzzJnSw7
         BAubZPVq3+P/tsVOum40eTx/KfqXNii6z5xFsNKLDrfnUU4gAP0OJ9LUtLq2mEJ6j+/h
         YwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdOTdZc5CyeYXsr7PKqimgFx+Tc5tMirB8c0EaxZfps=;
        b=iCe3h827yqVZd+8TbSF/OjljuRPU5FQ2n4hVgE2K2Cl+j90Hhk9hgNlpmwRVlfDfOX
         eNyxZ7+HU0NCTZm2OKOiEglLWpUfA+bpf98lMKsHlgGEORyVLVfgtq3Kn9X6XdsM1ri1
         vkm/9APY5HqE+cijj1cpKwNAD94kxyTRjFag/ya+1mjic0DQtazM2rrcnfWbTMvy6gPV
         28VLmFrtlT3J9nXPJsnhEKVcDrMi9CtUHnMR7X3b2S3/SYaFws0TcjKTZIdHKDMrqLRq
         lksNnVHIp7RI8P1jhjpxpoB8PLD+A+dF3Tms692HFc1dMJqU0xq0dMT3+/kONJ48f+xI
         nJeQ==
X-Gm-Message-State: APjAAAVxDII5B9n9NVqw/h7EXWMnPm02ICrl6ABPntBgErpbXPptvwQR
        4KLNcIG02+0fppMY+xAPjhfXD53TJK64V71jmzUoOQ==
X-Google-Smtp-Source: APXvYqyk5yE7MCphZkXr/9c9UskEoQtlnOLxlTpMfuJThBn/u/uKw55tSMEuGdBGOKm+L6zdGS9zT6NItKfbobLd6Uk=
X-Received: by 2002:a5e:9e03:: with SMTP id i3mr26607453ioq.66.1563225719176;
 Mon, 15 Jul 2019 14:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164705.220693-1-henryburns@google.com>
 <CAMJBoFMS2BiCdBFBEGE_p5fovDphGqjDjaBYnfGFWhNvCnAvdQ@mail.gmail.com> <CAGQXPTh-Z664T3Uxak-CiRn6Mc-s=esRzURLpwQaN+v0RgxFyg@mail.gmail.com>
In-Reply-To: <CAGQXPTh-Z664T3Uxak-CiRn6Mc-s=esRzURLpwQaN+v0RgxFyg@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Mon, 15 Jul 2019 14:21:23 -0700
Message-ID: <CAGQXPTi9qMCujvkM67Y28KiTP7xyGiR01ci9Yb6fgq8pW_tcFg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Reinitialize zhdr structs after migration
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Vitaly, I had the wrong impression from your email that
INIT_LIST_HEAD() was being ensured directly in migrate and got
confused. (I thought you were saying it happened through the call to
do_compact_page() queued).

That being said, I don't see where in migrate new_zhdr->buddy is being
checked. We do check for new_zhdr.work with
 if (work_pending(&zhdr->work)) {
...
}

Is that what you were referring to?
