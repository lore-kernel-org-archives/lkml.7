Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFBC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1C42067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfHMOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50711 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfHMOa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35F5C30605EF;
        Tue, 13 Aug 2019 14:30:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04EA56092F;
        Tue, 13 Aug 2019 14:30:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Aug 2019 16:30:26 +0200 (CEST)
Date:   Tue, 13 Aug 2019 16:30:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v6 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20190813143023.GC6971@redhat.com>
References: <20190812200939.23784-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812200939.23784-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 14:30:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12, Adrian Reber wrote:
>
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

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

