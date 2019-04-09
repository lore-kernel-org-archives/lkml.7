Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB118C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA6320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIBVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:21:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51019 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726515AbfDIBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:21:08 -0400
Received: (qmail 1623 invoked by uid 500); 8 Apr 2019 21:21:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Apr 2019 21:21:07 -0400
Date:   Mon, 8 Apr 2019 21:21:07 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Kento.A.Kobayashi@sony.com
cc:     jejb@linux.ibm.com, <martin.petersen@oracle.com>,
        <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE5892A0D@JPYOKXMS103.jp.sony.com>
Message-ID: <Pine.LNX.4.44L0.1904082118490.1490-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 Kento.A.Kobayashi@sony.com wrote:

> Hi,
> 
> >So it looks as though the SCSI subsystem doesn't like to have a reset handler call scsi_remove_host.  Commands dispatched by the removal routines are forced to wait for the reset recovery to finish, which won't happen until those commands have been completed.
> 
> You mean reset handeler should not call scsi_remove_host, right?
> But actually, scsi_remove_host is called from reset handler in this case.
> 
> >Is this a bug in the SCSI core? 
> No, I think this is a bug in uas driver.

Actually I was asking James and Martin, not you.

In any case, even assuming the cause of the problem is on the USB side, 
it's not clear whether the bug is in uas or in usbcore.

Alan Stern

