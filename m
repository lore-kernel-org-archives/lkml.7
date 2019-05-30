Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D127FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFEF25E1B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LRFge6i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfE3RLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:11:38 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:46648 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbfE3RLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:11:38 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23245C00ED;
        Thu, 30 May 2019 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559236307; bh=L18wwJsv2m4iqr/WgHJaglq/voxUsjhOCqKL+yC1/js=;
        h=From:To:CC:Subject:Date:References:From;
        b=LRFge6i5wJ7e8ixouhzxXmxvMPsuwYTP3oFkPgqIcp/gp5Dc0blP/xEU5C++jZ1yv
         oghmDdrzU1U+GTOllA4AfH4dd1434Ku+4sV4Gt7KHIeyxeKIrdywrBaB19PDGG2Nva
         EVY/1DsjdjMgPD4qSi+tXYtEB8z3cjtOIYPSDDsX3r681M7UfWEclEfO7Vn16C279j
         /lJOo61pjSpu7P9wO/4jwCHrbtykY26g+poXhbHy4pur/zXWYEw6LyMnd9t4AFbo0n
         YIOQvRDi0hXr+Z8IZMtuK/DykcW7VsE4abR7XcB6FJLDcha+lZWkPE8okvr2yfggTd
         fgPQkwa+bgozQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E6EC8A00FF;
        Thu, 30 May 2019 17:11:34 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu, 30
 May 2019 10:11:34 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: linux-next: manual merge of the userns tree with the
 arc-current tree
Thread-Topic: linux-next: manual merge of the userns tree with the
 arc-current tree
Thread-Index: AQHVFpY3j48GHTQpH0O+sxnueOIX7A==
Date:   Thu, 30 May 2019 17:11:33 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2520902@us01wembx1.internal.synopsys.com>
References: <20190530131721.0af603a4@canb.auug.org.au>
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

Hi Stephen,=0A=
=0A=
On 5/29/19 8:17 PM, Stephen Rothwell wrote:=0A=
> Hi all,=0A=
>=0A=
> Today's linux-next merge of the userns tree got a conflict in:=0A=
>=0A=
>   arch/arc/mm/fault.c=0A=
>=0A=
> between commits:=0A=
>=0A=
>   a8c715b4dd73 ("ARC: mm: SIGSEGV userspace trying to access kernel virtu=
al memory")=0A=
>   ea3885229b0f ("ARC: mm: do_page_fault refactor #5: scoot no_context to =
end")=0A=
>   acc639eca380 ("ARC: mm: do_page_fault refactor #6: error handlers to us=
e same pattern")=0A=
>   0c85612550a4 ("ARC: mm: do_page_fault refactor #7: fold the various err=
or handling")=0A=
>   c5d7f7610d88 ("ARC: mm: do_page_fault refactor #8: release mmap_sem soo=
ner")=0A=
>=0A=
> from the arc-current tree and commits:=0A=
>=0A=
>   351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")=0A=
>   2e1661d26736 ("signal: Remove the task parameter from force_sig_fault")=
=0A=
>=0A=
> from the userns tree.=0A=
>=0A=
> I fixed it up (see below) and can carry the fix as necessary. This=0A=
> is now fixed as far as linux-next is concerned, but any non trivial=0A=
> conflicts should be mentioned to your upstream maintainer when your tree=
=0A=
> is submitted for merging.  You may also want to consider cooperating=0A=
> with the maintainer of the conflicting tree to minimise any particularly=
=0A=
> complex conflicts.=0A=
=0A=
=0A=
Thx for this. Unfortunately I had to force push my for-next due to broken #=
7 and=0A=
#8 above. So you may have to do this once again.=0A=
=0A=
-Vineet=0A=
