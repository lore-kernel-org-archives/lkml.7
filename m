Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DDDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248C12089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCaBw+N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfJUNxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:53:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728819AbfJUNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571666003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+azFbWYGdODst3YpR9ii/SydvWcP8Z6kN7+s80qYWg=;
        b=KCaBw+N6tZh+c72k1CFmRUNBywxtByGBbtXDT/F4LS9F8NMoCq3rXVAYk1yq2NFpMFFJ+D
        2EEsDCSh0XwxutO4zw4lA2J0OiHoBq40KI1a3BOC8uhcTJ+x12wFBo1uaa0aADsGwrnoTa
        Iv8isU8OJ8El/Gfvhyo3o7NQzAX/6JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-dtCkrvXnMl6TL-SQC55TFA-1; Mon, 21 Oct 2019 09:53:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C1F91800DC7;
        Mon, 21 Oct 2019 13:53:18 +0000 (UTC)
Received: from treble (ovpn-123-96.rdu2.redhat.com [10.10.123.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34F7760A9F;
        Mon, 21 Oct 2019 13:53:15 +0000 (UTC)
Date:   Mon, 21 Oct 2019 08:53:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191021135312.jbbxsuipxldocdjk@treble>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20191018074634.801435443@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dtCkrvXnMl6TL-SQC55TFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 09:35:40AM +0200, Peter Zijlstra wrote:
> Now that set_all_modules_text_*() is gone, nothing depends on the
> relation between ->state =3D COMING and the protection state anymore.
> This enables moving the protection changes later, such that the COMING
> notifier callbacks can more easily modify the text.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---
>  kernel/module.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3683,10 +3683,6 @@ static int complete_formation(struct mod
>  =09/* This relies on module_mutex for list integrity. */
>  =09module_bug_finalize(info->hdr, info->sechdrs, mod);
> =20
> -=09module_enable_ro(mod, false);
> -=09module_enable_nx(mod);
> -=09module_enable_x(mod);
> -
>  =09/* Mark state as coming so strong_try_module_get() ignores us,
>  =09 * but kallsyms etc. can see us. */
>  =09mod->state =3D MODULE_STATE_COMING;
> @@ -3852,6 +3848,10 @@ static int load_module(struct load_info
>  =09if (err)
>  =09=09goto bug_cleanup;
> =20
> +=09module_enable_ro(mod, false);
> +=09module_enable_nx(mod);
> +=09module_enable_x(mod);
> +
>  =09/* Module is ready to execute: parsing args may do that. */
>  =09after_dashes =3D parse_args(mod->name, mod->args, mod->kp, mod->num_k=
p,
>  =09=09=09=09  -32768, 32767, mod,

[ Sorry if this was already discussed, I still have a large backlog. ]

Doesn't livepatch code also need to be modified?  We have:

prepare_coming_module()
=09klp_module_coming()
=09=09klp_init_object_loaded()
=09=09=09module_disable_ro()
=09=09=09...
=09=09=09module_enable_ro()

which is done right before the above patch does module_enable_ro().

We could remove the disable-RO from that case, though we'd still need it
for another case (late module patching).

--=20
Josh

