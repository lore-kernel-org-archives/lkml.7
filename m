Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F7EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9523C206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfG2O1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55517 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfG2O1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:27:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 092973082120;
        Mon, 29 Jul 2019 14:27:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91E27600F8;
        Mon, 29 Jul 2019 14:27:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Jul 2019 16:27:49 +0200 (CEST)
Date:   Mon, 29 Jul 2019 16:27:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190729142744.GA11349@redhat.com>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727222229.6516-2-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 14:27:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28, Christian Brauner wrote:
>
> +static struct pid *pidfd_get_pid(unsigned int fd)
> +{
> +	struct fd f;
> +	struct pid *pid;
> +
> +	f = fdget(fd);
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +
> +	pid = pidfd_pid(f.file);
> +	if (!IS_ERR(pid))
> +		get_pid(pid);
> +
> +	fdput(f);
> +	return pid;
> +}

Agreed, this looks better than the previous version.

FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

