Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C46C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43D62077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8GhQ+CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLKCno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:43:44 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45497 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLKCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:43:44 -0500
Received: by mail-pg1-f178.google.com with SMTP id b9so9588240pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2PKZ0IX3cZC2NpOSYKVLllzL+7nLw+rKkD8S3WmyZA=;
        b=w8GhQ+CZvgLHTTZwFdTQUSqsAyRFyIGpQ5AUhBq6xKd+opcy9MSsH7kHo+Oithf6uo
         KjLD6yMvJw8AbCOEsfTqbTrt53AS62NGCorl/kwrMwEh3TEmsPt8ZFyjX1CCEyIhWvIe
         q+uuuytgH4DO2LDHDTQr+60x2isx64yxsQPcL6vd8TJeWJey5lYT7rfW/Ts6E9f8EbJX
         f5ReBR0lnDgN0ds1RUuEpfBF/mpGRluv/iYG87x+U3A+1gg4vaWepMj2IRX6A9b81YGb
         tlrwwNlnTdavD2qbzgQ2Kbz2hZSDoSbVjnNBJqtEpHCT8GIZvMaGObuvpI9DwXriRJW3
         lY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2PKZ0IX3cZC2NpOSYKVLllzL+7nLw+rKkD8S3WmyZA=;
        b=f/E4N+z7zCWv2TlUbtXbG+KSIjHLfWUI+Q/uwHD/Kxx7/f1tjvj0Y6JomJrXUKZx3E
         D2hJIPMCx3ScF0P2thQ1DSo/HuHjO3E69Xp0fDBivwUDd8QcVprDqaHpWe05T3vaqsWy
         Sxzx3ZVVFcBdcAqO5pM2wkV4U43Vz6BMvgt1C11l+gQc7zBhKYeR7JT8wM2Vx/us0IFE
         Y000fRkguojs5L0HNDohw+LvEua1uDoWH2qT2BYDYXEcPQt/C5G2M/pDOsDOiCYObso1
         S50/4mTSSFe1lnlp6QusztMgNZ465AGdv89wrMxiFQ/14p3G9/cRMSKf1LT7hAtUWiZF
         XRiw==
X-Gm-Message-State: APjAAAWOOKyel9yd0sCpFqHdWDZ85ONQ8NSy9c+gWF2vhiS27imV1RIc
        zhnSt0VJ4MqKc0C/t+yULQAKJ5wuanA=
X-Google-Smtp-Source: APXvYqyVfjbcgqNdmMEHFYrJYcZxzszIKGFxppXi7nDzyRsAewfcHmU5EQL6U0AI1uYiJYJ4dueq4w==
X-Received: by 2002:a62:5290:: with SMTP id g138mr1269727pfb.54.1576032223182;
        Tue, 10 Dec 2019 18:43:43 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id x13sm416889pfc.171.2019.12.10.18.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 18:43:42 -0800 (PST)
Date:   Wed, 11 Dec 2019 08:13:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20191211024340.cvwalbr7tmvfqbrc@vireshk-i7>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <71417ba8-b844-ac96-bcad-4bf48fa8b869@arm.com>
 <20191210053448.ugjzbp2puzvnm37f@vireshk-i7>
 <20191210184633.GC20962@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210184633.GC20962@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-19, 18:46, Sudeep Holla wrote:
> May be to some/small extent.
> 
> 1. max_rx_timeout_ms is firmware dependent, maximum time it expects to
>    complete a synchronous request or acknowledge async request(worst case value).
> 2. max_msg_size is maximum size of the buffer we need to allocate, mostly
>    based on the specification and we don't have any more that 0x80. But
>    the custom/vendor specific protocols may wary and hence I thought of
>    keeping it configurable for platforms.
> 3. max_msg is the maximum number of messages the transport can support.
>    This is currently based on the mailbox layer. For SMC/HVC we can have
>    upto nr_cpus, something different for spci/optee. We must be able to
>    make it transport independent if required.
> 
>    This is mainly used to pre-allocate number of (tx/rx) buffers.

So we can only move max_msg to mailbox file and read it along with ops, right ?

-- 
viresh
