Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE28C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4318F2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNIC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:02:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:02:26 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVA4w-0006SY-CR; Thu, 14 Nov 2019 08:02:10 +0000
Date:   Thu, 14 Nov 2019 09:02:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v9 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191114080208.m5cl4hv5w7k2za4e@wittgenstein>
References: <20191114070709.1504202-1-areber@redhat.com>
 <20191114075759.3cdil2rh3dz4ozvs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114075759.3cdil2rh3dz4ozvs@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:57:59AM +0100, Christian Brauner wrote:
> On Thu, Nov 14, 2019 at 08:07:08AM +0100, Adrian Reber wrote:
> > The main motivation to add set_tid to clone3() is CRIU.
> > 
> > To restore a process with the same PID/TID CRIU currently uses
> > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > ns_last_pid and then (quickly) does a clone(). This works most of the
> > time, but it is racy. It is also slow as it requires multiple syscalls.
> > 
> > Extending clone3() to support *set_tid makes it possible restore a
> > process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> > race free (as long as the desired PID/TID is available).
> > 
> > This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> > on clone3() with *set_tid as they are currently in place for ns_last_pid.
> > 
> > The original version of this change was using a single value for
> > set_tid. At the 2019 LPC, after presenting set_tid, it was, however,
> > decided to change set_tid to an array to enable setting the PID of a
> > process in multiple PID namespaces at the same time. If a process is
> > created in a PID namespace it is possible to influence the PID inside
> > and outside of the PID namespace. Details also in the corresponding
> > selftest.
> > 
> > To create a process with the following PIDs:
> > 
> >       PID NS level         Requested PID
> >         0 (host)              31496
> >         1                        42
> >         2                         1
> > 
> > For that example the two newly introduced parameters to struct
> > clone_args (set_tid and set_tid_size) would need to be:
> > 
> >   set_tid[0] = 1;
> >   set_tid[1] = 42;
> >   set_tid[2] = 31496;
> >   set_tid_size = 3;
> > 
> > If only the PIDs of the two innermost nested PID namespaces should be
> > defined it would look like this:
> > 
> >   set_tid[0] = 1;
> >   set_tid[1] = 42;
> >   set_tid_size = 2;
> > 
> > The PID of the newly created process would then be the next available
> > free PID in the PID namespace level 0 (host) and 42 in the PID namespace
> > at level 1 and the PID of the process in the innermost PID namespace
> > would be 1.
> > 
> > The set_tid array is used to specify the PID of a process starting
> > from the innermost nested PID namespaces up to set_tid_size PID namespaces.
> > 
> > set_tid_size cannot be larger then the current PID namespace level.
> > 
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> 
> I have no quarrels with the core patch anymore.
> Note, once Oleg has said he's fine with this patch too I will likely
> reword the kernel-doc and the comment in alloc_pid() and the commit
> message a little before applying; but really just minor things that are
> not worth resending for.
> 
> Thanks!
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

And thanks for the --base=<commit> information you've added to this
version. :)

	Christian
