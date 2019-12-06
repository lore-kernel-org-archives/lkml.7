Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC53C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3124671
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575623877;
	bh=Ei0MUXq5zQzBW0Sn4OvuekeHYqdDN8TJDdYcN48UNTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dPIkul9YvaS7JFIS3LMvBnIZYMPp+lEaCE9vc4EF+l6eMOo65gyYAHUVj+s7THLrf
	 dppFjTthhyZ41IJY0f/cCjcoq/zrHI3+1V+XNYxjeVMNMFJQcxnmmwoD4hk5imhuNo
	 UAR6HzTciukicJfvqpy62hdHZY4vzFIIFYOxrmig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:17:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47060 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:17:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so5169931edi.13;
        Fri, 06 Dec 2019 01:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZDNaxJGmzD4UaAts+lOuP1c6KYX3Yal18Eu6hgRldFE=;
        b=W6s9eTIptdtZ0dLLkbpGfn5RZc0u81x1w2JyVnoifQYvmTnzIPl2nfWSQtrg6hWDJ/
         2p8ayKHc6mQy5RmE+GrogVd6vE2GULIR4xweEafvxWvLPsUk7y0VqRw0cyr0ii0GFRWh
         ajzHa41FaCNU4GZTMjxYpmM/2VlWXS4uJT8aqPEg44lc2A6M/nF1TzfAcdgbyPsloUR0
         cbMQ7YRXVrQg1XaQ07hWD9a/JnzpTnvAEFh9bYXeOtWq11UxwKRQdYMH4tL/NSx6IEFb
         Xp59ugS05p1HiCmUEBjaxX4j5sQYmfyIIXlMEuOTa/p6oWZnGawzGQPLZiLdDTmhFjbK
         CDmQ==
X-Gm-Message-State: APjAAAXMaJYqcjD5uoIpz5+I86oW9HVouiYMIclwJxemt8G1tuO0xHg2
        nczduWhDnhMRvHoJmiCfHiM=
X-Google-Smtp-Source: APXvYqwthFSYZky+fFl2W7INcRuVudrAxhT65DmzPiBOhsnAL6ENuF82nk2+q4RKoiNF15ld1GhDFw==
X-Received: by 2002:a17:906:ad96:: with SMTP id la22mr14113926ejb.84.1575623873663;
        Fri, 06 Dec 2019 01:17:53 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id n3sm207540ejj.29.2019.12.06.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 01:17:53 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:17:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191206091751.GB1917@pi3>
References: <20191205154410.29462-1-matheus@castello.eng.br>
 <20191205154410.29462-5-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205154410.29462-5-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:44:09PM -0300, Matheus Castello wrote:
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
> 
> Now we can use "maxim,alert-low-soc-level" property with the values from
> 1% up to 32% to configure alert interrupt threshold.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 52 ++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

