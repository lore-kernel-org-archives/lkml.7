Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85811C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D44D21655
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570927592;
	bh=Af3xuDOmu2mRlmVHh8KyOwgmi8BjnhCayyjozArl5rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IUXkZXwcFv9Nm6ShxYQNIsT8DjzmZaDj/hr+Rpw1zDVfQBcGjhmkpIkB2kDWuuEdV
	 eq+BbtSEN4ajGBRyL751FBkQopnI0a4AmDtwHihTPE5lHyWULBhuUQFzrXaFb6I39r
	 8dwLIvt/za/xcHUIrbZp+KU9piJ/h7bjIzxk+Azg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfJMAqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfJMAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:46:30 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D394821A4A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 00:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570927590;
        bh=Af3xuDOmu2mRlmVHh8KyOwgmi8BjnhCayyjozArl5rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFNSfK2nnknqf6YFpBWiswhdWqZghVAzwLOkXuFG627W92nSo0N5VKik94xJUR6d2
         9CD+Fgek4xkfURdNb1GlJI283z/EqpXfWatZGaljVv9wHnfuHFqUI+Hzq5kH5d1oIw
         cU+h8TENoLgwakgyqMhU5M5q3iSWg2kJktcfg+Js=
Received: by mail-wr1-f46.google.com with SMTP id n14so15618767wrw.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 17:46:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXGspvKg1kRHh1SxMLNWAt6zjoo9wKNPbAEdci67hdo0qrM1zRn
        tB4hrJZnjivGCvP4Rj0t5FDanDz/se9USRgNA2ykng==
X-Google-Smtp-Source: APXvYqysITTY9tkM0esE0JJ93/2Q/PuAdhhDrLgBh3/GK6dojhCF2+0RUifa4NNExyW7LOYnqyH2VI9/xqzLzckWab0=
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr4610565wrx.111.1570927588270;
 Sat, 12 Oct 2019 17:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-5-dancol@google.com>
 <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com> <CAKOZuevQD-xsy_PrvT7F3Pqaoo5apZFukj2ZKLLQKup1cwgZ-A@mail.gmail.com>
In-Reply-To: <CAKOZuevQD-xsy_PrvT7F3Pqaoo5apZFukj2ZKLLQKup1cwgZ-A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 17:46:16 -0700
X-Gmail-Original-Message-ID: <CALCETrWFFbgdR3qtsQhxdMbaocoeHHkwpTQ-mQKJ4mgWBHz-Ng@mail.gmail.com>
Message-ID: <CALCETrWFFbgdR3qtsQhxdMbaocoeHHkwpTQ-mQKJ4mgWBHz-Ng@mail.gmail.com>
Subject: Re: [PATCH 4/7] Teach SELinux about a new userfaultfd class
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 5:12 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Sat, Oct 12, 2019 at 4:09 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > Use the secure anonymous inode LSM hook we just added to let SELinux
> > > policy place restrictions on userfaultfd use. The create operation
> > > applies to processes creating new instances of these file objects;
> > > transfer between processes is covered by restrictions on read, write,
> > > and ioctl access already checked inside selinux_file_receive.
> >
> > This is great, and I suspect we'll want it for things like SGX, too.
> > But the current design seems like it will make it essentially
> > impossible for SELinux to reference an anon_inode class whose
> > file_operations are in a module, and moving file_operations out of a
> > module would be nasty.
> >
> > Could this instead be keyed off a new struct anon_inode_class, an
> > enum, or even just a string?
>
> The new LSM hook already receives the string that callers pass to the
> anon_inode APIs; modules can look at that instead of the fops if they
> want. The reason to pass both the name and the fops through the hook
> is to allow LSMs to match using fops comparison (which seems less
> prone to breakage) when possible and rely on string matching when it
> isn't.

I suppose that whoever makes the first module that wants to use this
mechanism can have the fun task of reworking it.  There's nothing
user-visible here that would make it hard to change in the future.
