Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74CC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8510E2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="khxVi1S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGLK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:59:51 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:51860 "EHLO
        elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfGLK7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:59:47 -0400
X-Greylist: delayed 40107 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 06:59:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1562929186; bh=HH6F+Zz+kcpvThVfKqHMkBysqE82SPlhncYX
        ZhiX8XU=; h=Received:From:Content-Type:Content-Transfer-Encoding:
         Subject:Message-Id:Date:To:Mime-Version:X-Mailer:X-ELNK-Trace:
         X-Originating-IP; b=khxVi1S29L13qOJpBTFyjE11W1Tcf7PnxENNINmuuc2mH4
        /unkFIa+iPlkpluAmACKv200cnHEpBaKTUk4wKKfMMqUr6oysQhH0RW6sZAXsH4eQ0+
        nR9gV+r1YGO1tg6hP5AyqodSk8I0rq3tmQtlb4zImPOsUYzniewvEg3PJeQQUt8bUJZ
        1EczKumUlpscp8iaGpeGlaY9COr+hAfwXuV9YABSYnJuAb0G+KSGi7cc1Hz/3dCxjpa
        Bi8SOPkyDZCaLlki4SJANL03ToH3T2AI8GNYvpH/9/WV3e0RA7C7ciubcAXhwqau2YA
        KqCQWLvTaOJdB8+6YOvye+vKh5Xg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=rwqx+vyeKMurkH0OFvHbLfVaybiiM6r5v2L+hmvnBERJ+rDNnAn6JWiCshFpUh+cFUrZzaOPfjUx9XAYsPh8LsW0999WmaGrgszzODBoAwFLv2RvfUsSV2r2yJ8S3xAFOFpeqY6d183BneVh+csZV/GWjf688tFNavw4vIwi0Guwbx1orVgPhat1HEacH6c5SF9phrx3wGnwfViTkvffAiF/z7QuZGeeT+GoZfMOoBjjeCcV7za5Vt4/3druSLpjxhWCoWBNL8l8BgOUvZTg8Jf0jXw+pi6IFkxpdVDLkPd/3ngCZfH0ltwIKVGZ+nFa7QXjKMNowPcL/Adf/xTgNg==;
  h=Received:From:Content-Type:Content-Transfer-Encoding:Subject:Message-Id:Date:To:Mime-Version:X-Mailer:X-ELNK-Trace:X-Originating-IP;
Received: from [24.6.250.120] (helo=[10.0.0.50])
        by elasmtp-galgo.atl.sa.earthlink.net with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4)
        (envelope-from <erblichs@earthlink.net>)
        id 1hliqM-0007dV-VB
        for linux-kernel@vger.kernel.org; Thu, 11 Jul 2019 19:51:19 -0400
From:   Mitchell Erblich <erblichs@earthlink.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Propose New Linux Scheduling Policies
Message-Id: <9989192B-F7F2-4B0E-BD96-21E0862BBD0F@earthlink.net>
Date:   Thu, 11 Jul 2019 16:51:17 -0700
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
X-ELNK-Trace: 074f60c55517ea841aa676d7e74259b7b3291a7d08dfec7965f5f19c0a0652b6d719b172dfc94dfe350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.6.250.120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Proposed new Linux Scheduling Policies                                   =
 July 2019

Version 0.9

=20

=20

./uapi/linux/sched.h

=20

#define             SCHED_INTERACTIVE            7

#define            SCHED_UNEQUAL                        8

=20

Each of these new scheduling policies have been implemented in one or =
more other UNIX operating systems in the past and currently to support a =
new scheduling behaviour. Isn=E2=80=99t ist about time that Linux =
supports these in the mainline OS.

=20

SCHED_INTERACTIVE is meant to be used for tasks that are infrequently =
runnable, but once runnable should run with an absolute minimum latency. =
An example of this is the mouse icon. Currently this behaviour is =
determined based on past running behaviour where a minimum percentage of =
use of its runnable time has occurred and thus can loose its interactive =
as its runs. Common sense says that this type of process should always =
be interactive.

=20

SCHED_UNEQUAL is meant to support an unfair scheduling policy for tasks =
that SHOULD run infrequently buy when runnable, SHOULD run to =
completion. This is more of a scalable flag, where the number of =
runnable tasks may increase, thus limiting its runnable time within a =
specific time window and/or the objects that the task is dealing with =
may increase that almost two times or more executing cycles are =
necessary for the task to run to completion. An example of this is a =
routing task that processes Link State Advertisements (LSAs) so a change =
in the routing table can be accomplished within a minimum of time. =
Without doing this network routing loops and black holes can exist for =
short periods of time loosing and/or increasing unnecessary control and =
data packet exchange.

=20

Manual pages: Any manual page such as SCHED_SETATTR(2)  SHOULD be =
updated to acknowledge these new scheduling policies.

=20

Applications: Tasks that display output about tasks / scheduling =
minimally need to be recompliled and be made aware of these new =
scheduling policies.

=20

Inheritance: It is not believed that  these new policies SHOULD be =
inherited at time of a clone(2) / fork().

=20

Weighting: Currently the suggested / proposed change is to implement a =
simplified differential weighting policy when SCHED_UNEQUAL is =
specified. A possible future change COULD support multiple UNEQUAL =
scheduling policies by combining an existing metric. This is for a later =
proposed change sometime after this proposed change is accepted.

=20

Security / Denial Of Service (DoS) issues:

            SCHED_INTERACTIVE:  Code must be implemented to prevent =
repeatedly  inserting SCHED_INTERACTIVE tasks onto cpu cores and to deny =
other tasks from executing.

=20

            SCHED_UNEQUAL: Currently only when multiple tasks are =
runnable and consume the entire window of cpu cycles, by running this =
task two or three times in a row SHOULD on the worse case add less than =
8% cpu cycles.

=20

            To mitigate any scheduling disturbances setting these flags =
should be limited to an administrator aka root type user with specific =
capabilities.

=20

TBDs: If Linux=E2=80=99s kernel.org sees that this feature is wanted in =
the near and/or distant future, then =E2=80=9CUNKNOWNs / TBDs=E2=80=9D =
or issues should be listed here.

=20

This notice is not a proposal for kernel.org code integration at this =
time, but is intended for Copyright Notice and a general consensus =
whether this feature is beneficial for its future inclusion into =
Linux=E2=80=99s kernel.org.

=20

Copyright Notice:

While this two page introduction on these new scheduling policies is =
being proposed, it is actually a minimal awareness document that should =
satisfy that a code change has been implemented within public domain =
source in the past and a determination whether this feature is wanted by =
kernel.org.

=20

While the actual implementation code that uses these flags is =
proprietary, as most OS code is modified, it is coded / changed by =
multiple engineers and without general acceptance that this change is =
accepted, anything beyond an inception / concept proposal to specify new =
scheduling policy flags kernel.org is unnecessary at this time.

=20

Warantee:

Usage etc, and incorporation of minimally tested / unknown / untested =
code is =E2=80=9CAS-IS=E2=80=9D with no warranties suggested or implied.

=20

Reference for a past scheduler:

SunOS within the SVR4.x used SCHED_INTERACTIVE

=20

VMware and others: Support a weighted process scheduler to allow UNEQUAL =
scheduling.

=20

=20

Mitchell Erblich
UNIX Kernel Engineer Developer


Mitchell Erblich
erblichs@earthlink.net



