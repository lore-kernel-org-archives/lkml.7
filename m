Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDA9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533B20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dkvDCEkI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ZfFZsayh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfKDPuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:50:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51419 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:50:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB9F5914C8;
        Mon,  4 Nov 2019 10:50:50 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=F8nu3+GauF9ZNKZ8YUrP8d5BXVA=; b=dkvDCE
        kIhvM6teO4LooGOU8Gw487g1RnJBa2qwXSxJY9dONHk+gmbPMJfAEHBWMr/0FFg0
        HOInSSCp0Z4IXVxCJbaQyAk119dXuE92MLXBEMfzbdxlUMbvndtYZUEH9q1OV0TO
        Dn9wC0pg9rZW/9d3apGUA1+LBCsrhRWIzHhi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4441914C7;
        Mon,  4 Nov 2019 10:50:50 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=MJwUa+Ds+yurBeM2+T2kV09aJg64fgUV1kGHAEhjw7s=; b=ZfFZsayhry+H2xoJHw+It7ZnDY10Q8+4inzZ8Wgpdlq61eXnbcT8ElbOy59cbfF9+96q4fHfJ0NLY0LAmQZDRTPvdNVpFU/Twvne8sNjgwgqzy2hZJsnxrNJZbtt00B2FgZy2QlOITnNKmOzGE9sPuQ3rDKrP2zd/svqQf268Jo=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0918914C5;
        Mon,  4 Nov 2019 10:50:47 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B25A32DA01A9;
        Mon,  4 Nov 2019 10:50:45 -0500 (EST)
Date:   Mon, 4 Nov 2019 16:50:45 +0100 (CET)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Or Cohen <orcohen@paloaltonetworks.com>, jslaby@suse.com,
        textshell@uchuujin.de, daniel.vetter@ffwll.ch, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
In-Reply-To: <20191104152428.GA2252441@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com> <20191104152428.GA2252441@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: DE6C8584-FF1A-11E9-8FA9-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019, Greg KH wrote:

> On Mon, Nov 04, 2019 at 04:39:55AM -0800, Or Cohen wrote:
> > Hi,
> > I discovered a OOB access bug using Syzkaller and decided to report it,
> > as I could not find a similar report in syzkaller mailing list,
> > syzkaller-bugs mailing list
[...]
> 
> I am at another conference at the moment and can't look at this much
> now, will try to later this week...

I'll looking into it now.


Nicolas
