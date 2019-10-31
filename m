Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C46CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6722080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BkZAy/ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfJaSAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:00:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33604 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfJaSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:00:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id m193so6000555oig.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtKYhEQC4Du9ORg0zqjtaU+h/BJ16IRRsZXZjPb+rYE=;
        b=BkZAy/ZBtOKgUyoV4BlnRwmrkFVUwptf0qjK350/iJWqZqY8rwPA3w9APbH0Ar7jJP
         Myq453PPrAQqlOPaOz7T8bCWYiZlcmfg6dLRDiCM4s2afyaBSa11EJIquwvpza1TmuJ5
         5lhUvJN5nSZlQ1u6yr/boyPir9JhKQ1XGJpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtKYhEQC4Du9ORg0zqjtaU+h/BJ16IRRsZXZjPb+rYE=;
        b=C2IHN/LoeXykbIpqChh+ixJtSpAcka6xXngnhwTzSGmcrBBDzld6uutaXFSSRRJ7GK
         A9/2Pl6lV0qgbDr5s1AzafvqzsHEO9Kd1mARHo6TRX1ejz3K8RTjDi25OhD6c5jGLlaB
         e5TU24xs2ckRO70+W1czuVVVfbo4IWC8lfBqXmTl9xuEycx9BZ5OGuW+BkIpdW08kAS+
         4LV7FfY9xpGrJZjjPWO089U1/9XwKxs8YEAIXlngP8p9yUSSbLVrj682yLZvWKzq6t/j
         B9/2cHzeqQURBjydCcPPt4H2SxcA/Bd8fNGlxyYHBtsSucsC3ksO4/hSgrR94Lkj893I
         LhPA==
X-Gm-Message-State: APjAAAVENHPIy6f/4UW1EJzkoaxDflmIpoROcoYTOCq1Br+c9xmSmYWY
        +5YNDyYNqUQlnnPhryMj4ZLhWkR3wWxLYDefBM/ZTQ==
X-Google-Smtp-Source: APXvYqwkVSmyXA86l0dDbS+Yn1IaXlPi06qdXQQXqLiaYA2/7QVISqar9cF+ryYJSjy8tYfqBoljcnUAQ9CGHT3N97M=
X-Received: by 2002:aca:c6c6:: with SMTP id w189mr804269oif.124.1572544803762;
 Thu, 31 Oct 2019 11:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com> <1572516532-5977-3-git-send-email-sheetal.tigadoli@broadcom.com>
In-Reply-To: <1572516532-5977-3-git-send-email-sheetal.tigadoli@broadcom.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Thu, 31 Oct 2019 10:59:52 -0700
Message-ID: <CACKFLink_aKX6WreKRT4eotN8Rq3UObJzew8xM_b=e+VZJGR3A@mail.gmail.com>
Subject: Re: [PATCH net-next V5 2/3] bnxt_en: Add support to invoke OP-TEE API
 to reset firmware
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 3:08 AM Sheetal Tigadoli
<sheetal.tigadoli@broadcom.com> wrote:
>
> From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
>
> In error recovery process when firmware indicates that it is
> completely down, initiate a firmware reset by calling OP-TEE API.
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
