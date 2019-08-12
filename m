Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7423EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B2A2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnCPktgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfHLQpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:45:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43709 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfHLQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:44:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so74691546lfm.10;
        Mon, 12 Aug 2019 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=haAdKs7rbQUe3gpmrRuhFR5wsUyRern2SR5ei/VJ5Ic=;
        b=YnCPktgXCK/n/5HaLRAHNTo08YLxq6UGPtgGqJGutbwpMmHDG824R/NvCa3DcDlIYn
         ilgD5YXwKAvmA6q/2T3zlLt6kWypNMdXKRZQHiylwlcUHhh7zGLxpCl1t2PDBYwrNXex
         3sQ0uNWGlgHaD/yDpW4DmuwsF3Xm7U6pDD8aACbM+pTN9PXsigq5CBv91OdxW1ald2yd
         dTXVftLApNWY3o6SKtuTTLWOPSf1vN4cHqF0BOLcDyjdKpMcIeTyim1yhKfvIFfWgZSS
         BOWq7SW7YiDkFPWQSyryLfviVm/1fFD5YUkIvxuPc9SuKchqSJ4Kn3sqHaNYGDrQPryN
         GYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=haAdKs7rbQUe3gpmrRuhFR5wsUyRern2SR5ei/VJ5Ic=;
        b=cI0Itg2a7F9610Ty95NgfGUKXiWSDrC2Ncsx3cqlzcp2cPtxdJLpeU4xp74xDQLpB0
         wu0Vgw6yiewh7DUu+Y17OOmYmxkgMsPyQiB5Pgdv/77QCxhMQs5FqhOVvaah4Z+L85t4
         sUVujnP7m40zWh0B5980dKb0BVi+fcIEoUGzZX61BQzuQ9RSPIKEwpka20uJ37zQxv3c
         HHUpqabi8sN/V5KnEU4ml8BkJA7O3NVI29l3DefM/ZinRq8VClRJ4kw1K2t/YMIj8oUW
         mmdLhk36CXRBoTo0aa8llSpVetE7oIm4CZvd/zAO+1mXzMrcnBP1/IASQCPxLlafSPn6
         xViw==
X-Gm-Message-State: APjAAAX3/QA5VwpeB1YpvBRiLbe1ZUSLB50hc6HV/IiL1oTw5LosTVpO
        GNw0UvHcwl3XZAsB62PDXsfdyISf
X-Google-Smtp-Source: APXvYqx66ZfFAQVtR9kndhfWQxRXOCgKHcZ8bf8W6yM+HYADFXELGpoXHKO8NLBDlnMg7Q4Hn1ilbw==
X-Received: by 2002:ac2:5b09:: with SMTP id v9mr19972348lfn.22.1565628297315;
        Mon, 12 Aug 2019 09:44:57 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id z7sm7927180ljh.104.2019.08.12.09.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:44:56 -0700 (PDT)
Subject: Re: [PATCH v2] ARM: dts: tegra124: nyan-big: Add timings for RAM
 codes 4 and 6
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723033744.4219-1-digetx@gmail.com>
Message-ID: <3aee7eaf-d8c0-f10e-c954-8a50b5932b91@gmail.com>
Date:   Mon, 12 Aug 2019 19:44:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723033744.4219-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.07.2019 6:37, Dmitry Osipenko пишет:
> Add timings for RAM codes 4 and 6 and a timing for 528mHz of RAM code 1,
> which was missed due to the clock driver bug that is fixed now in all of
> stable kernels.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Friendly ping :)
