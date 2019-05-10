Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFACCC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0D020989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfEJKZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:25:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38135 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfEJKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:25:29 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hP2iV-0001HQ-Pr; Fri, 10 May 2019 12:25:27 +0200
Message-ID: <1557483927.7859.3.camel@pengutronix.de>
Subject: Re: [PATCH][V2] reset: remove redundant null check on pointer dev
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 10 May 2019 12:25:27 +0200
In-Reply-To: <CAMpxmJWyVZ2hHE=1tu5NgSzEHZKD2pBo8KUXg1CLUaB-WX4KHQ@mail.gmail.com>
References: <20190510095832.28233-1-colin.king@canonical.com>
         <CAMpxmJWyVZ2hHE=1tu5NgSzEHZKD2pBo8KUXg1CLUaB-WX4KHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 12:14 +0200, Bartosz Golaszewski wrote:
> pt., 10 maj 2019 o 11:58 Colin King <colin.king@canonical.com> napisał(a):
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Pointer dev is being dereferenced when passed to the inlined
> > functon dev_name, however, dev is later being null checked
> > so at first this seems like a potential null pointer dereference.
> > 
> > In fact, _reset_control_get_from_lookup is only ever called from
> > __reset_control_get, right after checking dev->of_node hence
> > dev can never be null.  Clean this up by removing the redundant
> > null check.
> > 
> > Thanks to Philipp Zabel for spotting that dev can never be null.
> > 
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thank you both, applied to reset/fixes.

regards
Philipp
