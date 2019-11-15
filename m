Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FEDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3867820723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKOWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:46:54 -0500
Received: from baldur.buserror.net ([165.227.176.147]:55598 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfKOWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:46:53 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1iVkKM-0007zt-Nm; Fri, 15 Nov 2019 16:44:31 -0600
Message-ID: <71e4f8797fa6e4a116a6d1cabcb63871d7a0c4e0.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Date:   Fri, 15 Nov 2019 16:44:29 -0600
In-Reply-To: <02dd5acd-b81e-fde3-028c-16e754e846b5@kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
         <20191108130123.6839-33-linux@rasmusvillemoes.dk>
         <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
         <9f1a846b-c303-92fa-9620-f492ef940de7@rasmusvillemoes.dk>
         <02dd5acd-b81e-fde3-028c-16e754e846b5@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: timur@kernel.org, linux@rasmusvillemoes.dk, qiang.zhao@nxp.com, leoyang.li@nxp.com, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32()
 in ucc_uart_probe()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 08:35 -0600, Timur Tabi wrote:
> On 11/15/19 2:01 AM, Rasmus Villemoes wrote:
> > That would be a separate patch, this patch is only concerned with
> > eliminating the implicit assumption of the host being big-endian. And
> > there's already been some pushback to adding arch-specific ifdefs (which
> > I agree with, but as I responded there see as the lesser evil), so
> > unless there's a very good reason to add that complexity, I'd rather not.
> 
> We don't want to encourage people to introduce device trees that don't 
> have the brg-frequency property in them.

Yeah, workarounds like this should be as targeted as possible.  If we knew the
specific chips/boards on which U-Boot has this problem, then limiting it to
those would have been even better (e.g. fix up the device tree from the
platform code), but at this point containing the damage to PPC seems like the
most reasonable approach.  It's not relevant to this specific patch, but it is
relevant to a patchset expanding the set of platforms on which this code
builds.

-Scott


