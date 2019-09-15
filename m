Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36B5C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C544214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfIOSSW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 14:18:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39401 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:18:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9Z6I-00079r-T5; Sun, 15 Sep 2019 12:18:18 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9Z6H-00011n-Lw; Sun, 15 Sep 2019 12:18:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
        <87r24piwhm.fsf@x220.int.ebiederm.org>
        <CAKgNAkhK2qBbz5aVY9VdK0UzvpZ=c7c7LWQ1MK2gu-rVKUz9_g@mail.gmail.com>
        <87ftl5donm.fsf@x220.int.ebiederm.org>
        <b8b9d8bd-e959-633f-b879-4bfe4eb0df23@gmail.com>
        <20190910111551.scam5payogqqvlri@wittgenstein>
        <30545c5c-ff4c-8b87-e591-40cc0a631304@gmail.com>
        <871rwnda47.fsf@x220.int.ebiederm.org>
        <448138b8-0d0c-5eb3-d5e5-04a26912d3a8@gmail.com>
Date:   Sun, 15 Sep 2019 13:17:58 -0500
In-Reply-To: <448138b8-0d0c-5eb3-d5e5-04a26912d3a8@gmail.com> (Michael
        Kerrisk's message of "Sun, 15 Sep 2019 10:12:09 +0200")
Message-ID: <87ef0hbezt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1i9Z6H-00011n-Lw;;;mid=<87ef0hbezt.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/EkPm9GGkbZrSz8OMQs54EEEIMjCGmbkA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: pivot_root(".", ".") and the fchdir() dance
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hello Eric,
>
> On 9/11/19 1:06 AM, Eric W. Biederman wrote:
>> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
>> 
>>> Hello Christian,
>>>
>>>>> All: I plan to add the following text to the manual page:
>>>>>
>>>>>        new_root and put_old may be the same  directory.   In  particular,
>>>>>        the following sequence allows a pivot-root operation without need‐
>>>>>        ing to create and remove a temporary directory:
>>>>>
>>>>>            chdir(new_root);
>>>>>            pivot_root(".", ".");
>>>>>            umount2(".", MNT_DETACH);
>>>>
>>>> Hm, should we mention that MS_PRIVATE or MS_SLAVE is usually needed
>>>> before the umount2()? Especially for the container case... I think we
>>>> discussed this briefly yesterday in person.
>>> Thanks for noticing. That detail (more precisely: not MS_SHARED) is
>>> already covered in the numerous other changes that I have pending
>>> for this page:
>>>
>>>        The following restrictions apply:
>>>        ...
>>>        -  The propagation type of new_root and its parent mount must  not
>>>           be MS_SHARED; similarly, if put_old is an existing mount point,
>>>           its propagation type must not be MS_SHARED.
>> 
>> Ugh.  That is close but not quite correct.
>> 
>> A better explanation:
>> 
>>     The pivot_root system call will never propagate any changes it makes.
>>     The pivot_root system call ensures this is safe by verifying that
>>     none of put_old, the parent of new_root, and parent of the root directory
>>     have a propagation type of MS_SHARED.
>
> Thanks for that. However, another question. You text has two changes.
> First, I understand why you reword the discussion to indicate the
> _purpose_ of the rules. However, you also, AFAICS, list a different set of
> of directories that can't be MS_SHARED:
>
> I said: new_root, the parent of new_root, and put_old
> You said: the parent of new_root, and put_old, and parent of the
> root directory.


> Was I wrong on this detail also?

That is how I read the code.  The code says:

	if (IS_MNT_SHARED(old_mnt) ||
		IS_MNT_SHARED(new_mnt->mnt_parent) ||
		IS_MNT_SHARED(root_mnt->mnt_parent))
		goto out4;

We both agree on put_old and the parent of new_mnt.

When I look at the code root_mnt comes from the root directory, not new_mnt.

Furthermore those checks fundamentally makes sense as the root directory
and new_root that are moving.  The directory put_old simply has
something moving onto it.

>> The concern from our conversation at the container mini-summit was that
>> there is a pathology if in your initial mount namespace all of the
>> mounts are marked MS_SHARED like systemd does (and is almost necessary
>> if you are going to use mount propagation), that if new_root itself
>> is MS_SHARED then unmounting the old_root could propagate.
>> 
>> So I believe the desired sequence is:
>> 
>>>>>            chdir(new_root);
>> +++            mount("", ".", MS_SLAVE | MS_REC, NULL);
>>>>>            pivot_root(".", ".");
>>>>>            umount2(".", MNT_DETACH);
>> 
>> The change to new new_root could be either MS_SLAVE or MS_PRIVATE.  So
>> long as it is not MS_SHARED the mount won't propagate back to the
>> parent mount namespace.
>
> Thanks. I made that change.

For what it is worth.  The sequence above without the change in mount
attributes will fail if it is necessary to change the mount attributes
as "." is both put_old as well as new_root.

When I initially suggested the change I saw "." was new_root and forgot
"." was also put_old.  So I thought there was a silent danger without
that sequence.

Eric

