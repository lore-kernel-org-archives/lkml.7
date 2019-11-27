Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A21C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B6F206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bKc5LPzv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iSMawMmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK0QZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:25:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54153 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:24:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C530A98165;
        Wed, 27 Nov 2019 11:24:57 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=4zSRlyWhp/C5o6pJju34HY+cPHo=; b=bKc5LP
        zvukMQhg3/raOO1OJxVdFV/DE8r3ZZF7Rk5Y/0owsxT1AbqE2HyjzLzD/ROcOnwJ
        arj1DI6Tf3+ciQvPiYRRI7MaG01ngBuF6E9YOSYlublte9iN7Z1m/D1MHRFT/5uD
        5comw8y61uJ1ghAZQznjyIo6V4bsr9sUR/Mys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC00998164;
        Wed, 27 Nov 2019 11:24:57 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=mJenc5JHD2H16CxWbZM+1z2KFSadwBr9IYAovHDG1Yo=; b=iSMawMmODlsK3C0EchDKRilULS9ACSWQBCPfOnXz4iic99XFR6A8WPU8UqM6xrJeLRohCq9FB+MWu0Xfc27E+kJWslvbiUeaEPgDCM0K6rpzLwR8InCt3ZEg/+79DRPALN82VGQpz11Etup7DCHlOeRGs+qp/yMTP/ctkBtfjkA=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9063B98163;
        Wed, 27 Nov 2019 11:24:54 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id AF9982DA01B2;
        Wed, 27 Nov 2019 11:24:52 -0500 (EST)
Date:   Wed, 27 Nov 2019 11:24:52 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jslaby@suse.com>,
        Or Cohen <orcohen@paloaltonetworks.com>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
In-Reply-To: <20191127064507.GC1711684@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1911271121200.8537@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr> <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com> <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com> <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com> <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
 <nycvar.YSQ.7.76.1911261652290.8537@knanqh.ubzr> <20191127064507.GC1711684@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 71F3D270-1132-11EA-9305-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019, Greg KH wrote:

> On Tue, Nov 26, 2019 at 04:55:32PM -0500, Nicolas Pitre wrote:
> > Greg, could you apply this please?
> 
> Yes, I will, but I don't seem to have it in my email archives anywhere,
> was it burried in that long thread?

I've seen much longer threads than this one, but yes it was at its tail.
Hence the direct ping.


Nicolas
