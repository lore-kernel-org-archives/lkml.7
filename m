Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E0CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8241E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PLgLyLnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEQHCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:02:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEQHCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:02:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so5894735wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Ss4NB5m+SG0EZIQDhH7NjLniRsiUjmxyrNTSlSe9Hss=;
        b=PLgLyLnGuNGgT8VXGDwFxsshlERTrEv9OeoVFs0VRs0YgE+oPWe56SBGIyYtrVf2qT
         h2pdyfEY/oOLqsJF5QN2mBsXJLsqmOkXJo/R6RZYSLOMW/LOsm5w2oJ8lYNTcc3uA17x
         2EV4wPAYG/ukn1NpGIT68nOA5b3i25a7sq3W9IhHEuhpuFTpbQ1AU7cpe8D7hESI6PPv
         lovLb4l0+uh5JFzw3HisD90486y8A6x05kXEZ6ctIlvmi6xE6u0nnGaMk7kNuYD2Eraw
         stZ+ACK2Cb7HA29wckCg26It3pti49UGs62KuUwdrA1d8+FhhFMcUsA+GBaNXrnM83sl
         Igfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Ss4NB5m+SG0EZIQDhH7NjLniRsiUjmxyrNTSlSe9Hss=;
        b=lbIZSnBodFdEh2ikkTo74nWQ9T6o2GgdPMI+UdEb9fC0AvgLYHpZatyj5p6HHZ4JM6
         Cxjdl2XWIphBXuFl+4SejGWccndT8c1PF0e6w6k5Ec8/Yhc1M7nIPbwBj33xywCrQon5
         XpjvuCAXuZFPaomEs2K8wNa8P+5E8DpXKTiKx4U91t8MbqVkS9A11OsANuoyjAmGn6Sp
         x0WjikaWU3mw2wwKue0HKtJrMWzk5qdvB2EdvmPcxMOJNqYKWOAEowrRQv4l3ChgnArL
         vRHC+DyDMI8Ek/FXN61TQCblABrNcNziZZG3z5fLjzjGXecAigEJlehLi+PAoEpKSScF
         Nbcw==
X-Gm-Message-State: APjAAAWUL2Q38hwx4Fj24KIFEWBuk2UpZKN7UYPydaHS50wHllRZzqyO
        OQO6LNSokjVQbPs892YVZWI48Q==
X-Google-Smtp-Source: APXvYqwlgwQ3Ti3QErOn6prvvwGIqOr2oU52GGb1WUMpJUlWibmqRpjYkl8UEH1bwumcelp6Jd7x0g==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr6314398wrp.37.1558076518190;
        Fri, 17 May 2019 00:01:58 -0700 (PDT)
Received: from [172.18.135.95] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id e8sm16976835wrc.34.2019.05.17.00.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 00:01:57 -0700 (PDT)
Date:   Fri, 17 May 2019 09:01:42 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190516165021.GD17978@ZenIV.linux.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk> <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io> <20190516165021.GD17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2019 6:50:22 PM GMT+02:00, Al Viro <viro@zeniv=2Elinux=2Eorg=2Eu=
k> wrote:
>[linux-abi cc'd]
>
>On Thu, May 16, 2019 at 06:31:52PM +0200, Christian Brauner wrote:
>> On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
>> > On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
>> > >=20
>> > > Hi Linus, Al,
>> > >=20
>> > > Here are some patches that make changes to the mount API UAPI and
>two of
>> > > them really need applying, before -rc1 - if they're going to be
>applied at
>> > > all=2E
>> >=20
>> > I'm fine with 2--4, but I'm not convinced that cloexec-by-default
>crusade
>> > makes any sense=2E  Could somebody give coherent arguments in favour
>of
>> > abandoning the existing conventions?
>>=20
>> So as I said in the commit message=2E From a userspace perspective it's
>> more of an issue if one accidently leaks an fd to a task during exec=2E
>>=20
>> Also, most of the time one does not want to inherit an fd during an
>> exec=2E It is a hazzle to always have to specify an extra flag=2E
>>=20
>> As Al pointed out to me open() semantics are not going anywhere=2E
>Sure,
>> no argument there at all=2E
>> But the idea of making fds cloexec by default is only targeted at fds
>> that come from separate syscalls=2E fsopen(), open_tree_clone(), etc=2E
>they
>> all return fds independent of open() so it's really easy to have them
>> cloexec by default without regressing anyone and we also remove the
>need
>> for a bunch of separate flags for each syscall to turn them into
>> cloexec-fds=2E I mean, those for syscalls came with 4 separate flags to
>be
>> able to specify that the returned fd should be made cloexec=2E The
>other
>> way around, cloexec by default, fcntl() to remove the cloexec bit is
>way
>> saner imho=2E
>
>Re separate flags - it is, in principle, a valid argument=2E  OTOH, I'm
>not
>sure if they need to be separate - they all have the same value and
>I don't see any reason for that to change=2E=2E=2E

One last thing I'd like to point out is that
we already have syscalls and ioctls that
return cloexec fds=2E So the consistency
argument is kinda dead=2E

If you still prefer to have cloexec flags
for the 4 new syscalls then yes,
if they could at least all have the same name
(FSMOUNT_CLOEXEC?) that would be good=2E

>
>Only tangentially related, but I wonder if something like
>close_range(from, to)
>would be a more useful approach=2E=2E=2E  That kind of open-coded loops i=
s
>not
>rare in userland and kernel-side code can do them much cheaper=2E=20
>Something
>like
>	/* that exec is sensitive */
>	unshare(CLONE_FILES);
>	/* we don't want anything past stderr here */
>	close_range(3, ~0U);
>	execve(=2E=2E=2E=2E);
>on the userland side of thing=2E  Comments?

Said it before but, the list was mistyped so again:
I think that's a great idea=2E
I have a prototype for close_range(start, end, flags)=2E
I'll wait after rc1 and then send it out=2E

Christian
