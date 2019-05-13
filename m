Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C83C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40926208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvfH0are"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEMWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:33:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:33:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so7952773pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvQvgfEGSLgUqO5Q9NdIyP63IIoIQn87HFDmXmj0MKc=;
        b=ZvfH0arew0ocZDDdoYxHlTfwpsvBkycRrF4g9K2oR08xEh1FrVl57VdAJJPkME+NMp
         CnltQ+dNfL78uYuw773bZ1MdSrn3fv/MV6zbZvj3N9ahhVZG/VdCLzStnA6T3j4NBURi
         BIYZ6UKCrpcJOGmOeXM4aLeuR6egOfZ7e72aNGaARNzGiXP3tC0ieJTVKF0NR3DWo/C8
         4NKcza9dATpUs139NFOpiFCb2D1Y3A4s4x+7A3PuetpM8acbqIHEUNhTSXiGjdefUBvA
         QjLPBp4VWIXBKUObrYthE/FqVekPSDll7Ppwg5t08ouGxRZlZ2q0WCXL6Ri/j5GYkrPR
         6FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvQvgfEGSLgUqO5Q9NdIyP63IIoIQn87HFDmXmj0MKc=;
        b=h8Vt/akjUZZzOgCJg7rghx0LASUdGvwTa6h9ujbthsY/1GMONQcfLQ09c7V9MkOZDq
         OjF9G14YxOLR9d91SbVfYNlH24/cdQy1QwToJt/R2dn0QsSBK0X2r5m9X+f9dnEbciuD
         qntjPIJcI0o19Pz94xhFmt+vwNPITZ+oKELo9666yA0186SyeJtsZOPg6/v6ABeed08z
         jCu1Gmf2Cmn9JRo16gfT7ut3JJYx+xcQq7nmyb2M1AEYC/pMQmjgKBcOsGYBwk3rPvm8
         IZoCW5ag+eZ80R7qLLiHVE5b07+j4TSb6gk4aWwvVW10eJF+yVEK1VH+W2JWIBWeTPfS
         oNPA==
X-Gm-Message-State: APjAAAWP7PWkEtKxtqRL80y5LiwaU0TsyDnuOrzB8genANSVOHp1TDZS
        Gt1fbmlxPkpPV9A1e9wPSbVgPw==
X-Google-Smtp-Source: APXvYqxPHzPRhlNAh7fHXKNAPmAkVKGQ4nrfmtUr2JNvkogfwiYQFup8yN7ZBuVfBdEZjih2EbKnLg==
X-Received: by 2002:a63:7552:: with SMTP id f18mr32376239pgn.234.1557786820042;
        Mon, 13 May 2019 15:33:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q20sm24595819pgq.66.2019.05.13.15.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 15:33:39 -0700 (PDT)
Date:   Mon, 13 May 2019 16:33:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 29/30] coresight: acpi: Support for AMBA components
Message-ID: <20190513223337.GG16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-30-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-30-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:56AM +0100, Suzuki K Poulose wrote:
> All AMBA devices are handled via ACPI AMBA scan notifier
> infrastructure. The platform devices get the ACPI id
> added to their driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/acpi/acpi_amba.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index 7f77c07..eef5a69 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -24,6 +24,15 @@
>  
>  static const struct acpi_device_id amba_id_list[] = {
>  	{"ARMH0061", 0}, /* PL061 GPIO Device */
> +	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
> +	{"ARMHC501", 0}, /* ARM CoreSight ETR */
> +	{"ARMHC502", 0}, /* ARM CoreSight STM */
> +	{"ARMHC503", 0}, /* ARM CoreSight Debug */
> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
> +	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
> +	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
> +	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
> +	{"ARMHC9FF", 0}, /* ARM CoreSight Funnel */
>  	{"", 0},

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  };
>  
> -- 
> 2.7.4
> 
