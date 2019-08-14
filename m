Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDCC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB43B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfHNKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:04:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:04:21 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxq8R-0000Aj-TB; Wed, 14 Aug 2019 10:04:04 +0000
Date:   Wed, 14 Aug 2019 12:04:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Pavel Emelianov <xemul@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrei Vagin (C)" <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v6 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20190814100402.jf5p2wsqngeuazaj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a65c4c4-6860-b042-a0bf-b3f8e9b277af@virtuozzo.com>
 <20190813143023.GC6971@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:50:03AM +0000, Pavel Emelianov wrote:
> On 8/12/19 11:09 PM, Adrian Reber wrote:
> > The main motivation to add set_tid to clone3() is CRIU.
> > 
> > To restore a process with the same PID/TID CRIU currently uses
> > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > ns_last_pid and then (quickly) does a clone(). This works most of the
> > time, but it is racy. It is also slow as it requires multiple syscalls.
> > 
> > Extending clone3() to support set_tid makes it possible restore a
> > process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> > race free (as long as the desired PID/TID is available).
> > 
> > This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> > on clone3() with set_tid as they are currently in place for ns_last_pid.
> > 
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> 
> Acked-by: Pavel Emelyanov <xemul@openvz.org>

On Tue, Aug 13, 2019 at 04:30:24PM +0200, Oleg Nesterov wrote:
> On 08/12, Adrian Reber wrote:
> >
> > The main motivation to add set_tid to clone3() is CRIU.
> >
> > To restore a process with the same PID/TID CRIU currently uses
> > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > ns_last_pid and then (quickly) does a clone(). This works most of the
> > time, but it is racy. It is also slow as it requires multiple syscalls.
> >
> > Extending clone3() to support set_tid makes it possible restore a
> > process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> > race free (as long as the desired PID/TID is available).
> >
> > This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> > on clone3() with set_tid as they are currently in place for ns_last_pid.
> >
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 

Added-to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd

Merged-into:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

Thanks!
Christian
