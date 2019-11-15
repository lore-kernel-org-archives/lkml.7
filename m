Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30647C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6C2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CocXL900"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKOQdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:33:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39230 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727531AbfKOQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573835598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoBpdLu+jjhEff2mhAg7g0GBmy6uvMAfLJMPx0Oznc8=;
        b=CocXL900M5qe204dbjJUvmNdKChxhVCskxbwOqwnHpa933LbfBXo2J/J6JGec4AQJ23iev
        bi5/uiCHPqTAOeTfziE5Syy5SPzDUZ3W5lSHYVkeVrhwY96AEJT6UPPQW4tuI10fs7pmne
        kXdwyYJjVuVzpVDfqmcJ2JGe1aH/YK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-viOPJ7bnNzO4e6bAbfKvjw-1; Fri, 15 Nov 2019 11:33:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13496DBD0;
        Fri, 15 Nov 2019 16:33:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id E46C967E61;
        Fri, 15 Nov 2019 16:33:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Nov 2019 17:33:12 +0100 (CET)
Date:   Fri, 15 Nov 2019 17:33:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115163308.GC25528@redhat.com>
References: <20191115123621.142252-1-areber@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115123621.142252-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: viOPJ7bnNzO4e6bAbfKvjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Adrian Reber wrote:
>
> v11:
>  - abort alloc_pid() correctly if one of the PIDs specified in
>    set_pid[] is invalid (Andrei)
> ---
>  include/linux/pid.h           |  3 +-
>  include/linux/pid_namespace.h |  2 +
>  include/linux/sched/task.h    |  3 ++
>  include/uapi/linux/sched.h    | 53 +++++++++++++++++---------
>  kernel/fork.c                 | 24 +++++++++++-
>  kernel/pid.c                  | 72 +++++++++++++++++++++++++++--------
>  kernel/pid_namespace.c        |  2 -
>  7 files changed, 122 insertions(+), 37 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

