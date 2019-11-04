Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE736CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D7C218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2yVQ/mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfKDHy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:54:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37768 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:54:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so9882968wrv.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 23:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3RH9aKhMCOj6QTRmd89NHsLi2YVADcB75E8Mv/2sWs=;
        b=z2yVQ/mZtfyy1iWUj+6k/cl0a6kCAdgr+Pe8zQowUyjbK4OWqECLs1pysJPTVENjs2
         T6LU0ahnuSsLLo2l4nntm2Ysu0P/WvCSgEFKgLEyLh/rdDelWE6h+4h7KU78TBcDTfkt
         72Y8iJZjS0ih4q+TCyYuYYAuxdpTDd1pps4UimDpoEl4RIC3IiSOgzhwtNZqmmLz7nb0
         7+I2j/YkNtoCG3AvzTQxcad/x+Qtn0EcE3FbvZwHTIt2sKFs/JqXuqyHLRMCC218Luqi
         tCOtrv3rHwmMD5i7EnGvekWmuEsYVt8ZHHYEV7ekcLZu58rBhXwZTvPqwiwQobv/TafL
         CFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3RH9aKhMCOj6QTRmd89NHsLi2YVADcB75E8Mv/2sWs=;
        b=BQdZf6syDDxKt47dSMmFwg7Noir83liEG5VlB3yyKb0NH0TsaxxNj0YfjvP21UyArT
         VGVayJ2hf3pW1ILmRA2atGx1SWW+bfTBw4toF9AiT+2GGpeTJu55uaAiRwdpxkFzhtvW
         r9lTFDek9KewlERR5anaCZf+hIkSwLZJLY6IsciGS0BWSNKVsnKKGW6s+OB6l7J+GcUE
         fSSiXV76WDoWAetyWQM/6bD/S8bjPyIGqrqTEHU5F6lWNdQLQucAQPVKt0YbOb6rTJiY
         P9Xjne4aoHxVWu8g+wnJYyBd+zsgo3MzgL0vub1z4qi/uvUQ/p16hBPZaqi7s7omz9Xf
         M3Uw==
X-Gm-Message-State: APjAAAVkBt90dqe6ISfYmcIjaZQWKcKHTHeRe6a7oBi5cOvQHkfTul8F
        ZIe9ZQh2ftdhLGKTmfCE+xQ3XA==
X-Google-Smtp-Source: APXvYqzwTl0p24NIwpPNLzuLF7ZBZJYcawaApLHhcSd1TLwu+/dFYxfxYP6hXLot3M5Zc/SG+0qPmg==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21547527wrv.119.1572854063846;
        Sun, 03 Nov 2019 23:54:23 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id o12sm7166620wrw.50.2019.11.03.23.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 23:54:23 -0800 (PST)
Date:   Mon, 4 Nov 2019 08:54:20 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191104075420.GA2781989@lophozonia>
References: <20191030145112.19738-1-will@kernel.org>
 <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck>
 <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia>
 <20191101172145.GA3983@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101172145.GA3983@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Nov 01, 2019 at 05:21:46PM +0000, Will Deacon wrote:
> As far as symbols exported from the IOMMU and PCI layers, did you find you
> needed anything on top of the stuff I'm exporting in patches 1 and 3?

No, I needed the same symbols (minus fsl_mc_device_group and
iommu_group_ref_get).

Thanks,
Jean
