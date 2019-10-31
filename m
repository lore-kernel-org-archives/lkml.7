Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E88CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132D52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiNMy1tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfJaJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:41:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726864AbfJaJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572514865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FphYlGHf0GOBbNL99gSzHiqeOzgs9Hepno3U9ekZfgk=;
        b=UiNMy1tM15M00E9bwA6cbRF4S/yXCJrmsU0yrXJeFWuQR2kVX+uk2Zm3/rS2xTfxbZ0Gsg
        6fc6ayNxLPn7tr+xEtiPrBP49NTJGlP4f7NGfOzQfh3qCVbCM5ja4IXMVcuGW+o71IwQS4
        uTC2eLdz3dfE8ZGFDv4AAaIqeRXtvkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-FFvMLDcLMMOOAmBqX6VMqQ-1; Thu, 31 Oct 2019 05:41:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91647800D49;
        Thu, 31 Oct 2019 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 339045D6A3;
        Thu, 31 Oct 2019 09:40:39 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when
 the crashkernel option is specified
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191031033517.11282-1-lijiang@redhat.com>
 <20191031033517.11282-2-lijiang@redhat.com>
 <20191031071345.GA17248@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
Date:   Thu, 31 Oct 2019 17:40:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191031071345.GA17248@nazgul.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FFvMLDcLMMOOAmBqX6VMqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8831=E6=97=A5 15:13, Borislav Petkov =E5=86=
=99=E9=81=93:
> Please do not merge a 0day bot fix with another patch of yours which
> does not cause it in the first place. When you look at this patch alone,
> what do you think the Reported-by tag means, if anything at all?
>=20
Thanks for your suggestions.

Maybe it should be a separate patch to fix the old compile warnings as foll=
ow.
And i should put the patch into this series.


commit d2091d1f4f67f1c38293b0e93fdbfefa766940cf (HEAD -> master)
Author: Lianbo Jiang <lijiang@redhat.com>
Date:   Thu Oct 31 15:48:02 2019 +0800

    kexec: Fix i386 build warnings that missed declaration of struct kimage
   =20
    Kbuild test robot reported some build warnings, please refer to the
    Link below for details.
   =20
    Add a declaration of struct kimage to fix these compile warnings.
   =20
    Fixes: dd5f726076cc ("kexec: support for kexec on panic using new syste=
m call")
    Reported-by: kbuild test robot <lkp@intel.com>
    Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
    Link: https://lkml.org/lkml/2019/10/30/833

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 0acf5ee45a21..ef5638f641f2 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
=20
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,

> Also, it is not a "RESEND" if you change them. You can call them v8.1 or
> whatever to denote that the change is small.
>=20
Thanks for your explanation in detail.

> Also, do not send v9 or v8.1 or whatever, immediately but wait for other
> reviews.

OK. Lets wait a week or more.

> You have sent these patches 4(!) times in this week alone. How
> would you feel if I hammer your inbox with patches on a daily basis?
>Probably because the change is small.

Anyway, so sorry, it seems inconsiderate.

> You can read
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>=20
> in the meantime, especially section
>=20
> "9) Don't get discouraged - or impatient"
>=20
> while waiting.

OK. Thanks.

Lianbo

