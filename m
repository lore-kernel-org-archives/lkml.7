Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE500CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B030A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHPCvXv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfJ2GZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:25:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28299 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbfJ2GZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572330356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X50ijSp+B0o1arpNjHljt3f++0frPk6KMXEog3CQ89o=;
        b=XHPCvXv2CChLuJqLBoydG2cmYikOw6iUfcLRWDlk0GFcvlYQmuCDQyQ9DW95oGeDnVVlEy
        D1MbWCpB/VyTY5/BT7gP22Ks/HAcQfPQXi8338SD4tGQV4RVjkj33S1UGrvM5NQd5GVuDV
        93Z63OkFeJa+VBs7Ndh/4p+DkBBUKlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-P6sGBN67PIm5dGAhj0AmYw-1; Tue, 29 Oct 2019 02:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D07A1005500;
        Tue, 29 Oct 2019 06:25:51 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B61FF5C1D6;
        Tue, 29 Oct 2019 06:25:45 +0000 (UTC)
Date:   Tue, 29 Oct 2019 14:25:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2 v7] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191029062543.GC7616@MiWiFi-R3L-srv>
References: <20191029021059.22070-1-lijiang@redhat.com>
 <20191029021059.22070-2-lijiang@redhat.com>
 <20191029052842.GA7616@MiWiFi-R3L-srv>
 <ffb0d2d3-31c3-fba0-e0f4-bd48999a033e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ffb0d2d3-31c3-fba0-e0f4-bd48999a033e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: P6sGBN67PIm5dGAhj0AmYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 at 02:06pm, lijiang wrote:
> >>  struct crash_memmap_data {
> >> @@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(v=
oid)
> >>  =09rcu_read_unlock();
> >>  }
> >> =20
> >> +/*
> >> + * When the crashkernel option is specified, only use the low
> >> + * 1MiB for the real mode trampoline.
> >> + */
> >> +void __init kexec_reserve_low_1MiB(void)
> >=20
> > Thanks for the effort, Lianbo. I believe everyone is confident with thi=
s
> > solution and fix.
> >=20
> > I have a tiny concern, why the function name is
> > kexec_reserve_low_1MiB(), but not kexec_reserve_low_1M()?
>=20
> Thanks for your comment, Baoquan.
>=20
> It means that kernel will reserve 1M 'Byte' memory, the function name doe=
s not
> have special meaning.
>=20
> Would you mind if i change it to the crash_reserve_low_1M()?

Yes, crash_xx looks better since it's only related to crash dumping. As
for 1M, not very sure, see if other people have comment about it. Anyway,
crash_reserve_low_1M() looks good to me. Thanks.

>=20
> void __init crash_reserve_low_1M(void)
>=20
> Thanks.
> Lianbo
>=20
> > I searched in kernel code with below filter, didn't see MiB appearing i=
n
> > a function name. I am not sure about it either, just ask.
> >=20
> > git grep "_[1-9]*M " arch/ kernel/ mm include/ drivers/ net/ init fs cr=
ypto/ certs/ ipc lib
> >=20
> > Thanks
> > Baoquan
> >=20
> >> +{
> >> +=09if (cmdline_find_option(boot_command_line, "crashkernel",
> >> +=09=09=09=09NULL, 0) > 0) {
> >> +=09=09memblock_reserve(0, 1<<20);
> >> +=09=09pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> >> +=09}
> >> +}
> >> +
> >>  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> >> =20
> >>  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> >> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> >> index 7dce39c8c034..b8bbd0017ca8 100644
> >> --- a/arch/x86/realmode/init.c
> >> +++ b/arch/x86/realmode/init.c
> >> @@ -8,6 +8,7 @@
> >>  #include <asm/pgtable.h>
> >>  #include <asm/realmode.h>
> >>  #include <asm/tlbflush.h>
> >> +#include <asm/crash.h>
> >> =20
> >>  struct real_mode_header *real_mode_header;
> >>  u32 *trampoline_cr4_features;
> >> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
> >> =20
> >>  =09memblock_reserve(mem, size);
> >>  =09set_real_mode_mem(mem);
> >> +=09kexec_reserve_low_1MiB();
> >>  }
> >> =20
> >>  static void __init setup_real_mode(void)
> >> --=20
> >> 2.17.1
> >>

