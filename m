Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6AC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AE52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+afOhMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFQPIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:08:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51271 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfFQPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:08:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so9683382wma.1;
        Mon, 17 Jun 2019 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=drOUk7hcYTDS3ImtEYKzz1UKjn+tkNi4N2VeCrqXb4k=;
        b=J+afOhMUX1X7A38kJ/Mq04wXk3bCR2HUSF0c35e6343jOrWU5whQeziHmaoVwY1tw/
         Gcz76A6yYukxnM+Rw6T0VDwT0UtdeIw8Zt+imrev/qeF9zafkxfUFYRfwlk7f3cH25zP
         RSTao6CU5b+J3J3idfWMh+l2CSZwKrPsTvb+hnqMoA93wQnCBCut1TxZ9iQa8XJqybe9
         DunKsxP3FoYzn8KaKsqA2WiDQrV12eChAnlmwZcdyH13TrynhBYkcIISe69xVZNbOz/k
         KWbmgCxi6qep/NFShbSmTOA87Dsx7s1uaR6ospYib5RzE1W5FtChadWFNnVzfiozH/ht
         urPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drOUk7hcYTDS3ImtEYKzz1UKjn+tkNi4N2VeCrqXb4k=;
        b=HiRCwtJaxAlpoAe63xjA2WTmnzWlju5+1CX8rv1tEndo9Z+EHU6IGoFmc3G6YSMVqF
         1GNEDn9fMUIy+xfx+KdEVYEpjzG5rPVQBQXBPekVJ5WJcS+lXsvfYOMJtcx4OtxMRcp+
         Bhf/cWFfffPPuG8OZVgT5SzSUmtYdUX8n10AiWirsIaiU2fem+Bj+wBfa7Kt5mhl+8WN
         tBVSCKASMN+2nuNHHStBRWHe7DVXOUn6M8MMAdE8AFlXy4cIbFOr64vPgzDRcx0oRmQo
         Bt1sCeCKyJH/JRpG19uuNYFwolURaOg4nOj8R1EO/j2WmnNZxFp22K7yO+1qBFc8uqA/
         Y1ug==
X-Gm-Message-State: APjAAAXHl25oxx9Syu7HpPNW5IXZVDpICoNMw7/wtPgN/1c3IMnQ7Ui3
        2kigTdXX14GfMDfYPmPoQg12V4T1
X-Google-Smtp-Source: APXvYqxaSrlIaNzQJ9iLsbpcpPsSCclTDkuVNqnj0CDCrMYyJtZV+GwV2vrTmg1tENM9PAcmt3L8mQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr14163099wma.34.1560784094372;
        Mon, 17 Jun 2019 08:08:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id r12sm17562343wrt.95.2019.06.17.08.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:08:13 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] memory: tegra: Introduce Tegra30 EMC driver
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190617082143.GM29894@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <10dd12ce-b85d-7c33-8b10-7c7e66a109ad@gmail.com>
Date:   Mon, 17 Jun 2019 18:08:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617082143.GM29894@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 11:21, Peter De Schrijver пишет:
> On Mon, Jun 17, 2019 at 02:35:41AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series introduces driver for the External Memory Controller (EMC)
>> found on Tegra30 chips, it controls the external DRAM on the board. The
>> purpose of this driver is to program memory timing for external memory on
>> the EMC clock rate change. The driver was tested using the ACTMON devfreq
>> driver that performs memory frequency scaling based on memory-usage load.
> 
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Thank you very much! I'll address comments from Thierry in v5 and probably add one
more very minor change. I'll add yours ACK to v5 if there won't be any radical
changes. Thanks again for helping with the review!
