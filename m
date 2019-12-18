Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6357CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3026A2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWUCpOts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLRQG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:06:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727345AbfLRQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576685212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bYD9qM4G12ACsN8N52oMjoJYQ17/So3FWT5iFWswF8E=;
        b=DWUCpOtsqc9bJ8aEu6wXuH6oFAAjS85SitXCGvGc3K/l5WzWtSJwf+5418zPrkQ0FtuuJi
        qC3IhNCW1pp/eRaO3yezVCgKGymTU2ZhiZhe/pN0ilSMWSiK2fkftYj3jNcyS2tqF5Lkls
        SH50txSbmcYPhXYnRY/bJS8UGcyaqOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-MCe3Gu6ROiu6e5Okftj-Ag-1; Wed, 18 Dec 2019 11:06:49 -0500
X-MC-Unique: MCe3Gu6ROiu6e5Okftj-Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892D919523BD;
        Wed, 18 Dec 2019 16:06:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 168D626DE0;
        Wed, 18 Dec 2019 16:06:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 18 Dec 2019 17:06:43 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:06:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Q: does force_iret() make any sense today?
Message-ID: <20191218160641.GA29716@redhat.com>
References: <20191218153107.GA3489@redhat.com>
 <CAMzpN2gOA=ysOCidCUmxZ6cev5HuKXPdBA_mni5SR01=ii-+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gOA=ysOCidCUmxZ6cev5HuKXPdBA_mni5SR01=ii-+KQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Brian Gerst wrote:
>
> On Wed, Dec 18, 2019 at 10:31 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I do not pretend I understand the arch/x86/entry/ code, but it seems that
> > asm does all the necessary checks and the "extra" TIF_NOTIFY_RESUME simply
> > has no effect except tracehook_notify_resume() will be called for no reason?
>
> It's a relic of a time before the more robust checks for
> SYSRET/SYSEXIT were added.  The idea was to divert the syscall return
> flow off the fast path.  Even if no exit work was done, the slow path
> always returned with IRET.  But with all the entry rework that has
> been done it is no longer needed and can be removed.

Thanks, this was my understanding. Will you make a patch?

Oleg.

