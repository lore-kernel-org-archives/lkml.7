Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF0FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7521835
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfdRVMwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfJaB1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:27:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbfJaB1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572485238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrEKWKcGTyztKzabI5ITf2bBcmFzk5xS87SUwCJb26g=;
        b=cfdRVMwz/Kq4hhSzIwQcNjLQz6LeZ6r/eauMXDGIVe+z74lWzSJnd02JYTnE0b8ekVV9Qh
        9xJk74o4nEpaWqVmaJV0MUxCr12+euT958fjUIdavQNGDxHvTdMfPaLUvP0Jyd50di2y7Y
        g9kJq69OxxIx7V0UBJHytYX9iVFl4h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-QWfdGM8fOS-0jt5Bu5JrkQ-1; Wed, 30 Oct 2019 21:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B17E92B4;
        Thu, 31 Oct 2019 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2EE60BE0;
        Thu, 31 Oct 2019 01:27:00 +0000 (UTC)
Subject: Re: [PATCH 0/2 v8] x86/kdump: Fix 'kmem -s' reported an invalid
 freepointer when SME was active
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191030035501.23713-1-lijiang@redhat.com>
Message-ID: <8396c1d7-8ffc-65d1-fbff-558efcf44538@redhat.com>
Date:   Thu, 31 Oct 2019 09:26:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030035501.23713-1-lijiang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QWfdGM8fOS-0jt5Bu5JrkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

Please ignore this patch series because the compile warnings are reported b=
y kduild.

I will resend v8 later after the warnings are fixed.

Sorry for this.

Thanks.
Lianbo

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8830=E6=97=A5 11:54, Lianbo Jiang =E5=86=99=
=E9=81=93:
> In purgatory(), the main things are as below:
>=20
> [1] verify sha256 hashes for various segments.
>     Lets keep these codes, and do not touch the logic.
>=20
> [2] copy the first 640k content to a backup region.
>     Lets safely remove it and clean all code related to backup region.
>=20
> This patch series will remove the backup region, because the current
> handling of copying the first 640k runs into problems when SME is
> active(https://bugzilla.kernel.org/show_bug.cgi?id=3D204793).
>=20
> The low 1M region will always be reserved when the crashkernel kernel
> command line option is specified. And this way makes it unnecessary to
> do anything with the low 1M region, because the memory allocated later
> won't fall into the low 1M area.
>=20
> This series includes two patches:
> [1] x86/kdump: always reserve the low 1M when the crashkernel option
>     is specified
>     The low 1M region will always be reserved when the crashkernel
>     kernel command line option is specified, which ensures that the
>     memory allocated later won't fall into the low 1M area.
>=20
> [2] x86/kdump: clean up all the code related to the backup region
>     Remove the backup region and clean up.
>=20
> Changes since v1:
> [1] Add extra checking condition: when the crashkernel option is
>     specified, reserve the low 640k area.
>=20
> Changes since v2:
> [1] Reserve the low 1M region when the crashkernel option is only
>     specified.(Suggested by Eric)
>=20
> [2] Remove the unused crash_copy_backup_region()
>=20
> [3] Remove the backup region and clean up
>=20
> [4] Split them into three patches
>=20
> Changes since v3:
> [1] Improve the first patch's log
>=20
> [2] Improve the third patch based on Eric's suggestions
>=20
> Changes since v4:
> [1] Correct some typos, and also improve the first patch's log
>=20
> [2] Add a new function kexec_reserve_low_1MiB() in kernel/kexec_core.c
>     and which is called by reserve_real_mode(). (Suggested by Boris)
>=20
> Changes since v5:
> [1] Call the cmdline_find_option() instead of strstr() to check the
>     crashkernel option. (Suggested by Hatayama)
>=20
> [2] Add a weak function kexec_reserve_low_1MiB() in kernel/kexec_core.c,
>     and implement the kexec_reserve_low_1MiB() in arch/x86/kernel/
>     machine_kexec_64.c so that it does not cause the compile error
>     on non-x86 kernel, and also ensures that it can work well on x86
>     kernel.
>=20
> Changes since v6:
> [1] Move the kexec_reserve_low_1MiB() to arch/x86/kernel/crash.c and
>     also move its declaration function to arch/x86/include/asm/crash.h
>     (Suggested by Dave Young)
>=20
> [2] Adjust the corresponding header files.
>=20
> Changes since v7:
> [1] Change the function name from kexec_reserve_low_1MiB() to
>     crash_reserve_low_1M().
>=20
> Lianbo Jiang (2):
>   x86/kdump: always reserve the low 1M when the crashkernel option is
>     specified
>   x86/kdump: clean up all the code related to the backup region
>=20
>  arch/x86/include/asm/crash.h       |   6 ++
>  arch/x86/include/asm/kexec.h       |  10 ---
>  arch/x86/include/asm/purgatory.h   |  10 ---
>  arch/x86/kernel/crash.c            | 102 ++++++++---------------------
>  arch/x86/kernel/machine_kexec_64.c |  47 -------------
>  arch/x86/purgatory/purgatory.c     |  19 ------
>  arch/x86/realmode/init.c           |   2 +
>  7 files changed, 34 insertions(+), 162 deletions(-)
>=20

