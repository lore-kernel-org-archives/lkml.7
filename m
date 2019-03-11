Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DFB2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552331622;
	bh=zPv8wh55mywMCqa0owDJ4RdB4f4ecTYLUs/yicH8mwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VISYb0nFt+G/w+6bVST0vPazmbxjTx0+8GG8T377BUfxWIsGnouuxl4RU++jN3ZEO
	 Y+/Deqdw1/3h5SemzU0krqXURRe9lXVUtII8ZGx3OPTSNr35G6ReEX0Ncmr1Cm+O8h
	 GBIvsfRxWA8SfZkB7zCZDXVUSWZyuhRnG47ksMBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCKTNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKTNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:13:41 -0400
Received: from localhost (unknown [104.132.1.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4325D20657;
        Mon, 11 Mar 2019 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552331620;
        bh=zPv8wh55mywMCqa0owDJ4RdB4f4ecTYLUs/yicH8mwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNCZ/6kWBThGhQTGTG0EXae1YaKzqvpxp54475VMH3YIND7pPRRiv7Yn8pNwpOD00
         CREzzfEMXwcXPVZ9ieK5rXw6kA1vkzVmdYEwrCDmfYitULPKwS5hA0Cn0Rt0SaWBiT
         BEzFpuClxHcHozT4rtBByU4AqXJsNgsVlHgH+Yho=
Date:   Mon, 11 Mar 2019 12:13:39 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
Message-ID: <20190311191339.GA5628@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com>
 <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com>
 <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:02:34PM -0400, Sven Van Asbroeck wrote:
> On Fri, Feb 8, 2019 at 9:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Well, who wants this code?  Who uses it?  Find those people and get them
> > to review it.  If no one wants it or uses it, that kind of implies that
> > it's not needed :)
> 
> We have customers who (will) talk to this ABI from userspace, but they are
> not 'Linux-y' enough to come to the mailing list and meaningfully review
> the userspace ABI.
> 
> IMHO the current reality of Fieldbus on Linux is companies rolling their own
> proprietary out-of-tree interfaces and drivers. They do this partly because
> there is no existing community or infrastructure. So there is no incentive
> to be involved with mainline, which could also explain why no-one is commenting
> on this Fieldbus ABI.
> 
> Chicken-and-egg problem ?
> 
> Greg, could I convince you to take this Fieldbus subsystem in drivers/staging?
> Perhaps its presence may kickstart or seed a Linux Fieldbus community.
> Being in staging/ also means that we can tweak the userspace ABI to our
> heart's content if more people/requirements come in.
> 
> If there's been no meaningful activity in, say, one year from now, you may
> decide to send this whole subsystem to /dev/null.

That sounds like a good plan, I'll take that.  Want to respin the
patches with the code in drivers/staging/ and I'll be glad to queue them
up after 5.1-rc1 is out.

thanks,

greg k-h
