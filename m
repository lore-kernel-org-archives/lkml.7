Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D31C76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981CC21721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563235520;
	bh=piOXQeY06JPCbmjpjb4VUzp823ZxS1bYEAb7P6Bg000=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EJgmJSTlVRfgL8EcooLHzs8tmzKWaJgrNOSCktvnHTXEc1wmf+92ftwmkT2ZjNWAK
	 gY6QkfXNPb7HMJtiVNCIE+wMZTW4k68Dk9TOy11kgZqpeglNXVFS9tdsiEJgbMP7S9
	 u0hlsKeqQXpJRKIHJFa/ivlxWZHZg4P+vv6X+By4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfGPAFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbfGPAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:05:19 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDDC2173B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 00:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563235518;
        bh=piOXQeY06JPCbmjpjb4VUzp823ZxS1bYEAb7P6Bg000=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y2Ky5stlz1vjJHjrhqC+/Z4/SW6q7GLgSIANYaO6MjGtN8a6+MAIdSifb6xJgfmRX
         8qHvdM14LxOUi4kcFHTo0MTMsNTIqmL/8aEa9YOsKIpof1/oS3f6JymbIAn5uxKHTD
         8wqoQx4+n3WGWh/XO47UPQtWDPzF7EZPjydUVjdQ=
Received: by mail-wr1-f43.google.com with SMTP id g17so18907683wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 17:05:17 -0700 (PDT)
X-Gm-Message-State: APjAAAXmWCYiZE32gaBwOBhlXnkWndH5E3K/BCIKPLz9L40CHj8yyLet
        oOsB9dqYw2wfQSFDAMnRaAvJOwnQlJPTS8od0GEs8w==
X-Google-Smtp-Source: APXvYqx0js9g/XgFkOCOiw+uw19siPzaDdmMc8GKluoJU646DWxzrGkc1mGVQwl+4SGTL6UZQX7cp5pa+mFQL1LRw7I=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr12173472wrj.352.1563235516486;
 Mon, 15 Jul 2019 17:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
 <602B4D96-E2A9-45BE-8247-4E3481ED5402@vmware.com> <4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
In-Reply-To: <4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 17:05:04 -0700
X-Gmail-Original-Message-ID: <CALCETrWBO6dUNzkyD12ZfEQ+biN8rhrWxm8YoNhgisDd2Spujg@mail.gmail.com>
Message-ID: <CALCETrWBO6dUNzkyD12ZfEQ+biN8rhrWxm8YoNhgisDd2Spujg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Nadav Amit <namit@vmware.com>, LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 4:30 PM Andrew Cooper <andrew.cooper3@citrix.com> w=
rote:
>
> On 15/07/2019 19:17, Nadav Amit wrote:
> >> On Jul 15, 2019, at 8:16 AM, Andrew Cooper <andrew.cooper3@citrix.com>=
 wrote:
> >>
> >> There is a lot of infrastructure for functionality which is used
> >> exclusively in __{save,restore}_processor_state() on the suspend/resum=
e
> >> path.
> >>
> >> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored by
> >> lapic_{suspend,resume}().  Saving and restoring cr8 independently of t=
he
> >> rest of the Local APIC state isn't a clever thing to be doing.
> >>
> >> Delete the suspend/resume cr8 handling, which shrinks the size of stru=
ct
> >> saved_context, and allows for the removal of both PVOPS.
> > I think removing the interface for CR8 writes is also good to avoid
> > potential correctness issues, as the SDM says (10.8.6.1 "Interaction of=
 Task
> > Priorities between CR8 and APIC=E2=80=9D):
> >
> > "Operating software should implement either direct APIC TPR updates or =
CR8
> > style TPR updates but not mix them. Software can use a serializing
> > instruction (for example, CPUID) to serialize updates between MOV CR8 a=
nd
> > stores to the APIC.=E2=80=9D
> >
> > And native_write_cr8() did not even issue a serializing instruction.
> >
>
> Given its location, the one write_cr8() is bounded by two serialising
> operations, so is safe in practice.
>
> However, I agree with the statement in the manual.  I could submit a v3
> with an updated commit message, or let it be fixed on commit.  Whichever
> is easiest.
>

I don't see anything wrong with the message.  If we actually used CR8
for interrupt priorities, we wouldn't want it to serialize.  The bug
is that the code that did the write_cr8() should have had a comment as
to how it serialized against lapic_restore().  But that doesn't seem
worth mentioning in the message, since, as noted, the real problem was
that it nonsensically restored just TPR without restoring everything
else.
