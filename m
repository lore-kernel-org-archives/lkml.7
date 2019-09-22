Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F31C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6A2208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gFi6WBCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfIVW1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:27:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIVW1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:27:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7837014pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=4122js9VzeoHge4cdqVUvNxYMN8/LRqY7OEquLQFbJQ=;
        b=gFi6WBCT2RXWKrRM2WOLIRmqm06uTxsTjzM9ZkFHUuOz5wtfUQDFEUjXiaTB1i2YQP
         yt8wVUq0pvqZ9tuwaNeCBnCBHtEYN5iua9oR7D+rGvqKx7SbmW4hjEvgYa7p4ebKu1TE
         +JCyq6oCJXJ5rnvPbB+PdoS+zcl/9VGsPaYp06k2rKvV9rYXtCMrOdb2xDY98MiUhvCD
         lEdSdAJjkaDjDL72MyFSCDXHxJ4+2rZv+3BblS5n5sXm9VD8xbh7OS3WClnDaLMSFz2L
         qW3fp7zExm6H2WKT8G6wBIRfo75pT/AbrDU2zGH0UN9Kjzf04FGpSeEmK5h0WazJnenp
         v0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4122js9VzeoHge4cdqVUvNxYMN8/LRqY7OEquLQFbJQ=;
        b=SLrRkkujEi1OigJ9a5p0vs3Qwdqs3BQDL+A8TfJI6VB9Z/crVccDYFbpbkn7rtiAkv
         Uuq+oJpkAC3rd5ttKatYoMm7gmYar2TpkRB+WXsK+U/TT00G2An1C4OyGkwnT5PsbTtH
         oqNjgp3KVKRKBGSY2mVu7zrwj5OrGLUZmzRqua6CTeWAk4Sk2hqn36tWCv3PCAKtWtVL
         VNvEfuywUNUxPjHIxEuyzkDVsG2smrxk02ngHOqcAMDr+CH8qqjD2M7bpZlXuyz+ZDWC
         U0RxXvo5ik5jl6+7sX87EZxSbLnp8FhsHle2AwAobepUnOYQsNIZTJxnpYbcEQwRUfz7
         Qmmg==
X-Gm-Message-State: APjAAAW0h6OXyCvLBlBDkY0qrEni7QRIfSDelHt2shXTBMND96ftqtUk
        x78GPQPTCx9lGX4dKaLW9FyiWw==
X-Google-Smtp-Source: APXvYqzyICwgu2nsF0p3uEHmrh0rScEPh1VCeMpKC62Xdw4iwuAiKtc/bOayJ0c7xkb5C7wzKV4toQ==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr29467462pfe.109.1569191227648;
        Sun, 22 Sep 2019 15:27:07 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id u10sm9477135pfm.71.2019.09.22.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 15:27:07 -0700 (PDT)
Date:   Sun, 22 Sep 2019 15:27:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Use the correct style for SPDX License
 Identifier
Message-ID: <20190922152705.59b66b0c@cakuba.netronome.com>
In-Reply-To: <20190921134522.GA3575@nishad>
References: <20190921134522.GA3575@nishad>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019 19:15:25 +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in header file for Distributed Switch Architecture drivers.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Applied, thank you!
