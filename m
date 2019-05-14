Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158ACC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E591D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfENTuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:50:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62336
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfENTuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:50:08 -0400
X-IronPort-AV: E=Sophos;i="5.60,469,1549926000"; 
   d="scan'208";a="306019325"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 21:50:05 +0200
Date:   Tue, 14 May 2019 21:50:04 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 1/3] Coccinelle: pci_free_consistent: Use formatted
 strings directly in SmPL rules
In-Reply-To: <a91f9a9b-57be-59a8-1755-37936512ff20@web.de>
Message-ID: <alpine.DEB.2.21.1905142148460.2612@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <a91f9a9b-57be-59a8-1755-37936512ff20@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-914917962-1557863405=:2612"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-914917962-1557863405=:2612
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 May 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 14 May 2019 16:54:40 +0200
>
> Formatted strings were always assigned to the Python variable “msg”
> before they were used in two rules of a script for the semantic
> patch language.
> Delete these extra variables so that the specified string objects
> are directly used for the desired data output.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NACK.  If the code is going to change, I would rather it come closer to
staying within 80 characters.

julia


> ---
>  scripts/coccinelle/free/pci_free_consistent.cocci | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
> index 43600ccb62a8..2056d6680cb8 100644
> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> +++ b/scripts/coccinelle/free/pci_free_consistent.cocci
> @@ -38,15 +38,15 @@ return@p2 ...;
>  p1 << search.p1;
>  p2 << search.p2;
>  @@
> -
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> -coccilib.report.print_report(p2[0],msg)
> +coccilib.report.print_report(p2[0],
> +                             "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s"
> +                             % (p1[0].line,p2[0].line))
>
>  @script:python depends on org@
>  p1 << search.p1;
>  p2 << search.p2;
>  @@
> -
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> -cocci.print_main(msg,p1)
> +cocci.print_main("ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s"
> +                 % (p1[0].line,p2[0].line),
> +                 p1)
>  cocci.print_secs("",p2)
> --
> 2.21.0
>
>
--8323329-914917962-1557863405=:2612--
