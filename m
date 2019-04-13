Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4AC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A952082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDMITn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:19:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfDMITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:19:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC0C3B02C;
        Sat, 13 Apr 2019 08:19:41 +0000 (UTC)
Date:   Sat, 13 Apr 2019 10:19:41 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: ds1685: use correct device struct to get
 platform device struct
Message-Id: <20190413101941.fb76cdf06f476d7353d439b7@suse.de>
In-Reply-To: <462d6bfd-c91a-3c5c-1dfd-69d8b48449e6@gentoo.org>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
        <20190411143323.20945-2-tbogendoerfer@suse.de>
        <20190412101106.GU3578@piout.net>
        <20190412134459.446ef705c86aa1c7b926abc7@suse.de>
        <462d6bfd-c91a-3c5c-1dfd-69d8b48449e6@gentoo.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 01:17:19 -0400
Joshua Kinard <kumba@gentoo.org> wrote:

> On 4/12/2019 07:44, Thomas Bogendoerfer wrote:
> > On Fri, 12 Apr 2019 12:11:06 +0200
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> >> Every patch need a commit message. Maybe you could indicate that this
> >> never gave any issue because parent is the first member of struct
> >> device.
> > 
> > I'll update the commit message, I get a nice stacktrace because of that
> > bug, so the path from work_queue calling ds1685_rtc_poweroff never worked.
> > 
> > Thomas.
> 
> I'll wager that's why the thing stopped powering off my Octane.  It *used*
> to work when I wrote the driver, but stopped after some unidentified point,
> and I never found the time to try and track it down.

calling ds1685_rtc_poweroff with the correct platform device works, so the bug is
not in the poweroff function but in the work queue.

> Which machine are you testing on, out of curiosity?

SGI Octane but I'm not setting prepare_poweroff.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
