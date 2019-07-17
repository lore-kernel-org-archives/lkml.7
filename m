Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21C0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdi/CahG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGQVdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:33:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41873 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfGQVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:33:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so12692398lfa.8;
        Wed, 17 Jul 2019 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7+kBt+hpNhWnJDSLaCc/NMcKRejk0BMADoCKFn35+w=;
        b=Tdi/CahG8ijMQcPkUT02t/B0oR52AFbT0HfmQx7mD9Ccskl/CD9Rl3i31T0rNfORMW
         RfmNzSLClbMnxUgHu9+H3DV+XDh/4lqQlLnUrPKb8AravmG/FkMJJRv68qlgPnmKM5O9
         3P5sI7dQTaFQwyoOd1WjgpqDIf8laepfm9b2Bw7YxoeVQ00xGtGi26FhxglInmqlwi8T
         cP/eosqKTsVjU1LQJpPEVH1esRBsKWmbm0zoA6WrpMZ0yibmtXaxYJCxoiJj5ISkosJo
         60m+2djBU0RqpSPs3r+x0Ly2+zL8H4DPM/yHb8kAtitUxQrkTV8y+f3Is1HqZuJZsXNI
         COMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7+kBt+hpNhWnJDSLaCc/NMcKRejk0BMADoCKFn35+w=;
        b=p22dqkjZ7vJnu6/llKRGePTjntJTNXIK+K9wAIKjZ7To0PDJRKVG/0dx0Xs/Ax4ZZ8
         xTr4C3vRTGT7BPEVx50C4rM3KoWjQzlheAABS0NiMzhh/X6/mX44jWsr179DzRUKkIj+
         K1YLswGYr0SO9WNp9PAQwIicb2VeM7SqeTp9Gn84lryJbeJqscHmPAvT9moDri6PP+eI
         wCGLYJZ4YaVEs599B8/1B5Een7vRFZicitFEnssj+Ww2ufRA368qnhKVxszRPU3aT8bF
         nFE+OGZttCfCq/dTAXC9Ta55g/5gDJ82+YYgSHHaoLVXvwPBbRp6xXk/IjVCICFq7BNp
         oQDQ==
X-Gm-Message-State: APjAAAWwNjDfAKnuqUeELopL2bb6kEf0wvrCN4da/5RwArmS2MfwYyQO
        rL2eY35gfGF5AuLJOOLLCrYZ62yX
X-Google-Smtp-Source: APXvYqyWWJdEJH7Bm4om2kS216YUtwKzy/nbcJHZXwjv6rdN2qKWUcAVlHl30YtAlrutbuxByQx+Nw==
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr19243516lfo.107.1563399217552;
        Wed, 17 Jul 2019 14:33:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id 11sm4689925ljc.66.2019.07.17.14.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 14:33:36 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clk: tegra: divider: Fix missing check for
 enable-bit on rate's recalculation
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190715173527.5719-1-digetx@gmail.com>
 <20190717200821.A77A120818@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ca05abf7-1486-ceb7-91d6-266640eea69e@gmail.com>
Date:   Thu, 18 Jul 2019 00:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717200821.A77A120818@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.07.2019 23:08, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-07-15 10:35:26)
>> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
>> have any effect in that case.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Any Fixes tags for these patches?

I'm not aware of any actual bugs that this change fixes. Probably better
to just s/Fix/Add/ in the commit's title?
