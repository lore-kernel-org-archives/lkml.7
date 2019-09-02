Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA56C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2176420674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfIBTYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:24:24 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:39724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbfIBTYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:24:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 848D3999D;
        Mon,  2 Sep 2019 19:24:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: idea71_260a5d3da1f24
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Sep 2019 19:24:21 +0000 (UTC)
Message-ID: <6c8bbcbe2f3af638d2286baf1acc9bfb723bf95b.camel@perches.com>
Subject: Re: [PATCH] power: reset: reboot-mode: Fix author email format
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sre@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     matwey.kornilov@gmail.com,
        "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Sep 2019 12:24:20 -0700
In-Reply-To: <20190902190622.vvl7hcgfqayf6xmk@earth.universe>
References: <20190713154248.24382-1-matwey@sai.msu.ru>
         <20190902190622.vvl7hcgfqayf6xmk@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 21:06 +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Jul 13, 2019 at 06:42:48PM +0300, Matwey V. Kornilov wrote:
> > Closing angle bracket was missing.
> > 
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> 
> Thanks, queued.

This is relatively widespread.

There are 80 more of these in the kernel tree.

$ git grep -P 'MODULE_AUTHOR.*<[^>]+$' | wc -l
81

Here's a trivial little script to fix them all:

$ git grep -P -n 'MODULE_AUTHOR.*<[^>]+$' | \
  while read entry ; do \
    file=$(echo $entry|cut -f1 -d:); \
    line=$(echo $entry|cut -f2 -d:); \
    sed -i "${line}s/\");/>\");/" $file; \
  done

