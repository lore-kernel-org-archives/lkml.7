Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B72C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FBD2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOIVFCgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfG3E1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:27:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44143 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfG3E1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:27:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so28328980plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JW7f9vGQQeIdCYi5oG1fvaE4YOboQo/NkTQ3HgRPbY=;
        b=XOIVFCgtpJBWk7Tb9XaiqzDybNvI8C9NLyNpbCM+jYkR96724HsU8Oo89ShWGCm8xA
         bSPbvGE1nQP/EvgbPCMX1zENsk1ZgrSU7/kbrSrYH5IHY+TO8Zk64vnW+/Brd3IXZ6lb
         FNOlmHOsX3vUTVN3SprytpRzmhk3ZeMp6TT+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JW7f9vGQQeIdCYi5oG1fvaE4YOboQo/NkTQ3HgRPbY=;
        b=kGKujs7/84rpl+jMjhMxelkoOjjKjNu9ppj03r9ugBeHBZDYjTSSyCL+4yYQD1QE7z
         EhWZiwRlm+uzvMHAw12AkZ22Sk2WXzeAcs0CZNZgknJAT7o6bYiJEODgc71uje5GAI36
         IseVIYomGRRrcCFjeEcNiaYBuEOQEe22M6yL+4Od4Xfj7rO1k0u9JO7PJ5aWQj9XNd/H
         BPK9pZ/KQEQymU66fQlNDcVHps7hhOIoiuHeCi9d2C8aym8qVsqR8GHlyNKKG0zF7Dxj
         1WO8L6sdRCBW9NK8gUsFB2U0Rejj0K6104pY0YpqO06LnYDRHrZdUz6YfP2+sjHVkTKP
         1S2Q==
X-Gm-Message-State: APjAAAUfULgFpu+y27zHxapVwGSqFcLlMfANXzJP0awFBe94LqFitBqZ
        wlBoWV+tgROjqwBCbWNFdafnpA==
X-Google-Smtp-Source: APXvYqwSDiGUbFNXmD4UUuzQTrgUfwOEdKhVFVoru/Sd62ifjM3SEdL2qQ3F01JDwTlKcwncB0bs3A==
X-Received: by 2002:a17:902:2ac8:: with SMTP id j66mr108240204plb.273.1564460866293;
        Mon, 29 Jul 2019 21:27:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm93251303pfn.150.2019.07.29.21.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:27:45 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:27:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
Message-ID: <201907292127.8E1719BF5A@keescook>
References: <201907291442.B9953EBED@keescook>
 <3e515b31-0779-4f65-debf-49e462f9cd25@kernel.dk>
 <CAKwvOdkRxJ6Vtm8CX1ZgDgzzAywSyx7Y-nNFn+tVPf35YQc2YQ@mail.gmail.com>
 <6c270cac-e946-bba8-03e7-633a7c9006e6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c270cac-e946-bba8-03e7-633a7c9006e6@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:00:08PM -0600, Jens Axboe wrote:
> On 7/29/19 3:58 PM, Nick Desaulniers wrote:
> > On Mon, Jul 29, 2019 at 2:55 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 7/29/19 3:47 PM, Kees Cook wrote:
> >>> Jeffrin reported a KASAN issue:
> >>>
> >>>     BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
> >>>     Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> >>>     ...
> >>>     The buggy address belongs to the variable:
> >>>       cdb.48319+0x0/0x40
> >>>
> >>> Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
> >>> eject_tray()"), this fixes a cdb[] buffer length, this time in
> >>> zpodd_get_mech_type():
> >>>
> >>> We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
> >>> ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.
> >>
> >> Applied, thanks.
> > 
> > Dropped my reviewed by tag. :(
> > https://lkml.org/lkml/2019/7/22/865

Argh, sorry!

> I'll add it.

Thanks! :)

-- 
Kees Cook
