Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445BC2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43CB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="uUB0+vEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLYGHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:07:09 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:15211 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfLYGHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:07:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577254028; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WBG1ZiYj+iJJrSUURj9H+ndKxXeywY95HPsfqF/a078=;
 b=uUB0+vEB597IZjIS++N7nDQxOgZZtNMqksV0kBaa1IseDc8C7OIB0l4cz9bMmuMnct0AdNOu
 j78mTU5dfLvF56H9aLspNdwyGVP9Rrol8SBsnuFtFxFQ1+q0igzKWfRSQJmHs/sCbLqe8+GI
 OM8bol64YamX+MmziyD0vr97qkA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e02fc88.7fb23dcc2298-smtp-out-n03;
 Wed, 25 Dec 2019 06:07:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 584C9C433A2; Wed, 25 Dec 2019 06:07:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9D0CC43383;
        Wed, 25 Dec 2019 06:07:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Dec 2019 14:07:03 +0800
From:   rjliao@codeaurora.org
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Retry btsoc initialize when it
 fails
In-Reply-To: <20191219065217.14122-1-rjliao@codeaurora.org>
References: <20191219065217.14122-1-rjliao@codeaurora.org>
Message-ID: <4c02862a446715d393d4b5ddac3b3bed@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ingnore this patch, I have just sent the new set of patches.

在 2019-12-19 14:52，Rocky Liao 写道：
> This patch adds the retry of btsoc initialization when it fails. There 
> are
> reports that the btsoc initialization may fail on some platforms but 
> the
> repro ratio is very low. The failure may be caused by UART, platform HW 
> or
> the btsoc itself but it's very difficlut to root cause, given the repro
> ratio is very low. Add a retry for the btsoc initialization will 
> resolve
> most of the failures and make Bluetooth finally works.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1cb706acdef6..af45b31f1b5f 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -53,6 +53,9 @@
>  /* Controller debug log header */
>  #define QCA_DEBUG_HANDLE	0x2EDC
> 
> +/* max retry count when init fails */
> +#define QCA_MAX_INIT_RETRY_COUNT 3
> +
>  enum qca_flags {
>  	QCA_IBS_ENABLED,
>  	QCA_DROP_VENDOR_EVENT,
> @@ -1259,6 +1262,7 @@ static int qca_setup(struct hci_uart *hu)
>  	struct qca_data *qca = hu->priv;
>  	struct qca_serdev *qcadev;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> +	unsigned int init_retry_count = 0;
>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>  	const char *firmware_name = qca_get_firmware_name(hu);
>  	int ret;
> @@ -1276,6 +1280,7 @@ static int qca_setup(struct hci_uart *hu)
>  	 */
>  	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 
> +retry:
>  	if (qca_is_wcn399x(soc_type)) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> 
> @@ -1341,6 +1346,20 @@ static int qca_setup(struct hci_uart *hu)
>  		 * patch/nvm-config is found, so run with original fw/config.
>  		 */
>  		ret = 0;
> +	} else {
> +		if (init_retry_count < QCA_MAX_INIT_RETRY_COUNT) {
> +			qca_power_off(hdev);
> +			if (hu->serdev) {
> +				serdev_device_close(hu->serdev);
> +				ret = serdev_device_open(hu->serdev);
> +				if (ret) {
> +					bt_dev_err(hu->hdev, "open port fail");
> +					return ret;
> +				}
> +			}
> +			init_retry_count++;
> +			goto retry;
> +		}
>  	}
> 
>  	/* Setup bdaddr */
