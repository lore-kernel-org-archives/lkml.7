Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21699218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCUKLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:11:55 -0400
Received: from skyboo.net ([94.40.87.198]:44500 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfCUKLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:11:54 -0400
Received: from [10.1.0.1] (helo=nemesis.skyboo.net)
        by skyboo.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1h6ufo-0006iu-D4; Thu, 21 Mar 2019 11:11:48 +0100
Date:   Thu, 21 Mar 2019 11:11:43 +0100
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Message-Id: <20190321111143.c54afe794f1de222a0cd020a@skyboo.net>
In-Reply-To: <9351961553005269@iva4-406defa25fee.qloud-c.yandex.net>
References: <20190318092737.8170-1-manio@skyboo.net>
        <20190318092737.8170-3-manio@skyboo.net>
        <6836A9A3-AF86-4E2F-9215-647CB36E22DA@gmail.com>
        <9351961553005269@iva4-406defa25fee.qloud-c.yandex.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.1.0.1
X-SA-Exim-Rcpt-To: zbr@ioremap.net, jeff.dagenais@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: Re: [PATCH 2/2] w1: fix the resume command API
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

On Tue, 19 Mar 2019 17:21:09 +0300
Evgeniy Polyakov <zbr@ioremap.net> wrote:

> Looks like this may break the search logic, can you check that with this patch applied
> some other single slave device will correctly 'tell' its id and it can be addressed via match rom (like, basically, just reading temperature or something like that)?

Yes, I have tested it in a mixed environment (regarding single slave/multidrop):

/sys/devices/w1_bus_master5 # ll
total 0
drwxr-xr-x    9 root     0                0 Mar 21 10:53 .
drwxr-xr-x   17 root     0                0 Mar  2 16:49 ..
drwxr-xr-x    4 root     0                0 Mar 21 10:55 28-00000921ff5e
drwxr-xr-x    3 root     0                0 Mar 21 11:04 29-0000001246a4
drwxr-xr-x    3 root     0                0 Mar 21 11:04 29-0000001246b1
drwxr-xr-x    3 root     0                0 Mar 21 11:04 29-0000001246b9
drwxr-xr-x    3 root     0                0 Mar 21 10:54 29-0000001246bc
drwxr-xr-x    3 root     0                0 Mar 21 10:53 3a-0000000f354f

/sys/devices/w1_bus_master6 # ll
total 0
drwxr-xr-x    4 root     0                0 Mar 21 10:54 .
drwxr-xr-x   17 root     0                0 Mar  2 16:49 ..
drwxr-xr-x    3 root     0                0 Mar 21 11:07 29-0000001246a9

No problem with searching and using other slaves on the bus.

regards,
-- 
Mariusz Białończyk | xmpp/e-mail: manio@skyboo.net
https://skyboo.net | https://github.com/manio
