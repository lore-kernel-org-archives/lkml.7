Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F8C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D44A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJtYtnee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfFRQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:25:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44430 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfFRQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:25:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so139546ljc.11;
        Tue, 18 Jun 2019 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aWbCD8GTr6CtvHS0OInn6v/N+gapK0DJLyamEDwpKj4=;
        b=VJtYtneeXLFnE2Kgv8v9aKFOEvUb8xxc/1PCBD8efOOP50gl/24SIlGDQHYLAaIseE
         XEjc4+xIiUKxYrcyxSL9H7IC7+DAxCyTbjGysv3Un0GvwpQYqb7ftjCmtVhy80fMXVQI
         YlPtC1n/ckzTi7nwNaiaolzxT6s9UaGbRRvIRCL7SAYFwuEYz5iyBxgZxg24BbYoX5FL
         9YbUaeHnrrXAqy+v/1JevuLwffDzTGBZTkhFJKogxgC5bm05Wj8DdJh4PaXxOZ72KgiF
         xdP7VFh1dlQ6msfBBCS+ZeLoc1BMU/EAMOKjS60BSooTpx8Al5iBwcPKTf2e0p1U7YHA
         3jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aWbCD8GTr6CtvHS0OInn6v/N+gapK0DJLyamEDwpKj4=;
        b=SWaWtrVhLxG4xA4pnK0pmvM02cHG6Svvrxd0By7QT14ZHvirjyGoWenp96kv0aMpU6
         CmCzlsa6rxTEQ7DtcfZtdrIc4GrcJ6WnxonImE38jFk3pouN05nebDznE1RUEXW9gcTT
         jOzTFQTRUnSPrbxOcSx1wKBi6A34/ing5yBvUrT56xWcesjSXwXIeZ0lXlkBcJNrtPvp
         dCaSscWPuDWD5N6MJaOSU3SS4CFF0n+uOJNRtXuyHvSBsccTUq4HCyISGGbRM/Fu9cno
         u0Eyc88Cnm1+DMXOHovdfo/rPRDINjMtxOmvoou2aVhZeRCNMR8N4WhM0Gx9Anco94qd
         8HGw==
X-Gm-Message-State: APjAAAVDcoPPk+sED9kkKI+Pk1zgGi8R0ISL0yCqU78eQbWgkkLFHN1v
        wDMFyByyqK95kWiXQPOxgpcQE35M
X-Google-Smtp-Source: APXvYqzG2iTDPApqIc4jJGIBCo6+Ymm2Bv7Wobc3Cy6YTnyO4a/BGln0f6FiaOQMI6BNKcyIXRy5zA==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr22426619ljk.154.1560875147346;
        Tue, 18 Jun 2019 09:25:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id q1sm2277023lfc.79.2019.06.18.09.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:25:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] regulator: core: Introduce API for regulators
 coupling customization
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-2-digetx@gmail.com>
 <20190617152340.GX5316@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df8a9f20-5e44-a7aa-13db-c3ba7cbacab1@gmail.com>
Date:   Tue, 18 Jun 2019 19:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617152340.GX5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 18:23, Mark Brown пишет:
> On Tue, Jun 04, 2019 at 02:58:57AM +0300, Dmitry Osipenko wrote:
>> Right now regulator core supports only one type of regulators coupling,
>> the "voltage max-spread" which keeps voltages of coupled regulators in a
>> given range from each other. A more sophisticated coupling may be required
>> in practice, one example is the NVIDIA Tegra SoC's which besides the
>> max-spreading have other restrictions that must be adhered. Introduce API
>> that allow platforms to provide their own customized coupling algorithms.
> 
> So, I don't completely hate this and I'm not sure there's any good
> solutions here...

Thanks!

>> + * @balance_voltage: Callback invoked when voltage of a coupled regulator is
>> + *                   changing. The callee should perform voltage balancing
>> + *                   and change voltage of the coupled regulators.
> 
> Some documentation on what the context for calling this is (locking and
> so on) and how it should do the adjustments it wants to do would be
> good.
> 

Okay, I'll extend the doc.
