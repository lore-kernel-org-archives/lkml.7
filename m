Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F29C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A494E21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfGELja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:39:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:45408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfGELja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:39:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 04:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="155261669"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2019 04:39:25 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, jpawar@cadence.com, kurahul@cadence.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3 driver.
In-Reply-To: <1562324238-16655-3-git-send-email-pawell@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-3-git-send-email-pawell@cadence.com>
Date:   Fri, 05 Jul 2019 14:39:24 +0300
Message-ID: <87tvc0lngz.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
> diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
> index da82606be605..d388a3a5ab7e 100644
> --- a/include/linux/usb/ch9.h
> +++ b/include/linux/usb/ch9.h
> @@ -70,4 +70,29 @@ extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
>   */
>  extern const char *usb_state_string(enum usb_device_state state);
>  
> +/**
> + * usb_decode_ctrl - Returns human readable representation of control request.
> + * @str: buffer to return a human-readable representation of control request.
> + *       This buffer should have about 200 bytes.
> + * @size: size of str buffer.
> + * @bRequestType: matches the USB bmRequestType field
> + * @bRequest: matches the USB bRequest field
> + * @wValue: matches the USB wValue field (CPU byte order)
> + * @wIndex: matches the USB wIndex field (CPU byte order)
> + * @wLength: matches the USB wLength field (CPU byte order)
> + *
> + * Function returns decoded, formatted and human-readable description of
> + * control request packet.
> + *
> + * The usage scenario for this is for tracepoints, so function as a return
> + * use the same value as in parameters. This approach allows to use this
> + * function in TP_printk
> + *
> + * Important: wValue, wIndex, wLength parameters before invoking this function
> + * should be processed by le16_to_cpu macro.
> + */
> +extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
> +				   __u8 bRequest, __u16 wValue, __u16 wIndex,
> +				   __u16 wLength);
> +

where's the stub when !TRACING?

-- 
balbi
