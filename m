Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCE220842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615998;
	bh=pVSfYIlzn3yG2Vhxq1/FZ/qGcjO5DT4ZLCyifUSAIvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmlEjuLD/ynxeK7kN6lxlfBeRdXzqV3JZ7h151T1TJ/QbGlrra2HW0M8kZ+aX3tgT
	 0kEBWhCJYixUK3J24ALCf6x1UymwCoKazfAScVy3r4pn55qrpRedu4QhaFz7UVj9g2
	 qrOcxeJUmIp037bN7RpexeCBZnBikEVdUNot50OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfHLNT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfHLNT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:19:57 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2120320684;
        Mon, 12 Aug 2019 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565615996;
        bh=pVSfYIlzn3yG2Vhxq1/FZ/qGcjO5DT4ZLCyifUSAIvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhLcJikBIG9LKg9xa66AKfYk2OmZ4MBG46Dv9DR4sJmgPNTZn5XXVMlqTVTpoK7s8
         jhBn2d0DndTJMzExTIACSpx93BWVtkd31c1JIj/cQ3LwGk97Pga9h0xW+aRenUglLt
         0pCsaSolP6RkIkumevR6zoJbpI9gCIEhKXG8JW/k=
Date:   Mon, 12 Aug 2019 15:19:45 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v4] firmware: imx: Add DSP IPC protocol interface
Message-ID: <20190812131944.GE27041@X250>
References: <20190801095636.22944-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801095636.22944-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:56:36PM +0300, Daniel Baluta wrote:
> Some of i.MX8 processors (e.g i.MX8QM, i.MX8QXP) contain
> the Tensilica HiFi4 DSP for advanced pre- and post-audio
> processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing
> and a dedicated Messaging Unit for notifications.
> 
> DSP IPC protocol offers a doorbell interface using
> imx-mailbox API.
> 
> We use 4 MU channels (2 x TXDB, 2 x RXDB) to implement a
> request-reply protocol.
> 
> Connection 0 (txdb0, rxdb0):
>         - Host writes messasge to shared memory [SHMEM]
> 	- Host sends a request [MU]
> 	- DSP handles request [SHMEM]
> 	- DSP sends reply [MU]
> 
> Connection 1 (txdb1, rxdb1):
> 	- DSP writes a message to shared memory [SHMEM]
> 	- DSP sends a request [MU]
> 	- Host handles request [SHMEM]
> 	- Host sends reply [MU]
> 
> The protocol interface will be used by a Host client to
> communicate with the DSP. First client will be the i.MX8
> part from Sound Open Firmware infrastructure.
> 
> The protocol offers the following interface:
> 
> On Tx:
>    - imx_dsp_ring_doorbell, will be called to notify the DSP
>    that it needs to handle a request.
> 
> On Rx:
>    - clients need to provide two callbacks:
> 	.handle_reply
> 	.handle_request
>   - the callbacks will be used by the protocol on
>     notification arrival from DSP.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
