Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21597C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E663F20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUDO+As9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgAHTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:18:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAHTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:18:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so4505528lja.6;
        Wed, 08 Jan 2020 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71tYmvlt1/OOqPFBAI/jjpMMYNxkMt5zcCbmPmd2ETA=;
        b=PUDO+As9UymSnClBvDvqSFYHVAkKXUizQpgRHB1mEJKNdaTeowHIAxh41LlWDvHlsa
         OG57rciwPJ3lFnKvgwp9Xy5Bl8BQ+DiURyp1g1S+N/Sekjn1RDo/NrcvoOJyGaC+9/VA
         3NB4+isxt8Ku5KSf2AAwp7wHmIQ/mrVO2Rq4JekZBlmlvxEh8gBtmi7dQ4TxcgPguXTL
         THJyoZK92dkKs44FZrVD5kWt11ASdvh+LHnCbJnAVA3oj73NeYwhdedfe2uQORl2CMYz
         svKrSfQ/vM1svExi9UZ3yyjO1Mv5ncNW7plUA9yl5gO9tkRQ25D9EMfwXXarhdm85DDD
         sLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71tYmvlt1/OOqPFBAI/jjpMMYNxkMt5zcCbmPmd2ETA=;
        b=Cn8gYgYV84infd/xIrjbTN/DfEu+q7Mz7nrHIqQjnDgger/UfeLwXeMv1hQXU2Rvxp
         ErxuPZLyvuI2KQZ4hV+aJpf6oJ7YOgV4cIrtVuttDNQsHqZv8a8ZknHkuxyKJBuoQaZL
         ACnqYpL67BoyHSENK1CgflnzY6NlVOzbPs3dpWDmFhOVvpkOyBOTAMjUCBx5Ejdk9hr/
         JIA+KcyqfZRtsW0B+XFH8DCI0S/Noeox2x1lhde974XSMQYgj62TN9/tEq3mSqI7CO9m
         ItmCKwWlaSWHxDQezKQpoPgzWYF/aEBV191ocrZrYSirxj0jDNAtfSp7jLbAMxooewZ4
         EOsA==
X-Gm-Message-State: APjAAAVSX3ig8qVVwz7WLamvunVe+IdhYULco/yhxSHB5OPhxRXxIzzD
        e/2AzYjPSmhPAMBr9OxWqDwCBOAU
X-Google-Smtp-Source: APXvYqx/i2fcvteVjDObebNcYyRRkA/45O12bIrSnU7Foob/eK5/fQZ2csTYr2BtD92U/8h3E/J1RA==
X-Received: by 2002:a2e:884f:: with SMTP id z15mr3801293ljj.46.1578511110777;
        Wed, 08 Jan 2020 11:18:30 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n3sm1849852lfk.61.2020.01.08.11.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:18:29 -0800 (PST)
Subject: Re: [PATCH v7 03/21] dt-bindings: clock: tegra: Add DT id for OSC
 clock
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f78cc952-a582-e84c-4f80-8baac4ecb111@gmail.com>
Date:   Wed, 8 Jan 2020 22:18:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.01.2020 07:24, Sowjanya Komatineni пишет:
> OSC is one of the parent for Tegra clocks clk_out_1, clk_out_2, and
> clk_out_3.
> 
> This patch adds DT id for OSC clock to allow parent configuration
> through device tree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
