Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16003C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0AA2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553564107;
	bh=BtbVbMRScB1MlU7O4a1gHi6RtXrMC6FJ6yX0WEe+mhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sQ2b2wKjpR3N8Ex5bixr4S0XeEgRzKhIQD+p0S+P3Fw4paLa+yCKu/lLxFZ/14TnQ
	 SuA3HqKzbBEq2t3fHRiRNJEEeR3iRF9eaFK7KWcH9JdQA3Pu6afAa0ehwcqltHc+4P
	 ITi7/6KTG98SkGHN1xuIWwAHIGGU5i3mn543WM4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfCZBfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfCZBfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:35:05 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713CD2075D;
        Tue, 26 Mar 2019 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553564104;
        bh=BtbVbMRScB1MlU7O4a1gHi6RtXrMC6FJ6yX0WEe+mhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ga94NYNelUWPt0c3xBt69ZdI8oqhRBpY0/dr/YX4y2T/4NeMHRHWrrKeNIKRd+cR5
         XKwXvdk0eBtrHGOpTduTcr1AgvQ+z38oztGdAxeMyczhoaQDCg2uq24LuYxkQBskJI
         ibtKxkdTbQibVvq3dDxycVIBD8E+d5hoz75QMNug=
Date:   Tue, 26 Mar 2019 10:34:58 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Lanqing Liu <lanqing.liu@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 23/25] serial: sprd: clear timeout interrupt
 only rather than all interrupts
Message-ID: <20190326013458.GC21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-24-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-24-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:14PM +0100, Arnd Bergmann wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 
> On Spreadtrum's serial device, nearly all of interrupts would be cleared
> by hardware except timeout interrupt.  This patch removed the operation
> of clearing all interrupt in irq handler, instead added an if statement
> to check if the timeout interrupt is supposed to be cleared.
> 
> Wrongly clearing timeout interrupt would lead to uart data stay in rx
> fifo, that means the driver cannot read them out anymore.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 4350782570b919f254c1e083261a21c19fcaee90)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sprd_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Also added to 4.9.y
