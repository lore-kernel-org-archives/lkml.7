Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C92CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026E1206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563407;
	bh=ck5Mr/1QzH4xU4uppqyGT+330sA/lUX/lbsfjn5pzqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=APXQUsZdjBVS66lPOcobBXbtCB56TEcuOsRCj+ElFsWOPzZHKxfkrHvf+uPWR5qu3
	 AUyd1GC2rpNMDjuGf/Li4a4tYCLBQTqcSkSUOfaMiD/loPTwpywg3/kbHrFSyt6Del
	 bj2KXgor3qrhWzwfgR4BqL8rXw32t3qEJFWsbfFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfCZBX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:23:23 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F779208E4;
        Tue, 26 Mar 2019 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563402;
        bh=ck5Mr/1QzH4xU4uppqyGT+330sA/lUX/lbsfjn5pzqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWCSE13WMQDVa/GNmDcSblzao3Ti8faGATIeXkqOuAp4y6RVZq3Gbzw/CSd07Zg4i
         DPHYPbFj+9v7pAVn2EqojcALFg4NqrlJk0vCSglE0qaiglplCTOzZe7f9pczvuKp7E
         3+lcpSSCrLrBrs8loeiEUjSV4LJn8X0vJTUZdXLQ=
Date:   Tue, 26 Mar 2019 10:21:54 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wei Qiao <wei.qiao@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Lanqing Liu <lanqing.liu@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 19/25] serial: sprd: adjust TIMEOUT to a big
 value
Message-ID: <20190326012154.GE29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-20-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-20-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:10PM +0100, Arnd Bergmann wrote:
> From: Wei Qiao <wei.qiao@spreadtrum.com>
> 
> SPRD_TIMEOUT was 256, which is too small to wait until the status
> switched to workable in a while loop, so that the earlycon could
> not work correctly.
> 
> Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sprd_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also applied to 4.9.y
