Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A963C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 04:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3343204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 04:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unoGz+98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfETEnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 00:43:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45789 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfETEnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 00:43:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so6066822pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+XiwKGCePMesqEFsZbk88+d/XnSzWj4VH7Ml5qL5pt0=;
        b=unoGz+98418sHeX4y3va9Fw7O/7rbEjL0hqVIq1my/Asr2dzM38M5H+2LqZvHB8AAU
         CqAQ6kJMNTvZsHuKd08/xPftA/HCBVOpd9T/IVsfET13Jf59zZ2lgw7rBogYKdMYL5HO
         D19WNFD3+CXw7ekYEu/sBvRFOLcPxesn9XRptLA4MN0cxd/h+H6ijVajWhreBcZlEb89
         1zto6lDvOL6iTVNTtZLtBD5/usk/MiY8ToYMfmuWPSFpLXmjSRm7UfgLrVM9IDZz023L
         +jA3+5k0WyY/BV+s9tNRRQvSDaqiY473/tMDg9LXbhdS9165ETFM0jaOZW2A2jQBuMSY
         XRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XiwKGCePMesqEFsZbk88+d/XnSzWj4VH7Ml5qL5pt0=;
        b=RiO0yL6DAfH4A25hbEUUv0B8yVmrqQ/LKGXWSzqKwBZb43wjzOSEQgT7EEC6wHWEr8
         0TzVkev9LcuOGv1zYjIgzjp41CAFwp6xXpuWgFuVNg8ntmnwkK/Uy77DuXtzh81DLYDW
         t15wqKEfqn9q0cCyPdYETcncLpItG277li5sDhqZxT0L0UTtckENRH5cMKN6tXCydD0X
         LdRPzMm4iUrw93GfhdKeiMak6LBsN0+v4i29yXYR9ZddX14JE/V+XXCcQqWwKmcqsYPx
         oRwa5mxv/HVWpd756c0KmjUGK3gCer+JQLZ/XNbYXfsXmbwTMd/zvXkPP4JL4tJyxQej
         d3Vg==
X-Gm-Message-State: APjAAAUQw67e4l6hjSgaQ8AZICKcjqPlu1oBWQgZYIINUPEHh/ZWUF6C
        CWvQLa620RmliHZGaK1LcXTncw==
X-Google-Smtp-Source: APXvYqxKxyg7Aak1yT0b9mdNSLwjCHjek+L8V1ZtJqzVLOZXXZuDfEEcEGssLjb+LtYO06CzCKIoow==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr19217573plb.247.1558327400037;
        Sun, 19 May 2019 21:43:20 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id b16sm27365221pfd.12.2019.05.19.21.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 21:43:19 -0700 (PDT)
Date:   Mon, 20 May 2019 10:13:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [PATCH 4/8] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
Message-ID: <20190520044317.pwciu4bjuz5jh7f7@vireshk-i7>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1557997725-12178-5-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557997725-12178-5-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-19, 17:08, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> This adds dt-binding documentation of cci devfreq
> for Mediatek MT8183 SoC platform.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  .../bindings/devfreq/mt8183-cci-devfreq.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> new file mode 100644
> index 000000000000..3189902902e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> @@ -0,0 +1,20 @@
> +* Mediatek Cache Coherent Interconnect(CCI) frequency device
> +
> +Required properties:
> +- compatible: should contain "mediatek,mt8183-cci" for frequency scaling of CCI

Example doesn't have this compatible .

> +- clocks: for frequency scaling of CCI
> +- clock-names: for frequency scaling of CCI driver to reference
> +- regulator: for voltage scaling of CCI
> +- operating-points-v2: for frequency scaling of CCI opp table
> +
> +Example:
> +	cci: cci {
> +		compatible = "mediatek,cci";
> +		clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> +		clock-names = "cci_clock";
> +		operating-points-v2 = <&cci_opp>;
> +	};
> +
> +	&cci {
> +		proc-supply = <&mt6358_vproc12_reg>;
> +	};
> \ No newline at end of file
> -- 
> 2.12.5

-- 
viresh
