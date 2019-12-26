Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3201C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B89206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju0iqBtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLZUmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:42:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39285 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 15:42:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so10596462ywc.6;
        Thu, 26 Dec 2019 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g86qrskhZaRGjgxmstzX/LzWZezxaIn6S4dfDOioLNc=;
        b=ju0iqBtCnCnRzhHPSabea6qcNcgjTcoZTuWNuXELMsATmmtOTvqb2CE7WydBM8iUTb
         /gcEOkUclsx6k5jU5kxaokTJWZH5n1jGh9Y1QP3HYvQCs14jVQox0MjJJCZYLW4qJM7q
         xvvWKw2xIQdWge6Ek0GPn5sScOxj2kXuDFkEM1RR0GNatT8UjzizaPTzFFy/bognj0Bx
         YLo0Nty+67EKBWMR+VXnMY6Ec4W5kDjtsTqlrnUElcdptcN9GZ2P5FirxMezi5ZrDpDt
         q3bDVJWS7vg3it6AKzdSp1T+vwqzoWbJ8BC7T7K/X40u4u4tcbF1hW5K9Mna3JiEKT9C
         o7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g86qrskhZaRGjgxmstzX/LzWZezxaIn6S4dfDOioLNc=;
        b=QKdNsetTJ/TA92QyrQhTyiSSr744gkgacx4BxSD4S9zhEuXWFugKDUd2AuFNgbxWRt
         GvEQZP/yYP+SVPs87xKIyVC9Oc+gMkP39OncyoJ78ffYV8qE9TaB1a/jCXfFy0v8MAm1
         abrqwxsKMCZzOvm5XQ8eTjTs9H/U6EDBEoeC2wL/06nHcaqhS/9nlU88lXwskW0AiKqB
         D/YPKsRWNQ37gY8vJ763O/cOHqYHSxao4bsVKvaiiQ6KS5SVjczDwIpG6lwipkJOrYZY
         w8jHj9fQ7EmFqakW+HbOrTW8ZHJg8tz4UIc5t/1JS0XjkH38jFYGsAjU1lcUyJRQWzET
         5ihQ==
X-Gm-Message-State: APjAAAXN6qqgcT0gmZK7frn2YvHlswd/T74d6+YETFBxDExEvuSOxS+n
        gCTg/D5Sgkbi+LEXMD9S1Zsp48w=
X-Google-Smtp-Source: APXvYqzJGlQHJhPxiU5x5y4opucYX2yp8WR5sheWemmFHpMxLNx6Q4Rvb2ghhuSMJDRwFJgqMBtnSg==
X-Received: by 2002:a81:7016:: with SMTP id l22mr34108773ywc.69.1577392926123;
        Thu, 26 Dec 2019 12:42:06 -0800 (PST)
Received: from localhost ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w74sm12626034ywa.71.2019.12.26.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 12:42:05 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:42:05 -0500
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: huawei-wmi: Fix a possible NULL deref
Message-ID: <20191226204205.qzfcmohulcfbcl4e@960>
References: <20191225235841.14393-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225235841.14393-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch I'll be sending another one. guid->guid_string
is always true.

On 19/12/25 06:58PM, Ayman Bagabas wrote:
> We're iterating over a NULL terminated array.
>
> Fixes: 1ac9abeb2e5b ("platform/x86: huawei-wmi: Move to platform driver")
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  drivers/platform/x86/huawei-wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index a2d846c4a7ee..42d461eeeff4 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -784,13 +784,13 @@ static const struct wmi_device_id huawei_wmi_events_id_table[] = {
>  static int huawei_wmi_probe(struct platform_device *pdev)
>  {
>  	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
> +	struct input_dev *idev = *huawei_wmi->idev;
>  	int err;
>
>  	platform_set_drvdata(pdev, huawei_wmi);
>  	huawei_wmi->dev = &pdev->dev;
>
> -	while (*guid->guid_string) {
> -		struct input_dev *idev = *huawei_wmi->idev;
> +	while (guid->guid_string) {
>
>  		if (wmi_has_guid(guid->guid_string)) {
>  			err = huawei_wmi_input_setup(&pdev->dev, guid->guid_string, &idev);
> @@ -820,7 +820,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
>  {
>  	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
>
> -	while (*guid->guid_string) {
> +	while (guid->guid_string) {
>  		if (wmi_has_guid(guid->guid_string))
>  			huawei_wmi_input_exit(&pdev->dev, guid->guid_string);
>
>
> base-commit: 46cf053efec6a3a5f343fead837777efe8252a46
> --
> 2.24.1
>

--
Thank you,
Ayman
