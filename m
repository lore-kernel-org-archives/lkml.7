Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA6AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FC721902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCWP4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:56:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43831 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:56:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1h7j0m-0007u2-Fg; Sat, 23 Mar 2019 09:56:44 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1h7j0l-0002Id-9A; Sat, 23 Mar 2019 09:56:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
        <87in8ghetm.fsf@xmission.com>
        <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com>
Date:   Sat, 23 Mar 2019 10:56:11 -0500
In-Reply-To: <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com> (Jeff Mahoney's
        message of "Thu, 21 Mar 2019 14:30:03 -0400")
Message-ID: <87y355mvok.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1h7j0l-0002Id-9A;;;mid=<87y355mvok.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hMsJc8/oXHcpFVBZHXhbR9CL9HkANsm0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> writes:

> On 4/24/18 10:14 AM, Eric W. Biederman wrote:
>> jeffm@suse.com writes:
>> 
>>> From: Jeff Mahoney <jeffm@suse.com>
>>>
>>> Hi all -
>>>
>>> I recently encountered a customer issue where, on a machine with many TiB
>>> of memory and a few hundred cores, after a task with a few thousand threads
>>> and hundreds of files open exited, the system would softlockup.  That
>>> issue was (is still) being addressed by Nik Borisov's patch to add a
>>> cond_resched call to shrink_dentry_list.  The underlying issue is still
>>> there, though.  We just don't complain as loudly.  When a huge task
>>> exits, now the system is more or less unresponsive for about eight
>>> minutes.  All CPUs are pinned and every one of them is going through
>>> dentry and inode eviction for the procfs files associated with each
>>> thread.  It's made worse by every CPU contending on the super's
>>> inode list lock.
>>>
>>> The numbers get big.  My test case was 4096 threads with 16384 files
>>> open.  It's a contrived example, but not that far off from the actual
>>> customer case.  In this case, a simple "find /proc" would create around
>>> 300 million dentry/inode pairs.  More practically, lsof(1) does it too,
>>> it just takes longer.  On smaller systems, memory pressure starts pushing
>>> them out. Memory pressure isn't really an issue on this machine, so we
>>> end up using well over 100GB for proc files.  It's the combination of
>>> the wasted CPU cycles in teardown and the wasted memory at runtime that
>>> pushed me to take this approach.
>>>
>>> The biggest culprit is the "fd" and "fdinfo" directories, but those are
>>> made worse by there being multiple copies of them even for the same
>>> task without threads getting involved:
>>>
>>> - /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
>>>   resources.
>>>
>>> - Every /proc/pid/task/*/fd directory in a thread group has identical
>>>   contents (unless unshare(CLONE_FILES) was called), but share no
>>>   resources.
>>>
>>> - If we do a lookup like /proc/pid/fd on a member of a thread group,
>>>   we'll get a valid directory.  Inside, there will be a complete
>>>   copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
>>>   nothing is shared.
>>>
>>> This patch set reduces some (most) of the duplication by conditionally
>>> replacing some of the directories with symbolic links to copies that are
>>> identical.
>>>
>>> 1) Eliminate the duplication of the task directories between threads.
>>>    The task directory belongs to the thread leader and the threads
>>>    link to it: e.g. /proc/915/task -> ../910/task  This mainly
>>>    reduces duplication when individual threads are looked up directly
>>>    at the tgid level.  The impact varies based on the number of threads.
>>>    The user has to go out of their way in order to mess up their system
>>>    in this way.  But if they were so inclined, they could create ~550
>>>    billion inodes and dentries using the test case.
>>>
>>> 2) Eliminate the duplication of directories that are created identically
>>>    between the tgid-level pid directory and its task directory: fd,
>>>    fdinfo, ns, net, attr.  There is obviously more duplication between
>>>    the two directories, but replacing a file with a symbolic link
>>>    doesn't get us anything.  This reduces the number of files associated
>>>    with fd and fdinfo by half if threads aren't involved.
>>>
>>> 3) Eliminate the duplication of fd and fdinfo directories among threads
>>>    that share a files_struct.  We check at directory creation time if
>>>    the task is a group leader and if not, whether it shares ->files with
>>>    the group leader.  If so, we create a symbolic link to ../tgid/fd*.
>>>    We use a d_revalidate callback to check whether the thread has called
>>>    unshare(CLONE_FILES) and, if so, fail the revalidation for the symlink.
>>>    Upon re-lookup, a directory will be created in its place.  This is
>>>    pretty simple, so if the thread group leader calls unshare, all threads
>>>    get directories.
>>>
>>> With these patches applied, running the same testcase, the proc_inode
>>> cache only gets to about 600k objects, which is about 99.7% fewer.  I
>>> get that procfs isn't supposed to be scalable, but this is kind of
>>> extreme. :)
>>>
>>> Finally, I'm not a procfs expert.  I'm posting this as an RFC for folks
>>> with more knowledge of the details to pick it apart.  The biggest is that
>>> I'm not sure if any tools depend on any of these things being directories
>>> instead of symlinks.  I'd hope not, but I don't have the answer.  I'm
>>> sure there are corner cases I'm missing.  Hopefully, it's not just flat
>>> out broken since this is a problem that does need solving.
>>>
>>> Now I'll go put on the fireproof suit.
>
> Thanks for your comments.  This ended up having to get back-burnered but
> I've finally found some time to get back to it.  I have new patches that
> don't treat each entry as a special case and makes more sense, IMO.
> They're not worth posting yet since some of the issues below remain.
>
>> This needs to be tested against at least apparmor to see if this breaks
>> common policies.  Changing files to symlinks in proc has a bad habit of
>> either breaking apparmor policies or userspace assumptions.   Symbolic
>> links are unfortunately visible to userspace.
>
> AppArmor uses the @{pids} var in profiles that translates to a numeric
> regex.  That means that /proc/pid/task -> /proc/tgid/task won't break
> profiles but /proc/pid/fdinfo -> /proc/pid/task/tgid/fdinfo will break.
>  Apparmor doesn't have a follow_link hook at all, so all that matters is
> the final path.  SELinux does have a follow_link hook, but I'm not
> familiar enough with it to know whether introducing a symlink in proc
> will make a difference.
>
> I've dropped the /proc/pid/{dirs} -> /proc/pid/task/pid/{dirs} part
> since that clearly won't work.
>
>> Further the proc structure is tgid/task/tid where the leaf directories
>> are per thread.
>
> Yes, but threads are still in /proc for lookup at the tgid level even if
> they don't show up in readdir.
>
>> We more likely could get away with some magic symlinks (that would not
>> be user visible) rather than actual symlinks.
>
> I think I'm missing something here.  Aren't magic symlinks still
> represented to the user as symlinks?
>
>> So I think you are probably on the right track to reduce the memory
>> usage but I think some more work will be needed to make it transparently
>> backwards compatible.
>
> Yeah, that's going to be the big hiccup.  I think I've resolved the
> biggest issue with AppArmor, but I don't think the problem is solvable
> without introducing symlinks.

Has anyone looked at making the fd and fdinfo files hard links.

Alternatively it may make sense to see if there is something that we can
do with the locking to reduce the thundering hurd problem that is being
seen.

Eric

