Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20898CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2B21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnUNTrFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394137AbfJXSbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:31:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47441 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbfJXSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571941889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2aBhb6mYxSEN3F5sFE2bFJJzAJjFs83lANYjYhjQS8=;
        b=GnUNTrFX6vYlJb9lIbQJt7YnAx8l/fv7JKxDEHt2yi6g57txuRPavdtuWJkKRfQuIFxP6U
        HBLNijFhLAxcs4I4ieVXT5DqqJVSvirIjQcuKWQBhfsMYOn9YkY2NvPnNPK6X+ZxiyAL91
        31V7W/iVg8P/wF9EJaF+ZWv7UdK52+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-dSg4lei_PDW1nW54ltodpw-1; Thu, 24 Oct 2019 14:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 070305E6;
        Thu, 24 Oct 2019 18:31:23 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF5664506;
        Thu, 24 Oct 2019 18:31:17 +0000 (UTC)
Date:   Thu, 24 Oct 2019 13:31:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024183115.jomddpijq5u453qc@treble>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
 <20191023151654.GF19358@hirez.programming.kicks-ass.net>
 <20191023171514.7hkhtvfcj5vluwcg@treble>
 <20191024105904.GB4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191024105904.GB4131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dSg4lei_PDW1nW54ltodpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:59:04PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 23, 2019 at 12:15:14PM -0500, Josh Poimboeuf wrote:
> > On Wed, Oct 23, 2019 at 05:16:54PM +0200, Peter Zijlstra wrote:
> > > @@ -157,6 +158,14 @@ static int __apply_relocate_add(Elf64_Sh
> > > =20
> > >  =09=09val =3D sym->st_value + rel[i].r_addend;
> > > =20
> > > +=09=09/*
> > > +=09=09 * .klp.rela.* sections should only contain module
> > > +=09=09 * related RELAs. All core-kernel RELAs should be in
> > > +=09=09 * normal .rela.* sections and be applied when loading
> > > +=09=09 * the patch module itself.
> > > +=09=09 */
> > > +=09=09WARN_ON_ONCE(klp && core_kernel_text(val));
> > > +
> >=20
> > This isn't quite true, we also use .klp.rela sections to access
> > unexported vmlinux symbols.
>=20
> Yes, you said in that earlier email. That all makes it really hard to
> validate this. But unless we validate it, it will stay buggy :/
>=20
> Hmmm.... /me ponders
>=20
> The alternative would be to apply the .klp.rela.* sections twice, once
> at patch-module load time and then apply those core_kernel_text()
> entries, and then once later and skip over them.
>=20
> How's this?

How about something like this?  Completely untested, but if you agree
with this approach I could hack up kpatch-build to test it properly.

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ab4a4606d19b..597bf32bc591 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -239,6 +239,17 @@ static int klp_resolve_symbols(Elf_Shdr *relasec, stru=
ct module *pmod)
 =09=09if (ret)
 =09=09=09return ret;
=20
+=09=09/*
+=09=09 * Prevent module patches from using livepatch relas for
+=09=09 * vmlinux symbols.  Presumably such symbols are exported and
+=09=09 * normal relas can instead be used at patch module loading
+=09=09 * time.
+=09=09 */
+=09=09if (!vmlinux && core_kernel_text(addr)) {
+=09=09=09pr_err("unsupported livepatch symbol\n");
+=09=09=09return -EINVAL;
+=09=09}
+
 =09=09sym->st_value =3D addr;
 =09}
=20

