Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B12184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKXQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:16:13 -0500
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:50588 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:16:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DA04540E1;
        Mon, 11 Nov 2019 23:16:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nut53_18ddf32dd8d37
X-Filterd-Recvd-Size: 2182
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Nov 2019 23:16:10 +0000 (UTC)
Message-ID: <c2c803570b92fc18ac62902bd99075ccc33eb5b6.camel@perches.com>
Subject: Re: [PATCH v2 3/3] staging: wfx: replace u32 by __le32
From:   Joe Perches <joe@perches.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        Jules Irenge <jbi.octave@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Nov 2019 15:15:54 -0800
In-Reply-To: <3445403.d56fhTCmfW@pc-42>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
         <20191111133055.214410-3-jbi.octave@gmail.com> <3445403.d56fhTCmfW@pc-42>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 16:58 +0000, Jerome Pouiller wrote:
> On Monday 11 November 2019 14:30:55 CET Jules Irenge wrote:
> [...]
> > -       u32   count_rts_failures;
> > -       u32   count_ack_failures;
> > -       u32   count_rx_multicast_frames;
> > -       u32   count_rx_frames_success;
> > -       u32   count_rx_cmacicv_errors;
> > -       u32   count_rx_cmac_replays;
> > -       u32   count_rx_mgmt_ccmp_replays;
> [...]
> > +       __le32   count_rts_failures;
> > +       __le32   count_rx_multicast_frames;
> > +       __le32   count_rx_cmacicv_errors;
> > +       __le32   count_rx_cmac_replays;
> > +       __le32   count_rx_mgmt_ccmp_replays;
> > +       __le32   count_rx_beacon;
> > +       __le32   count_miss_beacon;
> > +       __le32   count_ack_failures;
> > +       __le32   count_rx_frames_success;
> >         u32   count_rx_bipmic_errors;
> > -       u32   count_rx_beacon;
> > -       u32   count_miss_beacon;
> 
> Hello Jules,
> 
> Your patch reorders members of the structure. It will break API with the 
> chip.

And if the hardware really is le, then almost certainly
_all_ the members of the struct should be __le32

