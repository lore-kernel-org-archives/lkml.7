Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F07420663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gX8+JCRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfDDUx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:53:29 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:43588 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730021AbfDDUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554411208;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ULQ2HJklT+EkwO41NZo2DIqG43azKVOYtnoS4mXbOeA=;
        b=gX8+JCRZMidyCjQKP4CR7AHU6cHTqIb0asD8IEk+NyxBQsKHsV9EUuoiHiGMwsjT
        3ZgLfkboektJzs1MG/cQdhfPQXVDEMvlOPBVRaRT/G5zUod4knB4Y8CsnoyX1WrZCBG
        PNq4E2ouwH0W5E0dBtKOknEMHkj2h7DhnUwf+W/U=
Date:   Thu, 4 Apr 2019 20:53:28 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Barret Rhoden <brho@google.com>
cc:     Dennis Zhou <dennis@kernel.org>, Eial Czerwacki <eial@scalemp.com>,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
In-Reply-To: <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
Message-ID: <01000169ea20bd44-f3d23988-e21e-4c0a-8e54-d8e54bbaa237-000000@email.amazonses.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com> <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com> <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com> <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com> <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.04-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Barret Rhoden wrote:

> > It is very expensive. VMSP exchanges 4K segments via RDMA between servers
> > to build a large address space and run a kernel in the large address
> > space. Using smaller segments can cause a lot of
> > "cacheline" bouncing (meaning transfers of 4K segments back and forth
> > between servers).
> >
>
> Given that these are large machines, would it be OK to statically reserve 64K
> on them for modules' percpu data?

Likely.

> The bug that led me to here was from someone running on a non-VSMP machine but
> had that config set.  Perhaps we make it more clear in the Kconfig option to
> not set it on other machines.  That might make it less likely anyone on a
> non-VSMP machine pays the 64K overhead.

Right.

> Are there any other alternatives?  Not using static SRCU in any code that
> could be built as a module seems a little harsh.

Sorry this ended up in my spam folder somehow. Just fished it out.

