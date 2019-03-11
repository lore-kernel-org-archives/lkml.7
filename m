Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B586A2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCKQg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:36:28 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33351 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:36:26 -0400
Received: by mail-io1-f71.google.com with SMTP id n15so4563744ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=v/W4l2oeEfeSQAeMVBpOW2XizYCPg5XJwuQyB8vi++c=;
        b=gINaEn+uaFP+axYGbyPb4aMJxuvuMN6K2UNcWcSomZ+MznPK2/EDbN1+P5zIpctwdt
         c94MSgdwq7WRVakJAa0S4iW9JZ31K34UCZeqYBz2abAlgFFqS9HkSGhY9cYwKkHzUKn7
         aMoUx+SOm4f4bQ9NPcan8qQdEm8cZSP3T4eaE8wxqIwnhIu3UCk/oxrAwUvmBg6EGfty
         hmK8S2iPaXVOhciynzz5aWqzxvG+OIHs35NfGVC8jS9eaNKwxW4XlPNRi/iB3E4svyjf
         UMkrm9qayo+07z4W+wj/omVTqLNtRlCWVd3xUzlX8dRZrAzkJ2s5rFUhyOosFLTPQzjW
         FlTw==
X-Gm-Message-State: APjAAAUTmh86O0McuQZDSh+oFw0sY7XUjm3W9Z22ylExmMgl6hDyRsmt
        VRfbKb2PvlHC1RLof4Q8JLjPfO3WWlKzlEBj8G3oXiyQh0er
X-Google-Smtp-Source: APXvYqyh1kjd66e8Qn9/ig6ya3to1B1vGO6ikYmmsr8EuU+SQKk9QUYL+oeFzc2qZvYkmYXlJR+TV1AHu9ZdKfy5xaYaijTc60QD
MIME-Version: 1.0
X-Received: by 2002:a05:660c:150:: with SMTP id r16mr298962itk.39.1552322185632;
 Mon, 11 Mar 2019 09:36:25 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:36:25 -0700
In-Reply-To: <CACT4Y+YLZYJ21Bao5HVAvXhvb9PQ41J-4RvtkZZEMF38qtkxHg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073a5740583d42c1e@google.com>
Subject: Re: Re: WARNING in ep_poll_callback
From:   syzbot <syzbot+@syzkaller.appspotmail.com>
To:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Cc:     akpm@linux-foundation.org, dbueso@suse.de, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, rpenyaev@suse.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 11, 2019 at 2:53 PM Roman Penyaev <rpenyaev@suse.de> wrote:

>> On 2019-03-11 14:45, Dmitry Vyukov wrote:
>> > On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> >>
>> >> Hi Andrew,
>> >>
>> >> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
>> >> removed from your tree, at least I got a notification on 9th of
>> >> january,
>> >> also I do not see it in the linux-next tree.
>> >>
>> >> Should I ignore this syzbot message?
>> >
>> > If this was resolved we need to communicate it to syzbot one way or the
>> > other.
>> > Since it was in linux-next, it won't even be able to do fix bisection.
>> > So the bug will be open forever otherwise.

>> Bug was fixed (commit was simply dropped).  How can I tell syzbot to
>> shut up
>> and to resolve the issue?

> Hi Roman,

> The docs are at:

>> See https://goo.gl/tpsmEJ for more information about syzbot.

> There is no official support for bugs fixed not by commit merges.
> Linux-next creates various interesting corner-cases for the process.
> Let's go with this option for now:

> #syz invalid

I see the command but can't find the corresponding bug.
Please resend the email to syzbot+HASH@syzkaller.appspotmail.com address
that is the sender of the bug report (also present in the Reported-by tag).


> --
> You received this message because you are subscribed to the Google  
> Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an  
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit  
> https://groups.google.com/d/msgid/syzkaller-bugs/CACT4Y%2BYLZYJ21Bao5HVAvXhvb9PQ41J-4RvtkZZEMF38qtkxHg%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
