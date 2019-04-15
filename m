Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3120848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wd8UfpPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfDOLHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:07:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:07:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so21336106wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wfw5ldk3ZYbGsiyKLrN6qBHHgOxUmz0myKpUjl/8reg=;
        b=Wd8UfpPZzy8Twcp5KutCBp+LWV7fbjuZ8xT3vt86KFgQQ1EW2PcEoqlgeywJwIgM+3
         fiWyMlM5O4tDVXdEVNP4vSzCkm3jwtEsDmAjSEFpf9xP03uyFLOuKpqIODRTUwr6zw/u
         EWRj8N2wl8bK8eOFByOTjEZgwiFhG92tOySbiAtXYH+7g85BYRv1EY7+CLHSZBX7oi9l
         SnsnjOJhDUplQH5p9sjI3cpQvpxIZFK4LXdwG1zF8hrqgdXgLrHksrWWqz3fmPvm5GXE
         WpoIhDsQuMdnGk7sXR5nw5R8ZcQUU9MLd5zV7n2iypkwmSj4Fu8kFmd5l7RooB7UyNfN
         rIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wfw5ldk3ZYbGsiyKLrN6qBHHgOxUmz0myKpUjl/8reg=;
        b=WWAbuU6HMo2QK7DP+7jgR5/ihCj4KXC2i7ohYQtivYBpIjyzbMWl+UdNjKKdqccuYq
         HrKRzaJOAmD5T2DqTv0FEhyWO44l8gEOiXO2g7IrjhcMkdlOx5kSzCAFOmqJ5HG3ZAa6
         qdIHWaECy9RWa4/BoCHFXsaRYl4JJvPN4BdJnrI8y+MD+L5XY47wUqgukwWzyZybps8L
         kZCKB14HGQXlF5YSE7ja/N343MBeMMZygPu2IgTL0Yak+pfhzl+Zqc+cMX/OXRk6PaYy
         9cJtxM97Y9pwjbSefaOmc+h6k7ZKEpOTkUlH3t88IIQ/dIMal3lLOmXZJLCq/I4fqZOJ
         LJTg==
X-Gm-Message-State: APjAAAX+UYhegN9ZwpIMu7G7qRAczIihNE37itGYBErcKbx4u7vIROUI
        CNqQUtFPiTHAOoUn2vX6eLR+5w==
X-Google-Smtp-Source: APXvYqy0awgkKSIBAMx4ZkmLOIVpjvrd2YtgrQxJ/5oGJj8SQs3gGmODIfqtLUroE2GrKFO+80ckVg==
X-Received: by 2002:adf:c60e:: with SMTP id n14mr47970020wrg.127.1555326438284;
        Mon, 15 Apr 2019 04:07:18 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id w18sm71622570wru.24.2019.04.15.04.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 04:07:17 -0700 (PDT)
Subject: Re: [PATCH 6/7] clocksource/arm_arch_timer: Remove use of workaround
 static key
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-7-marc.zyngier@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <88607699-bda8-8a3e-09bb-aaf1541fe8d0@linaro.org>
Date:   Mon, 15 Apr 2019 13:07:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408154907.223536-7-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 17:49, Marc Zyngier wrote:
> The use of a static key in a hotplug path has proved to be a real
> nightmare, and makes it impossible to have scream-free lockdep
> kernel.
> 
> Let's remove the static key altogether, and focus on something saner.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

