Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FFC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CB720881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJeeRdyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBCFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:05:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBCFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:05:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so6892010pgn.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GkukRNl2S7AKUKXitorWgt7om1NyQvPM7opONDpmqPY=;
        b=rJeeRdylJOz5NeR9L9X3bJI26hQEjwb18eXhnGmp8pjy5+jWI9pgWlkOLZ0o2m/OcB
         jN7o/ya9MPvlixbTkl2XRXqWDEDWjl5Ds42PG/Wckv8t///EJpk3/tf+C/gjvbRyYh0Z
         P3GNpljXNtfh2WBb5+OAZb0iiSI3WkYz4nAiW/q1yTyZVg1J0eTC+wBe5Ew+ISOQJBHO
         BYn0s5IE9xb/QHxpgtYaPQ5h5M91ZJ2u9Czv+xkPupREJjpcIKlLrnLtmGsmgHo9qa4Q
         M338Ns28ORRgsjB9Lgvjaf3Jgxk+gdg58jTJijW3h8JSgi74heA7U/shs+EVocAri/mH
         d6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkukRNl2S7AKUKXitorWgt7om1NyQvPM7opONDpmqPY=;
        b=OGeG5DPtdxbD+GIDKAbd6hHGvGQAr2F/Xrka+WxEKGJYPS7yLRFVGQFjFagGk96kUy
         ge70FeVMWSsYoR/cEDd8KQTjQ2+b/4C7qP/bCDGDshR5GA0+/458aHpuWKganyoUbHpT
         ANopeEcaWtQiHX3sfUTwGS3QDKcb3Z5EWAH27bPv4Fti0fFoNL/WUYw4JGpmtY/3ljcV
         pqTItjAYDcVlnJRguXCQIo3uK/9Xqkfqn5Jfw1sw3MIgQdMjBQgDXTu7UvWJ2OuN5Vbl
         WpLe9/KIdrG/11A7L1LPSFaaGAxRVkbrDGlq+asPhWom3ES43c3JNZbis9O3mQ7aWk4H
         oU+w==
X-Gm-Message-State: APjAAAWyYq34LBSmDMuOa8EAILhJ083IcLnYvINdme0C5dA2A7LC2TTL
        Jt1pHu7QqgOrwe+ZFfqTZSC0pg==
X-Google-Smtp-Source: APXvYqyPgKu+jIUNPCSoiBBTNt4IHiwOHu/QQGgwn9U3xBo9NbJ70oCRf13HF+icPFpm5l4tunLnhg==
X-Received: by 2002:a65:6541:: with SMTP id a1mr27540440pgw.409.1562033102876;
        Mon, 01 Jul 2019 19:05:02 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u23sm12678065pfn.140.2019.07.01.19.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 19:05:02 -0700 (PDT)
Date:   Mon, 1 Jul 2019 19:04:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: mdt_loader: Support loading non-split
 firmware
Message-ID: <20190702020459.GF1263@builder>
References: <20190622012146.19719-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622012146.19719-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Jun 18:21 PDT 2019, Bjorn Andersson wrote:

> Typically the firmware files for the various remoteprocs is split in a number
> of files. But in some releases these files are available in their unsplit form.
> 
> Extend the mdt loader to detect the unsplit firmware and load it transparently.
> 
> Also expose the function that compose the metadata header for validation and
> use this from the modem remoteproc driver, so that it can support unsplit files
> as well.
> 

Applied the two patches. Thanks Andy & Jeff.

Regards,
Bjorn

> Bjorn Andersson (2):
>   soc: qcom: mdt_loader: Support loading non-split images
>   remoteproc: qcom: q6v5-mss: Support loading non-split images
> 
>  drivers/remoteproc/qcom_q6v5_mss.c  | 33 ++++++++---
>  drivers/soc/qcom/mdt_loader.c       | 88 ++++++++++++++++++++++++++++-
>  include/linux/soc/qcom/mdt_loader.h |  2 +
>  3 files changed, 112 insertions(+), 11 deletions(-)
> 
> -- 
> 2.18.0
> 
