Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35589C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254F223BB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXnkLskS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfGWIQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:16:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGWIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:16:36 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so79913060iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItgzODWjIbCfFoPhrAm7MqYgVwgajEGQG3krTes1pwk=;
        b=ZXnkLskSMoSwZc5PzKd3b3dUGDE3gRBg3CiBhV2jjp1nxhOnmxN2yGuS8g4HWHu7NS
         4AliFx4CXsSdhQLNSqGVYHNO4NCPBw5hauaKdIyNvHSzLNHtzzebVnnzBQr50GtUN1L8
         C43tFKj8rS27WoAqFhPwMupnXt72xhwPhEyH0GJwuD5cAiqCwZz1d25YK12R92f6xuvG
         RY8+W/xc8PFz4SbpIMhCWz45jecwtDfbPIKDgKdk5B3hCLmflb988hOhpxCXU3oqlIME
         cyjc3x2MvG1N8SPNQVfHXHKj329fB2uBmGGwxx/QmbZ9p1mVdiVden7zNVPsSRDiHJbo
         iMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItgzODWjIbCfFoPhrAm7MqYgVwgajEGQG3krTes1pwk=;
        b=cWZsfM1iBCXZCSWYq/qzHPBhP+DrbCfALE6KUIFZr18m81xnoXG8AS5YnKZ+i+pKuo
         f7hP95acOcEFWi7F6bFWn9YkmGoGHraslb9HgoMi4uwUT19qRSvedvgmv3QQBvz47u5B
         JgONVvh1ybaYMpiR8tyPDJgJdSpLLs7X8maRMus0q2c57WVBlnqZomDu+aGOiV7dku8W
         feRGb0ZfmDPU2V7Ag7srQ/7v8oKWOYhjJrt5OTGt+JHOww3Xx/sUmqv8IzkCKBIxfTJc
         2tni8IZ/BxvH+S//6APJQqKeePT7/GQ6kLw2KJOth6OXudhi2hlVAsieknDYh3oVJ44q
         pTFg==
X-Gm-Message-State: APjAAAWbKaQTHltbj6J8mFxj6j3zshMWrg0y33KwbhlY676YecUmU+kH
        rlUR/a9hlvUAlWvclzsp3gZ2BahxVPrCBVhqZ19+6w==
X-Google-Smtp-Source: APXvYqzJNKMQpwXLGy1stVnHVldbWHpui5JgVFyimhte/10meEBELEs9ajvjEPGbTb6yeamB6oISV/VYaDUVEFAPGCI=
X-Received: by 2002:a6b:b556:: with SMTP id e83mr67623901iof.94.1563869795505;
 Tue, 23 Jul 2019 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f19676058ab7adc4@google.com> <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
 <20190611185206.GG3341036@devbig004.ftw2.facebook.com>
In-Reply-To: <20190611185206.GG3341036@devbig004.ftw2.facebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 10:16:24 +0200
Message-ID: <CACT4Y+ZNTh=t62oj_Y5XyQwjOJp3AWwWi8c-4DrX+jKNCVqzzg@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, mwb@linux.vnet.ibm.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:52 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jun 07, 2019 at 10:45:45AM +0200, Dmitry Vyukov wrote:
> > +workqueue maintainers and Michael who added this WARNING
> >
> > The WARNING was added in 2017, so I guess it's a change somewhere else
> > that triggered it.
> > The WARNING message does not seem to give enough info about the caller
> > (should it be changed to WARN_ONCE to print a stack?). How can be root
> > cause this and unbreak linux-next?
>
> So, during boot, workqueue builds masks of possible cpus of each node
> and stores them on wq_numa_possible_cpumask[] array.  The warning is
> saying that somehow online cpumask of a node became a superset of the
> possible mask, which should never happen.
>
> Dumping all masks in wq_numa_possible_cpumasks[] and cpumask_of_node()
> of each node should show what's going on.

This has reached upstream and all subsystem subtrees, now all Linux
trees are boot broken (except for few that still lack behind):
https://syzkaller.appspot.com/upstream

No new Linux code is tested by syzbot at this point.
