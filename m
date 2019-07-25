Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7921901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfGYObe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:31:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52458 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGYObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:31:33 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 06892CECB0;
        Thu, 25 Jul 2019 16:40:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hci_uart: check for missing tty operations in
 protocol handlers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <74627941.4546902.1564064789961.JavaMail.zimbra@redhat.com>
Date:   Thu, 25 Jul 2019 16:31:31 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Sumangala <suraj@atheros.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Loic Poulain <loic.poulain@intel.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        syzkaller@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1B4CE156-DB18-4010-ACB8-93A70AD1A3C5@holtmann.org>
References: <20190725120909.31235-1-vdronov@redhat.com>
 <2E234F47-724D-4CFB-93B5-48E5BDA6F230@holtmann.org>
 <74627941.4546902.1564064789961.JavaMail.zimbra@redhat.com>
To:     Vladis Dronov <vdronov@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladis,

>> why is this one hidden behind CONFIG_PM? The general baud rate changes are
>> independent of runtime power management support.
> 
> hci_bcm calls hci_uart_set_flow_control() only from functions hidden behind
> #ifdef-CONFIG_PM (surely this can change in the future), and so without
> CONFIG_PM set it cannot hit the bug (as of now). So I've hidden the check
> for tiocm[gs]et() behind #ifdef-CONFIG_PM too.
> 
> If you tell me it is better to remove this #ifdef, I'll remove it.

just remove it since I think that is a coincidence actually. And I think you also need to add a check in hci_h5.c since that got Realtek support, it should also use flow control or baud rate settings.

>> And I would introduce a bool hci_uart_has_tiocm_support(struct hci_uart *)
>> helper.
> 
> Great, I will add it to the v2 fix. I guess a good place for it is hci_ldisc.c,
> near hci_uart_set_flow_control(), isn't it?

Sounds good.

Regards

Marcel

