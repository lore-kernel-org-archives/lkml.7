Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC7EC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE8206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGUTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:05:44 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:45453 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbfGUTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:05:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E5052837F24C;
        Sun, 21 Jul 2019 19:05:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: power37_88bd3d85e2b24
X-Filterd-Recvd-Size: 3722
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 19:05:39 +0000 (UTC)
Message-ID: <4d4a8a02e4ec7fad9213302d17a6acd17851d8da.camel@perches.com>
Subject: Re: [PATCH v10 2/6] usb:common Separated decoding functions from
 dwc3 driver.
From:   Joe Perches <joe@perches.com>
To:     Pawel Laszczak <pawell@cadence.com>, felipe.balbi@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        rogerq@ti.com, linux-kernel@vger.kernel.org, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Date:   Sun, 21 Jul 2019 12:05:37 -0700
In-Reply-To: <1563733939-21214-3-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
         <1563733939-21214-3-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> to driver/usb/common/debug.c file. These moved functions include:
[]
> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
[]
> +static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
> +					 __u16 wValue, __u16 wIndex,
> +					 char *str, size_t size)

It's probably not necessary to use Hungarian
when moving these functions into generic code.

> +{
> +	switch (bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		snprintf(str, size, "%s Device Feature(%s%s)",
> +			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
> +			 ({char *s;
> +				switch (wValue) {
> +				case USB_DEVICE_SELF_POWERED:
> +					s = "Self Powered";
> +					break;
> +				case USB_DEVICE_REMOTE_WAKEUP:
> +					s = "Remote Wakeup";
> +					break;
> +				case USB_DEVICE_TEST_MODE:
> +					s = "Test Mode";
> +					break;
> +				case USB_DEVICE_U1_ENABLE:
> +					s = "U1 Enable";
> +					break;
> +				case USB_DEVICE_U2_ENABLE:
> +					s = "U2 Enable";
> +					break;
> +				case USB_DEVICE_LTM_ENABLE:
> +					s = "LTM Enable";
> +					break;
> +				default:
> +					s = "UNKNOWN";
> +				} s; }),
> +			 wValue == USB_DEVICE_TEST_MODE ?
> +			 ({ char *s;
> +				switch (wIndex) {
> +				case TEST_J:
> +					s = ": TEST_J";
> +					break;
> +				case TEST_K:
> +					s = ": TEST_K";
> +					break;
> +				case TEST_SE0_NAK:
> +					s = ": TEST_SE0_NAK";
> +					break;
> +				case TEST_PACKET:
> +					s = ": TEST_PACKET";
> +					break;
> +				case TEST_FORCE_EN:
> +					s = ": TEST_FORCE_EN";
> +					break;
> +				default:
> +					s = ": UNKNOWN";
> +				} s; }) : "");

I always find this sort of embedded switch/case char *
statement expressions difficult to read and think it's
better to use separate lookup functions.

I would much prefer something like:

static const char *usb_device_mode_desc(u16 mode)
{
	switch (mode) {
	case USB_DEVICE_SELF_POWERED:
		return "Self Powered";
	case USB_DEVICE_REMOTE_WAKEUP:
		return "Remote Wakeup";
	case USB_DEVICE_TEST_MODE:
		return "Test Mode";
	case USB_DEVICE_U1_ENABLE:
		return "U1 Enable";
	case USB_DEVICE_U2_ENABLE:
		return "U2 Enable";
	case USB_DEVICE_LTM_ENABLE:
		return "LTM Enable";
	}
	return "UNKNOWN";
}

		snprintf(str, size, "%s Device Feature(%s%s)",
> 			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
			 usb_device_mode_desc(wValue),
			 etc...);


etc...



