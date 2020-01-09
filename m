Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B62073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578613312;
	bh=V2TU7bmhK2rc0g3gTmxhO+8joHF8QS5c5TW8/rrWMSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MBXG9Rkol5Oi4Gz5NB9x2Y2+bCSCapCDn1rBWQtr3qRRqgjSCwQZxSGeqkWzWVBjX
	 X/ca3pecJW/kmhws9W4HEKOtNWiQB2oJnqhQhGTT8gha0goizG4T8JPmdGWj5XclG3
	 xZofgXmlr4eweIH8YhpET5VBcrpl3ZIBkFz8iD3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgAIXlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:41:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41259 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:41:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so159329ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfpfB0heb47nMgztDPhE6QVnvLuPdQSEP2b5ktH3qTQ=;
        b=JMCnPNu2FZKj4HmJcziRUk5O9yUgf94qqHvorN+sh+nwIlFA9njr0QdL7pC3p3/22w
         aUadfTYO3UAxVMhaO3fZYlehOasRUNSFGYP7qnx2IquOYnp2i+zuuvu6GIdGkOF22lTh
         KiDNWsr/WehUgh2ES9kDZ/ClZTU0gpsXokVzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfpfB0heb47nMgztDPhE6QVnvLuPdQSEP2b5ktH3qTQ=;
        b=gpwxqskP5reHSvYOWCan1w4p0NjjxBS728gocok8j+pORlHmVuTMHiRy8w/ivEEIkS
         V06kLFav1mE+RKdo1503NE97ua7y0Q26dxrMTGxz4n2LPawEgxUt7waKNz3YiDlhkGC0
         zHnfPHKLp0QOGKkjH4uN1oRjujVGSLGeBGBTAfupdmOEsMlxEvjd03/7c5COTZb4XQqF
         im5UY3a7fIi3CYuQqP4tZlkkLGccX1fPmDN8KA+2n/ncVhrvL9A3kJrqWcfnjfHWQb4C
         0iLCMoRBrXrkwflwe04N01RsfHiPeNXeZNJfgSKbvNeSdH8gDTCVjnLjxpCUnmOSb2ax
         3gvQ==
X-Gm-Message-State: APjAAAUldJnPYeMr76cszxigRPdd91DfXwGuCuirqrdskVIpV46JMfog
        4HkNolA066WnVpfhTcTJOMRzUd4eHBQ=
X-Google-Smtp-Source: APXvYqzfaqwDPc7l9guChin11/i0VFJqAbdxFPQ2yBVdoiWc/00PpY20qBIAwVUYR/ii7FSeO5jo+A==
X-Received: by 2002:a2e:548:: with SMTP id 69mr352956ljf.67.1578613309208;
        Thu, 09 Jan 2020 15:41:49 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w20sm64349ljo.33.2020.01.09.15.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:41:48 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id r19so183900ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:41:47 -0800 (PST)
X-Received: by 2002:a2e:8946:: with SMTP id b6mr367415ljk.1.1578613307533;
 Thu, 09 Jan 2020 15:41:47 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
 <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
 <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm> <nycvar.YFH.7.76.2001092137460.31058@cbobk.fhfr.pm>
 <CAHk-=wh_-q=MPtYmcb4gUHtQ2M96BVrzoDo3pauU-Ps9Q5uPtg@mail.gmail.com>
In-Reply-To: <CAHk-=wh_-q=MPtYmcb4gUHtQ2M96BVrzoDo3pauU-Ps9Q5uPtg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 15:41:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wji9frEf=nkfBmekhZs7QofyhDuT7_Lqt=kkjEZVAktzA@mail.gmail.com>
Message-ID: <CAHk-=wji9frEf=nkfBmekhZs7QofyhDuT7_Lqt=kkjEZVAktzA@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 3:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, good source code presumably notices EPOLLERR and handles it. So
> it _shouldn't_ matter what the kernel does if an error occurs. I
> haven't checked what people _actually_ do, tnough. I worry sometimes
> that user space just looks at EPOLLIN sees it not being set, and gets
> stuck in a busy loop polling in case of errors.

Googling around for it, I find this, for example:

    https://github.com/scylladb/seastar/issues/309

and yes, I think that's technically a user space bug, but it's very
much an example of this: they expect to get errors through read() or
write() calls, and get confused when poll() does not say that the fd
is readable or writable.

I don't know how common this is, but it didn't take a _lot_ of
googling for me to find that one..

           Linus
