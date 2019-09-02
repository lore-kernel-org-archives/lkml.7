Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235F9217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5PwGwBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfIBQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:06:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfIBQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:06:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so7674158pgv.2;
        Mon, 02 Sep 2019 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sxgseS6plewEfEHDjM3waRPe5YrFalTRTYQNjb7uPp4=;
        b=L5PwGwBs6FIZzKkWuxixRG5h3DDv2/Y1yKCo7SukPtJ69w25uAvYo8omFQgvdrL3Tr
         j9K+Zx8ZwqImF3qGBxgxxYMqNZG5ogPFVvG+jCpx+mQVl7s5+LoPRxuDKJtxogppUVyK
         R2IDKLYAM1BnrHjSw3ahwCWAVRyJkgmhAjO5J+uGMqVFHLm9r+jXi7mUqO6pViz24Ga+
         6EI138rjXXtmxYlWEKLxe7eJ0f6Idd1HLEXXfZBOrkbE12KKxreBKPW4LUK35JadQqWu
         WRvZt7meq2D6Zt8xzEOyldGbKckWN/RHKUZaSWqwSlxD10Ya0r9QZs+I1+V6VWAD5niR
         4wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sxgseS6plewEfEHDjM3waRPe5YrFalTRTYQNjb7uPp4=;
        b=K2vveLKT5Z9NRoB7JyOomS8P+sEOy+Wm+hfWCZy7wxQe+5ZxTV9DZ9LYQymSczHW+D
         nZmqFFwR8Ko9GPxuTHjW3qEJxYx2BYTQQO8wLVyo8XKg1idvkq4F/9CVDzONTR8CZn2Y
         OjM0Fvf8d2gkZrjnaa8E8+r0d1dh+ZSyvD0WSbd/pBKYJkdG/UnO0QBPAs9+hv708fhs
         RcD4vgvJquwqb8T1YEr+pDt7hUnt3tEnSC8KJFF0rwB/6U62br83Gevf4tOXJ3dPI5Dx
         Lqx2axBlEKX0X2N4LplPJlQQPB5DpGBEy3LEC3R1eziakIZQDSmVMajNKh+j33kf8Al5
         Zswg==
X-Gm-Message-State: APjAAAU6iWDDuSUYxUWJHYDANPpw1/MriAHjDolzxV21M2QmVNkh5Y2B
        71dmtxsMI4l4/DhyQ7xXGM4=
X-Google-Smtp-Source: APXvYqwqPC3RGR7rMKL0EGNwbK6QjUDTu5pYSnt93ij51dgyCiLk7Mp1Onc8LkVJhN8faPqnSCSjpA==
X-Received: by 2002:a17:90a:3aa3:: with SMTP id b32mr3135171pjc.75.1567440393554;
        Mon, 02 Sep 2019 09:06:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm11662476pjt.32.2019.09.02.09.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 09:06:33 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:06:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (as370-hwmon) Add DT bindings for
 Synaptics AS370 PVT
Message-ID: <20190902160632.GA16274@roeck-us.net>
References: <20190827113214.13773d45@xhacker.debian>
 <20190827113337.384457f6@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827113337.384457f6@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:44:57AM +0000, Jisheng Zhang wrote:
> Add device tree bindings for Synaptics AS370 PVT sensors.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/as370.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/as370.txt b/Documentation/devicetree/bindings/hwmon/as370.txt
> new file mode 100644
> index 000000000000..d102fe765124
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/as370.txt
> @@ -0,0 +1,11 @@
> +Bindings for Synaptics AS370 PVT sensors
> +
> +Required properties:
> +- compatible : "syna,as370-hwmon"
> +- reg        : address and length of the register set.
> +
> +Example:
> +	hwmon@ea0810 {
> +		compatible = "syna,as370-hwmon";
> +		reg = <0xea0810 0xc>;
> +	};
