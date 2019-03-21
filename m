Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67037C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1821902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfCUSaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:30:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbfCUSaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:30:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7B62AECD;
        Thu, 21 Mar 2019 18:30:07 +0000 (UTC)
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
 <87in8ghetm.fsf@xmission.com>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com>
Date:   Thu, 21 Mar 2019 14:30:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:66.0)
 Gecko/20100101 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <87in8ghetm.fsf@xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eNy8w67VKZg9HbgihoSF5hhlRl0FM26NH"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eNy8w67VKZg9HbgihoSF5hhlRl0FM26NH
Content-Type: multipart/mixed; boundary="5m1TIeU0UkJOA5ty3QdTJ8o72GemYIKmM";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>
Message-ID: <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com>
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
References: <20180424022106.16952-1-jeffm@suse.com>
 <87in8ghetm.fsf@xmission.com>
In-Reply-To: <87in8ghetm.fsf@xmission.com>

--5m1TIeU0UkJOA5ty3QdTJ8o72GemYIKmM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/18 10:14 AM, Eric W. Biederman wrote:
> jeffm@suse.com writes:
>=20
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> Hi all -
>>
>> I recently encountered a customer issue where, on a machine with many =
TiB
>> of memory and a few hundred cores, after a task with a few thousand th=
reads
>> and hundreds of files open exited, the system would softlockup.  That
>> issue was (is still) being addressed by Nik Borisov's patch to add a
>> cond_resched call to shrink_dentry_list.  The underlying issue is stil=
l
>> there, though.  We just don't complain as loudly.  When a huge task
>> exits, now the system is more or less unresponsive for about eight
>> minutes.  All CPUs are pinned and every one of them is going through
>> dentry and inode eviction for the procfs files associated with each
>> thread.  It's made worse by every CPU contending on the super's
>> inode list lock.
>>
>> The numbers get big.  My test case was 4096 threads with 16384 files
>> open.  It's a contrived example, but not that far off from the actual
>> customer case.  In this case, a simple "find /proc" would create aroun=
d
>> 300 million dentry/inode pairs.  More practically, lsof(1) does it too=
,
>> it just takes longer.  On smaller systems, memory pressure starts push=
ing
>> them out. Memory pressure isn't really an issue on this machine, so we=

