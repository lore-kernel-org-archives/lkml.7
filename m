Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0807C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1B206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJqIQTcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfDYQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:46:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41464 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:46:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so184124pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/IQSSk/LXWTRzdszIj6+hfd6gppMjKJokTDca/mb6g=;
        b=FJqIQTcnUv/bBkHre6QVurdXsLIzsGHPiHhQsfrtMnIiTxT30TYHcQlPthaIMuMxzO
         YUQEP4wuoJCJCJvwTIB+739EKOXA+mo+YttjPV7ugw5XvTRHLN01UXMaDqaI1hp/w85W
         kjAGW6Ed4poW9L2fWG1bwFvdi01vxVKybb3lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/IQSSk/LXWTRzdszIj6+hfd6gppMjKJokTDca/mb6g=;
        b=fGA+awAnCS7iqWUyXoP93QtN8uVKjfghlE2rKkyTtY2rwsh3t2X53NzDrflwkON6/C
         Ei3sR5CuWVFzRZFOBIFlCRllXrS90ujelMKmsOM1uFDbCXLQwSNxYRm+Hg6HQtz8mOtF
         nXhdzDn/AJjJYpmwz8oihRyyQ9E9G5PXTuJYW50nCM0qliK3ysetcyfQog5+q8nzgwSJ
         5Mo+gg9JBtxiIKMiFeeuw+0rVXXt42cvJDzDd6I0ZYDJGwdTfdSeI1pUw8aibu9+K+YY
         /tAgtqSvmQB9855Klr8XgoQ183z4D6WGqU06dpFSz38VYZs1HGZd2s3Ab6SCqt/8Y39b
         +Odw==
X-Gm-Message-State: APjAAAVureDYFtabP1G3Fhy8cPurpkCmjUhhW7fngYeDohVUM1qB5h8g
        MZXDplJY9zKxNzZ+FdGRbWOdQA==
X-Google-Smtp-Source: APXvYqyhpUHLP1UZ+vFp9LZmFFNV0dHmtiDDg8IPR26/GOv9X6L9/jv7yTIrxerJE3qC78EUmyI0Pw==
X-Received: by 2002:a63:750c:: with SMTP id q12mr38387096pgc.133.1556210806225;
        Thu, 25 Apr 2019 09:46:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n5sm24764349pgp.80.2019.04.25.09.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 09:46:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:46:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 1/2] Bluetooth: hci_qca: Added support for WCN3998
Message-ID: <20190425164644.GG112750@google.com>
References: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
 <1556194416-30842-2-git-send-email-c-hbandi@codeaurora.org>
 <08C6CC93-45C7-468E-AFC3-251507FA678E@holtmann.org>
 <2172b21d6b936c0befca1a608ae297c1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2172b21d6b936c0befca1a608ae297c1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:10:51PM +0530, Harish Bandi wrote:
> Hi Marcel,
> 
> On 2019-04-25 18:17, Marcel Holtmann wrote:
> > Hi Harish,
> > 
> > > Added new compatible for WCN3998 and corresponding voltage
> > > and current values to WCN3998 compatible.
> > > Changed driver code to support WCN3998
> > > 
> > > Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in V7:
> > > - Initialized rom_ver to 0 to fix compiler warning
> > > ---
> > > drivers/bluetooth/btqca.c   | 12 +++++++++---
> > > drivers/bluetooth/btqca.h   |  8 +++++++-
> > > drivers/bluetooth/hci_qca.c | 40
> > > ++++++++++++++++++++++++++--------------
> > > 3 files changed, 42 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > index 6122685..495a52f 100644
> > > --- a/drivers/bluetooth/btqca.c
> > > +++ b/drivers/bluetooth/btqca.c
> > > @@ -336,7 +336,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t
> > > baudrate,
> > > {
> > > 	struct rome_config config;
> > > 	int err;
> > > -	u8 rom_ver;
> > > +	u8 rom_ver = 0;
> > 
> > what is this change for?
> [Harish] - kbuild test robot gave compiler warning. So initialized.
> drivers/bluetooth/btqca.c:369:3: warning: 'rom_ver' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> 
> > 
> > > 	bt_dev_dbg(hdev, "QCA setup on UART");
> > > 
> > > @@ -344,7 +344,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t
> > > baudrate,
> > > 
> > > 	/* Download rampatch file */
> > > 	config.type = TLV_TYPE_PATCH;
> > > -	if (soc_type == QCA_WCN3990) {
> > > +	if (qca_is_wcn399x(soc_type)) {
> > > 		/* Firmware files to download are based on ROM version.
> > > 		 * ROM version is derived from last two bytes of soc_ver.
> > > 		 */
> > > @@ -365,7 +365,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t
> > > baudrate,
> > > 
> > > 	/* Download NVM configuration */
> > > 	config.type = TLV_TYPE_NVM;
> > > -	if (soc_type == QCA_WCN3990)
> > > +	if (qca_is_wcn399x(soc_type))
> > > 		snprintf(config.fwname, sizeof(config.fwname),
> > > 			 "qca/crnv%02x.bin", rom_ver);
> > > 	else
> > > @@ -410,6 +410,12 @@ int qca_set_bdaddr(struct hci_dev *hdev, const
> > > bdaddr_t *bdaddr)
> > > }
> > > EXPORT_SYMBOL_GPL(qca_set_bdaddr);
> > > 
> > > +bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
> > > +{
> > > +	return ((soc_type == QCA_WCN3990) || (soc_type == QCA_WCN3998));
> > 
> > no () needed around soc_type = check.
> 
> [Harish]  - OK, will change it.
> > 
> > > +}
> > > +EXPORT_SYMBOL_GPL(qca_is_wcn399x);
> > > +
> > 
> > Why is this exported. Make this an inline function in btqca.h.
> [Harish] - This was used in btqca.c also to check the soc_type

true, but this is still possible with an inline function in btqca.h.
