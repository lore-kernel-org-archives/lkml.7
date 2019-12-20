Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75964C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D921655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs5/CCNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLTTgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:36:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727413AbfLTTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576870559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0w7BdpFfq1sQvJ5pJAS7Ef9KsGQfYtQlP4zXMnJdaQY=;
        b=Vs5/CCNlyjFmfpvoWzUFW8DVCTiKOmRXkQjrgNhkdaroOxh/wSJ6wSrsfLiYGjnYzTSD7K
        lWidjBEJ0dJu0RMk4YrQ+H1fRA+ZX26mCKQtsHGNltRms64hH+b7mh2EWDyv8SuJYo1hcf
        NHHQg0vnf0F+DwgiLjebDX7TjSra+Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-1oiERg97PtSBy0Z3cBMOZA-1; Fri, 20 Dec 2019 14:35:55 -0500
X-MC-Unique: 1oiERg97PtSBy0Z3cBMOZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD7C1081BFB;
        Fri, 20 Dec 2019 19:35:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-70.brq.redhat.com [10.40.204.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 664CC5DA2C;
        Fri, 20 Dec 2019 19:35:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 20 Dec 2019 20:35:52 +0100 (CET)
Date:   Fri, 20 Dec 2019 20:35:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] x86: Remove force_iret()
Message-ID: <20191220193543.GD13464@redhat.com>
References: <20191219115812.102620-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219115812.102620-1-brgerst@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Brian Gerst wrote:
>
> force_iret() was originally intended to prevent the return to user mode with
> the SYSRET or SYSEXIT instructions, in cases where the register state could
> have been changed to be incompatible with those instructions.  The entry code
> has been significantly reworked since then, and register state is validated
> before SYSRET or SYSEXIT are used.  force_iret() no longer serves its original
> purpose and can be eliminated.

Plus iiuc today force_iret() == set_thread_flag(TIF_NOTIFY_RESUME) simply has
no effect on asm paths.

Acked-by: Oleg Nesterov <oleg@redhat.com>

