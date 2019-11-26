Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87DE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ/RWi0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfKZLIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:08:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfKZLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574766489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QxjabJ2+H9ENscnaiv9GHcq5iJDs19EC3SBNqZp5m4=;
        b=LZ/RWi0S+xJcoRvf93O4mo9BevSZ5FrZDAqt8lQQHDsPfTKCeO1HRgLq5h5nZUdlVht5tY
        wO0Z0/MwFWNRskdzTAJZi7VDbEY3Pa2U51Zap4Ul/es7HlOf1LjLgI17SzVJTXIT5LWQBJ
        oWN0ir45JLcv3AmQagjRxa8JxXvyA4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-hba4pxdaN9mom16cpi2g8g-1; Tue, 26 Nov 2019 06:08:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA952100550D;
        Tue, 26 Nov 2019 11:08:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 174745D6BE;
        Tue, 26 Nov 2019 11:07:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Nov 2019 12:08:03 +0100 (CET)
Date:   Tue, 26 Nov 2019 12:07:58 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()
Message-ID: <20191126110758.GA14051@redhat.com>
References: <20191126110659.GA14042@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126110659.GA14042@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hba4pxdaN9mom16cpi2g8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26, Oleg Nesterov wrote:
>
> This patch adds the sticky TS_COMPAT_RESTART flag which survives after
> return to user mode, hopefully it allows us to kill TS_I386_REGS_POKED
> but this needs another patch.

Alternatively we could add ->compat_restart into struct restart_block,
logically this is the same thing.

Rather than changing syscall_return_slowpath() we could introduce a new
helper, say,

=09void set_restart_block_fn(struct restart_block *restart, fn)
=09{
=09=09restart->fn =3D fn;

=09=09set/clear TS_COMPAT_RESTART or restart->compat_restart
=09=09depending on TS_COMPAT
=09}

but this patch looks simpler to me.

Oleg.

