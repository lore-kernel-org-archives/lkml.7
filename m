Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E462A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjHYF38Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbfJWTRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:17:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20314 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732232AbfJWTRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571858255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2jWJoLV4M/x0NOV2DvVdjIugn3QFhW+98dQqjMEXRs=;
        b=TjHYF38Z9lAFJaKAUzEiLl6KRn+Yz72OyN9m0GlOjTn5dqiWBWEy09PUnHXuC8ZrJ/wo3I
        9ynJlrgmNSNJ1lISFJrHPfaPhgwufMr80FPFiVse5w6vwak1kTYrlKuPxHHu8Twy46DZTA
        1wzkizizDejoFBaCnX3wLqgFZZQeaiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-jDBA8Uu1MnGLZW0w92yTEw-1; Wed, 23 Oct 2019 15:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0A2107AD31;
        Wed, 23 Oct 2019 19:17:29 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7892D1001B3F;
        Wed, 23 Oct 2019 19:17:27 +0000 (UTC)
Date:   Wed, 23 Oct 2019 14:17:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org
Subject: Re: [PATCH] x86/dumpstack/64: Don't evaluate exception stacks before
 setup
Message-ID: <20191023191725.67dg3vwkpodmbrqv@treble>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
 <20191023135943.GK12121@uranus.lan>
 <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jDBA8Uu1MnGLZW0w92yTEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 08:05:49PM +0200, Thomas Gleixner wrote:
> Cyrill reported the following crash:
>=20
>   BUG: unable to handle page fault for address: 0000000000001ff0
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:get_stack_info+0xb3/0x148
>=20
> It turns out that if the stack tracer is invoked before the exception sta=
ck
> mappings are initialized in_exception_stack() can erroneously classify an
> invalid address as an address inside of an exception stack:
>=20
>     begin =3D this_cpu_read(cea_exception_stacks);  <- 0
>     end =3D begin + sizeof(exception stacks);
>=20
> i.e. any address between 0 and end will be considered as exception stack
> address and the subsequent code will then try to derefence the resulting
> stack frame at a non mapped address.
>=20
>  end =3D begin + (unsigned long)ep->size;
>      =3D=3D> end =3D 0x2000
>=20
>  regs =3D (struct pt_regs *)end - 1;
>      =3D=3D> regs =3D 0x2000 - sizeof(struct pt_regs *) =3D 0x1ff0
>=20
>  info->next_sp   =3D (unsigned long *)regs->sp;
>      =3D=3D> Crashes due to accessing 0x1ff0
>=20
> Prevent this by checking the validity of the cea_exception_stack base
> address and bailing out if it is zero.
>=20
> Fixes: afcd21dad88b ("x86/dumpstack/64: Use cpu_entry_area instead of ori=
g_ist")
> Reported-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: stable@vger.kernel.org

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

--=20
Josh

