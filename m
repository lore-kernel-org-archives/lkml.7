Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F355206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSx8i6Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfC0R3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:29:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34182 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfC0R3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:29:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so8658738pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b74V/0OwQbSBs8jcShaZRpUMutCOweQ+Ml+pMHVBMz8=;
        b=nSx8i6LpW0AN7ZaGOLBBI/NDoJwfIDafz5zLjyudBSKQQDZmOFmLn9j7gZPSNaTh8/
         wFZCc9nCRJM98yQaYDEwJBIrZrJ0mJvjhf7b0xmLRjFmoPFPULSH/WUIgR+aVDwuU+9j
         vu8VgbPh2XoY8q8KbaesNDcUEnA4Fdobl9Ccc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b74V/0OwQbSBs8jcShaZRpUMutCOweQ+Ml+pMHVBMz8=;
        b=K8sd0CD2fOowf76Wj0xRX1fXQ7Po7TbqRTxsjtZUyqMQYDxpRrpTB5LGrvdMRsWH0o
         rykM3dGoyqUvHBPWeRP2U23Eys5xG+rtAbKMU+RlIz2a0KApDN5WTNR4ut1IoWQvgt3J
         lCUXEwy/w2rxMoAjPnJUfupQ1bmR4JqqTlhAG20fQ3tqLnPhtRdvQzUYeU/4zgoB44NF
         sPGDMwng+BAiNKIuyDFgBO5hvaSWJiuw1Udv+sR67vj2ewqjdXsJrcV6tzVSX2rDdvxz
         UwUQ9p3l1chQQKjMU1Yqfms7BfUDmzSp54pFTnOf5Y64+8GrkM3eHreM5JVHok6WoCAM
         O5dQ==
X-Gm-Message-State: APjAAAXFLrBkIeFoBDWtMkecC2OTGf+0l3Z7PZ1AiCNfZuyPpYTiYFaG
        wsG30kBSXQB39tner5L4GH3KHA==
X-Google-Smtp-Source: APXvYqw7wH/UoDl65e3uBkVqUW1sb5II2QTNP/njpyxiqhTDgGVw8AavRVdfbqvYZdkpFLutmDBRtA==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr18629273pga.447.1553707747190;
        Wed, 27 Mar 2019 10:29:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u62sm59161521pfa.124.2019.03.27.10.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 10:29:06 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:29:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
Message-ID: <20190327172905.GE112750@google.com>
References: <1553689723-21017-1-git-send-email-c-hbandi@codeaurora.org>
 <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:58:43PM +0530, Harish Bandi wrote:
> This patch enables regulators for the Qualcomm Bluetooth WCN3998
> controller.

I commented on this on v3, but you didn't update it:

  No, it doesn't.

  The next version should probably say something like "Add compatible
  string for the Qualcomm WCN3998 Bluetooth controller".

Thanks

Matthias
