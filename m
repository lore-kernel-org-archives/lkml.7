Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AE02067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbfIFPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:07:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730480AbfIFPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:07:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59AACAC67;
        Fri,  6 Sep 2019 15:07:28 +0000 (UTC)
Date:   Fri, 6 Sep 2019 17:07:37 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas <trenn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: /dev/mem and secure boot
Message-ID: <20190906170737.1a00178c@endymion>
In-Reply-To: <20190906121510.GA17328@kroah.com>
References: <20190906130221.0b47a565@endymion>
        <20190906121510.GA17328@kroah.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 14:15:10 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 06, 2019 at 01:02:21PM +0200, Jean Delvare wrote:
> > I've been bitten recently by mcelog not working on machines started in
> > secure boot mode. mcelog tries to read DMI information from /dev/mem
> > and fails to open it.  
> 
> What do you mean by "secure boot"?  Is this matthew's patchset that
> restricts /dev/mem/ or something else?

I mean that early in the kernel log is:

Secure boot enabled and kernel locked down

> > This made me wonder: if not even root can read /dev/mem (nor, I
> > suppose, /dev/kmem and /dev/port) in secure boot mode, why are we
> > creating these device nodes at all in the first place? Can't we detect
> > that we are in secure boot mode and skip that step, and reap the rewards
> > (faster boot, lower memory footprint and less confusion)?  
> 
> Sure, feel free to not register it at all if the mode is enabled.
> 
> thanks,
> 
> greg k-h


-- 
Jean Delvare
SUSE L3 Support
