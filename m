Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C6EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C87F2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwFDwO7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDHR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:26:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43698 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfDHR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:26:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so8006738pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6QxCx1woXIJoxK0RRPDeFB8xTfIuPiCOmQqUjahb29M=;
        b=BwFDwO7HJYO/Sbbcl6GcpnqnkQ4R9noghslVuBIR+gRjaWXL6r1GbrudJUXrRfBigr
         TKdQ7T7tXJ4kfqwb2xPtKx0RUcdCZ5O8GOL3mEX/8doZRh9RsZbteU+JVSTZNbdI0Hvn
         UHb02KHL5Ce9FFqCkC/G5noSeBD6J2gGwSKIvms09qpFjWVHolNvSOSu41FyT0m3wRL6
         7R2ljrawSF/wN1T/kd+Htjyd58MnRGhVT+QC8iobCL3XWEZxx7RKmENejmWknC63Jrr2
         G8xV9D8zEh4G/1MfkcnBXmEfSObjtJd6K6A1XkuH/A0YHD7JUskDNQxVx401rdpvexeN
         jJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6QxCx1woXIJoxK0RRPDeFB8xTfIuPiCOmQqUjahb29M=;
        b=aYBANgegh/225+B0FOzibHlHP348Ul6i4wdKNnq7M93EkxINZ24lHFbU87rvi4R9Za
         aK+PT+M05HTO7ba5I49X3pVDo8L4zu+ayHEQ4sGNdONAHDEisgFp4UYMuOxGEaYittnS
         rYTqHwNaqhMLhp5FGqqtsjRnAFLRYS1onkCumxkk6TVHuRQMEgVISwIcwV3YSs7p1Q4F
         7kEuzW1gjLVFNCDwLqq3E7JXep9RSTgZswlPy2mUXJW9uWVQdKj5Zb5mYKdy20j91Om0
         EXfiBnBkpPtutXQyCdOCDesVAsFE4XyOHdfy2UxGy/LEGNjapqfo8tiEOfoYf6FfzEYj
         gMmQ==
X-Gm-Message-State: APjAAAXx9NNNwNCOJVTxsZ9Id5yZcEL3hVuM58OdreWBlQfi7ME1Q7nS
        b4cU3kXqtzYrICMkdLDpcdVjbw==
X-Google-Smtp-Source: APXvYqxoD7TJg/5RfiXfJwBrQPJ5TVIwaYDza8AWix3cekWOYoWn0tQ/GaA6txBLqUceRZqwTvpb5w==
X-Received: by 2002:a62:ac08:: with SMTP id v8mr30836524pfe.42.1554744395845;
        Mon, 08 Apr 2019 10:26:35 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id x128sm26790619pfx.103.2019.04.08.10.26.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 10:26:34 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:26:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Hugh Dickins <hughd@google.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: shmem_recalc_inode: unable to handle kernel NULL pointer
 dereference
In-Reply-To: <1b0bc97a-8162-d4df-7187-7636e5934b23@yandex-team.ru>
Message-ID: <alpine.LSU.2.11.1904081014060.2770@eggly.anvils>
References: <1553440122.7s759munpm.astroid@alex-desktop.none> <CANaguZB8szw13MkaiT9kcN8Fux6hYZnuD-p6_OPve6n2fOTuoQ@mail.gmail.com> <1554048843.jjmwlalntd.astroid@alex-desktop.none> <alpine.LSU.2.11.1903311146040.2667@eggly.anvils> <alpine.LSU.2.11.1904021701270.5045@eggly.anvils>
 <alpine.LSU.2.11.1904041836030.25100@eggly.anvils> <56deb587-8cd6-317a-520f-209207468c55@yandex-team.ru> <alpine.LSU.2.11.1904072206030.1769@eggly.anvils> <1b0bc97a-8162-d4df-7187-7636e5934b23@yandex-team.ru>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Konstantin Khlebnikov wrote:
> 
> I suppose your solution will wait for wakeup from shmem_evict_inode()?

No, it's the other way round: shmem_unuse() gets on with its work without
delay, shmem_evict_inode() waits until the stop_eviction count has gone
down to zero, saying nobody else is at work on the inode.

Waiting in shmem_evict_inode() might be more worrying, if it weren't
already packed full with lock_page()s. And less attractive with the old
quadratic style of swapoff, when shmem_evict_inode() would have freed
the inode's swap much more efficiently than swapoff could then manage.

Hugh
