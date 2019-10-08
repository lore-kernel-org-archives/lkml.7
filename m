Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503E20873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfJHWRv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:17:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37296 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:17:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iHxnd-00043w-QM; Tue, 08 Oct 2019 16:17:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iHxnc-0000qU-Ss; Tue, 08 Oct 2019 16:17:45 -0600
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
        <87ef0hbezt.fsf@x220.int.ebiederm.org>
        <cc21557f-1568-68c3-e322-47ceb52fdf53@gmail.com>
        <71cad40b-0f9f-24de-b650-8bc4fce78fa8@gmail.com>
        <87y2y6j9i1.fsf@x220.int.ebiederm.org>
        <7e4b23df-ab83-3d5a-3dc5-54025e3682cf@gmail.com>
        <87k19geey0.fsf@x220.int.ebiederm.org>
        <c7041c6a-a4c6-75f2-5380-4fed67cd60b1@gmail.com>
        <87eeznc9fc.fsf@x220.int.ebiederm.org>
        <08d2b28b-21cc-e304-f624-bb5bc4ee98f4@gmail.com>
Date:   Tue, 08 Oct 2019 17:16:59 -0500
In-Reply-To: <08d2b28b-21cc-e304-f624-bb5bc4ee98f4@gmail.com> (Michael
        Kerrisk's message of "Tue, 8 Oct 2019 23:40:25 +0200")
Message-ID: <878spudgro.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iHxnc-0000qU-Ss;;;mid=<878spudgro.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VZR+ZDUtWFS7hknLL9o6/ui3Vkkwy7Rg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: pivot_root(".", ".") and the fchdir() dance
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> On 10/8/19 9:40 PM, Eric W. Biederman wrote:
>> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
>> 
>>> Hello Eric,
>>>
>>>>>> Creating of a mount namespace in a user namespace automatically does
>>>>>> 'mount("", "/", MS_SLAVE | MS_REC, NULL);' if the starting mount
>>>>>> namespace was not created in that user namespace.  AKA creating
>>>>>> a mount namespace in a user namespace does the unshare for you.
>>>>>
>>>>> Oh -- I had forgotten that detail. But it is documented
>>>>> (by you, I think) in mount_namespaces(7):
>>>>>
>>>>>        *  A  mount  namespace  has  an  owner user namespace.  A
>>>>>           mount namespace whose owner user namespace is  differ‐
>>>>>           ent  from the owner user namespace of its parent mount
>>>>>           namespace is considered a less privileged mount names‐
>>>>>           pace.
>>>>>
>>>>>        *  When  creating  a  less  privileged  mount  namespace,
>>>>>           shared mounts are reduced to  slave  mounts.   (Shared
>>>>>           and  slave  mounts are discussed below.)  This ensures
>>>>>           that  mappings  performed  in  less  privileged  mount
>>>>>           namespaces will not propagate to more privileged mount
>>>>>           namespaces.
>>>>>
>>>>> There's one point that description that troubles me. There is a
>>>>> reference to "parent mount namespace", but as I understand things
>>>>> there is no parental relationship among mount namespaces instances
>>>>> (or am I wrong?). Should that wording not be rather something
>>>>> like "the mount namespace of the process that created this mount
>>>>> namespace"?
>>>>
>>>> How about "the mount namespace this mount namespace started as a copy of"
>>>>
>>>> You are absolutely correct there is no relationship between mount
>>>> namespaces.  There is just the propagation tree between mounts.  (Which
>>>> acts similarly to a parent/child relationship but is not at all the same
>>>> thing).
>>>
>>> Thanks. I made the text as follows:
>>>
>>>        *  Each  mount  namespace  has  an owner user namespace.  As noted
>>>           above, when a new mount namespace is  created,  it  inherits  a
>>>           copy  of  the  mount  points  from  the  mount namespace of the
>>>           process that created the new mount namespace.  If the two mount
>>>           namespaces are owned by different user namespaces, then the new
>>>           mount namespace is considered less privileged.
>> 
>> I hate to nitpick, 
>
> I love it when you nitpick. Thanks for your attention to the details 
> of my wording.
>
>> but I am going to say that when I read the text above
>> the phrase "mount namespace of the process that created the new mount
>> namespace" feels wrong.
>> 
>> Either you use unshare(2) and the mount namespace of the process that
>> created the mount namespace changes.
>> 
>> Or you use clone(2) and you could argue it is the new child that created
>> the mount namespace.
>> 
>> Having a different mount namespace at the end of the creation operation
>> feels like it makes your phrase confusing about what the starting
>> mount namespace is.  I hate to use references that are ambiguous when
>> things are changing.
>>
>> I agree that the term parent is also wrong.
>
> I see what you mean. My wording is imprecise.
>
> So, I tweaked text earlier in the page so that it now reads
> as follows:
>
>        A  new  mount  namespace  is  created  using  either  clone(2)  or
>        unshare(2) with the CLONE_NEWNS flag.  When a new mount  namespace
>        is created, its mount point list is initialized as follows:
>
>        *  If  the  namespace  is  created using clone(2), the mount point
>           list of the child's namespace is a copy of the mount point list
>           in the parent's namespace.
>
>        *  If  the  namespace is created using unshare(2), the mount point
>           list of the new namespace is a copy of the mount point list  in
>           the caller's previous mount namespace.
>
> And then I tweaked the text that we are currently discussing to read:
>
>        *  Each mount namespace has an owner user namespace.  As explained
>           above,  when  a new mount namespace is created, its mount point
>           list is initialized as a  copy  of  the  mount  point  list  of
>           another  mount namespace.  If the new namespaces and the names‐
>           pace from which the mount point list was copied  are  owned  by
>           different user namespaces, then the new mount namespace is con‐
>           sidered less privileged.
>
> How does this look to you now?

Much better thank you.

Eric
