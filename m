Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C227204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfCRJ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:04 -0400
Received: from skyboo.net ([94.40.87.198]:39026 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfCRJ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:55 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1h5oYc-0002HH-KC; Mon, 18 Mar 2019 10:27:52 +0100
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Mon, 18 Mar 2019 10:27:35 +0100
Message-Id: <20190318092737.8170-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com, jeff.dagenais@gmail.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH 0/2] w1: DS2408 fixes
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I prepared a two fixes related with 1wire and DS2408.

In short the problem was that a single DS2408 slave was properly setting
the output value to a channel access write but the command was returning
error.
Moreover when there was a write of a 0xff value (all inputs off, there was 
also no problem - it's now also understandable for me after looking
at the transmission log) ;)
This problem doesn't occur on a multidrop bus.

Finally I was able to catch the problems recently after analyzing the
oscilloscope waveforms in PulseView.
After those fixes all is now working perfectly fine - no matter if it
is multidrop or single slave bus :)

ps. if you are merging this please also take into account a patch which
I've sent recently but it is still not merged:
https://lore.kernel.org/lkml/20190304112336.21397-1-manio@skyboo.net/

regards,
Mariusz Białończyk | xmpp/e-mail: manio@skyboo.net
https://skyboo.net | https://github.com/manio

Mariusz Bialonczyk (2):
  w1: ds2408: add a missing reset when retrying in output_write()
  w1: fix the resume command API

 drivers/w1/slaves/w1_ds2408.c | 13 ++++++++-----
 drivers/w1/w1_io.c            | 11 +++++++++--
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.19.0.rc1

