Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A694C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67B2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2Zi5ilU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfKGIzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:55:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41385 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfKGIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:55:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so956100lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWZb6GLCF2st+ZVn+OJmwleeG1odyNOnzVdWxMN71m4=;
        b=k2Zi5ilUpvfwvkE4Ppxa+x0nf4km4BOuvWm1ykPz7BHyrgqo9vEkTpio3e+6YeSAiA
         ksg0hvGFAxJJ5+A1qVHYbExIOTneSQo46Sclk8UiCKSz3NT2s4jWy4p2tAEvwQrmNNiU
         R1dMTOqkY/lBDgJo9yps5cz+dnI+fVkq6IK2r1jtC5lneKbhlws47UcUOwdRPKltMqm6
         zij//x+VBfeyEyoCWdveF8tUyAQEZ/iEK//xFdiRYEFxUGp0LG7WkmOsphoK1smcLmLN
         NJv5g+5Rf59q8D3VZyo4H3tIiMq2sFCIea6ZVnCBi3GTqfgWNkPBXG3iEIDBsP1axhe2
         e4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWZb6GLCF2st+ZVn+OJmwleeG1odyNOnzVdWxMN71m4=;
        b=kf9ejgmSM2vzcO1r6vIThB/yWtRTC9jQl1K2XcEeHm9WMUjj8uXoCnKx8/xYVMe1mb
         cf+uT6fWBMrbx2ZIOWCkwXmkhnfM8oYP/cUQOU0TDf2ysDmCJw5oFAoEBkpWo8/5JCix
         sTR6FNATBzY5DZZmW2pVF+HINyniTr3xCOrdIsCAHeIFlZVBTIe8CWmbna1BdbDSgVnv
         gpUV/Vd5ERTCn1vmlr93UGPZHHPck5yQ1xRvtUyNkVxZmSkV4f1MbOTBYEIQ92T/t2Hc
         mDLB34ILuKSlqk3Jyg78Js1W8OCo2eW9RlFt3S8Aj4Hhv8KVdnsGld3NlhGCybBGgfAX
         QV5Q==
X-Gm-Message-State: APjAAAWfx7O0swUCjs3iV7KgNR7nlU1n/30AxHn2fJ+P4jX1VcDzKcpT
        /JkJ9WfXILetmNNsll5QX1YJlnq1Fi957IJ7qNy5Yw==
X-Google-Smtp-Source: APXvYqwjmdL6xPlKTj58mFSrRkwb7zeLwRzSWb8Xgzdfaw5gPK5uHdRZEynEOzKUFWJ8jFmyiGAvxtKcJWxmRt9gblQ=
X-Received: by 2002:a19:8582:: with SMTP id h124mr1571095lfd.64.1573116935696;
 Thu, 07 Nov 2019 00:55:35 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com> <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com>
In-Reply-To: <20191107083902.GB3247@linux.ibm.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 7 Nov 2019 00:54:59 -0800
Message-ID: <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:39 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> On Tue, Nov 05, 2019 at 08:41:18AM -0800, Daniel Colascione wrote:
> > On Tue, Nov 5, 2019 at 8:24 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
> > > flag that uses the ioctl to receive the child uffd, it'll consume more
> > > CPU, but it wouldn't require the PTRACE privilege anymore.
> >
> > Why not just have callers retrieve FDs using recvmsg? This way, you
> > retrieve the message packet and the file descriptor at the same time
> > and you don't need any appreciable extra CPU use.
>
> I don't follow you here. Can you elaborate on how recvmsg would be used in
> this case?

Imagine an AF_UNIX SOCK_DGRAM socket. You call recvmsg(). You get a
blob of regular data along with some ancillary data. The ancillary
data may include some file descriptors or it may not. Isn't the UFFD
message model the same thing? You'd call recvmsg() on a UFFD and get
back a uffd_msg data structure. If that uffd_msg came with file
descriptors, these descriptors would be in ancillary data. If you
didn't reserve enough space for the message or enough space for its
ancillary data, the recvmsg() call would fail cleanly with MSG_TRUNC
or MSG_CTRUNC.

The nice thing about using recvmsg() for this purpose is that there's
tons of existing code for dealing with recvmsg()'s calling convention
and its ancillary data. You can, for example, use recvmsg out of the
box in a Python script. You could make an ioctl that also returned a
data blob plus some optional file descriptors, but if recvmsg already
does exactly that job and it's well-understood, why not just reuse the
recvmsg interface?

How practical is it to actually support recvmsg without being a
socket? How hard would it be to just become a socket? I don't know. My
point is only that *from a userspace API* point of view, recvmsg()
seems ideal.
