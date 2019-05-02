Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9CC2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556817829;
	bh=McLzeHbUb8hhAEei4Huj6kA/W8PLv+h6CtyGE9IeRbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hN9CRFS8IBu6Yqaxx9Kprxbpo3eqET63TtGJnEchJFkgGhNfDTyYppECofHwrgG49
	 valKhFFmH5d6W0uJbMOW84TUDUUjbADkH5f71p1QKH+eWmQI4VzkHj4fNLuJKCrfXe
	 HtaAYI9fhWLIyvfI8dc17s85BXIB0d3anVAIBShg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBRXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfEBRXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:23:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD78420651;
        Thu,  2 May 2019 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556817827;
        bh=McLzeHbUb8hhAEei4Huj6kA/W8PLv+h6CtyGE9IeRbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIg+PSOalUjXdKZSRF3dRJG7mfX614lAUkNLHXJ00iX0jNPuqvaFAvVWCCuGIVfwq
         kN/M+RVaGXpxtfR2xVxT5xTh73mIZcoPOYKV1PKO+RB8tAsl1OKo97hjEd/HQM8WgI
         Oczf8LQf8RaZWxf8SC1R166ygmBq9kaiju0IF/78=
Date:   Thu, 2 May 2019 19:23:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190502172345.GC1874@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> Add char device interface per DT node present and support
> file operations:
> - open(),
> - close(),
> - unlocked_ioctl(),
> - compat_ioctl().

Why do you need compat_ioctl() at all?  Any "new" driver should never
need it.  Just create your structures properly.

thanks,

greg k-h
