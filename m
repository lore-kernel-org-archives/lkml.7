Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47972C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0A206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlCRUBBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfDBDxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:53:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45608 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDBDxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:53:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5814529pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lal2WHvtJNuY3hfsxdKB3Hc+UyF+52PkMoX1ZCyfv7o=;
        b=jlCRUBBlnP20P4DQCAMtms2plBMcl/q9IhsY/OWk/0iLqrGjUqW4T7TdLUuOGqM7lq
         /DkBGtjiji/Fh6RZra8heqMxU2xsqgaHwMHwnbAE6p++f+gWNESGWaxYA123ll3KjCZ7
         r7H/Mq7gWmEI4aEtXDN2D3NXxeqvSRZ7vwWqq+JFO6KuNwhXhQuEoUy1Zs7VAtwllcTZ
         ZdYDdYyYP49ROMLNlvOs4MEkmtx2btdWAfJBYfs2PAK6ZfpAIncp7wlYAQVExmr/niWN
         wIeDCyrCyWV9FcZsOLLbcauZOAswkUrxB8fyBoOxD3GhIgut/Zqre1H2s09VEEC3dsNv
         DRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lal2WHvtJNuY3hfsxdKB3Hc+UyF+52PkMoX1ZCyfv7o=;
        b=WZCIDKAIUjZ9DT0qXzYS2OpAnACcy2GiL5EDAXZA9bpdz6yIwF5vDzgoXnneJyT1MD
         bNl+HgKFBvyEpXtPO0XjuXWmKuzgAMAPVITLPoCJ5pPs4S01mT68p3sEjtC/G4VPUTUW
         MP9keULKiCBtA2vmRVaUf6Y/HNg/r44E0OnsWpBs8Q5wfCBLXR7Dt+u7QKusf4Qab1n7
         hA88BcPKC6YHYIjxLJy3dH/tL86JbAs2JnXiorLnmdIdzIbXoL488IxRKScVi88UJDAF
         tuBS5hswd+AzpVNuwM50r5c4+lJ2o2gMrzxvTu1OvqKFIWUzyQj+uiIHyF88IN47KFXj
         89MA==
X-Gm-Message-State: APjAAAVt0WgQDrbqFTXj05/fI8L8lfehEYO89boiQhXuvwIX3ESOWLNc
        kYE6w2zhY3/wwabyEBEYqMjILg==
X-Google-Smtp-Source: APXvYqw4X3sAutZmbz6/wstJxUMCVxqJpqTM2zFiUQbwL9CnrSf6G7krTn2j0y6D0oyn8hN+YmAaFg==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr5253116pgr.360.1554177202007;
        Mon, 01 Apr 2019 20:53:22 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id f65sm17658298pff.21.2019.04.01.20.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 20:53:21 -0700 (PDT)
Date:   Tue, 2 Apr 2019 04:53:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: Fix potential NULL pointer dereference
Message-ID: <20190402035317.GJ4187@dell>
References: <20190302212727.14118-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190302212727.14118-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Mar 2019, Aditya Pakki wrote:

> lookup variable on failure of allocating memory via devm_kzalloc
> can cause a NULL pointer dereference. This patch avoids such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/mfd/sm501.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
