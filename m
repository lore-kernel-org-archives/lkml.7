Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CFBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB935214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560949193;
	bh=lExPXXI3rTL+3XGQzahMDAHFeeLapk/EQ7ah0G0ClWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ERglg3kBzLUIr3QSSsq1IWR8Tbz4iXKT4C08mpTMfeo/X5Ek2p/l0GODYGCwmUEQh
	 GyA6H6cuhlvyYmpO0y/eEx/BuXZTbc75K27apIoOL7peGrO9pKZNqua8MgSvQX4Zkk
	 OVZObCr7JfUO0T5kVjc0zJHABV32XMlREhdCSbbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfFSM7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFSM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:59:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEE5208CB;
        Wed, 19 Jun 2019 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560949191;
        bh=lExPXXI3rTL+3XGQzahMDAHFeeLapk/EQ7ah0G0ClWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywKv2dLRCVzhjsb7smAKa+I6bkRaz89pB3DygNdRe+chU8GP0aNazw0Kz7VMdN5hE
         q9mopAsGfGh1t1AzCFBh6wtkZ4Sib2h21sHC1GvmYqLjuXQPOByz1VuTWL2aJjfLy9
         u28H2MW8XJ6DAZd3yUHWcKZxruYwkCSQuk0Vft4M=
Date:   Wed, 19 Jun 2019 14:59:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-spdx@vger.kernel.org,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: SPDX conversion under scripts/dtc/ of Linux Kernel
Message-ID: <20190619125948.GA27090@kroah.com>
References: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 07:23:19PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> In this development cycle of Linux kernel,
> lots of files were converted to use SPDX
> instead of the license boilerplate.
> 
> However.
> 
> Some files were imported from a different project,
> and are periodically synchronized with the upstream.
> Have we discussed what to do about this case?
> 
> 
> For example, scripts/dtc/ is the case.
> 
> The files in scripts/dtc/ are synced with the upstream
> device tree compiler.
> 
> Rob Herring periodically runs scripts/dtc/update-dtc-source.sh
> to import outcome from the upstream.
> 
> 
> The upstream DTC has not adopted SPDX yet.
> 
> Some files in Linux (e.g. scripts/dtc/dtc.c)
> have been converted to SPDX.
> 
> So, they are out of sync now.
> 
> The license boilerplate will come back
> when Rob runs scripts/dtc/update-dtc-source.sh
> next time.
> 
> What shall we do?
> 
> [1] Convert upstream DTC to SPDX
> 
> This will be a happy solution if it is acceptable in DTC.
> Since we cannot push the decision of the kernel to a different
> project, this is totally up to David Gibson.

That's fine with me :)

> [2] Change scripts/dtc/update-dtc-source.sh to
>     take care of the license block somehow

That would also be good.

> [3] Go back to license boilerplate, and keep the files
>     synced with the upstream
>     (and scripts/dtc/ should be excluded from the
>      SPDX conversion tool.)

nothing is being excluded from the SPDX conversions, sorry.  The goal is
to do this for every file in the kernel tree.  Otherwise it's pointless.

> Or, what else?

Rob remembers to keep those first lines of the files intact when doing
the next sync?

thanks,

greg k-h
