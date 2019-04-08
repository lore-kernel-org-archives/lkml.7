Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D126C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqfqPSjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDHMqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:46:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43163 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:46:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id g7so9347493lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bigX4NxJR3ppFdZ1nlnRZZ1fUrma27Xk5kOgi8DY2XA=;
        b=bqfqPSjymjI7P3THMQoryspJAOgqZrBf+nx+bqlAJQYeYtcaWxyPP7MVp3WvQ6j5Gi
         i6Q9B7zFV/i2CDo5Nj/DQLUPXnGAoBDhkXO+KMII87vS+B2b1F0WYNYqv3HEUq6/I9Od
         Y8QjMLNbrwTzwHH+jmiRaVnfnZbVMmYlxbH04nElf1JnyZj/QfpHFA0UFda2pq3kEPcC
         Yuoboij9igXzwXSzNk41L7L4e1VuoNK1LreledLE+plTxBhEX1fbYh+wkiqNh8Rg/9z9
         fXmvL1fl+dqT8Y5f8W9AFC/lr2rkLrBAMWT457yaYamH23D62DHKxt8taREx06WiHABF
         wREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bigX4NxJR3ppFdZ1nlnRZZ1fUrma27Xk5kOgi8DY2XA=;
        b=gKK7+RRhItGhqFQFo21PSVNSVo1rj6UXaGn3X6J4wQgZ5RhpGQuf4fElhoE5yPut6U
         rmbxgLPrq1xOgOsNAa7td1RIiXAh3ee+oNiNBkHRMIlGlIdXKgcACsKJ/6qKpMhERZTT
         fU9RxzNDcOZxh+1pBJ/W0YUeP85/rUUQ+TB7rucW9UEBTOgwmrQjKDipQsNAGRD6IkDX
         ifl/CWau2OonsW/JTBWP1II5tJiKhpyWJp2FcJtka6OgtAQI1+8BGJ5J/oV47KNCjiUS
         3YkAkGKU6bB6NW9E2vSg9zZknENvVb5Rz9EuqgCHLqX3cVu1CwrP2nLhZDl8OxgrlYqc
         ro4A==
X-Gm-Message-State: APjAAAWT9EMjgK1BdtpUtY/7Qv8BiATwJfm8vVbQvCWWvUbVS0QlJo5F
        YVcDmW+q3MplmGfzPKFsLjGAkG6MX6Bzw1s9CAyK4k3j
X-Google-Smtp-Source: APXvYqxQcCcdXcRoHdIzW1pK3kT74897T8WNIOtUT/jBdaYoqpL+c/pa5gS/pnMBaq+rq0oTPOzhwsZZ3gtn69CfT3w=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr16036357lfk.138.1554727579298;
 Mon, 08 Apr 2019 05:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <1554383739-16050-1-git-send-email-Sandeep.Singh@amd.com>
In-Reply-To: <1554383739-16050-1-git-send-email-Sandeep.Singh@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:46:08 +0200
Message-ID: <CACRpkdaDbUULRDfTet-zLtyH6oeJijHDYCUewY9RfmMMtw+KEA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Added IRQF_SHARED flag for amd-pinctrl driver
To:     "Singh, Sandeep" <Sandeep.Singh@amd.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 3:16 PM Singh, Sandeep <Sandeep.Singh@amd.com> wrote:

> From: Sandeep Singh <sandeep.singh@amd.com>
>
> Some of the AMD reference boards used single GPIO line for
> multiple devices. So added IRQF_SHARED flag in amd pinctrl driver.
>
>
> Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>

OK makes perfect sense so patch applied.

The patch itself looked funny when I tried to apply it but
as it's just a oneliner I managed to fix it up.

Yours,
Linus Walleij
