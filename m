Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CA2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvivgHko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfDBEGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:06:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBEGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:06:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5651765pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/BudzxJSuvPoxSMTNXL/vt4h+DmYX8E7c5je0g6hGW8=;
        b=dvivgHkoQ4ODL8dw6MmsDW63sPJs9D9JiOlFz86R1MLBXEPrVz7ERxEO5NaFm4Ok9A
         QdA8FBVIvlAJrh9+vzYROiKU8Pd7pAVkD6Me5fDzV03NnSSJVD8NVhCLmSaWetmbSKIr
         VGFJMeeuqBhuSUPCOMkBc5pTbY8NwQxO+yABXTfPB5tSIYneGOCTJEZO4/vuiTfQd1ze
         VclgvI9sq08cevrkEGBaSNjwiG2we0sZ61HYCFtPv1chvvTpvS+ey4e9n+d+Anwbein2
         RoPfr2IdUEq1lU18iqsADeh6Aa3rO9Zg3Q4/z3e7PJdwBanB179gOxHhi5alYgqafuAv
         ceQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/BudzxJSuvPoxSMTNXL/vt4h+DmYX8E7c5je0g6hGW8=;
        b=o1HFTNRBGJQCtASz2QNMmBsjpw4rJQkz4iEriOQr3gM8qza8LK1f7AAg/a21hcHl9g
         dN3zaqCFL8X7wh2ZIprSiF6O8t99TCOrLSxuiM4edDXJUWGeQ7QRLwRD/oRYxVmk+Hre
         AuO1Y84OlXSM8vEruUGIqmp/km6PVHRsiNGOixmbs79f6ZGARNA/3ZqfFCtb7NPGDEJ2
         BKweleo1WTHH7Gyn5CLWzYjKfeRm+gzKBg4JGIT6UnBCaVKAS3b0U0eY6arzol6TmIoG
         0azN87s080nT+Fjte1cw4c7jjQ/dVyAvaQQJH1c2ej3U4EOLyjTpvWFfcJQb3eDKe5BQ
         1VLg==
X-Gm-Message-State: APjAAAVY7MgM3faVUQsj1EfTYa500/g3pe3d5nfvTp4md443FLiZ34hk
        Cw54XFNtqLYHeFagP95gY093P7shxUaf1g==
X-Google-Smtp-Source: APXvYqwxmw2QRNvSjQmtk6J/WURH/2rBtCOHPr3bQV28vrxyjHq2aqGftylbbyXxyBFxuRnlLXh4tw==
X-Received: by 2002:a65:6144:: with SMTP id o4mr27172989pgv.247.1554178013420;
        Mon, 01 Apr 2019 21:06:53 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id y12sm32774618pgq.64.2019.04.01.21.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:06:52 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:06:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec_dev: Add a poll handler to receive MKBP
 events
Message-ID: <20190402040647.GM4187@dell>
References: <20190308123659.16101-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308123659.16101-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Mar 2019, Enric Balletbo i Serra wrote:

> From: Vincent Palatin <vpalatin@chromium.org>
> 
> Allow to poll on the cros_ec device to receive the MKBP events.
> 
> The /dev/cros_[ec|fp|..] file operations now implements the poll
> operation. The userspace can now receive specific MKBP events by doing the
> following:
> - Open the /dev/cros_XX file.
> - Call the CROS_EC_DEV_IOCEVENTMASK ioctl with the bitmap of the MKBP
>   events it wishes to receive as argument.
> - Poll on the file descriptor.
> - When it gets POLLIN, do a read on the file descriptor, the first
>   queued event will be returned (using the struct
>   ec_response_get_next_event format: one byte of event type, then
>   the payload).
> 
> The read() operation returns at most one event even if there are several
> queued, and it might be truncated if the buffer is smaller than the
> event (but the caller should know the maximum size of the events it is
> reading).
> 
> read() used to return the EC version string, it still does it when no
> event mask or an empty event is set for backward compatibility (despite
> nobody really using this feature).
> 
> This will be used, for example, by the userspace daemon to receive and
> treat the EC_MKBP_EVENT_FINGERPRINT sent by the FP MCU.

MFD does not seem like the correct place for this.  Maybe this is a
good candidate for drivers/platform/chrome/* where the rest of your
platform empire now resides.

> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/cros_ec_dev.c | 163 +++++++++++++++++++++++++++++++++++++-
>  drivers/mfd/cros_ec_dev.h |   1 +
>  2 files changed, 160 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
