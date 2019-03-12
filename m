Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C83AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B0F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCLPhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfCLPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CA13B172;
        Tue, 12 Mar 2019 15:37:33 +0000 (UTC)
Message-ID: <1552405047.21557.7.camel@suse.com>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Oliver Neukum <oneukum@suse.com>
To:     Kento.A.Kobayashi@sony.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, Jacky.Cao@sony.com,
        Kan.Iibuchi@sony.com, No.Tanaka@sony.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 12 Mar 2019 16:37:27 +0100
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-03-11 at 08:36 +0000, Kento.A.Kobayashi@sony.com wrote:
> Hi,
> 
> > no I am sorry, that is an assumption you just cannot make.
> > Anything can trigger a reset. That being SCSI is the common case certainly, but not the only case. And in those cases we cannot depend on upper layers doing the right thing, if we just ignore an error.
> 
> While we investigate this issue, we debugged and found usb_reset_and_verify_device will return -NODEV before enter post_reset operation.

Yes, this can happen.

> And the return value(-ENODEV) will be returned to error handler.
> uas_eh_device_reset_handler->usb_reset_device -> usb_reset_and_verify_device (return -ENODEV) Then I wrote that commit message that we think even if we ignore "ENODEV" in post reset to avoid hang issue but the error will also be reported to error handler.
> #If ignore an error and the error will not be reported then it is not good.

Well, what do we do now? Are you saying that the state model SCSI is
using is wrong?

> Additional information about usb-storage driver(usb/storage/usb.c) in usb_stor_post_reset() function, it always return 0 that means rebind will not be execute and this issue doesn't happen.

I am afraid this is only partially correct. The device descriptors can
still fail to match.

	Regards
		Oliver

