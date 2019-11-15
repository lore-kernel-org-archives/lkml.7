Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFDF20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHubXHNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKOASX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:18:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbfKOASW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573777101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZC4oRKrw/qWdzHQoCwRQZNWCxM2orILGhYYmWScMkN8=;
        b=gHubXHNew/mkVcGaYaMqRrWGEeAkWLVYPrKA47WAYffSSFu6KJYi3USmcnmrJ1HhrIShwr
        KiAbCfWtbzt/tB0Q37QmiHIMACuyYVxtr/U9OefiVAaworV8FFsVbsXo4X4WE1T5oo1wsk
        UgsQWCOGzmIFaXRSIyYrFVX1iJXR7HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-GWv-dqrhPmGI0TpTUuYg4g-1; Thu, 14 Nov 2019 19:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C270107ACC5;
        Fri, 15 Nov 2019 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BEC03DBB;
        Fri, 15 Nov 2019 00:18:06 +0000 (UTC)
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com> <20191114123920.GA7222@zn.tnic>
 <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
 <20191114144353.GB7222@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <16a61f4d-a112-6766-0272-9cfd65e78503@redhat.com>
Date:   Fri, 15 Nov 2019 08:18:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191114144353.GB7222@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GWv-dqrhPmGI0TpTUuYg4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B411=E6=9C=8814=E6=97=A5 22:43, Borislav Petkov =E5=86=
=99=E9=81=93:
> On Thu, Nov 14, 2019 at 10:20:42PM +0800, lijiang wrote:
>> I really saw my building result, but kbuild reported the following messa=
ges:
>>
>> vim +5 arch/x86/include/asm/crash.h
>>
>> dd5f726076cc76 Vivek Goyal 2014-08-08   4 =20
>> dd5f726076cc76 Vivek Goyal 2014-08-08  @5  int crash_load_segments(struc=
t kimage *image);
>> dd5f726076cc76 Vivek Goyal 2014-08-08   6  int crash_copy_backup_region(=
struct kimage *image);
>> dd5f726076cc76 Vivek Goyal 2014-08-08   7  int crash_setup_memmap_entrie=
s(struct kimage *image,
>> dd5f726076cc76 Vivek Goyal 2014-08-08   8  =09=09struct boot_params *par=
ams);
>> 89f579ce99f7e0 Yi Wang     2018-11-22   9  void crash_smp_send_stop(void=
);
>> dd5f726076cc76 Vivek Goyal 2014-08-08  10 =20
>>
>> :::::: The code at line 5 was first introduced by commit=20
>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> :::::: dd5f726076cc7639d9713b334c8c133f77c6757a kexec: support for kexec=
 on panic using new system call
>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> You should not take the report of a bot blindly but should always double
> check it. Like every other computer system programmed by humans, it can
> make mistakes.
>=20

Indeed, i totally agree.

>> Would you mind giving me any suggestions about this?
>=20
> I'll take care of it all and push the results out soon.
>=20

OK, thank you so much.

Lianbo

