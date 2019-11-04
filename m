Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1080ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637D21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572876268;
	bh=JfrQzHk4VVvW0rbpX/mHKv3AhoW6sHfAbE/yIi+CTlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJDGFIa7Bj95Yx6vkkc6UKxXan8/E1+oBlZ9Aka0iU9WmLcLmblhLrKZs//NXIpYQ
	 Mav48QIN6S5p7B6yy2RAVcfKINGJosM4u5x04zXi+Ctf5LLU+gTZVHQ0VrDi1c6GxP
	 fGJAQMab4BVWWBtikUmKtqJcga17Z9Ezl8b5jve8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfKDOE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfKDOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:04:27 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED73C218BA;
        Mon,  4 Nov 2019 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572876266;
        bh=JfrQzHk4VVvW0rbpX/mHKv3AhoW6sHfAbE/yIi+CTlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdhRoJc2/mmWkG31jP61Am6yxGJtjcNlbjKsqUEKhGxkK/ZlTuKDc4wu4abLZEDvl
         23gUmKGO4Zs1HDYlNKY81PVAHb5crSCh7gPWLMdV6/D3ARzMhtXztdu2HUR13/yGgC
         Go7RsFy4ngzpyHSew0LA5k1YGqZxmhk8x/xh2afE=
Date:   Mon, 4 Nov 2019 15:04:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
Message-ID: <20191104140422.GA2180983@kroah.com>
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191104130904.GC29493@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104130904.GC29493@kuha.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:09:04PM +0200, Heikki Krogerus wrote:
> Hi Greg,
> 
> On Tue, Oct 08, 2019 at 03:59:23PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 08-10-2019 14:25, Heikki Krogerus wrote:
> > > Hi Hans,
> > > 
> > > Fixed the compiler warning in this version. No other changes.
> > > 
> > > The original cover letter:
> > > 
> > > That AXP288 extcon driver is the last that uses build-in connection
> > > description. I'm replacing it with a code that finds the role mux
> > > software node instead.
> > > 
> > > I'm proposing also here a little helper
> > > usb_role_switch_find_by_fwnode() that uses
> > > class_find_device_by_fwnode() to find the role switches.
> > 
> > Both patches look good to me and I can confirm that things still
> > work as they should on a CHT device with an AXP288 PMIC, so for both:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> These two patches in this series are basically about the usb role API,
> so can you take them?

Sure, will do that, thanks.

greg k-h
