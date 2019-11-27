Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E2C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aItzIAsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfK0RG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:06:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbfK0RG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574874416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oOmKbV9hdKrDqi7PW4BFEhBM29CRms8n2gM1AJunA0=;
        b=aItzIAsk/PjT7DuIdphv/HxbwiGiiQfjBTTxYVdzUF9wpBjRJZgRV373uMqixu8zLoUW6D
        q/RTBUchAlJ42Ge3vG67RsBzN16eKZSvCeqakA9a8Wr/ntQRJRekqQIHU93PUVOA1wHzzl
        SvJZ71zzoKCmf8E+V77NRjMLTIouL8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-9VTPTGAtPsiPVflD9etptw-1; Wed, 27 Nov 2019 12:06:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08E6800EB9;
        Wed, 27 Nov 2019 17:06:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id B09296015A;
        Wed, 27 Nov 2019 17:06:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Nov 2019 18:06:50 +0100 (CET)
Date:   Wed, 27 Nov 2019 18:06:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()
Message-ID: <20191127170644.GB26180@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
 <CALCETrWTjUJQVXmbhnAfpg=J1kV8XZnWrjR7Yt+a1Dd2GSTr5A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrWTjUJQVXmbhnAfpg=J1kV8XZnWrjR7Yt+a1Dd2GSTr5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9VTPTGAtPsiPVflD9etptw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26, Andy Lutomirski wrote:
>
> How about we rename restart_block::fn to __fn,

Oh, please no. We can do this later, this needs to update every arch/

> add fields
> restart_syscall_nr and restart_syscall_arch,

Hmm, why do we nedd 2 fields ?

and do:

> IMO the ideal solution would be to add a new syscall nr to restart a
> syscall and make it the same on all architectures.

Damn yes! And I tried to suggest this 2 years ago. But

> This has
> unfortunate interactions with seccomp, though.

Yes. Do you think we can do something with seccomp?

Oleg.

