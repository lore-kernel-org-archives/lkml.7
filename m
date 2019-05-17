Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECAE20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Dh+1CbT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEQGzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:55:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38755 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfEQGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:55:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so5852034wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=4Ft7vXd1zuW+VBauzDv2GqD/tRxDd6qBcaHK1f4P0u0=;
        b=Dh+1CbT6CcF0vPmgJk2+E2MWtzwYSqSzTXYy6MkqNyqwJ4O7EEhwvIK0mt900W4AUC
         i+ym48gKb2zVLc2yruZU/QElE/hfhRKAk8goAtPKPbAAtzn/9GhV3HfGPRKW/x6OB9O4
         YAOK7dJavS8lvJLnYNNTYJrm3nM26WdErWCLMWIUO5Ibo1CC0zKEgfRQS+UbWp4QCXtG
         klfR3yQ1604qtCSQT2irXTeGzZv13hyeNDsJfb4CDMwVzw5b9AJsW1d3NpCrbxp5bDQy
         rWv8t6ZiaMu+DEYYs/jVG+nsY3m6tNWEMzq06os9YP4X0LDP3Xv80VHQMJnK6Wm9A4Kh
         1SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4Ft7vXd1zuW+VBauzDv2GqD/tRxDd6qBcaHK1f4P0u0=;
        b=PVPAIsrV0H+4MhtTh/O+OShTojOagKxHVq35NeWwuD06eVS19UWJqDBBJX4TSePM/K
         fkoMQWxz5pP+OnI/OEMn8I+Cb7xcpyWWKvgXkBy1T8MfwRBuwoPPyqT/CgoYWm01L/Li
         0ujrFmJDWsOcy+wKYcp2JRbdNM/wFyzW7ifRU4ijLa+2Spx4Ox9/bs1FHNwlJ2A4ACfZ
         EI9XmW+HQoIdf2lK4efO/VPb46y6AgrXOH6Yfmmw3IDuw6SXiCapgE/f2vI4dYqB1h2u
         HK+QJjN35p5WBH4Y42CWk/ABBC4scJsoMXF/QTQCY9UUT+mqFm7ovOksF8V5n3xswVqg
         DC/g==
X-Gm-Message-State: APjAAAXgN99H/7T5cZXcxQbqTWmBiQr3Yepkl219g7uo0H6mYQBQxzoy
        D+URvq4bG2GHF/mxj8od/cqHsg==
X-Google-Smtp-Source: APXvYqxlzt7I3AKYu26X01bVUVKlpPBiyYa8Q4VkKvznW1qD7TyuMByccR8dAdsIOGEIHnNIr90JsA==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr5189366wrn.198.1558076098185;
        Thu, 16 May 2019 23:54:58 -0700 (PDT)
Received: from [172.18.135.95] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id v5sm14219659wra.83.2019.05.16.23.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 23:54:57 -0700 (PDT)
Date:   Fri, 17 May 2019 08:54:52 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190516202331.GA29908@altlinux.org>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk> <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io> <20190516165021.GD17978@ZenIV.linux.org.uk> <20190516202331.GA29908@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <D41D33CA-ADFC-4E79-9C9C-79FE19E068CA@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2019 10:23:31 PM GMT+02:00, "Dmitry V=2E Levin" <ldv@altlinux=2E=
org> wrote:
>[looks like linux-abi is a typo, Cc'ed linux-api instead]
>
>On Thu, May 16, 2019 at 05:50:22PM +0100, Al Viro wrote:
>> [linux-abi cc'd]
>>=20
>> On Thu, May 16, 2019 at 06:31:52PM +0200, Christian Brauner wrote:
>> > On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
>> > > On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
>> > > >=20
>> > > > Hi Linus, Al,
>> > > >=20
>> > > > Here are some patches that make changes to the mount API UAPI
>and two of
>> > > > them really need applying, before -rc1 - if they're going to be
>applied at
>> > > > all=2E
>> > >=20
>> > > I'm fine with 2--4, but I'm not convinced that cloexec-by-default
>crusade
>> > > makes any sense=2E  Could somebody give coherent arguments in
>favour of
>> > > abandoning the existing conventions?
>> >=20
>> > So as I said in the commit message=2E From a userspace perspective
>it's
>> > more of an issue if one accidently leaks an fd to a task during
>exec=2E
>> >=20
>> > Also, most of the time one does not want to inherit an fd during an
>> > exec=2E It is a hazzle to always have to specify an extra flag=2E
>> >=20
>> > As Al pointed out to me open() semantics are not going anywhere=2E
>Sure,
>> > no argument there at all=2E
>> > But the idea of making fds cloexec by default is only targeted at
>fds
>> > that come from separate syscalls=2E fsopen(), open_tree_clone(), etc=
=2E
>they
>> > all return fds independent of open() so it's really easy to have
>them
>> > cloexec by default without regressing anyone and we also remove the
>need
>> > for a bunch of separate flags for each syscall to turn them into
>> > cloexec-fds=2E I mean, those for syscalls came with 4 separate flags
>to be
>> > able to specify that the returned fd should be made cloexec=2E The
>other
>> > way around, cloexec by default, fcntl() to remove the cloexec bit
>is way
>> > saner imho=2E
>>=20
>> Re separate flags - it is, in principle, a valid argument=2E  OTOH, I'm
>not
>> sure if they need to be separate - they all have the same value and
>> I don't see any reason for that to change=2E=2E=2E
>>=20
>> Only tangentially related, but I wonder if something like
>close_range(from, to)
>> would be a more useful approach=2E=2E=2E  That kind of open-coded loops=
 is
>not
>> rare in userland and kernel-side code can do them much cheaper=2E=20
>Something
>> like
>> 	/* that exec is sensitive */
>> 	unshare(CLONE_FILES);
>> 	/* we don't want anything past stderr here */
>> 	close_range(3, ~0U);
>> 	execve(=2E=2E=2E=2E);
>> on the userland side of thing=2E  Comments?
>
>glibc people need a syscall to implement closefrom properly, see
>https://sourceware=2Eorg/bugzilla/show_bug=2Ecgi?id=3D10353#c14

I have a prototype for close_range()=2E
I'll send it out after rc1=2E

Christian

