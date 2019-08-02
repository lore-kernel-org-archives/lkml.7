Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB80C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93509216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG5RfcjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436731AbfHBOr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:47:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36223 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436716AbfHBOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:47:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so73118797ljj.3;
        Fri, 02 Aug 2019 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3glAiGKhuEDNJUpDzDakal4T8PJZgARPlC6as0O+dc=;
        b=DG5RfcjRN6PaSlDmYV3U/dpGFOGQn6H7LESYUzCLQATPMAA7Qtk9bIUpUeibaADa2k
         8yed6zddy7nEdDadeegWD4JF3z+36PwS2syPhw08GYMzOoKWGn3cLaODhj/TLpdNViWF
         SyPhWduqUq5L9Gud66cODAC3LlwtEqB2LhIJML7z/pkEnaUpvmLbaxCf7OqycEkG37oh
         wynkd5QmoeUbrECyJ+q0Tm3y22GhnRAhmE5t0B/TvUKms5seH39/1M6pjXmcDtGBIKfA
         xTVH7hwk2c1RsaT8pG+/lK/X1CnwL7ApMBAvddx2wNlExTtgFCHTy5MZJCB3e4crs7IK
         JcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3glAiGKhuEDNJUpDzDakal4T8PJZgARPlC6as0O+dc=;
        b=BAO44gDfmMGvkz7QH31U7PQO13bchmGh0TiVSmNNPfk5CCwVyJYQfiOac4S6HOxcxv
         ZsdHTyXTIIje5RMqKoC9UqNzBxGZ8blpbhazidh7prAKjlYVTGNxTLwn3a8wZwBgFeuE
         6b7yXTcw8h9+TCtjwsIwhvM0xYXxTE8rh2yOx7sK35ss58GCO0s12BCD+va09ifh4G7Q
         VbnTAz0n8eblx7rJZi4yn1r0iw4KFYWxpQ2Hk91jaFAfLTDuir9rS5fjI7BriTFtnrfk
         Y1lCJEiS1D+KbIIsTiz1Cz1783iUzegJD2wvXcrhiOWpjtdPTM62A1fmRIoJcohDuOdt
         KW9A==
X-Gm-Message-State: APjAAAWZFBGSlxq4sM+BBGxfhrYMQ6EFtxIDxwH5P9U9iZQ8FUeOg6Bb
        ThFAVT9479PIRK8mlMRiXetRhCqt
X-Google-Smtp-Source: APXvYqxcWd81wLwW1HnIMVXA2OeDcW7m1IlnXPXXct1U6Uj2NPWiSQDOeXA1+FeT3O/thOZ6KoZF8w==
X-Received: by 2002:a2e:b60c:: with SMTP id r12mr23070576ljn.124.1564757243919;
        Fri, 02 Aug 2019 07:47:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id n24sm15338397ljc.25.2019.08.02.07.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:47:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: regulator: Document regulators
 coupling of NVIDIA Tegra20/30 SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190725151832.9802-1-digetx@gmail.com>
 <20190725151832.9802-2-digetx@gmail.com>
Message-ID: <ae79a9c0-7c87-63e4-8555-b80851cb22cd@gmail.com>
Date:   Fri, 2 Aug 2019 17:47:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725151832.9802-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.07.2019 18:18, Dmitry Osipenko пишет:
> There is voltage coupling between three regulators on Tegra20 boards and
> between two on Tegra30. The voltage coupling is a SoC-level feature and
> thus it is mandatory and common for all of the Tegra boards.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra-regulators-coupling.txt      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt b/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
> new file mode 100644
> index 000000000000..4bf2dbf7c6cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
> @@ -0,0 +1,65 @@
> +NVIDIA Tegra Regulators Coupling
> +================================
> +
> +NVIDIA Tegra SoC's have a mandatory voltage-coupling between regulators.
> +Thus on Tegra20 there are 3 coupled regulators and on NVIDIA Tegra30
> +there are 2.
> +
> +Tegra20 voltage coupling
> +------------------------
> +
> +On Tegra20 SoC's there are 3 coupled regulators: CORE, RTC and CPU.
> +The CORE and RTC voltages shall be in a range of 170mV from each other
> +and they both shall be higher than the CPU voltage by at least 120mV.
> +
> +Tegra30 voltage coupling
> +------------------------
> +
> +On Tegra30 SoC's there are 2 coupled regulators: CORE and CPU. The CORE
> +and CPU voltages shall be in a range of 300mV from each other and CORE
> +voltage shall be higher than the CPU by N mV, where N depends on the CPU
> +voltage.
> +
> +Required properties:
> +- nvidia,tegra-core-regulator: Boolean property that designates regulator
> +  as the "Core domain" voltage regulator.
> +- nvidia,tegra-rtc-regulator: Boolean property that designates regulator
> +  as the "RTC domain" voltage regulator.
> +- nvidia,tegra-cpu-regulator: Boolean property that designates regulator
> +  as the "CPU domain" voltage regulator.
> +
> +Example:
> +
> +	pmic {
> +		regulators {
> +			core_vdd_reg: core {
> +				regulator-name = "vdd_core";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-coupled-with = <&rtc_vdd_reg &cpu_vdd_reg>;
> +				regulator-coupled-max-spread = <170000 550000>;
> +
> +				nvidia,tegra-core-regulator;
> +			};
> +
> +			rtc_vdd_reg: rtc {
> +				regulator-name = "vdd_rtc";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-coupled-with = <&core_vdd_reg &cpu_vdd_reg>;
> +				regulator-coupled-max-spread = <170000 550000>;
> +
> +				nvidia,tegra-rtc-regulator;
> +			};
> +
> +			cpu_vdd_reg: cpu {
> +				regulator-name = "vdd_cpu";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1125000>;
> +				regulator-coupled-with = <&core_vdd_reg &rtc_vdd_reg>;
> +				regulator-coupled-max-spread = <550000 550000>;
> +
> +				nvidia,tegra-cpu-regulator;
> +			};
> +		};
> +	};
> 

Hello Rob,

Are you okay with this patch? We just need to mark the SoC voltage
regulators appropriately and regulators themselves vary from board to
board, hence this binding is not something that could be done using
YAML, I guess.
