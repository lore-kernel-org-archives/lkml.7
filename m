Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B7ACA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D02521906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE/cvgYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502573AbfJXNfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:35:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46298 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502516AbfJXNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:35:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so19160597lfc.13;
        Thu, 24 Oct 2019 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FbgSAKuKivrD7KWCdkROt8M8bJsyR6G6H0hxiq2O7bk=;
        b=VE/cvgYHp6gvvcOXN1zR/dYQvbhcECqSyiTlHl7nLxyvhGUKom/dSx4G4GzZ04FDns
         7pwG3mD0oWht3y2FvM71zTDpODrY7yySgxc/54I+TJnN/ell2D8I/xFEDSXMU9D9peC5
         8KZwkIlmdFQExFpiR7pEOuukXh+40S5XUXSDbiGCS0pZIyQUXL5LemXxSzMvU+6G11T3
         dzc+bFVR/zt6ZCaPlgIhA79/U+rRt400ptD3Ox5jPYhUZBRQuowsgSORr9cdVljjK01a
         TZV+mdwR7jbVY2vGsfKwlp7j+5DwwQyK8ihjtVMSt3EQJ047cRY6Eh4V1v5vOfFWQza5
         U9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FbgSAKuKivrD7KWCdkROt8M8bJsyR6G6H0hxiq2O7bk=;
        b=UOHInqeD6qGJ58Ok4nAm/sKiT2f8dFHWEZaHUyMEcO/1abMACHVhq7LuYUstUv7jtM
         kkTYK85DVR+wfyvS9v3IYCAedi8jM2pF152WYpoCCuuyCclr2g7Zy4Fkup3/9ep8SNge
         7WgNVmGfAQIq89z3RPHUVEOFeRBeaAZ1IJoCgYiTp9YOv4SNz/NqMySm+RYbUpLph35P
         bq6inILmDjIQHauMw3fe+515LAAvg8idOftGRNDmdbzyxeDu1U7LYnODAd5d7MzvHSEH
         gcRtFXAF6W52Ct89X6/GVY3BsWlNxBcvQgO+PnX6Y7bhwUN5KT7Ami2YgmlhfEbZOx50
         +j/g==
X-Gm-Message-State: APjAAAWHaGSXB7I61bi5eeO+g5tk01CbkhsLwHnTkfFPcKB4iuguG8Dh
        SOXnK7nAhrAJTK7IRkuFr/l4UMkD
X-Google-Smtp-Source: APXvYqxCvQZdvyAvyjHYR+MpDh+LS9bfFYAbqrYzDsS0aWHkIORftxUxo45a+NeXjvZM3uXh8pwr5A==
X-Received: by 2002:a19:f813:: with SMTP id a19mr11362936lff.33.1571924115321;
        Thu, 24 Oct 2019 06:35:15 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id 90sm8577433ljc.0.2019.10.24.06.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:35:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20191024115016.GA2924027@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
Date:   Thu, 24 Oct 2019 16:35:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024115016.GA2924027@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 14:50, Thierry Reding пишет:
> On Sun, Jun 23, 2019 at 08:37:41PM +0300, Dmitry Osipenko wrote:
>> On ARM32 we don't want any of the clients device to be backed by the
>> implicit domain, simply because we can't afford such a waste on older
>> Tegra SoCs that have very few domains available in total. The recent IOMMU
>> support addition for the Video Decoder hardware uncovered the problem
>> that an unfortunate drivers probe order results in the DRM driver probe
>> failure if CONFIG_ARM_DMA_USE_IOMMU=y due to a shortage of IOMMU domains
>> caused by the implicit backing. The host1x_client_register() is a common
>> function that is invoked by all of the relevant DRM drivers during theirs
>> probe and hence it is convenient to remove the implicit backing there,
>> resolving the problem.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
> 
> I don't really want to do this in a central place like this. If we
> really do need this, why can't we do it in the individual drivers?

Why do you want to duplicate the same action for each driver instead of
doing it in a single common place?

> we already call host1x_client_iommu_attach() from all the drivers and
> that detaches from the IOMMU as well. So I'm not sure I understand why
> this is needed.

Wish you could ask that couple months ago. I'll try to refresh the details.
