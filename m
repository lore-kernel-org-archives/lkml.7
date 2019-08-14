Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA4C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfHNM3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNM3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:29:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED579300D209;
        Wed, 14 Aug 2019 12:29:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D88B80697;
        Wed, 14 Aug 2019 12:29:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Aug 2019 14:29:16 +0200 (CEST)
Date:   Wed, 14 Aug 2019 14:29:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v1 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814122909.GA11595@redhat.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814113822.9505-1-christian.brauner@ubuntu.com>
 <20190814113822.9505-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814113822.9505-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 14 Aug 2019 12:29:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, christian.brauner@ubuntu.com wrote:
>
>  	case P_PGID:
>  		type = PIDTYPE_PGID;
> -		if (upid <= 0)
> +		if (upid < 0)
>  			return -EINVAL;
> +
> +		if (upid == 0)
> +			pid = get_pid(task_pgrp(current));

this needs rcu lock or tasklist_lock, this can race with another thread
doing sys_setpgid/setsid (see change_pid(PIDTYPE_PGID)).

Oleg.

