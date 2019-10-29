Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4726F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572367949;
	bh=W4XX97PoCbD1ccbiz4hoXwSku4pWV6yF2Na31s9mC+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TLMs6mz2JcQopAJsBoUNCNrAt0P/XwBRcI9M1z0IzEpTi3u+HHORpw0cLw4GOnBlb
	 0fa0JTCaCpc74pXksTaWk4fzEQqRO+qKXwJYg4lJXtov7sMPk/E+HryODKpywBzqu0
	 eE8rYcvu9f6MZ3kfphsG6iAbRT1MZIeRlaKa8Ip8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbfJ2Qw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:52:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44618 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfJ2Qw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:52:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so7640057lfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCP0gTNW0nrKOjfGXUDHkeT9LXYh8gTwBFSl8WQWe9E=;
        b=PCQcPN9krk/MLfnozI5e+YmrRxCY8nQ2YUphNRQ+Q7PWvraCFUevYyKeC3hb6cSU+E
         ptoftGM6aIVugo0NJ5Sj7+8ikD83EWAw+XBoNW6982A8TmkIVBVLCjVZXretXxGE0hIE
         uxSzFEmOYqjXztMzAKG2M3avS6nE/p3Mb230Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCP0gTNW0nrKOjfGXUDHkeT9LXYh8gTwBFSl8WQWe9E=;
        b=Szu4e4Yj5ekKW+X5cigHeRda9m4BdC34IfGUvkYHrU3tZDU1my//a3eHkSOh5k457H
         DzgPSQ/xDzeCgAd7p2lNZI3eCaAZvdmAS+EoYRplyEcl6MKjU56i63X19fMVE+BLTD2n
         yKxLSuq9fI3kzed87t8ObecOfxAdkhGUklQAUefmM7d02OKfOVyz/qTLV06m75kTLcVF
         khFtxuREqzuNCaswsEoKTu0Nl9v/1AfIrPkqp+rYG60ZTdr3I3L/HB5pyuP5TB01zNUI
         qIAwaELNgm8r4HJXIq/c9c8IrE2FS3Z4aDE6ygFKFoIXmX+5YA2evVo4mmx802fW2I+h
         ZeZQ==
X-Gm-Message-State: APjAAAW+bV+lpBqVoBfyJHPSdHoENeMaIyXhd7m6h72AFm1Hc0O0KXxF
        vwQekVs4PxgLKdWFoOXRGUeNYz7HxciGeg==
X-Google-Smtp-Source: APXvYqyXJiPJ3pogpekO4vUxWClrqHIhqBzSwKtizkWkaNy2A0LLnTLWfkt9BbwAQwQhLVbOUKfBuw==
X-Received: by 2002:ac2:5097:: with SMTP id f23mr2249151lfm.90.1572367943335;
        Tue, 29 Oct 2019 09:52:23 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 81sm7614434lje.70.2019.10.29.09.52.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 09:52:22 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id t8so11034108lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:52:21 -0700 (PDT)
X-Received: by 2002:a19:820e:: with SMTP id e14mr3088342lfd.29.1572367941598;
 Tue, 29 Oct 2019 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
In-Reply-To: <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Oct 2019 17:52:05 +0100
X-Gmail-Original-Message-ID: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
Message-ID: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 3:25 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> I think all network filesystems which synchronize metadata lazily should be
> marked. For example as "SB_VOLATILE". And vfs could handle them specially.

No need. The VFS layer doesn't call generic_file_buffered_read()
directly anyway. It's just a helper function for filesystems to use if
they want to.

They could (and should) make sure the inode size is sufficiently
up-to-date before calling it. And if they want something more
synchronous, they can do it themselves.

But NFS, for example, has open/close consistency, so the metadata
revalidation is at open() time, not at read time.

               Linus
