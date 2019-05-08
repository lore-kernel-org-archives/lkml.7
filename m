Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2618CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9455205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqtxi/yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfEHN1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:27:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43283 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEHN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:27:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so12371482lji.10;
        Wed, 08 May 2019 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2D3RG8pXMm+z0HEk76Tz92evizs+d/UqhmcHqQu6yA0=;
        b=mqtxi/yiwaglx8Z9kcnVjlPEnzlHFKooyG01vtm3OqueUr2ldpmOi4OBCKZs+Rj8u3
         +sAqgF6ISrNjlM9QBob5MH1hwcKQ06mehu7RYf0pQKZJOylx3aaT/lPL1emAUeoffZME
         Rk0IujZXNYkIDdbB3TBKQ7x2ZKV/66bwKgJw9WD1q0IfPpUf/8wjzMSXe5uECl1axvtD
         wcGZN6zdfvs3I7PFVoL8456rTrOLaVvFey+2Ka/MoTp2dyiTVwfyzt6bSegArSCpmpbF
         CemykKpi41MiWm1ig+/ppg2Suf6OuURWnx7AVnIK5OGw/yjTOMtNAxnjVEtFuGhZVOSe
         3B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2D3RG8pXMm+z0HEk76Tz92evizs+d/UqhmcHqQu6yA0=;
        b=rK/O0SBtcaD5tKpcY7oMRUaMEE5SMmLXQFLVz+Yr5XZF5ZF4hdTuEBEzlKEuj/KYGJ
         +TtTB4iky5tacUHRuaOBp/wekZPd7ZT7R1BewRnkerX6bQLguYcCe+J+bpY8zRRHZC6f
         zAg4Maua1sgkElb/yuDT9brMjRfToqqJ8w8SxSbaVyoUYzM6CzXkYoaNO9RI/9vvjEfT
         u8gHK9V+H6v+dyEgEuZwyN3hyB2XylogVdLg+bPfgE0cftZOQqvB5dlmfWNtF02zKsc5
         MB8fTpb+rhHxIrxePq3jPQsiJwbrnMSp4obTQ90IU1y7vS6vZ1w7kheZSgj2a4NCp3cX
         KLTA==
X-Gm-Message-State: APjAAAXMrG9AzCAgoTzA8VLqE2asn4eJJ1MtbaOmkwI+t94yo3p7vrEd
        lIQ3kgsmWXSSxJDhExAAz7URBUGt
X-Google-Smtp-Source: APXvYqwJNhl/SS47KTmlnE23qhbggTKV/WCPJsEnQkPRfSj07XNZ+x7u4WiOR3Qys8r6RGxkKXg8XA==
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr14366245ljj.90.1557322065507;
        Wed, 08 May 2019 06:27:45 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id p14sm1019184lfk.24.2019.05.08.06.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 06:27:43 -0700 (PDT)
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
Date:   Wed, 8 May 2019 16:27:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508075848.GX14916@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.05.2019 10:58, Mark Brown пишет:
> On Sun, Apr 14, 2019 at 08:59:39PM +0300, Dmitry Osipenko wrote:
>> Add regulators coupler for Tegra30 SoC's that performs voltage balancing
>> of a coupled regulators and thus provides voltage scaling functionality.
> 
> Same here, what are the requirements this is implementing?
> 

There are two coupled regulators: CPU and CORE.

Constraints:

1) The max-spread voltage is 300mV.

2) CORE voltage must be higher than the CPU by at least N mV, where N
varies depending on the CPU voltage.

3) There is a constraint on the maximum CORE voltage depending on
hardware model/revision (cpu_speedo_id) where a higher voltages
apparently may cause physical damage, so it's better to hardcode the
limitation in the code rather than to rely on a board's device-tree
description. This constraint is quite vaguely defined in the downstream
kernel, I'm not really sure if it's solely about the hardware safety.
