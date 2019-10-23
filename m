Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3A521928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgIrHUc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfJWRP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:15:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726205AbfJWRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571850927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=617sJpkJrHxWXGxLxE+ajDrOrRik16ybHA6VjXhWGmA=;
        b=VgIrHUc5/LWmt3W6rzQ+GoYrgzagOvLZ7tVZZR2czYuseeRloa1AAwpwf18/RhEbLwXmNB
        OQ2+ZOcnzD8u1/xmyUdetBAcuaWmWNJLQmHQnfqT7V7JbjRkbJ2wP00UNbmrl0P7X8MWHB
        sHpRRCRA+TF+bkUmo+2W8dgYRO7PK6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-mJxpOxcsMAmXNsr3nwCp7w-1; Wed, 23 Oct 2019 13:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23EA1800D6B;
        Wed, 23 Oct 2019 17:15:21 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D29B6061E;
        Wed, 23 Oct 2019 17:15:16 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:15:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191023171514.7hkhtvfcj5vluwcg@treble>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
 <20191023151654.GF19358@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191023151654.GF19358@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mJxpOxcsMAmXNsr3nwCp7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 05:16:54PM +0200, Peter Zijlstra wrote:
> @@ -157,6 +158,14 @@ static int __apply_relocate_add(Elf64_Sh
> =20
>  =09=09val =3D sym->st_value + rel[i].r_addend;
> =20
> +=09=09/*
> +=09=09 * .klp.rela.* sections should only contain module
> +=09=09 * related RELAs. All core-kernel RELAs should be in
> +=09=09 * normal .rela.* sections and be applied when loading
> +=09=09 * the patch module itself.
> +=09=09 */
> +=09=09WARN_ON_ONCE(klp && core_kernel_text(val));
> +

This isn't quite true, we also use .klp.rela sections to access
unexported vmlinux symbols.

--=20
Josh

