Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D820C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3217C206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZbmEpU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCOMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:12:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbfLCOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575382372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWT0o3rfY4Pg9dfGakNcTQJLoFgbG8ngbgCDLw3/UgM=;
        b=gZbmEpU2xPqAW+c9vhEPnbBVWqp5jZ600bb1QbxekplWgvKbMxFmPIBI0FVk7Tft91/U73
        bXAHximrhM31j7o8AYHacSZQz7Xeq7YVb868Esel3PYkK4IdwOSTtWLNvVOVZP66KhSISV
        XgiT2PHXRgakHu5ISc7S/VSXVe4NEek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-YNys2k-UPEi9zA0jrKbA7g-1; Tue, 03 Dec 2019 09:12:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F0828C1F55;
        Tue,  3 Dec 2019 14:12:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id B55B819C68;
        Tue,  3 Dec 2019 14:12:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Dec 2019 15:12:46 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:12:39 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20191203141239.GA30688@redhat.com>
References: <20191126110659.GA14042@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126110659.GA14042@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YNys2k-UPEi9zA0jrKbA7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version follows the latest recommendation from Linus,
arch_set_restart_data() just saves ti->status in restart->arch_data.

Andy, I can add another patch or change 4/4 to save the syscall number
instead, I am fine either way.

However, personally I dislike restart->arch_data, imo 3/4 is all we need.

I agree, set_restart_fn() is better than the ugly ERESTART_RESTARTBLOCK
check in syscall_return_slowpath() added by v1. But to me the x86-only
arch_data field in restart_block is much worse than the sticky TS_ flag.

To remind, there is another reason for the "transient" 3/4, 4/4 is not
easily backportable.

Oleg.
---
 arch/x86/include/asm/processor.h   |  9 ---------
 arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
 arch/x86/kernel/signal.c           | 24 +-----------------------
 fs/select.c                        | 10 ++++------
 include/linux/restart_block.h      |  1 +
 include/linux/thread_info.h        | 12 ++++++++++++
 kernel/futex.c                     |  3 +--
 kernel/time/alarmtimer.c           |  2 +-
 kernel/time/hrtimer.c              |  2 +-
 kernel/time/posix-cpu-timers.c     |  2 +-
 10 files changed, 36 insertions(+), 44 deletions(-)

