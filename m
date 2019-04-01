Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C97CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603BE20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDATYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:24:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDATYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:24:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9F4942822A0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: How to add Unicode character tables to the kernel?
In-Reply-To: <CAHk-=wg4OqHpbckCcan73TXkB-rxS1C2M53uLs27Gw2w4PzR5g@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 1 Apr 2019 10:51:39 -0700")
Organization: Collabora
References: <20190331230940.GA30957@mit.edu>
        <CAHk-=wg4OqHpbckCcan73TXkB-rxS1C2M53uLs27Gw2w4PzR5g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 01 Apr 2019 15:23:57 -0400
Message-ID: <857ecd5y2a.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Mar 31, 2019 at 4:09 PM Theodore Ts'o <tytso@mit.edu> wrote:
>>
>> The question is how to do this, with different tradeoffs.  One is to
>> simply include a utf8data.h file, which will be 320k.  That might
>> sound large, but in fs/nls there are 3544k worth of similar files.
>> Some are relatively small --- only 16k.  But others are quite large
>> --- 480k to 856k.  The table for Chinese character set is such an
>> example.  So in comparison, the 320k size of utf8data.h is quite
>> compact.
>>
>> The problem with this solution is that the files in fs/nls, and the
>> proposed utf8data.h, are generated files.
>
> Oh, we definitely don't want to copy the original huge tables, and we
> don't even *want* people to edit those things in the first place.
>
> So generated files are fine. It's not like the source data isn't
> public, and yes, the commit message should have a pointer to it and
> how to get the source and the generated files. But no, we shouldn't
> feel like we should encourage people to be able to generate their own
> modified unicode tables.

Thanks!  Ted, as you know, the current patchset depends on the original
tables, so I will adapt it to only include the generated files and
submit a new version to the mailing list.

-- 
Gabriel Krisman Bertazi
