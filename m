Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAEAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEA4223BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwUJ16S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfGWKSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:18:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39103 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbfGWKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:18:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so28909487lfa.6;
        Tue, 23 Jul 2019 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0NxHyQROzPmtM9MXJU92pgi742xaCuz41fYcUBO0Bk=;
        b=kwUJ16S0V5k7EU02kr/CfM8B1LmU43mVHOxXD1suA/GpjVpivZVQOiS/uXq939BPUE
         CQaOqs3LIB79psK6khL326adwc2WXBoMuCofFJr1ewYE4MHrxLs6bC6mvXxSFmzs0rdG
         1l/Wz6rNEdLqcTV7iVt70J2uwrTleCC8BuuNyHDNeCSLiwkq5qf8Rx5gCAzFQGSwJfFQ
         wMRptBx5cPQqZpTvbDf/sJAZqsRRmE73OYYwBUEOJ7nieA+/wpnooZrvhLFq7XSz0JC7
         BV/5nOj7VXFdRN6BM0WrK16RhEV+EWPcynLwPtch6bM3HQmuNoeRm/D0YopnjSb6GEjJ
         JQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0NxHyQROzPmtM9MXJU92pgi742xaCuz41fYcUBO0Bk=;
        b=dow71nIeqGlyyyKodiFxh2G/bcQ/XtHptI1Whqn/GY83VSfV/oDmx2uwKpYmlEdOmX
         rsl/GYgNWuk8VqZQkAUe2eL+dUtOaBVs3ynSgqhVDhFlL+n/1M5rM7KUU1nCPpowDmKH
         hb0QeA4vmbMwBSTZLVRjXb7r+cYpFsnm79PWzppbPXgUb5P4yjWShsB6GDyIWX1eT2mQ
         QAyXW6EM9BZ/AMwus7/LL1Fnnd0dnT2wD7nIjZzmpIzHvPbGv0gPfwtYc2nW0r/J7XrW
         VXtpMVuA27qosnNtimL23qZ+YZcveBSy+tSiEbDd/+Xy+Jo2P6SPrm9WibgNuoQWSHvE
         6+/w==
X-Gm-Message-State: APjAAAV3eneMXO0X7iI8hJdq7846S4Qlux1mnz83DxSAFjeN3Ej80xiR
        vU+e1jON62mcGHc7KAZQcE6Pv4sV
X-Google-Smtp-Source: APXvYqxDUeZYnaKfKCJAi3lGD8Cs/bCd1CmQaO7oP9X2eQk8sky3zkWKhY6M4ov7Bvf4WtPC9T4Yvw==
X-Received: by 2002:a19:f007:: with SMTP id p7mr34615262lfc.24.1563877087221;
        Tue, 23 Jul 2019 03:18:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id m28sm7885105ljb.68.2019.07.23.03.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:18:06 -0700 (PDT)
Subject: Re: [PATCH v2] drm/tegra: sor: Enable HDA interrupts at plugin
To:     Viswanath L <viswanathl@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1563787632-19762-1-git-send-email-viswanathl@nvidia.com>
 <11288075-f34a-222c-66da-2bfd13db987c@gmail.com>
 <fe7a0f13-4e85-56db-7629-92c6a8f67014@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5281fd84-bbe8-8482-0224-068b87349aaa@gmail.com>
Date:   Tue, 23 Jul 2019 13:18:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <fe7a0f13-4e85-56db-7629-92c6a8f67014@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.07.2019 13:11, Viswanath L пишет:
> Thanks for your comments, Dmitry. Please see my responses inline.
> 
> On 7/23/2019 6:00 AM, Dmitry Osipenko wrote:
>> 22.07.2019 12:27, Viswanath L пишет:
>>> HDMI plugout calls runtime suspend, which clears interrupt registers
>>> and causes audio functionality to break on subsequent plugin; setting
>>> interrupt registers in sor_audio_prepare() solves the issue
>> Hello Viswanath,
>>
>> A dot should be in the end of sentence, please. And should be better to
>> s/plugin/plug-in/ in the commit's message/title because 'plugin' sounds
>> as a noun.
> [VL] Yes, I'll make the above changes.
>>
>> Please don't version patch as v2 if v1 wasn't ever sent out.
> [VL] Now that I have sent v2, shall I continue with v2 for the next
> patch? Apologies for this oversight.

v3 should be good.

>> You should add a stable tag here to get patch backported into stable
>> kernel versions:
>>
>> Cc: <stable@vger.kernel.org>
> [VL] Yes, will add.
>>
>>> Signed-off-by: Viswanath L <viswanathl@nvidia.com>
>> The kernel upstreaming rules require a full name. I'm pretty sure that L
>> isn't yours surname.
> [VL] My name appears as "Viswanath L" in all company records and email
> lists. I would strongly prefer to keep it this way, unless that is an
> absolute no-no.

I guess it should be okay, but a full name is much more preferable.