>> end up using well over 100GB for proc files.  It's the combination of
>> the wasted CPU cycles in teardown and the wasted memory at runtime tha=
t
>> pushed me to take this approach.
>>
>> The biggest culprit is the "fd" and "fdinfo" directories, but those ar=
e
>> made worse by there being multiple copies of them even for the same
>> task without threads getting involved:
>>
>> - /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
>>   resources.
>>
>> - Every /proc/pid/task/*/fd directory in a thread group has identical
>>   contents (unless unshare(CLONE_FILES) was called), but share no
>>   resources.
>>
>> - If we do a lookup like /proc/pid/fd on a member of a thread group,
>>   we'll get a valid directory.  Inside, there will be a complete
>>   copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
>>   nothing is shared.
>>
>> This patch set reduces some (most) of the duplication by conditionally=

>> replacing some of the directories with symbolic links to copies that a=
re
>> identical.
>>
>> 1) Eliminate the duplication of the task directories between threads.
>>    The task directory belongs to the thread leader and the threads
>>    link to it: e.g. /proc/915/task -> ../910/task  This mainly
>>    reduces duplication when individual threads are looked up directly
>>    at the tgid level.  The impact varies based on the number of thread=
s.
>>    The user has to go out of their way in order to mess up their syste=
m
>>    in this way.  But if they were so inclined, they could create ~550
>>    billion inodes and dentries using the test case.
>>
>> 2) Eliminate the duplication of directories that are created identical=
ly
>>    between the tgid-level pid directory and its task directory: fd,
>>    fdinfo, ns, net, attr.  There is obviously more duplication between=

>>    the two directories, but replacing a file with a symbolic link
>>    doesn't get us anything.  This reduces the number of files associat=
ed
>>    with fd and fdinfo by half if threads aren't involved.
>>
>> 3) Eliminate the duplication of fd and fdinfo directories among thread=
s
>>    that share a files_struct.  We check at directory creation time if
>>    the task is a group leader and if not, whether it shares ->files wi=
th
>>    the group leader.  If so, we create a symbolic link to ../tgid/fd*.=

>>    We use a d_revalidate callback to check whether the thread has call=
ed
>>    unshare(CLONE_FILES) and, if so, fail the revalidation for the syml=
ink.
>>    Upon re-lookup, a directory will be created in its place.  This is
>>    pretty simple, so if the thread group leader calls unshare, all thr=
eads
>>    get directories.
>>
>> With these patches applied, running the same testcase, the proc_inode
>> cache only gets to about 600k objects, which is about 99.7% fewer.  I
>> get that procfs isn't supposed to be scalable, but this is kind of
>> extreme. :)
>>
>> Finally, I'm not a procfs expert.  I'm posting this as an RFC for folk=
s
>> with more knowledge of the details to pick it apart.  The biggest is t=
hat
>> I'm not sure if any tools depend on any of these things being director=
ies
>> instead of symlinks.  I'd hope not, but I don't have the answer.  I'm
>> sure there are corner cases I'm missing.  Hopefully, it's not just fla=
t
>> out broken since this is a problem that does need solving.
>>
>> Now I'll go put on the fireproof suit.

Thanks for your comments.  This ended up having to get back-burnered but
I've finally found some time to get back to it.  I have new patches that
don't treat each entry as a special case and makes more sense, IMO.
They're not worth posting yet since some of the issues below remain.

> This needs to be tested against at least apparmor to see if this breaks=

> common policies.  Changing files to symlinks in proc has a bad habit of=

> either breaking apparmor policies or userspace assumptions.   Symbolic
> links are unfortunately visible to userspace.

AppArmor uses the @{pids} var in profiles that translates to a numeric
regex.  That means that /proc/pid/task -> /proc/tgid/task won't break
profiles but /proc/pid/fdinfo -> /proc/pid/task/tgid/fdinfo will break.
 Apparmor doesn't have a follow_link hook at all, so all that matters is
the final path.  SELinux does have a follow_link hook, but I'm not
familiar enough with it to know whether introducing a symlink in proc
will make a difference.

I've dropped the /proc/pid/{dirs} -> /proc/pid/task/pid/{dirs} part
since that clearly won't work.

> Further the proc structure is tgid/task/tid where the leaf directories
> are per thread.

Yes, but threads are still in /proc for lookup at the tgid level even if
they don't show up in readdir.

> We more likely could get away with some magic symlinks (that would not
> be user visible) rather than actual symlinks.

I think I'm missing something here.  Aren't magic symlinks still
represented to the user as symlinks?

> So I think you are probably on the right track to reduce the memory
> usage but I think some more work will be needed to make it transparentl=
y
> backwards compatible.

Yeah, that's going to be the big hiccup.  I think I've resolved the
biggest issue with AppArmor, but I don't think the problem is solvable
without introducing symlinks.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--5m1TIeU0UkJOA5ty3QdTJ8o72GemYIKmM--

--eNy8w67VKZg9HbgihoSF5hhlRl0FM26NH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAlyT2CsACgkQHntLYyF5
5bL+uBAAg9VHYSDszvUxhjGOGhr/mwI9H419x3IN6m/pFAo3UfuP2fBVZuiiWtT5
DNYsl5bZ8URxU6Mh33Gi7vQjEUEL4GitH2wDS/o0kqrCXTTYR19uJOWwxds+MrIf
kfLnxADIrU4MYZhRr96mUu+LXQGqa5Apj8Ud2OaaSTxKT7bjp3lt9JuqUv+ndZPY
gWw7hS5d2/zyllVhm3dpAj+N6Zy4rXMlXLVZKAeyHVpRQtdxm0p8yyj/d2lmGd8W
343NMEL/NOk9NlUrnYduy+6kSMJ+EWzvK57lK/gcdbOlR00tCJ4BLkYBIyw1+o/p
9rWNm3rpGkTpBawQymIe2UKEOMOhocXC20Jr5I7X2Nrp/SfFaMgDauA7USlRU2Bc
/3kS1pzaTBkQ8+Sq9U+s5S4PfDBHILkgG+JeIK3yvz0LYCqCiSoTLspvYOAuEODH
VOkyAiR2cn5cdDvAK5Rs4F1hoxQnswy+9fxpqRB6nvyeko5CSMUhwQJLxLGvtyBs
reOXD3O9C7D4at9ChcYTdCEJ4G+bazCBcAq9TDjl6fsbKgpohnlerbSFLRqBfVss
G07BDbW0I3vhGf2e/rxa/A4arMSY9NETLAAsKiIK4mns0kmBO+fPY9A+N+uzqkQa
6FWk0gr7MoMf5PwyulugHTx87jAooXWi9qijiq90uwn/m31+1mk=
=arCa
-----END PGP SIGNATURE-----

--eNy8w67VKZg9HbgihoSF5hhlRl0FM26NH--
