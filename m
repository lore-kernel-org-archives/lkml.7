Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28267C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVGmntSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLLJvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:51:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728371AbfLLJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576144294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHWsf1eKzFO4kj5ajqTbRfrnSvneiwRK1IpHxsxAQr4=;
        b=PVGmntSM4knbEQGFlWppLYL/AnUcYQ8x+wrEqek2ed5K/KGlRuk7QjfWnZEqYWCyy/j8kA
        x8vG9fMloYefL1sAI7LmuhQH+jy89KvXeuLw/BWT08JGsOkFUCJU4rQfklLENtxGNdMSAt
        WJJA++bDRbcmyqP2Bmjm+8GUcT9BO4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-NYwOj1hOPM2Z8GbVJ1dQuQ-1; Thu, 12 Dec 2019 04:51:33 -0500
X-MC-Unique: NYwOj1hOPM2Z8GbVJ1dQuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A6CDBE6;
        Thu, 12 Dec 2019 09:51:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5AAE860BE1;
        Thu, 12 Dec 2019 09:51:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Dec 2019 10:51:31 +0100 (CET)
Date:   Thu, 12 Dec 2019 10:51:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/exit: do panic earlier to get coredump if global
 init task exit
Message-ID: <20191212095127.GA5460@redhat.com>
References: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, qiwuchen55@gmail.com wrote:
>
> Of course testing signal_group_exit() is not sufficient. It is still
> possible that this is someone calling exit(2)

Or execve(), so

> @@ -785,6 +781,9 @@ void __noreturn do_exit(long code)
>  		panic("Aiee, killing interrupt handler!");
>  	if (unlikely(!tsk->pid))
>  		panic("Attempted to kill the idle task!");
> +	if (unlikely(is_global_init(tsk) &&
> +		(signal_group_exit(tsk->signal) || thread_group_empty(tsk))))
> +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);

so this can panic() if one of init's threads does does exec.

Oleg.

