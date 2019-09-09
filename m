Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27180C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EF121920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfIIKkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:40:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfIIKkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:40:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7H5v-00043v-EB; Mon, 09 Sep 2019 04:40:27 -0600
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7H5t-00072P-An; Mon, 09 Sep 2019 04:40:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Philipp Wendler <ml@philippwendler.de>,
        linux-man <linux-man@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jordan Ogas <jogas@lanl.gov>, werner@almesberger.net,
        Al Viro <viro@ftp.linux.org.uk>
References: <CAKgNAki0bR5zZr+kp_xjq+bNUky6-F+s2ep+jnR0YrjHhNMB1g@mail.gmail.com>
        <20190805103630.tu4kytsbi5evfrhi@mikami>
        <3a96c631-6595-b75e-f6a7-db703bf89bcf@gmail.com>
        <da747415-4c7a-f931-6f2e-2962da63c161@philippwendler.de>
        <CAKgNAkjS+x7aMVUiVSgCRwgi8rnukqJv=svtTARE-tt-oxQxWw@mail.gmail.com>
Date:   Mon, 09 Sep 2019 05:40:05 -0500
In-Reply-To: <CAKgNAkjS+x7aMVUiVSgCRwgi8rnukqJv=svtTARE-tt-oxQxWw@mail.gmail.com>
        (Michael Kerrisk's message of "Tue, 6 Aug 2019 14:03:13 +0200")
Message-ID: <87r24piwhm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i7H5t-00072P-An;;;mid=<87r24piwhm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=213.30.8.110;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c6MeuT4/YbjCiKID4z0Z9syV2XRq6dMM=
X-SA-Exim-Connect-IP: 213.30.8.110
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: pivot_root(".", ".") and the fchdir() dance
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hello Philipp,
>
> On Tue, 6 Aug 2019 at 10:12, Philipp Wendler <ml@philippwendler.de> wrote:
>>
>> Hello Michael, hello Aleksa,
>>
>> Am 05.08.19 um 14:29 schrieb Michael Kerrisk (man-pages):
>>
>> > On 8/5/19 12:36 PM, Aleksa Sarai wrote:
>> >> On 2019-08-01, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>> >>> I'd like to add some documentation about the pivot_root(".", ".")
>> >>> idea, but I have a doubt/question. In the lxc_pivot_root() code we
>> >>> have these steps
>> >>>
>> >>>         oldroot = open("/", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
>> >>>         newroot = open(rootfs, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
>> >>>
>> >>>         fchdir(newroot);
>> >>>         pivot_root(".", ".");
>> >>>
>> >>>         fchdir(oldroot);      // ****
>> >>>
>> >>>         mount("", ".", "", MS_SLAVE | MS_REC, NULL);
>> >>>         umount2(".", MNT_DETACH);
>> >>
>> >>>         fchdir(newroot);      // ****
>> >>
>> >> And this one is required because we are in @oldroot at this point, due
>> >> to the first fchdir(2). If we don't have the first one, then switching
>> >> from "." to "/" in the mount/umount2 calls should fix the issue.
>> >
>> > See my notes above for why I therefore think that the second fchdir()
>> > is also not needed (and therefore why switching from "." to "/" in the
>> > mount()/umount2() calls is unnecessary.
>> >
>> > Do you agree with my analysis?
>>
>> If both the second and third fchdir are not required,
>> then we do not need to bother with file descriptors at all, right?
>
> Exactly.
>
>> Indeed, my tests show that the following seems to work fine:
>>
>> chdir(rootfs)
>> pivot_root(".", ".")
>> umount2(".", MNT_DETACH)
>
> Thanks for the confirmation, That's also exactly what I tested.
>
>> I tested that with my own tool[1] that uses user namespaces and marks
>> everything MS_PRIVATE before, so I do not need the mount(MS_SLAVE) here.
>>
>> And it works the same with both umount2("/") and umount2(".").
>
> Yes.
>
>> Did I overlook something that makes the file descriptors required?
>
> No.
>
>> If not, wouldn't the above snippet make sense as example in the man page?
>
> I have exactly that snippet in a pending change for the manual page :-).

I have just spotted this conversation and I expect if you are going
to use this example it is probably good to document what is going
on so that people can follow along.

>> chdir(rootfs)
>> pivot_root(".", ".")

At this point the mount stack should be:
old_root
new_root
rootfs

With "." and "/" pointing to new_root.

>> umount2(".", MNT_DETACH)

At this point resolving "." starts with new_root and follows up the
mount stack to old-root.

Ordinarily if you unmount "/" as is happening above you then need to
call chroot and possibly chdir to ensure neither "/" nor "." point to
somewhere other than the unmounted root filesystem.  In this specific
case because "/" and "." resolve to new_root under the filesystem that is
being unmounted that all is well.

Eric
