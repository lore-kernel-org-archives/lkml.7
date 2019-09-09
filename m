Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA46C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EDA20640
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imxIhVk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfIIQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:14:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40906 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfIIQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:14:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so9455761pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKRKebMQp8+SbILfMU8ecMqIsBhud1/TN1PMbu5EjjI=;
        b=imxIhVk5aoekCjb3KrtkWUiDJG9zxpKIE771OqRjLKCUU5dIADhAa6wXm0FY6+YtDF
         VCz/+iFQxpMJz/eejN+BtKQWxzSBWU5Xq6jCCo3dlJRkvDYeCw80LJoyhXngUTW1Ltz7
         F4PEOrXFIgE8XECGTNyTooYBhKEHd1LlHLq1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKRKebMQp8+SbILfMU8ecMqIsBhud1/TN1PMbu5EjjI=;
        b=apz0akoU1yRNflG3ABTSXuO09wyORpp+sU5Bn53P6qeM1I1InFrcobfIL7ivEdkxWh
         08pVjdcbcrHOKxHSiWVOTbaiaZ6O2aPK0ZwSp8YDuEH7HdDiu1K+FKjpQE6bDxSLmP2S
         d+bBYnvRi/JG1hvwShESrhj2It49rxoe1sW/mvB7uFNeZmdGrUF1h3I0lKJxuTdPi5wk
         HMh7wtejEKxKZDuiFKs3aAkTHhnF28bvFIeShtSpokdkXO/EYGIprjzstpS7cyyj5uGk
         ofCuRwzrNkFIz/5OB0IC1YOuw7OZKntqN/WvCTe4aiYQzrqkaAYBc7V2+IHRjvjsnGnn
         gH0g==
X-Gm-Message-State: APjAAAX7JV/fyLNuixyqbCCSIxyCsLoFDgsbJOhcanX8XF1BHRqJNHLE
        aTC6EyoGOABjEXXGoNxzEy7U4rV882M=
X-Google-Smtp-Source: APXvYqxv0uRHIjWCqUuwfqWyNKlXfBanrG+Rix/cvYZZTS2khVb7BokyP3a1CE29ekh+2DNFWd0/lA==
X-Received: by 2002:a63:3281:: with SMTP id y123mr21806450pgy.72.1568045643654;
        Mon, 09 Sep 2019 09:14:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j1sm14982164pgl.12.2019.09.09.09.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 09:14:02 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:13:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 04/40] Bluetooth: btqca: Add a short delay before
 downloading the NVM
Message-ID: <20190909161359.GE133864@google.com>
References: <20190908121114.260662089@linuxfoundation.org>
 <20190908121115.297090022@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190908121115.297090022@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 01:41:37PM +0100, Greg Kroah-Hartman wrote:
> [ Upstream commit 8059ba0bd0e4694e51c2ee6438a77b325f06c0d5 ]
> 
> On WCN3990 downloading the NVM sometimes fails with a "TLV response
> size mismatch" error:
> 
> [  174.949955] Bluetooth: btqca.c:qca_download_firmware() hci0: QCA Downloading qca/crnv21.bin
> [  174.958718] Bluetooth: btqca.c:qca_tlv_send_segment() hci0: QCA TLV response size mismatch

WC3990 support was only added in 4.19, so this shouldn't be needed in
older kernels, but it shouldn't do any harm either ;-)

> It seems the controller needs a short time after downloading the
> firmware before it is ready for the NVM. A delay as short as 1 ms
> seems sufficient, make it 10 ms just in case. No event is received
> during the delay, hence we don't just silently drop an extra event.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 0bbdfcef2aa84..a48a61f22f823 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -363,6 +363,9 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
>  		return err;
>  	}
>  
> +	/* Give the controller some time to get ready to receive the NVM */
> +	msleep(10);
> +
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
