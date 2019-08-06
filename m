Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD65C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2FD2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfHFIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:22:04 -0400
Received: from ngcobalt01.manitu.net ([217.11.48.101]:47560 "EHLO
        ngcobalt01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfHFIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:22:04 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 04:22:03 EDT
Received: from server.passau (ipbcc33479.dynamic.kabel-deutschland.de [188.195.52.121])
        (Authenticated sender: smtp-send)
        by ngcobalt01.manitu.net (Postfix) with ESMTPSA id 1E60A33E4ED3;
        Tue,  6 Aug 2019 10:12:46 +0200 (CEST)
Received: from [192.168.6.60] (t460p [192.168.6.60])
        by server.passau (Postfix) with ESMTPSA id 76841814DE;
        Tue,  6 Aug 2019 10:12:45 +0200 (CEST)
From:   Philipp Wendler <ml@philippwendler.de>
Subject: Re: pivot_root(".", ".") and the fchdir() dance
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Aleksa Sarai <asarai@suse.de>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jordan Ogas <jogas@lanl.gov>, werner@almesberger.net,
        Al Viro <viro@ftp.linux.org.uk>
References: <CAKgNAki0bR5zZr+kp_xjq+bNUky6-F+s2ep+jnR0YrjHhNMB1g@mail.gmail.com>
 <20190805103630.tu4kytsbi5evfrhi@mikami>
 <3a96c631-6595-b75e-f6a7-db703bf89bcf@gmail.com>
Message-ID: <da747415-4c7a-f931-6f2e-2962da63c161@philippwendler.de>
Date:   Tue, 6 Aug 2019 10:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3a96c631-6595-b75e-f6a7-db703bf89bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael, hello Aleksa,

Am 05.08.19 um 14:29 schrieb Michael Kerrisk (man-pages):

> On 8/5/19 12:36 PM, Aleksa Sarai wrote:
>> On 2019-08-01, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>>> I'd like to add some documentation about the pivot_root(".", ".")
>>> idea, but I have a doubt/question. In the lxc_pivot_root() code we
>>> have these steps
>>>
>>>         oldroot = open("/", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
>>>         newroot = open(rootfs, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
>>>
>>>         fchdir(newroot);
>>>         pivot_root(".", ".");
>>>
>>>         fchdir(oldroot);      // ****
>>>
>>>         mount("", ".", "", MS_SLAVE | MS_REC, NULL);
>>>         umount2(".", MNT_DETACH);
>>
>>>         fchdir(newroot);      // ****
>>
>> And this one is required because we are in @oldroot at this point, due
>> to the first fchdir(2). If we don't have the first one, then switching
>> from "." to "/" in the mount/umount2 calls should fix the issue.
> 
> See my notes above for why I therefore think that the second fchdir()
> is also not needed (and therefore why switching from "." to "/" in the
> mount()/umount2() calls is unnecessary.
> 
> Do you agree with my analysis?

If both the second and third fchdir are not required,
then we do not need to bother with file descriptors at all, right?

Indeed, my tests show that the following seems to work fine:

chdir(rootfs)
pivot_root(".", ".")
umount2(".", MNT_DETACH)

I tested that with my own tool[1] that uses user namespaces and marks
everything MS_PRIVATE before, so I do not need the mount(MS_SLAVE) here.

And it works the same with both umount2("/") and umount2(".").

Did I overlook something that makes the file descriptors required?
If not, wouldn't the above snippet make sense as example in the man page?

Greetings
Philipp

[1]: https://github.com/sosy-lab/benchexec/blob/b90aeb034b867711845a453587b73fbe8e4dca68/benchexec/container.py#L735
