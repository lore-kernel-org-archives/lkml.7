Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314A12184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsQskc9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKPQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:16:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37388 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:16:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id d5so11535509otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=leQP7w6Wd8/nHQ8w8DwldOm2MjClO/82CYqD+qmowYg=;
        b=JsQskc9U6qWQPqhpsIpTIYY5TrCAee8ZhIkjRkRg71HFWa6n6t7/3VNRCRT2ljanm1
         Xpcpy319ZXaKl4BZJD2TY17PxCEvb2+4TnU2/cEvChEeB4S5nnMWuRz+EoqGxLLa3769
         g2hzp29p+NPHE9p9xbaRT65sXJb3h4uagGoxMUghDVuRl0UZ+76I6se6593aRbqixGOi
         6QRRt+IxQMdhOwDOMcsKVxo5bzg9cPXxeqJXIJnoed5WCsD6uQ7fQK1SPylHGSKZgtSv
         SS0o0eWEwg92MBbcZccHVkzrpdgrkhAPY5nHVFt9kH1G7EQfAtyX8/KGGP/w/BWwm5/G
         w3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=leQP7w6Wd8/nHQ8w8DwldOm2MjClO/82CYqD+qmowYg=;
        b=i0z3BV3iTYYhb6EzqaNqyje79SGIq/LM2H7q87phFElJyWQUg64bRqMw96OwIUcvnD
         HtYxBX56HMzqM/OfEW/JoJaEqGbWR5JfykixBBOXlxq0vHu7N1Y+q1tlFefMW4zy29Bv
         W8FG3dTHkLLSAiup0G4P7Gc8tTvEkhbPvKiX8UWBFAcwkfhjyqyI1hRhrZ0cKIcreo1v
         Cigceu7VWx504qGbyTtPiRMuy+eDjFTk1gpFYE+loY6xHDMeJk69FrhzN1qq019H1XBj
         0OQqzBHBJnhAX+AfK6lhV0rDevOduBmk/HqOTLNB1mzrXENlkKYiCKAKcDzAF9z+3eg5
         Yt2w==
X-Gm-Message-State: APjAAAUZTAGz6zf8GXxX9XHCFDqsMfgvpVE+H3KVrivsZboniNi/kxpr
        33akydmyzHShReCM0YKh6KLcGB80GGb5P1IKCX7HJr+bymg=
X-Google-Smtp-Source: APXvYqyt/IkbFIh9Cl1Lv8X68IFC1LWWvUcr8H+wBhmRbeRhg4F6LhQKaLJoxWurrZgZN5uSlVIhyPCFQuyVf+dyubk=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr12701581otb.183.1573485384956;
 Mon, 11 Nov 2019 07:16:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 11 Nov 2019 16:15:58 +0100
Message-ID: <CAG48ez3zpBwU6vHSuY6VoP+Uw_Jz6uxYN1Teg2wSpwZrPmAn-g@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:03 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Michael Kerrisk:
>
> >        Another  difference  for  the  raw clone() system call is that t=
he
> >        stack argument may be NULL, in which case the child uses a  dupl=
i=E2=80=90
> >        cate  of the parent's stack.  (Copy-on-write semantics ensure th=
at
> >        the child gets separate copies of stack pages when either  proce=
ss
> >        modifies  the  stack.)   In  this case, for correct operation, t=
he
> >        CLONE_VM option should not be specified.  (If the child shares t=
he
> >        parent's  memory  because of the use of the CLONE_VM flag, then =
no
> >        copy-on-write duplication occurs and chaos is likely to result.)
>
> I think sharing the stack also works with CLONE_VFORK with CLONE_VM, as
> long as measures are taken to preserve the return address in a register.

That basically just requires that the userspace function declaration
for clone3 includes __attribute__((returns_twice)), right?
