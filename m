Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10847C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD66206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl25IicR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLISIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:08:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbfLISIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575914921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cTjZfqtnLTQpkUl1nJ/jTzVdcY8EvBeyGVedbcZ4sA=;
        b=Kl25IicRveu9rFZCe9NbxMgJjkIMuPGXMx017ShzcvFS3Emun5pbPI+Ad93Hud2+4B5QD8
        3qcpB+JIYmSt1Gb+7fsJfQeNzJ1ISLqq7Acf+Gx+NZc/LLzu51DRbnszEEVSXclMp4UZSX
        l+GS+UogP1VFqDPYGo9xzhMBORzNYsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-27QZrnkLOk-XUVBphY-IGQ-1; Mon, 09 Dec 2019 13:08:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF9D18C35AF;
        Mon,  9 Dec 2019 18:08:36 +0000 (UTC)
Received: from treble (ovpn-125-102.rdu2.redhat.com [10.10.125.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB511001901;
        Mon,  9 Dec 2019 18:08:35 +0000 (UTC)
Date:   Mon, 9 Dec 2019 12:08:33 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] objtool: silence build output from sync-check.sh
Message-ID: <20191209180833.2oleipnnzh7btqno@treble>
References: <20191207205419.9344-1-olof@lixom.net>
MIME-Version: 1.0
In-Reply-To: <20191207205419.9344-1-olof@lixom.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 27QZrnkLOk-XUVBphY-IGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 12:54:20PM -0800, Olof Johansson wrote:
> The sync-check.sh script prints out the path due to a "cd -" at the end
> of the script, even on silent builds. This isn't needed, since the
> script is never sourced (so it won't change the working directory of
> the surrounding build anyway).
>=20
> Just remove the cd to make the build silent.
>=20
> Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-hea=
ders.sh")
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  tools/objtool/sync-check.sh | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
> index 9bd04bbed01e..2a1261bfbb62 100755
> --- a/tools/objtool/sync-check.sh
> +++ b/tools/objtool/sync-check.sh
> @@ -48,5 +48,3 @@ check arch/x86/include/asm/inat.h     '-I "^#include [\=
"<]\(asm/\)*inat_types.h[
>  check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.=
h[\">]"'
>  check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\=
)*asm/insn.h[\">]"'
>  check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\=
)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_p=
refix.h[\">]"'
> -
> -cd -

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

If you want to send it through -tip, please resend to x86@kernel.org.

--=20
Josh

