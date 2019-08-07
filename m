Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3822296
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfHGRzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:55:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfHGRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:55:36 -0400
Received: from c-67-180-61-213.hsd1.ca.comcast.net ([67.180.61.213] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hvQ9f-0007M4-6W; Wed, 07 Aug 2019 17:55:19 +0000
Date:   Wed, 7 Aug 2019 19:55:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807175511.xchtx764hkkervu3@wittgenstein>
References: <20190806191551.22192-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806191551.22192-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:15:50PM +0200, Adrian Reber wrote:
> The main motivation to add set_tid to clone3() is CRIU.
> 
> To restore a process with the same PID/TID CRIU currently uses
> /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> ns_last_pid and then (quickly) does a clone(). This works most of the
> time, but it is racy. It is also slow as it requires multiple syscalls.
> 
> Extending clone3() to support set_tid makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).
> 
> This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> on clone3() with set_tid as they are currently in place for ns_last_pid.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>

I'm currently on vacation until 12 August so I'm going to be a little
slow in responding. Sorry about that!

Christian
