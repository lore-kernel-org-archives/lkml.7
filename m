Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9748C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF962084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445073;
	bh=WUexA2+dp05oChEUY0hVcSnJGehxfowRO2+SZ2+eUDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tBgXYDDl6FJrbPoOA1KEaxhLJrdvhlOQekZanVTE7Pw9P9qzzox5Oh2DQHN9xrgMw
	 seWdPpeDdIAJ50IGqjo5+TE37K2RalxUPQcEvUYG207y13kkLVSs9zki7tB7YZlQUK
	 6rzu8zGSV4+09GjIZZLeCRs/sOric9ousJCmE2Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393224AbfFMQ5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbfFMBAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:00:33 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DD520B7C;
        Thu, 13 Jun 2019 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560387632;
        bh=WUexA2+dp05oChEUY0hVcSnJGehxfowRO2+SZ2+eUDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=03XL9DAVVWVD08SCihXoCb+VMg14Qe4N0JjLvI2qz6yWLN8k3lI5jhzDJ4oQpOh73
         ODhE/FDdjsYf0cN14H2V8IPabHV05TMOWNJnCPwwOCy0nrZ1Q/384BAQ5PcqarQ/gU
         KnjV1EfqhlRVRJ0s3WFfskPMF5KWnCWHeROGM/ZQ=
Date:   Wed, 12 Jun 2019 18:00:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH v2] mm/oom_killer: Add task UID to info message
 on an oom kill
Message-Id: <20190612180031.e9314711c9d0c77ba915d977@linux-foundation.org>
In-Reply-To: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
References: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 13:57:53 -0400 Joel Savitz <jsavitz@redhat.com>
wrote:

> In the event of an oom kill, useful information about the killed
> process is printed to dmesg. Users, especially system administrators,
> will find it useful to immediately see the UID of the process.
> 
> In the following example, abuse_the_ram is the name of a program
> that attempts to iteratively allocate all available memory until it is
> stopped by force.
> 
> Current message:
> 
> Out of memory: Killed process 35389 (abuse_the_ram)
> total-vm:133718232kB, anon-rss:129624980kB, file-rss:0kB,
> shmem-rss:0kB
> 
> Patched message:
> 
> Out of memory: Killed process 2739 (abuse_the_ram),
> total-vm:133880028kB, anon-rss:129754836kB, file-rss:0kB,
> shmem-rss:0kB, UID 0

The other fields are name:value so it seems better to make the UID
field conform.

Also, there's no typesafe way of printing a uid_t (using the printk %p trick)
so yes, we have to assume its type.  But assuming unsigned int is
better than assuming int!

So...



s/UID %d/UID:%u/ in printk

--- a/mm/oom_kill.c~mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill-fix
+++ a/mm/oom_kill.c
@@ -876,7 +876,7 @@ static void __oom_kill_process(struct ta
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID %d\n",
+	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u\n",
 		message, task_pid_nr(victim), victim->comm,
 		K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
_

