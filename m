Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FDC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F09205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr+YXFbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJHPCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:02:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35851 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:02:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so12231221lff.3;
        Tue, 08 Oct 2019 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hanP64qrgvYP3vcHeIcVDhG/zEHvopBb2ZM93vS38+E=;
        b=Wr+YXFbDG3SuKJgcC8V6ICw1ifCnCImtHQRsskiQ0R+DvOgI7lzWJwXLdjwWrrcld9
         2w6Em2HQOzrhddTgsyP7oyfYqCyuJ1Tfc5bBc/Zd38d8th6Kdutpu4E7w83DSbCrPyJT
         3TgzGwp50rxctT7CwmaLEcPNXj/R+9LhxK/+fV+jpJ3C/2vGN798qQMipU0MpYNhTEjv
         l0WKTRWN9McoM1wZB4MeSHLOm3WnvKQO5Q6MzXCMaeai6kyAY0dxFk1DAE0a+C2+W75x
         FCZ5jr5kG1UV1qtMO9aIVKTJHdeyPYqyqnSvDP5LYPcXlvBctZR+DSqCtLV7/rMyI17B
         ycNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hanP64qrgvYP3vcHeIcVDhG/zEHvopBb2ZM93vS38+E=;
        b=pGISBUnv/024TJucCP8NjUM+QhG/lpLW+xgkDOYAQt472P+M8L3c/z0KpF6f6VLaTO
         AHPt36K6RRJR7up3QZuhBRjmOjEjcGqo5K+DAeZuHw+wvDhwfUzE2sZUIJg1rxIZJEqt
         kCbmdnwJQpOJn9WmVzxUrS+vukiVE5X9HE5bSH9Co4wG2KviN+JKEw2haKdKgjfILHiv
         5U6onnkxcfAaJxvKQGY49uBskqM6Xfgy79HUGdrh59rUzcgbV85bGPKaWHv68wEWvd28
         5MY25LJVZ5HZpbscM3nnmLPCBJBjM3mkzW3fR0tTqiZtLMP7Pf/yvTZ/xebTAVdQP0Vx
         9CDA==
X-Gm-Message-State: APjAAAURI7CRpQUa3i60CXh92RVKvn06B9Fl6KYAvu5647XqfgU2F8Lg
        ZFKLg6XhyU7/TVnZ/jtzm6o=
X-Google-Smtp-Source: APXvYqynG39rtW8ewBqivAhxBMiEYn8Rg0jVcXQa/Zub1o83LOmidrw9zWPspJtxHGVFbVYdYlUwQQ==
X-Received: by 2002:a19:c002:: with SMTP id q2mr21169179lff.62.1570546958611;
        Tue, 08 Oct 2019 08:02:38 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id t16sm4066596ljj.29.2019.10.08.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 08:02:37 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled regulators
 in regulator_enable()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
Date:   Tue, 8 Oct 2019 18:02:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.10.2019 16:24, Bartlomiej Zolnierkiewicz пишет:
> 
> On 10/8/19 2:47 PM, Mark Brown wrote:
>> On Tue, Oct 08, 2019 at 02:38:55PM +0200, Marek Szyprowski wrote:
>>
>>> Then if I get it right, the issue is caused by the commit 7f93ff73f7c8 
>>> ("opp: core: add regulators enable and disable"). I've checked and 
>>> indeed reverting it fixes Peach Pi to boot properly.

Yes, please note that the "ww_mutex" patch didn't change the original logic and only
rearranged the code a tad.

 The question is if
>>> this is desired behavior or not?
>>
>> That doesn't seem ideal - either it's redundant for regulators that need
>> to be marked as always-on anyway or it's going to force the regulators
>> on when a device could do runtime PM (eg, if the same code can run on
>> something like a GPU which can be turned off while the screen is off or
>> is displaying a static image).
> 
> Commit 7f93ff73f7c8 ("opp: core: add regulators enable and disable")
> currently can be safely reverted as all affected users use always-on
> regulators. However IMHO it should be possible to enable always-on
> regulator without side-effects.
> 
> When it comes to setting regulator constraints before doing enable
> operation, it also seems to be possible solution but would require
> splitting regulator_set_voltage() operation on two functions:
> 
> - one for setting constraints (before regulator_enable() operation)
> 
> - the other one actually setting voltage (after enable operation)
> 
> Unfortunately this is much bigger task and doesn't seem to be -rc
> time material so I'm in favor of just applying Marek's fix as it is
> for now.

That OPP patch caused the same problem for the NVIDIA Tegra20 CPUFreq driver (in-progress)
and I resolved it in the coupler's code [0]. Perhaps the generic coupler could do the same
thing by assuming that min_uV=current_uV until any consumer sets the voltage, i.e. if
regulator_check_consumers(min_uV=0) returns min_uV=0.

[0] https://lkml.org/lkml/2019/7/25/892
