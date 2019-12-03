Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8835C20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRjMPOlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfLCGoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:44:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43869 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfLCGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:44:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so1098267pjs.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtcC2GPbq3JBTNN9rECUNMmDwyrELwKzppI404mA1B0=;
        b=wRjMPOlBfADkyTJLJ+qfTIeQ+c1YuA/C4h8xlDGs/YxBgN3g+ZBMHvWYLx3fjV4fB4
         4fjdsYInTmt6mFQOn/KyVkGZe5FDxTEZ4KzgzipYgRLNpxSELJKO7p06y1Go2DoyU9Ne
         WgcSaHlmgKuZT3aMz342pryO0glR52VXfbX4KtrhpwwdXzoupO+qErSGLGhRdyJXKkj6
         pT9j58tveL1Ei7pmvv1oGAoCsHFkrEU5oWPEC6eXRC2Y7+WkzIkr1qfl0JkmhACl8DXC
         O8WLrIR6/vDsnrTr2EaLNP9i4z4/9CcBYPDV+ozWuSq9+kqJu5LFg8WjGOaZb1+R8zyu
         WJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtcC2GPbq3JBTNN9rECUNMmDwyrELwKzppI404mA1B0=;
        b=V2VHmcQd17zrmQ0olKSUyQO+s7LvOXLbNXyDvJGl+Pwocyx8HSmWme/E9yAasv6kAN
         SGcMl29VGf3PZbYLEusXy49ss/j31EbygWMNgyL5ZkeA1dsSmDiTxLXAFAe9n7aucyhJ
         L+yPpr3Fh/93Au00dHnGQBQC/KRQNF+g01p2P4VpHcBpdJdi6exaz/li2suTXSaOkDx5
         fMJg3KQZcfTkaYNkg2WtlsJ6UZhPogzxmdk4+aEV0zcS1vEvHDYCXfWiFlwai2U2c1je
         00i+8EX+XNzwHH5FhX5tBZ4f2c6xPO2Mdg7W918HuGqx9eYW6rP7joQciJjCBuMftB9J
         5Qpw==
X-Gm-Message-State: APjAAAVa+4zCJr8k096CXoMjkPgBp5SZA8rx67s3ILIPQmUsr/NqW6NA
        hE0JpgmFOZEbr2kggWI0eNaMGA==
X-Google-Smtp-Source: APXvYqzYR63Yw28c4/d7oAFcf009oytJ/A4hfebVb8UZjSFsWH61NqfDrwL11mFnOI8UwvyHTTEgLw==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr3488377pls.104.1575355450554;
        Mon, 02 Dec 2019 22:44:10 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id h4sm1398580pjs.24.2019.12.02.22.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 22:44:09 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:14:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
Message-ID: <20191203064407.ssw5cij5mlz5udg7@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> Provide some documentation for the idle injection cooling effect in
> order to let people to understand the rational of the approach for the
> idle injection CPU cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
