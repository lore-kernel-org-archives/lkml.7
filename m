Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F3A217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ixT9WUjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDKJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:21:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38326 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDKJVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:21:33 -0400
Received: from [10.119.185.175] (x2f7f9af.dyn.telefonica.de [2.247.249.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEC991EC01B6;
        Thu, 11 Apr 2019 11:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554974490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ArcHdxASerKPWBHzWz02Yr3opgXM61uRU/36Wc0nFAw=;
        b=ixT9WUjKH0lmoUFef7fiK6hzXaoNvNWejhhGm7xfF7LWG0kQo5E8VkdCFKC3HjKBpTcHwK
        qdQiHNcX3ZMKanLpkkeLc2VDO9V77snHlvZHOGUy6DjoUwoCrM4EyysMRnZGHCyjIAPkGV
        KALBz1jW2TqOO6OjDQvewlXGVcL3E6k=
Date:   Thu, 11 Apr 2019 11:21:28 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp> <20190410171431.GE26580@zn.tnic> <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com> <20190411080927.GA30080@zn.tnic> <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com> <20190411083738.GC30080@zn.tnic> <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernel
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 11, 2019 11:13:03 AM GMT+02:00, Junichi Nomura <j-nomura@ce=2Ejp=
=2Enec=2Ecom> wrote:
>On 4/11/19 5:37 PM, Borislav Petkov wrote:
>> On Thu, Apr 11, 2019 at 08:16:45AM +0000, Junichi Nomura wrote:
>>> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e=2Eg=2E if t=
he
>>> setup_data was invalid=2E In such a case, falling back to
>efi_get_rsdp_addr()
>>> will hit the problem of accessing invalid table pointer again=2E
>>=20
>> Then you need to do this:
>>=20
>> 	if (kexeced kernel) {
>> 		addr =3D kexec_get_rsdp_addr();
>> 		if (!addr) {
>> 			/* cannot get address */
>> 			return -1;
>> 		}
>>=20
>> 		return addr;
>> 	}
>>=20
>> and the calling function get_rsdp_addr() must check the return value
>and
>> if it is not 0, return immediately=2E
>
>Do you mean making get_rsdp_addr() like this?

Does that look like what I've typed above?

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
