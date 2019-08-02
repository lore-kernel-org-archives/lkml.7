Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92852C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660982173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761767;
	bh=Mfej1gsF5s5LDrrvRClXBvNNFTeMEaTN4dRVcQmNCyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c6F3zph8rCAPkT89jbUgA60XIcNOYwquUHYNfPSsIZk9VaeG7y1H87MQR0B9KfpKB
	 vm0Y5o8+1zt+PSusddo23VmKBD4PWXvC91hyfOyxpDlY786a5UoaQnsqzSR/2XwDSj
	 HESLxaqoy4rpQw0b+FP93jcEFNivtVF/9u4sLcKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbfHBQCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388512AbfHBQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:02:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBAA216C8;
        Fri,  2 Aug 2019 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761765;
        bh=Mfej1gsF5s5LDrrvRClXBvNNFTeMEaTN4dRVcQmNCyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS7/8i9RSdN8bU4WAPWxwk1bzPeAX3fwadmTZ1GBF3d6XKiiEWtPep5S4095XmhUR
         JLSqY+mLW1C4fq/z16vInoVfEMgd3UUqT0OR60C706QrlJm1su9felp/0E+WG2jKR/
         lXm639h72rLL+0pysOTCQxy7V79+l2Hx0mlkLnxs=
Date:   Fri, 2 Aug 2019 18:02:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Message-ID: <20190802160243.GA15484@kroah.com>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a lot of devices, like servers, you have more than one serial console,
> and you do not always know, how they are numbered. Therefore, we start a
> console on ttyS0 and ttyS1.
> 
> In user space, we also would like to write to both consoles to not worry
> about the numbering. Writing to `/dev/console` only write to the active
> console.

So the same data to multiple console devices with just one userspace
call?  Why?

>     $ more /proc/consoles # I think
>     tty0                 -WU (EC p  )    4:1
>     ttyS0                -W- (E  p a)    4:65
>     ttyS1                -W- (E  p a)    4:65
> 
> Does a device exist, or can a device be configured so you can write to
> all (serial) consoles from user space?

With one syscall, not that I know of, sorry.

greg k-h
