Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DEECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FDC20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AnfMU9g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfJAOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:48:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfJAOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:48:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91Ed9bu126893;
        Tue, 1 Oct 2019 14:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=r2bx07k8cvHeEWslLBzDQgSseP2xv04aUuEkxPKPjyk=;
 b=AnfMU9g3kCbiJpkkZYvTwpOdV03FPZEgf3wcfDMSSN38kMFF/9qDB740zQar2AouhlXR
 ZNpcM77eXu5fgLK3N68lrGn86CAf1M2L7j9mOgpQ7mNajN5HiwNmW8PQ7KCAg8gBzHXB
 12bF9gdAIoqdhs7F77NOKcZulDdZDQk4rzc/46XOT1TVxi/kz2e7NfUBldx7ER/3bI88
 Nb4tyvNXEjdTQzTYFnde++vyTk/9a5SsuAfhQ9YOqXbokN2BG+zVuIfmnO+CfjEUvpXu
 dRWLFQIpbPPcV668gsB7badUsGGBxHf9qsd9dCjMUTiE9YHDDaFHa8TMhqgyX9Jh3QM/ Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05rpfau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 14:47:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91Ecalj039546;
        Tue, 1 Oct 2019 14:47:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vbqd106ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 14:47:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91ElntT010326;
        Tue, 1 Oct 2019 14:47:49 GMT
Received: from tomti.i.net-space.pl (/10.175.183.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 07:47:49 -0700
Date:   Tue, 1 Oct 2019 16:47:43 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     hpa@zytor.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v2 2/3] x86/boot: Introduce the setup_indirect
Message-ID: <20191001144743.qrazs4fi7iuf25k5@tomti.i.net-space.pl>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-3-daniel.kiper@oracle.com>
 <143DFBDE-E604-48E0-8072-6DB68E3E83C1@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143DFBDE-E604-48E0-8072-6DB68E3E83C1@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 08:56:44AM -0700, hpa@zytor.com wrote:
> On July 4, 2019 9:36:11 AM PDT, Daniel Kiper <daniel.kiper@oracle.com> wrote:

[...]

> >diff --git a/arch/x86/include/uapi/asm/bootparam.h
> >b/arch/x86/include/uapi/asm/bootparam.h
> >index b05318112452..aaaa17fa6ad6 100644
> >--- a/arch/x86/include/uapi/asm/bootparam.h
> >+++ b/arch/x86/include/uapi/asm/bootparam.h
> >@@ -2,7 +2,7 @@
> > #ifndef _ASM_X86_BOOTPARAM_H
> > #define _ASM_X86_BOOTPARAM_H
> >
> >-/* setup_data types */
> >+/* setup_data/setup_indirect types */
> > #define SETUP_NONE			0
> > #define SETUP_E820_EXT			1
> > #define SETUP_DTB			2
> >@@ -10,6 +10,7 @@
> > #define SETUP_EFI			4
> > #define SETUP_APPLE_PROPERTIES		5
> > #define SETUP_JAILHOUSE			6
> >+#define SETUP_INDIRECT			7
> >
> > /* ram_size flags */
> > #define RAMDISK_IMAGE_START_MASK	0x07FF
> >@@ -47,6 +48,14 @@ struct setup_data {
> > 	__u8 data[0];
> > };
> >
> >+/* extensible setup indirect data node */
> >+struct setup_indirect {
> >+	__u32 type;
> >+	__u32 reserved;  /* Reserved, must be set to zero. */
> >+	__u64 len;
> >+	__u64 addr;
> >+};
> >+
> > struct setup_header {
> > 	__u8	setup_sects;
> > 	__u16	root_flags;
>

> This needs actual implementation; we can't advertise it until the
> kernel knows how to consume the data! It probably should be moved to
> after the 3/3 patch.
>
> Implementing this has two parts:
>
> 1. The kernel needs to be augmented so it can find current objects via
> indirection.
>
> 2. And this is the main reason for this in the first place: the early
> code needs to walk the list and map out the memory areas which are
> occupied so it doesn't clobber anything; this allows this code to be
> generic as opposed to having to know what is a pointer and what size
> it might point to.
>
> (The decompressor didn't need this until kaslr entered the picture,
> but now it does, sadly.)

Do you think about arch/x86/boot/compressed/kaslr.c:mem_avoid[]?
But it is static. OK, we can assume that we do not accept more than
something indirect entries. However, this is not nice...

> Optional/future enhancements that might be nice:
>
> 3. Add some kind of description (e.g. foo=u64 ; bar=str ; baz=blob) to
> make it possible to write a bootloader that can load these kinds of
> objects without specific enabling.

This means an extension to command line parser. Am I right?

> 4. Add support for mapping initramfs fragments  this way.
>
> 5. Add support for passingload-on-boot kernel modules.

I am not sure what you mean exactly by those two.

Anyway, I would focus only on things which are potentially useful now or
in the near future and not require much code changes. So, IMO #1 and #2
at this point.

Daniel
