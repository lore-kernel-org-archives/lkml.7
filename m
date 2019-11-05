Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93065C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7399521882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfKEOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:33:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:56900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389604AbfKEOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:33:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 797ACB591;
        Tue,  5 Nov 2019 14:33:42 +0000 (UTC)
Message-ID: <1572964421.2921.20.camel@suse.com>
Subject: Re: [PATCH 4.14 67/95] UAS: Revert commit 3ae62a42090f ("UAS: fix
 alignment of scatter/gather segments")
From:   Oliver Neukum <oneukum@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 05 Nov 2019 15:33:41 +0100
In-Reply-To: <20191104212111.409017128@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
         <20191104212111.409017128@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 04.11.2019, 22:45 +0100 schrieb Greg Kroah-Hartman:
> There is no longer any reason to keep the virt_boundary_mask setting
> in the uas driver.  It was needed in the first place only for
> handling devices with a block size smaller than the maxpacket size and
> where the host controller was not capable of fully general
> scatter-gather operation (that is, able to merge two SG segments into
> a single USB packet).  But:
> 
>         High-speed or slower connections never use a bulk maxpacket
>         value larger than 512;
> 
>         The SCSI layer does not handle block devices with a block size
>         smaller than 512 bytes;
> 
>         All the host controllers capable of SuperSpeed operation can
>         handle fully general SG;
> 
>         Since commit ea44d190764b ("usbip: Implement SG support to
>         vhci-hcd and stub driver") was merged, the USB/IP driver can
>         also handle SG.

Hi,

same story as in 4.4.x, I am afraid.

	Regards
		Oliver

