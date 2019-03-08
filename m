Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62616C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gunF4Opm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W7CKDR0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCHFPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:15:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfCHFPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:15:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0DDAA6034E; Fri,  8 Mar 2019 05:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552022132;
        bh=h/0tuvw7uWCwhB6ncK4IjAlUStmNtP9V3x9UHw/jDDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gunF4OpmnEZPBdr5lug9sLfwJn/mcFMqmuqcTGOan1JafMr/niW6B4YVQcYzmu99E
         qZJTKrWoIgBbNTSdEl+m/8gnUEajDwO0Z9W5v9MtL1tQkLgqIlgXoxNQVsA7N95/HH
         OgrlkVefRFM5BIDjDKfRgD16Lw2qIx8COjNDhPF8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 72C046034E;
        Fri,  8 Mar 2019 05:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552022131;
        bh=h/0tuvw7uWCwhB6ncK4IjAlUStmNtP9V3x9UHw/jDDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W7CKDR0MpFO+HFvi5OvUxHU+ksuTOWxuWRFqs6q2aCufgRZKnvUKBnA/yPz3BhMTg
         +sRE4wDmJ55nwNjIekljxiw9/vQ5veEmqDJqp2vG0oodKTzgM0EqanpjIiP0H/DF+p
         Dwxwjk5RGSokZTZABQtfOJ9MtGOZdA4wR25r6Gig=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 08 Mar 2019 13:15:31 +0800
From:   rjliao@codeaurora.org
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
In-Reply-To: <20190306162113.8585-1-bgodavar@codeaurora.org>
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
Message-ID: <802c0b3fedc631aabd47d7c63cfdfc85@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-03-07 00:21，Balakrishna Godavarthi 写道：
> This patch enables enough time to ROME controller to bootup
> after we bring the enable ping out of reset.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f..1953b13511e7 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>  		if (qcadev->btsoc_type != QCA_WCN3990) {
>  			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +			/* Controller needs time to bootup. */
> +			msleep(150);
>  		} else {
>  			hu->init_speed = qcadev->init_speed;
>  			hu->oper_speed = qcadev->oper_speed;
Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Rocky Liao <rjliao@codeaurora.org>
