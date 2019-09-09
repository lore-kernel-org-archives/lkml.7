Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40FDC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275120863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ZSKBUntz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfIIWeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:34:36 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:54140 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389010AbfIIWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9KscsWAaBE1jNLn+Rl6HyrO5x40q+4spa6O3IhEemW8=; b=ZSKBUntzMqekIqdvviTztD4gS
        fkTNNLm6wtkTBXwaU7DwIRNVgk5FHBxPO5Qd5yrQXOWGzgbbumsyUfKx+FagwKgNpmVYDAoaSAlfq
        VbMB0zqFaGHdazhNhw7bxV8xb8c49lsDz1vgn/RTl4drn1CzrWdlaOuz4WiSf8FFBsi6M=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.132])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <bshanks@codeweavers.com>)
        id 1i7SEx-0000Es-SN; Mon, 09 Sep 2019 17:34:32 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <20190907212610.GA30930@ranerica-svr.sc.intel.com>
Date:   Mon, 9 Sep 2019 15:34:28 -0700
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <317243DA-3BAE-4620-8E31-5F23145DD992@codeweavers.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
 <20190907212610.GA30930@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 7, 2019, at 2:26 PM, Ricardo Neri =
<ricardo.neri-calderon@linux.intel.com> wrote:
>=20
> On Thu, Sep 05, 2019 at 04:22:21PM -0700, Brendan Shanks wrote:
>>=20
>> 	if (umip_inst =3D=3D UMIP_INST_SGDT || umip_inst =3D=3D =
UMIP_INST_SIDT) {
>> +		u64 dummy_base_addr;
>> +		u16 dummy_limit =3D 0;
>> +
>> 		/* SGDT and SIDT do not use registers operands. */
>> 		if (X86_MODRM_MOD(insn->modrm.value) =3D=3D 3)
>> 			return -EINVAL;
>> @@ -228,13 +228,24 @@ static int emulate_umip_insn(struct insn *insn, =
int umip_inst,
>> 		else
>> 			dummy_base_addr =3D UMIP_DUMMY_IDT_BASE;
>>=20
>> -		*data_size =3D UMIP_GDT_IDT_LIMIT_SIZE + =
UMIP_GDT_IDT_BASE_SIZE;
>=20
> Maybe a blank line here?

Adding a blank line in place of the removed line? I=E2=80=99m not sure I =
see the need for it, there=E2=80=99s already a blank line above, and =
it's followed by the block comment.

Brendan=
