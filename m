Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF92C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B185A2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfG0LUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 07:20:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43290 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG0LU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:20:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrKkV-0001FM-Fn; Sat, 27 Jul 2019 05:20:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrKkU-0002QG-KR; Sat, 27 Jul 2019 05:20:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
        <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
        <20190726232220.GM1131@ZenIV.linux.org.uk>
        <878sskqp7p.fsf@xmission.com>
        <20190727022826.GO1131@ZenIV.linux.org.uk>
Date:   Sat, 27 Jul 2019 06:20:18 -0500
In-Reply-To: <20190727022826.GO1131@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 27 Jul 2019 03:28:26 +0100")
Message-ID: <87h877pvv1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hrKkU-0002QG-KR;;;mid=<87h877pvv1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Vq3Lzknntv8YcPI8xoS/ElyuyKem99zY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka user-namespace-mountable) filesystems
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Fri, Jul 26, 2019 at 07:46:18PM -0500, Eric W. Biederman wrote:
>
>> If someone had bothered to actually look at how I was proposing to clean
>> things up before the new mount api we would already have that.  Sigh.
>> 
>> You should be able to get away with something like this which moves the
>> checks earlier and makes things clearer.  My old patch against the pre
>> new mount api code.
>
> Check your instances of ->permission(); AFAICS in all cases it's (in
> current terms)
> 	return ns_capable(fc->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;


Yes.  Because I refactored all of the logic to be in terms of current
before we even get to the filesystem.  The idea is on a per filesystem
basis to know which namespaces for the filesystem will be selected
and to check those.

Since all that version of the patch converts is the old API we know
from only looking at current what needs to be checked.

> In principle I like killing FS_USERNS_MOUNT flag, but when a method
> is always either NULL or exact same function...

Either you are being dramatic or you read the patch much too quickly.

userns_mount_permission covers the common case of FS_USERNS_MOUNT.
Then there are the cases where you need to know how the filesystem is
going to map current into the filesystem that will be mounted.  Those
are: proc_mount_permission, sysfs_mount_permission,
mqueue_mount_permission, cgroup_mount_permission,

So yes I agree the function of interest is always capable in some form,
we just need the filesystem specific logic to check to see if we will
have capable over the filesystem that will be mounted.

I don't doubt that the new mount api has added a few new complexities.

*Shrug*  I have done my best to keep it simple, and to help avoid
breaking changes.   When you never post your patches for public review,
and don't take any feedback it is difficult to give help.

Eric
