Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0251204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCHRDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:03:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:41466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHRDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:03:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59B26AFC3;
        Fri,  8 Mar 2019 17:03:51 +0000 (UTC)
Message-ID: <1552063928.29776.2.camel@suse.com>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Oliver Neukum <oneukum@suse.com>
To:     Kento.A.Kobayashi@sony.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Fri, 08 Mar 2019 17:52:08 +0100
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-03-08 at 09:13 +0000, Kento.A.Kobayashi@sony.com wrote:
> The usb_reset_and_verify_device included in usb_reset_device fails
> with -ENODEV after power off hub port, and the -ENODEV error will
> be reported to uas_eh_bus_reset_handler and upper layer, so it
> doesn't need to do rebind if -ENODEV happens.

Hi,

no I am sorry, that is an assumption you just cannot make.
Anything can trigger a reset. That being SCSI is the common
case certainly, but not the only case. And in those cases
we cannot depend on upper layers doing the right thing, if
we just ignore an error.

NACK

	Sorry
		Oliver

