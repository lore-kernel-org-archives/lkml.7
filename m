Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA3C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34FC20863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2NVhLX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfEZSmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 14:42:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41212 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfEZSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 14:42:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so3377592pfq.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S88EltoJvW0HnJQIXBVSy2Mn8e0LGr9vTiSSOx2clK8=;
        b=Q2NVhLX/V/C/lVZq0EZZ4yDM27WjHpoQiWYfJ5JbHajiOfE0tjIUFcTpddLzwy2chM
         Rfld9gOWwFVBI6u3/F7rgJlW00osHhQcX76bIsTm2iazaZ5ef4rB5Fs5QMMto/OTXldz
         X/BPoE6iqeg9FA1EzlduSMN/AfpYfDQ2iFe3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S88EltoJvW0HnJQIXBVSy2Mn8e0LGr9vTiSSOx2clK8=;
        b=RloIwa5uG6H3J5sYz5rMuYwYs7uvp70J0+83Q3y7NkrsUO8iIR9rCIvf3OkYpNx8Bp
         u5GgQhHO2Ds7j/SPcAoDoLaOhZfwNLq52+uo2gHVZFUb0OaPQwnJxFV+QOz4tOv5BjF7
         nAsXpQFSKARLbJnmeTya3M+W5xvEv9my0ZxTi0LNKD/H4S2rerOnGUEwITfzCxms2JTb
         7A108CKhaFPn2szoUNO8NO/0a0nTbwAYjpDdK73/4Oq4xdLcGIfSf6nxZEOfk+I8HCKh
         sBBs7Is2sA6uBNiovU0z87TYQ8VaNDJco1sLJa4pKE1CzUmaeRNM7m+a+2DF9qoeDjTf
         1EAA==
X-Gm-Message-State: APjAAAVPIQuvWl204Y25jS9MWAYd94wsGIgrWPhFWHInNlxyBC1l+GEe
        D4xZ6orl/NIa+irtDwpOVhowTjBGJvIyEQ==
X-Google-Smtp-Source: APXvYqyaZoSVsYgO0quEjzoc5Ouq76hUjTrOkBjooE0FUyoX8LzowTKQ77/Ey+sNsIzlC0QcF5eeEg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr129348135pfi.67.1558896132915;
        Sun, 26 May 2019 11:42:12 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id 124sm9857463pfe.124.2019.05.26.11.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 11:42:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
Date:   Sun, 26 May 2019 20:42:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190517225420.176893-3-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2019 12:54 AM, Douglas Anderson wrote:
> Normally when the MMC core sees an "-EILSEQ" error returned by a host
> controller then it will trigger a retuning of the card.  This is
> generally a good idea.

Probably a question for Adrian, but how is this retuning scheduled. I 
recall seeing something in mmc_request_done. How about deferring the 
retuning upon a release host or is that too sdio specific.

Regards,
Arend
