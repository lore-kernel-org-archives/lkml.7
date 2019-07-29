Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011EAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FD620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0+IKuRgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfG2Vzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:55:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40899 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfG2Vzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:55:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so27969165pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3T/GUVqteqkHmzbznEpOcbT8aQLi9+EOOC3CkxIeJbQ=;
        b=0+IKuRgKJDd0xjqL5gtk2BFAMRK8s0lZYqu98SVbYw8Opdb7SvDYJdXweso/6QDKuK
         BPZOrN3vmKEqndYKEb2amHgMb+/qdUJ5BBpWPHz1rR8/WBDdrnCbm1ETqI6OSjU2euvz
         U52UbzMYRhYvhYIsJSqU5DH/0B5Hy+KnW56b59SAcRGWqaMgYyx1FSfuprcyxmf5wPjI
         fnnc/MKxOQDOfXRXfrfoNEy4TkJOsoeuIGVZvDZhYjhDzHJ7iPEFfEi2w50JNtg3xpen
         k9wBhPx26/3mX0blGY1Uku3r3yZIaFl3Pzsu8tq7bLT93S7vLonaqjmofwau+GweZYA+
         1C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3T/GUVqteqkHmzbznEpOcbT8aQLi9+EOOC3CkxIeJbQ=;
        b=WzrCL8PUwOO3jwUDy4VGOzU4yVZdLsXmiqiRRrRnoQEWcbtaOGGXXPnzQoaQbEswg1
         e12gi9nKlU5C9aQ4TsvO9ejRfgUTCBGd+svek9ocOW0cEW/rsW6K3cat9ZKeY2nfUQ5B
         c04Y4aGICvt0ckEl5nrNWAcWhpxYG+DjmqQRPQApPXxPqfNtwjHYrsRLdxEbX2guuHRQ
         SjqSE+Gdh9pso9636RCNFfQCLEkHlWD4iJ4LXY/3ELhoTFOR0Lg8AoQlZgy+mzgZ7krM
         h4N87IigcpsrBRt3r2HgJ4TMHeEk0RXgF+moufC9784t/WuXnuAx7507unHMZylR0FkF
         xmJQ==
X-Gm-Message-State: APjAAAXgxsBjA9JEbjmxTKirrtSPjMWgpoJKWNJrVMKrTEF7aHnvFfjQ
        i0abdsthHIizb+quAeXhc88=
X-Google-Smtp-Source: APXvYqy0zTt4ZzZa+EL9RdGc10104jnsAL60+sIs6pFs26GZju/HmH06oB8VngKbhZmNZHGN4ZHsjw==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr77398507plr.202.1564437343656;
        Mon, 29 Jul 2019 14:55:43 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id w18sm79993616pfj.37.2019.07.29.14.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 14:55:42 -0700 (PDT)
Subject: Re: [PATCH v2] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>
References: <201907291442.B9953EBED@keescook>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e515b31-0779-4f65-debf-49e462f9cd25@kernel.dk>
Date:   Mon, 29 Jul 2019 15:55:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907291442.B9953EBED@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 3:47 PM, Kees Cook wrote:
> Jeffrin reported a KASAN issue:
> 
>    BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
>    Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
>    ...
>    The buggy address belongs to the variable:
>      cdb.48319+0x0/0x40
> 
> Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
> eject_tray()"), this fixes a cdb[] buffer length, this time in
> zpodd_get_mech_type():
> 
> We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
> ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.

Applied, thanks.

-- 
Jens Axboe

