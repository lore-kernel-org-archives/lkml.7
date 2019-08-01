Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5C5214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564668365;
	bh=/QGwV/099q7Ievh2NdD7j7R9/868BoMicaYNGZZ6kPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UnOEOTrHKmuQ5+cVps1E9VAtoP83JiJr/M3q2wDQ7oNNBJi0F5CgmTDcoQpQQzqu5
	 2fyz8i5MSUVByYG7KVc4i99gynAjyf/nvERldUWvqkCaBnzfrSgJSFq/Ssxji8JBST
	 JeCSGGWTLXfLSpQV54iinPlEit+ORNRga88hSKhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfHAOGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbfHAOGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:06:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A741A20838;
        Thu,  1 Aug 2019 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564668363;
        bh=/QGwV/099q7Ievh2NdD7j7R9/868BoMicaYNGZZ6kPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyvXwckMZP/C30lbjcHqLQW+JdPhnbP1qEUqpiIxqptK4JObN56JDyDuDhiyJ2H/y
         nwE798SqAY7Y1/pb+yyjeTbdCZhKn46UPR5YTDHN/ptzIqpTQGN6dqrJFjNoefFLpK
         0u1uMKx4SharqupYDyxm3c798o8dnVAI3Mw5OVFs=
Date:   Thu, 1 Aug 2019 16:05:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        mika.westerberg@linux.intel.com, wsa@the-dreams.de
Subject: Re: [PATCH 1/3] i2c: Revert incorrect conversion to use generic
 helper
Message-ID: <20190801140558.GA31375@kroah.com>
References: <20190801061042.GA1132@kroah.com>
 <20190801102026.27312-1-suzuki.poulose@arm.com>
 <20190801135451.GA26585@kroah.com>
 <09633766-0156-ffb5-3821-3b57e1448599@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09633766-0156-ffb5-3821-3b57e1448599@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:03:06PM +0100, Suzuki K Poulose wrote:
> On 08/01/2019 02:54 PM, Greg KH wrote:
> > On Thu, Aug 01, 2019 at 11:20:24AM +0100, Suzuki K Poulose wrote:
> > > The patch "drivers: Introduce device lookup variants by ACPI_COMPANION device"
> > > converted an incorrect instance in i2c driver to a new helper. Revert this
> > > change.
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
> > 
> > I'll go add this...
> 
> Thanks Greg ! Sorry, I thought the commit ids may change in linus's and
> thus I referred to the "commit subject"

Once they are in my -next branch, they will not change.

thanks,

greg k-h
