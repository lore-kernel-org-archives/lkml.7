Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F542073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS9OrlgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLDMPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:15:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727445AbfLDMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575461750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrOcJXjbn+gLPI/4sofwxCKBoLtTKzVjEyNDABlcD40=;
        b=bS9OrlgWWCUpEFgJ92/cefwYbfpC9/nbI+sG4azotUbIxLogZQxVdbFOqdn/9pZKHls8gu
        ClicWT/7JICWeUCGk23USqRm2PYuV9IIQ6o69nIeYDtAmljwzLiKbZ6FP2k/baSqoSOgE5
        k2ecM8lCRqjWJ1ujr8YFxNmkHJKw/Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-WwkofpKWOdmHNCrBb0M2bg-1; Wed, 04 Dec 2019 07:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9ACA911BB;
        Wed,  4 Dec 2019 12:15:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 200FE5D6BB;
        Wed,  4 Dec 2019 12:15:42 +0000 (UTC)
Date:   Wed, 4 Dec 2019 13:15:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
Message-ID: <20191204121540.GE20746@krava>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
 <20191202170633.GN2844@hirez.programming.kicks-ass.net>
 <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
MIME-Version: 1.0
In-Reply-To: <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WwkofpKWOdmHNCrBb0M2bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:39:49PM +0200, Meelis Roos wrote:
> > Does something like so fix it?
>=20
> Unfortunately not (tested on top of todays git):

hi,
which p6 model are you seeing this on?
how do you trigger that?

thanks,
jirka

>=20
> [    0.000000] Linux version 5.4.0-11180-g76bb8b05960c-dirty (mroos@d600)=
 (gcc version 9.2.1 20191109 (Debian 9.2.1-19)) #20 Tue Dec 3 15:14:51 EET =
2019
> [...]
> [    8.774201] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    8.774256] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:1=
16:29
> [    8.774297] index 8 is out of range for type 'u64 [8]'
> [    8.774341] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-11180-g76bb8=
b05960c-dirty #20
> [    8.774345] Hardware name: Dell Computer Corporation Latitude D600    =
               /0X2034, BIOS A16 06/29/2005
> [    8.774349] Call Trace:
> [    8.774368]  dump_stack+0x16/0x19
> [    8.774377]  ubsan_epilogue+0xb/0x29
> [    8.774384]  __ubsan_handle_out_of_bounds.cold+0x43/0x48
> [    8.774396]  ? sysfs_add_file_mode_ns+0xad/0x180
> [    8.774406]  p6_pmu_event_map+0x3b/0x50
> [    8.774413]  is_visible+0x25/0x30
> [    8.774419]  ? collect_events+0x150/0x150
> [    8.774425]  internal_create_group+0xd8/0x3e0
> [    8.774431]  ? collect_events+0x150/0x150
> [    8.774438]  internal_create_groups.part.0+0x34/0x80
> [    8.774444]  sysfs_create_groups+0x10/0x20
> [    8.774454]  device_add+0x62a/0x710
> [    8.774463]  ? kvasprintf_const+0x59/0x90
> [    8.774471]  ? kfree_const+0xf/0x30
> [    8.774479]  ? kobject_set_name_vargs+0x6a/0xa0
> [    8.774489]  pmu_dev_alloc+0x8e/0xe0
> [    8.774497]  perf_event_sysfs_init+0x40/0x78
> [    8.774503]  ? stack_map_init+0x17/0x17
> [    8.774508]  do_one_initcall+0x7a/0x1b3
> [    8.774519]  ? do_early_param+0x75/0x75
> [    8.774528]  kernel_init_freeable+0x1ae/0x230
> [    8.774537]  ? rest_init+0x6d/0x6d
> [    8.774544]  kernel_init+0x9/0xf3
> [    8.774550]  ? rest_init+0x6d/0x6d
> [    8.774556]  ret_from_fork+0x2e/0x38
> [    8.774562] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    8.774606] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    8.774649] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:1=
16:29
> [    8.774690] load of address (ptrval) with insufficient space
> [    8.774727] for an object of type 'const u64'
> [    8.774765] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-11180-g76bb8=
b05960c-dirty #20
> [    8.774768] Hardware name: Dell Computer Corporation Latitude D600    =
               /0X2034, BIOS A16 06/29/2005
> [    8.774771] Call Trace:
> [    8.774777]  dump_stack+0x16/0x19
> [    8.774783]  ubsan_epilogue+0xb/0x29
> [    8.774789]  ubsan_type_mismatch_common.cold+0xd6/0xdb
> [    8.774797]  __ubsan_handle_type_mismatch_v1+0x2d/0x40
> [    8.774804]  p6_pmu_event_map+0x4b/0x50
> [    8.774809]  is_visible+0x25/0x30
> [    8.774815]  ? collect_events+0x150/0x150
> [    8.774820]  internal_create_group+0xd8/0x3e0
> [    8.774826]  ? collect_events+0x150/0x150
> [    8.774833]  internal_create_groups.part.0+0x34/0x80
> [    8.774839]  sysfs_create_groups+0x10/0x20
> [    8.774846]  device_add+0x62a/0x710
> [    8.774854]  ? kvasprintf_const+0x59/0x90
> [    8.774859]  ? kfree_const+0xf/0x30
> [    8.774865]  ? kobject_set_name_vargs+0x6a/0xa0
> [    8.774873]  pmu_dev_alloc+0x8e/0xe0
> [    8.774879]  perf_event_sysfs_init+0x40/0x78
> [    8.774884]  ? stack_map_init+0x17/0x17
> [    8.774890]  do_one_initcall+0x7a/0x1b3
> [    8.774897]  ? do_early_param+0x75/0x75
> [    8.774906]  kernel_init_freeable+0x1ae/0x230
> [    8.774913]  ? rest_init+0x6d/0x6d
> [    8.774920]  kernel_init+0x9/0xf3
> [    8.774926]  ? rest_init+0x6d/0x6d
> [    8.774932]  ret_from_fork+0x2e/0x38
> [    8.774937] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

