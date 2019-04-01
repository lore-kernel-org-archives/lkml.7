Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6658C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF9C20651
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z6mprssQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDAVfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:35:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33784 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:35:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so3245339plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2BWpsf3eguvBn3XgFLe8zv3fkMLRcZ0jw/2QokUZA4=;
        b=Z6mprssQVG5eQFdr5Y5zngC4TRp+VUYA8LiKYING+NTddEKOlPbm/DBw9UBdvW781g
         MFgO6ykBbPXfBOs+vcbxqix00VZAjDCbHluDWSJYiBxqrN17+dbTSiCpKJKspQ9pqBgf
         U41BWOyBXIuhVkGO70iyrTPAxoqJbLf/gKK0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2BWpsf3eguvBn3XgFLe8zv3fkMLRcZ0jw/2QokUZA4=;
        b=ntWZAFTmmPgG/82nxkUE6kuuszZHLl41Q0WuGec74KKtuId9cTx5boXjVGxz70/wez
         ysf6k4Kc+68nnhNAo0dVr8hOaaO8SKt2l7ipXZWpF1jVdDXC0wvsebM8/1boaJWmg/kf
         oGlpuYLeW3wnAwhWsu0UhOu9Wy+Mtlo8SJDLDNwmMGtXMH3/02NAK/YtNa0TUphb2Nmv
         bdktr6aBgXKVVPxSWEy6z7SCLGVf4azNb2bnAVYFMHkHELVFPDb4cb4hR/qTngacQVsg
         H0naJLOepboDfUGWTBaIpFm2LgWcqm5HzjKFzr+fegJbLpFhrl2xbtztDsUX3rbYt6Be
         TOMg==
X-Gm-Message-State: APjAAAX+MUgfTDXDl8JSHn+3COL8HKFvvikW3WgE7WQscH/vODv7n8dr
        O2wib15vPl93SKByIUjuGO6AUQ==
X-Google-Smtp-Source: APXvYqzDeNkCwOMbFz+GH/L3JaCuanMzQzgaPMp6QsJsyld950NGSadH/U95WTU33Se2cVfYKUgf1w==
X-Received: by 2002:a17:902:241:: with SMTP id 59mr31361252plc.79.1554154541312;
        Mon, 01 Apr 2019 14:35:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f65sm16923236pff.21.2019.04.01.14.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 14:35:40 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:35:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
Message-ID: <20190401213540.GJ112750@google.com>
References: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

do you have any comments or can this fix be landed?

Thanks

Matthias

On Wed, Mar 13, 2019 at 04:52:19PM -0700, Matthias Kaehlcke wrote:
> qca_set_baudrate() calls serdev_device_wait_until_sent() assuming that
> the HCI is always associated with a serdev device. This isn't true for
> ROME controllers instantiated through ldisc, where the call causes a
> crash due to a NULL pointer dereferentiation. Only call the function
> when we have a serdev device. The timeout for ROME devices at the end
> of qca_set_baudrate() is long enough to be reasonably sure that the
> command was sent.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
> Bluetooth chip wcn3990")
> Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reported-by: Rocky Liao <rjliao@codeaurora.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4ea995d610d2..714a6a16f9d5 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1004,7 +1004,8 @@ static int qca_set_baudrate(struct hci_dev
> *hdev, uint8_t baudrate)
>  	while (!skb_queue_empty(&qca->txq))
>  		usleep_range(100, 200);
> 
> -	serdev_device_wait_until_sent(hu->serdev,
> +	if (hu->serdev)
> +		serdev_device_wait_until_sent(hu->serdev,
>  		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> 
>  	/* Give the controller time to process the request */
