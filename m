Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6261C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B620665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="2FLKiWfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGHIam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:30:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44664 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfGHIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:30:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so10288612lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ztkKFuoNyYWW8TvhBAfe9IkmKE0E5S6jFYK6qsfI+as=;
        b=2FLKiWfJ6TELTzv2UmKaQ8Ce56VitiUoFyz37Mt8idG0Tcb4aShmNk9A2xRnAANDpr
         Wbg75xrRLdbKNJ9uoFgb+pO81pUcwd90P8+6xsLyLKWhMtbPz4bHKlO7X4f83xbPsAp5
         f9Uz94axmque8KceNcL14YcYjqYwtHUYfXJeO4UHb9UbtCRYUUpB7JCRQpgzt7IVzHKY
         7a018YhWOu8XMrX6cE2ddTJzD7zApYVPIwACOiH5/sw/WWJIt2l45fcdutxjIl6JVqaI
         jJ6fM+bdvubDrKkV6uQ49DLMg1kEf+q5pwn2eFlIjWPdOmwIfNMSHbu9bt/fkcAC/Gvv
         MvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztkKFuoNyYWW8TvhBAfe9IkmKE0E5S6jFYK6qsfI+as=;
        b=qBP5b1bT4W/P3DcmYIliKC7igcLvva26zcnEn9tagqH98Cr4oNy+BFIHsUS6MRFIlX
         LHtULMmvq/jtnUdFe1Nh28R5XS4UFZUk0sS6Sw/KsThGmy/PIDqLVu0FJ3ZfPrbL9uJC
         tveeT5bMtRsuYV62zfYuRxRnIG6iIPXtkl+QQsYUUUzTtjEbbF3MPz2GXIxVKoo/XYXo
         bWhvZTJE9yt/mTUkZMJr96jqWLSpc/xpNRTEU8lMY6n3PNc+6LTxcic0vKfJmI78SC0T
         wrEcK6ns3mUlLlHuB1Y8ewli8UDLxbcW13GD5UvaR8jgfIpDGwvsEB+c79aXCOT6Qlm/
         0BFA==
X-Gm-Message-State: APjAAAUHmmIequOnR8+r3/lBo6We9zcqqad3A9ogN8LuqMiF/qRWq6HR
        dNk8MwcFwLQweHKZT11NFY10KUC1QZlsWw==
X-Google-Smtp-Source: APXvYqxI1tVn7Kh3jFQltkzQRum0mRc1xHVC7YeMg/XXBNxCzrBu9D7uRCAaeKQOWInbA16ct1+25A==
X-Received: by 2002:ac2:455a:: with SMTP id j26mr7890772lfm.18.1562574640173;
        Mon, 08 Jul 2019 01:30:40 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:80a:6f53:f8ef:3097:c1a4:9983? ([2a00:1fa0:80a:6f53:f8ef:3097:c1a4:9983])
        by smtp.gmail.com with ESMTPSA id j7sm3887470lji.27.2019.07.08.01.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 01:30:39 -0700 (PDT)
Subject: Re: [PATCH] usb: roles: Add PM callbacks
To:     "Chen, Hu" <hu1.chen@intel.com>, hdegoede@redhat.com
Cc:     Balaji <m.balaji@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190708022514.7161-1-hu1.chen@intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <699cc89d-7366-c167-4295-5153ab7b5716@cogentembedded.com>
Date:   Mon, 8 Jul 2019 11:30:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708022514.7161-1-hu1.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08.07.2019 5:25, Chen, Hu wrote:

> On some Broxton NUC, the usb role is lost after S3 (it becomes "none").
> Add PM callbacks to address this issue: save the role during suspend and
> restore usb to that role during resume.
> 
> Test:
> Run Android on UC6CAY, a NUC powered by Broxton. Access this NUC via
> "adb shell" from a host PC. After a suspend/resume cycle, the adb still
> works well.
> 
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> Signed-off-by: Balaji <m.balaji@intel.com>
> 
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 277de96181f9..caa1cfab41cc 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
[...]
> @@ -167,6 +168,30 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int intel_xhci_usb_suspend(struct platform_device *pdev,
> +				  pm_message_t state)
> +{
> +	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	data->role = intel_xhci_usb_get_role(dev);

    Why not just pass &pdev->dev here?

> +
> +	return 0;
> +}
> +
[...]

MBR, Sergei
