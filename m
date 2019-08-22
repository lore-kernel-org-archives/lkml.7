Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8866C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71872233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566508514;
	bh=cMvgT9+Hti7+e9rtYjt9JjvQSTI7OPAivX0JomfHWns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DcES/gcNRwK6C9iJJqAP0MANLZxrfCPq0CBNZQz4PVseVzY2nGD5HivYagFbj3xQX
	 /5paDD2K0xlYVyb+PPBCGrF45OjNUUVh6hMZujTR06sETkJVPXyGYaeY7edGmujLbx
	 U3mRFnmmzVXvONZJgAqmtHgAyh2e+hW7TKvTxwm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390192AbfHVVPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbfHVVPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:15:12 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B09B20673;
        Thu, 22 Aug 2019 21:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566508512;
        bh=cMvgT9+Hti7+e9rtYjt9JjvQSTI7OPAivX0JomfHWns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrayglshAsw5nlzXV7lOu2jl+/WSgjODLHpdcsKe4JuFFgS1pRbd4k5zRgE9b9mgd
         7Fr+EfxrnBqYqabQkLIiMoVvx7q48zEkM5IdoN6RgPVw3QywciLtPkM7KBgFOq4e9w
         e268S0oQ/NNCfOARU4Da8ph9GU95t9ZZ87+ZGKb4=
Date:   Thu, 22 Aug 2019 14:15:11 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jslaby@suse.com, jay.dolan@accesio.com, hslester96@gmail.com,
        je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com,
        heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Message-ID: <20190822211511.GA11893@kroah.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190816112644.GF30120@smile.fi.intel.com>
 <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:49:50AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi,
> 
> Andy Shevchenko 於 2019/8/16 下午 07:26 寫道:
> > On Fri, Aug 16, 2019 at 01:27:29PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> > > Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
> > > IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
> > > only support IO.
> > 
> > We have 8250_fintek.
> > Isn't it a right place to add these?
> > 
> 
> The 8250_fintek implements PNP device with id PNP0501.
> Should I also implements PCIe device in this file?

Does it use the same logic?  If so, that makes sense, but if you can not
share anything, then no, it does not make sense.

thanks,

greg k-h
