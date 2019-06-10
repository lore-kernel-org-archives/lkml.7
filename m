Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F810C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2257A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iD93RKJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbfFJPzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:55:45 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:44256 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404005AbfFJPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:55:43 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 79D5AC5896;
        Mon, 10 Jun 2019 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560182141; bh=aihNbKp08qv3DocJmNBn+1cqwnR6GWVl1CV2mAjc24U=;
        h=From:To:CC:Subject:Date:References:From;
        b=iD93RKJs/EbchZsrL1WjVDrxDFv9IToe8PnqWY1KtMl6yN80aQqdRjpdKJZxNNKHm
         DbQJz1DWUGgUBkXgmo6VHAOvHU1k+/SY09ttUqAj62JO2uw/ARIIGT+sX25pJA428H
         /WyHNbF5/9z6l1GzRJrXlWo4wEAhl607nvt30OH4oiNr725gslsq2exmbKFu48sYEB
         n+bljA7YRJDwb8HwHgOYl8B5G+m1hymXxAmkai7AXwOKsZu8HuFP+N3ckBtUolbRyE
         6Si4gqf9ckH/9DOJya1YWB10LUZiHf/fy535HVbW9vFl757aN78pJazA+sRh5aeNDX
         HrBCAAQzvm6/g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3B5E5A0276;
        Mon, 10 Jun 2019 15:55:42 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 10 Jun 2019 08:55:41 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Cupertino Miranda <Cupertino.Miranda@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ARC Assembler: bundle_align_mode directive support
Thread-Topic: ARC Assembler: bundle_align_mode directive support
Thread-Index: AQHVHicA2N+x/AVgjkyWYOIr/ofXig==
Date:   Mon, 10 Jun 2019 15:55:41 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
References: <3962a9ad199cea45b1cfadb80be551aab83b7028.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/19 11:21 AM, Eugeniy Paltsev wrote:=0A=
> Hi Cupertino,=0A=
>=0A=
> I tried to use ".bundle_align_mode" directive in ARC assembly, but I got =
following error:=0A=
> ----------------->8--------------=0A=
> Assembler messages:=0A=
> Error: unknown pseudo-op: `.bundle_align_mode'=0A=
> ----------------->8--------------=0A=
>=0A=
> Is it possible to implement it in ARC assembler?=0A=
> There is some context about the reason we want to have it:=0A=
>=0A=
> I'm trying to add support of jump labels for ARC in linux kernel. Jump la=
bels=0A=
> provide an interface to generate static branches using self-modifying cod=
e.=0A=
> This allows us to implement conditional branches where changing branch=0A=
> direction is expensive but branch selection is basically 'free'.=0A=
>=0A=
> There is nuance in current implementation:=0A=
> We need to patch code by rewriting 32-bit NOP by 32-bit BRANCH instructio=
n (or vice versa).=0A=
> It can be easily done with following code:=0A=
> ----------------->8--------------=0A=
> write_32_bit(new_instruction)=0A=
> flush_l1_dcache_range_this_cpu=0A=
> invalidate_l1_icache_range_all_cpu=0A=
> ----------------->8--------------=0A=
>=0A=
> I$ update will be atomic in most of cases except the patched instruction =
share=0A=
> two L1 cache lines (so first 16 bits of instruction are in the one cache =
line and=0A=
> last 16 bit are in another cache line).=0A=
> In such case we can execute half-updated instruction if we are patching l=
ive code (and we are unlucky enough :)=0A=
=0A=
While I understand your need for alignment, I don't see how you can possibl=
y=0A=
execute stray lines.=0A=
dcache flush will be propagated by hardware (SCU) to all cores (as applicab=
le) and=0A=
the icache cache flush xcall is synchronous and will have to finish on all =
cores=0A=
before we proceed to execute the cod eitself.=0A=
=0A=
>=0A=
> As of today I simply align by 4 byte instruction which can be patched wit=
h ".balign 4" directive:=0A=
> ----------------->8--------------=0A=
> static __always_inline bool arch_static_branch_jump(struct static_key *ke=
y,=0A=
>     bool branch)=0A=
> {=0A=
> asm_volatile_goto(".balign 4\n"=0A=
>  "1:\n"=0A=
>  "b %l[l_yes]\n" // <- instruction which can be patched=0A=
>  ".pushsection __jump_table, \"aw\"\n"=0A=
>  ".word 1b, %l[l_yes], %c0\n"=0A=
>  ".popsection\n"=0A=
>  : : "i" (&((char *)key)[branch]) : : l_yes);=0A=
>=0A=
> return false;=0A=
> l_yes:=0A=
> return true;=0A=
> }=0A=
> ----------------->8--------------=0A=
>=0A=
> In that case patched instruction is aligned with one 16-bit NOP if this i=
s required.=0A=
> However 'align by 4' directive is much stricter than it actually required=
. =0A=
=0A=
I don't quite understand. Can u write a couple of lines of pseudo assembly =
to show=0A=
what the issue is.=0A=
=0A=
> It's enough=0A=
> that our 32-bit instruction don't cross l1 cache line boundary.=0A=
> That will save us from adding useless NOP padding in most of the cases.=
=0A=
> It can be implemented with ".bundle_align_mode" directive which isn't sup=
ported by ARC AS unfortunately.=0A=
=0A=
This seems like a reasonable request (contingent to the difficulty of=0A=
implementation in binutils). but I can't comprehend why you would need it.=
=0A=
