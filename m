Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90B7206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGwpRHEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJHRFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:05:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHRFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:05:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so18353968lje.9;
        Tue, 08 Oct 2019 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwJ1hZvta6EOZ00P9vyRDrTf5gBQEKDe/oC17yzs81Q=;
        b=pGwpRHEfUWNjrxhIDtIjNvEBu2Xg4XNEAmN4gKj558qWm0ocdonn3sjLOrjCumKCwk
         2C28TgTG4w/0VD+lFlaWbIa5rRWYd7E9BBBug6m3iJAtmxu6AccXl19ROT1cB2nnCZ6M
         nTqQSoGaccJw5HQ5w8MAgd0wFwCTcJhS7bLgk9iXybxSLKYUFVzbizlYBaw/2b8pm4He
         BpFiOIZjlgDJNykGgc7DmjSbDlzjdkmlOBBqztmYkq5lfXuZnssJ/8gRqXWjfN8MHrR+
         Qc7ub7O28Z8YKbG1Kc00/xNywfMz9+IGN7C6VuDFzg46fIC5QIHcHPE+l8B6D8Yc18MK
         uDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwJ1hZvta6EOZ00P9vyRDrTf5gBQEKDe/oC17yzs81Q=;
        b=krubnlyaY4VPYVJGLzBwgJ47WA+1KpqDFtdZZ7ATd+UciTdX8IuYOmxkLI78OJ+evx
         k+s0udv9Uq7aH4LfcWrYppGh7WzlDWACY1IudWskJUIfUt8leCoapuoznNcmWGaR8f58
         V9lZTR3R3QcKZZMjkWueH4GDBIyV/oJ2Fhd+JLqZo5/Al2gJo3cMtiaDv91jhfonisWi
         ufL+LVMBfKP6/WBMu+oNGovopzBJutvtdU1Zo8+elKVbKJdHAV3mT4JP++2hnwcx290y
         esIq+RZM3RLPbRMODEKWzdr6IWpLtUh1jK1vPqBYq5fKspHkLfFTw5tgA6NtfBehohGs
         MLXg==
X-Gm-Message-State: APjAAAXtQ0WA5INh5jR3Q+wBJQchGlw8ye8C4j6qK1oP8R4ZGMK1yFln
        rJZTNNrmUX3pcAjTQ3tVQeg=
X-Google-Smtp-Source: APXvYqz6CUAzKvfhG2a98w6gEuvAEVF0JEVpIrH3fHBvreWgREV9BTl908nAnCfHWFA0q++rRP/oIw==
X-Received: by 2002:a2e:5358:: with SMTP id t24mr23216696ljd.209.1570554305656;
        Tue, 08 Oct 2019 10:05:05 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id k13sm4361363ljc.96.2019.10.08.10.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 10:05:04 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled regulators
 in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
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
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
Date:   Tue, 8 Oct 2019 20:05:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008161535.GN4382@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.10.2019 19:15, Mark Brown пишет:
> On Tue, Oct 08, 2019 at 06:02:36PM +0300, Dmitry Osipenko wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

Indeed, thanks!

>> That OPP patch caused the same problem for the NVIDIA Tegra20 CPUFreq
>> driver (in-progress) and I resolved it in the coupler's code [0].
>> Perhaps the generic coupler could do the same thing by assuming that
>> min_uV=current_uV until any consumer sets the voltage, i.e. if
>> regulator_check_consumers(min_uV=0) returns min_uV=0.
> 
> That sounds like it might just postpone the inevitable - if you set the
> wrong voltage first it might decide to drop down some voltage that
> wasn't expected.  There's a bit of a bootstrapping issue.  I think it
> would be safer to just say that anything that is within spec won't get
> changed any time we balance, we'd only change things if needed to bring
> them back into spec.

Yes, the case of changing voltage before regulator is enabled seems
won't work as expected.

Maybe it won't hurt to disallow a non always-on regulators to be coupled
until there will be a real user for that case.
