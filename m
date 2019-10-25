Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E50CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7258020684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anqM3aJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfJYOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:21:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJYOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572013288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7J520lWRrj+imxTJv4l8gCNf2Iz1uwFcRE5x73vWAiM=;
        b=anqM3aJADVLYOOM+3wiyOZy47bg9YU1ZzkvyZIivAwdQrjYOU+O8c5GlKmn3NPAfDKUUbK
        XVmMH4L3Im4fgZlUCvShSkOiqNCUBvIrStLGcMhnrMens05Xx53bYKe4u40uHwWE0r+Ndq
        u3XLzNZq5rg36Oyped0D489WL62faW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-bBTAucNmPdSyO7tcEJsfqQ-1; Fri, 25 Oct 2019 10:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35555801E5C;
        Fri, 25 Oct 2019 14:21:14 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 604C760BEC;
        Fri, 25 Oct 2019 14:21:12 +0000 (UTC)
Date:   Fri, 25 Oct 2019 09:21:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stacktrace: don't skip first entry on noncurrent tasks
Message-ID: <20191025142110.jgz5jy4nuryhawv5@treble>
References: <20191025065226.10196-1-jslaby@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191025065226.10196-1-jslaby@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bBTAucNmPdSyO7tcEJsfqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:52:26AM +0200, Jiri Slaby wrote:
> When doing cat /proc/<PID>/stack, the output is missing the first entry.
> When the current code walks the stack starting in stack_trace_save_tsk,
> it skips all scheduler functions (that's OK) plus one more function. But
> this one function should be skipped only for the 'current' task as it is
> stack_trace_save_tsk proper.
>=20
> The original code (before the common infrastructure) skipped one
> function only for the 'current' task -- see save_stack_trace_tsk before
> 3599fe12a125. So do so also in the new infrastructure now.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  kernel/stacktrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 6d1f68b7e528..d06a2e4d0142 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -141,7 +141,8 @@ unsigned int stack_trace_save_tsk(struct task_struct =
*tsk, unsigned long *store,
>  =09struct stacktrace_cookie c =3D {
>  =09=09.store=09=3D store,
>  =09=09.size=09=3D size,
> -=09=09.skip=09=3D skipnr + 1,
> +=09=09/* skip this function if they are tracing us */
> +=09=09.skip=09=3D skipnr + !!(current =3D=3D tsk),
>  =09};
> =20
>  =09if (!try_get_task_stack(tsk))

I think a similar change is needed for the other !CONFIG_ARCH_STACKWALK
version of stack_trace_save_tsk() in that file?

--=20
Josh

