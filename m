Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36FCC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7262620882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnGdrDwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfCaMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:20:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50551 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfCaMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:20:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7314982wmi.0;
        Sun, 31 Mar 2019 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rq2qnn47mauf8TSFP+D7lgLChm4pd89KV0DM2soDP3I=;
        b=jnGdrDwfg7M5HzN3XLNHEOw6HtVDwy89Kgd/OS++ujZk09XStQZrQu5ml0G3BXxvEG
         C/NnVvfnVwMC+fXkqkUbXtaMV1ojWztrTZoq2oUSrIvDyJPDTvf6MbqXzJAhdKoN9oGb
         17P6QDQ2UxRo6tDpBLcPKMsm18Rp5rr3efF69wFoPS+l7KoINv05073lOSPkaeuj9bH4
         PJV7efWJ/SlpSq2MwZnEdYoYe9lgJSo+qE8mENyIvoD70tgXfmgRcffIUiXi6lcFMZdO
         S4W/WkYXtkqX2Z7F15Z9DvSy6fChE80LdQILfxQS8jVTVmfVZrge5vehJaBcWfgQ1839
         RTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rq2qnn47mauf8TSFP+D7lgLChm4pd89KV0DM2soDP3I=;
        b=q2EW19KfPWSuqTrZjEqYdqy05awhuNOiLLBgGXYbkVSdgIkL17Oip0WXR2JtEbMcrM
         SMx9NfBdjpCrUyws6Gj2UzLe7rllXvk3qMnbAllOliJHP9ZjPbVlFAmLIn9EbS/Q4sWd
         XSZ/EG/pIBpYn6De2RPcYHLz1Wt6VIj7yGET0KuJkoea32WEjvCz7WAuCVUwX7I6YBhL
         wCoDHJeEU+Q6jQbGccM3DK94IE42wGOXWVra+RQJbuFMaGN6Prltw4Kkxg6X0YA1g+Zd
         LxQU0bP1tDoT0S7kiU+RRVeWMBXEf1LmplO/IiU1zGRgkQ9mNAzqQ/WMQUEYgqYiOSLZ
         Crbw==
X-Gm-Message-State: APjAAAXenk7zGZuht4VQKjh6x7VckQaKOyR9bAvdIiEBJGBHHt58FI6s
        rFnNJMZymV+2AqH/1wdwMw63zFCeufE=
X-Google-Smtp-Source: APXvYqwW5Nee+QU+jol70jZKFDrKI46q9lTBcwZa8VsZ+VS+EB+BYhzVRCwUIqXFTlucUwUBJKdjLA==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr9565138wml.115.1554034830973;
        Sun, 31 Mar 2019 05:20:30 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id g19sm7249287wmh.17.2019.03.31.05.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:20:30 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:20:28 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/8] fbdev: sm712fb: fix crashes and garbled display
 during DPMS modesetting.
Message-ID: <20190331122028.sfdbpojjxdwjuvp2@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-7-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-7-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:02AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), blanking the display
> or starting the X server will crash and freeze the system, or garble the
> display.
> 
> Experiments showed this problem can mostly be solved by adjusting the
> order of register writes. Also, sm712fb failed to consider the difference
> of clock frequency when unblanking the display, and programs the clock for
> SM712 to SM720.
> 
> Fix them by adjusting the order of register writes, and adding an
> additional check for SM720 for programming the clock frequency.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
