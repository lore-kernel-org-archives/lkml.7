Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B459C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D32183E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556043393;
	bh=g0IVXqa/Y4i5aAaYke9vj3+8qJZw9M2R/F0j9joHvQ0=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=o1VkgWV6KEEFctDPxrcoY+FAFx1v9kpH8OFhEMPujwubFqBuq2FhruWBll4fD73Mf
	 A2YLKtCSXaT43n9BoIErKbeK2hzcdM/PxVN6jK8/NkRhSQpS0EAXAPiukg2081Rcmy
	 K3wy2f8vNuJltrfNodGfZsyZsbuMcgtQcEql/TCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDWSQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:16:31 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5431208E4;
        Tue, 23 Apr 2019 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556043390;
        bh=g0IVXqa/Y4i5aAaYke9vj3+8qJZw9M2R/F0j9joHvQ0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=0WGhAnI4qbWAmbYe/wXR3JQSWCnuRxoq/wmROI0Gjw3ucPMHVfQ7n8zaxn5xEKHjD
         tSssSyOT72htChQYZEw9VFSoLLkcg6Y/BRaS3kkfILRdihkGCCkebf43GmJbwpKo6Z
         gV2C+gYJW8UH5YZqJ11jFRLQMBi+qXI/6nBfD5pw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB6434A133CB5ABA0286B0F487EE230@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com> <ebda22b2d3f7e35db5809bf21f4f9ee3ac38f5d9.1555921081.git.leonard.crestez@nxp.com> <155596430227.15276.13435242792506854365@swboyd.mtv.corp.google.com> <AM0PR04MB6434A133CB5ABA0286B0F487EE230@AM0PR04MB6434.eurprd04.prod.outlook.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] scripts/gdb: Add $lx_clk_core_lookup function
To:     Leonard Crestez <leonard.crestez@nxp.com>
Message-ID: <155604339005.15276.3433915905558978655@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 11:16:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-04-23 04:12:49)
> On 4/22/2019 11:18 PM, Stephen Boyd wrote:
> > Do you need to do the .string() for comparison? Or does it work just as
> > well to compare a gdb.Value object to a python string? It would be nice
> > if the gdb.Value object could figure out that they're not both gdb.Value
> > objects so it can do a string comparison itself.
>=20
> The gdb manual is not clear on how comparisons work on gdb.Value types.=20
> Converting to a python string and comparing in python work well, using=20
> =3D=3D on string gdb.Values results in this:
>=20
>      gdb.error: evaluation of this expression requires the program to=20
> have a function "malloc"
>=20
> My guess is gdb attempts to convert both arguments to gdb.Value and do=20
> the comparison via a call on the target? This is very undesirable here.
>=20
> I get the same error if "name" is a gdb.Value instead of being converted =

> to a string in invoke().
>=20

Ok. Thanks for checking. It might be worth filing a bug with gdb to see
if this can be improved in the future.

