Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88741C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D31A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCHl/gxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfFSFma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:42:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37406 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:42:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so301911wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/cpf3zq+TFw4UEIBZS68FxYFecgYH1xkj5zf5lev0W8=;
        b=cCHl/gxL/zXc4WXMsveXwVsU3cxUW+ACFRX97VZSnWNLVolF18pOwLb4cZ5wfy5RnJ
         3REAqJcFK/oGI2QJKcdjOZzJo77brsZ933bk0GZFC6Yb2FeFRu/ZUcdxus4jSMt5QMmv
         cb5mKHlWsJqPkUdz1B5NnEwJWJoHUrL5L43sT51FshRXu6kSGA18KFYUDbdIq3gciajm
         RcT5NEUePlSW1DD27FCL//Db+0LRRjSYEJXPvbTgus3ZYx7ERKnhVKaedqbEpQlbN+J+
         As7P0XNVfOhDqFB3DaVhv4y3AmIyWNhEna4XviYfA0OCDgHVzB72f+z0351/UGM/LxtR
         RG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/cpf3zq+TFw4UEIBZS68FxYFecgYH1xkj5zf5lev0W8=;
        b=kUBClavojJmNzytvv45utfp24Fc76wwR3Mb6gUnc9L9cOEuv6eOTX9//IKJeGC3TME
         Zzta+TS3R7Y8CeAvlnR+NMM21hblsW41XZAXi4JkpoU0CZ1XR29CarjZA98ZJdRUTB5e
         fijkd2rBQKd/+OiGw+RTirTdZ5Rt7K0rLYDpx4zkc1fQXCrMQOFTSR7GwPk1vDGfUbRm
         lcd9dEWsok/murltLRzGSJEOw06NZVd3d0QH1UVt8iJ51XjYPqBfRY7muow+++yNlMtl
         oHFDyM5ZNOoYKTNEZQqZ8kZYJxXtcihjm/+NuEhMbVdSrydKdqhWfSv9lO5iqrFNnA+S
         UOgA==
X-Gm-Message-State: APjAAAWUNbzI3CLyPP4Bdg5/WDJuX8253gkoZTZGabSk7t5Xnq9OO7cE
        FoBx7Vt3rsVxRx1sWu+HLL0sYw==
X-Google-Smtp-Source: APXvYqz1GbEe2qolDZxYNYoUdvQZ5fsE8k6qQo1nlTIumvRmIvonzAOQdnQDSY6CuatAS38KNkwUlw==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10mr6205898wmc.40.1560922945130;
        Tue, 18 Jun 2019 22:42:25 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id u18sm293652wmd.19.2019.06.18.22.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:42:24 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:42:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     agross@kernel.org, david.brown@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/1] scsi: ufs-qcom: Add support for platforms booting
 ACPI
Message-ID: <20190619054222.GE18371@dell>
References: <20190617115454.3226-1-lee.jones@linaro.org>
 <yq1zhmeuvst.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1zhmeuvst.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard, Martin,

On Tue, 18 Jun 2019, Martin K. Petersen wrote:
> > New Qualcomm AArch64 based laptops are now available which use UFS
> > as their primary data storage medium.  These devices are supplied
> > with ACPI support out of the box.  This patch ensures the Qualcomm
> > UFS driver will be bound when the "QCOM24A5" H/W device is
> > advertised as present.
> 
> Applied to 5.3/scsi-queue. Thanks!

Ideal.  Thanks for your help.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
