Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D82053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGOyUJU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393714AbfFMRQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfFLVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:46:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so7042793pgh.9;
        Wed, 12 Jun 2019 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MWVX/SDKQ5hCaU+PRwtbuc+mCAPdzcR+yRwlPuU4g8I=;
        b=AGOyUJU0VcKoNIpBvixuxYn4aHrJUXO83cuRwHMEQFBLRJf9DqUjHmABD9e3+IxLB0
         tDwiN+pENIXNk/XuKiiAEuWjTMjUyyL0ARNfaaAZRL7o1t0JruNjEQQbr4doyWOT58nO
         cc+Et+RdXnNPfSlIZ4z8EX1pqCCs6ZWZ0puW7ocRCNo+KGEPT6a7DCLDuz4um3NCDDbC
         gr6F3a+Y4qW/+Ats/18xShNwEI+aA1uwtzZltVJ8zHVofr+T47aMDAehK7BHmECPsvNe
         dJ1ABRyGAEh6XmfYB9RrB0MeuRBKKY4ktWoC8gvlRJkZXk73NEKX9BZWH/mtlu5RPC1Q
         uPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MWVX/SDKQ5hCaU+PRwtbuc+mCAPdzcR+yRwlPuU4g8I=;
        b=jIeQGXJUYR+IAoJhdHaLMu90z/JOyBpCnDtHB4JoiG+ZaUT0UKXqNYt87dwbYhQVy2
         jWN+UqtO8XWb9DpPR6wwYuXL2/FfLfLkqZa0dVesXnKZCgts45VddnowxeDPGDMSIAZH
         8Y6SWt4Xn/xkIZkB14+VbEkCSl6e0xAV+8wGyrnt1KLKCmQ46S85EKPOUNP4bT3HGQUE
         lVOSZqichWxdO5bZ/LOSFi64xM3hz0gHnIW5HtWEENvCUf1A8sfQi0Eh936Pf/PZ5nC9
         CgP9uf0lYBJmIKQTT0Fp08Br6/AKuOiZFRHMiFiAbfDK5rSCUzRGaFpfe+R5saV4LQfK
         N7Bw==
X-Gm-Message-State: APjAAAUQl3XVosOW8f2vE1aIb2eSCa9waG78QKzuQVvjspklRU0wh7eX
        ML5cZk+rjcFD6jjoy3xjJLLdqxJJ
X-Google-Smtp-Source: APXvYqyHfd7kIttaQoM9QuG1xNjOSAdXgcMOFu9Mt+x67Qtt2yv0ktA5jQMTfmOms5FxNyie6J7V8A==
X-Received: by 2002:a63:c09:: with SMTP id b9mr26718386pgl.241.1560375999503;
        Wed, 12 Jun 2019 14:46:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g9sm384994pgs.78.2019.06.12.14.46.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 14:46:38 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:46:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        hdegoede@redhat.com, bjorn.andersson@linaro.org, agross@kernel.org,
        lee.jones@linaro.org, xnox@ubuntu.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] HID: quirks: Refactor ELAN 400 and 401 handling
Message-ID: <20190612214636.GA40779@dtor-ws>
References: <20190612212604.32089-1-jeffrey.l.hugo@gmail.com>
 <20190612212721.32195-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612212721.32195-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:27:21PM -0700, Jeffrey Hugo wrote:
> There needs to be coordination between hid-quirks and the elan_i2c driver
> about which devices are handled by what drivers.  Currently, both use
> whitelists, which results in valid devices being unhandled by default,
> when they should not be rejected by hid-quirks.  This is quickly becoming
> an issue.
> 
> Since elan_i2c has a maintained whitelist of what devices it will handle,
> which is now in a header file that hid-quirks can access, use that to
> implement a blacklist in hid-quirks so that only the devices that need to
> be handled by elan_i2c get rejected by hid-quirks, and everything else is
> handled by default.
> 
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/hid/hid-quirks.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index e5ca6fe2ca57..bd81bb090222 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/input/elan-i2c-ids.h>
>  
>  #include "hid-ids.h"
>  
> @@ -914,6 +915,8 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
>  
>  bool hid_ignore(struct hid_device *hdev)
>  {
> +	int i;
> +
>  	if (hdev->quirks & HID_QUIRK_NO_IGNORE)
>  		return false;
>  	if (hdev->quirks & HID_QUIRK_IGNORE)
> @@ -978,18 +981,20 @@ bool hid_ignore(struct hid_device *hdev)
>  		break;
>  	case USB_VENDOR_ID_ELAN:
>  		/*
> -		 * Many Elan devices have a product id of 0x0401 and are handled
> -		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
> -		 * is not (and cannot be) handled by that driver ->
> -		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
> +		 * Blacklist of everything that gets handled by the elan_i2c
> +		 * input driver.  This avoids disabling valid touchpads and
> +		 * other ELAN devices.
>  		 */
> -		if (hdev->product == 0x0401 &&
> -		    strncmp(hdev->name, "ELAN0800", 8) != 0)
> -			return true;
> -		/* Same with product id 0x0400 */
> -		if (hdev->product == 0x0400 &&
> -		    strncmp(hdev->name, "QTEC0001", 8) != 0)
> -			return true;
> +		if ((hdev->product == 0x0401 || hdev->product == 0x0400)) {
> +			for (i = 0; strlen(elan_acpi_id[i].id); ++i)
> +				if (!strncmp(hdev->name, elan_acpi_id[i].id,
> +					     strlen(elan_acpi_id[i].id)))
> +					return true;
> +			for (i = 0; strlen(elan_of_match[i].name); ++i)
> +				if (!strncmp(hdev->name, elan_of_match[i].name,
> +					     strlen(elan_of_match[i].name)))
> +					return true;

Do we really need to blacklist the OF case here? I thought that in ACPI
case we have clashes as HID gets matched by elan_i2c and CID is matched
by i2c-hid, but I do not believe we'll run into the same situation on OF
systems.

Thanks.

-- 
Dmitry
