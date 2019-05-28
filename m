Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865EEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6312B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfE1PX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:23:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59407 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1PX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:23:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVdwk-0005LO-Ez; Tue, 28 May 2019 09:23:26 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVdwj-0000nk-MF; Tue, 28 May 2019 09:23:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
References: <20190526102612.6970-1-christian@brauner.io>
Date:   Tue, 28 May 2019 10:23:21 -0500
In-Reply-To: <20190526102612.6970-1-christian@brauner.io> (Christian Brauner's
        message of "Sun, 26 May 2019 12:26:11 +0200")
Message-ID: <87ef4i7gd2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hVdwj-0000nk-MF;;;mid=<87ef4i7gd2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192bua1YZy3Dbuv7XOFCoNXo6ZmQQ/qw3c=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] fork: add clone6
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> This adds the clone6 system call.
>
> As mentioned several times already (cf. [7], [8]) here's the promised
> patchset for clone6().
>
> We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> free flag from clone().
>
> Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> at Linux Plumber Conference last year and has been sent out and reviewed
> (cf. [5]). It is expected that it will go upstream in the not too distant
> future. However, it relies on the addition of the CLONE_NEWTIME flag to
> clone(). The only other good candidate - CLONE_DETACHED - is currently not
> recycable as we have identified at least two large or widely used codebases
> that currently pass this flag (cf. [2], [3], and [4]). Given that we
> grabbed the last clone() flag we effectively blocked the time namespace
> patchset. It just seems right that we unblock it again.

I am not certain just extending clone is the right way to go.

- Last I looked glibc does not support calling clone without creating
  a stack first.  Which makes it unpleasant to support clone as a fork
  with extra flags as container runtimes would appreciate.

- Tying namespace creation to process creation is unnecessary.
  I admit both the time and the pid namespace actually need a new
  process before you can use them, but the trick of having a namespace
  for children and a namespace the current process uses seems to handle
  that case nicely.

- There is cruft in clone current runtimes do not use.
  The entire CSIGNAL mask. Also: CLONE_PARENT, CLONE_DETACHED.  And
  probably one or two other bits that I am not remembering right now.

  It would probably make sense to make all of the old linux-thread
  support optional so we can compile it out, and in a decade or two
  get rid of it as unused code.

Maybe some of this is time critical and doing everything in a single
system call makes sense.  But I don't a few extra microseconds matters
in container creation.  It feels to me like the road to better
maintenance of the kernel would just be to move work out of clone.

It certainly feels like we could implement all of the current
clone functionality on top of a simpler clone that I have described.

Perhaps we want sys_createns that like setns works on a single
namespace at a time.

Eric
