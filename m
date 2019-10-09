Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20ECECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF16206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPBVAl//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfJIIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:52:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41184 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbfJIIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:52:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so1620931ljg.8;
        Wed, 09 Oct 2019 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f04OdU6Fyk3m2zdZCMUEKpGzg4pA3Tu5ccwXrcxWMa0=;
        b=vPBVAl//lPkqDRQlLMjKuZdWOSz95s6yp3C/B+ltHKl8GcNV8r85ugL9sN1QgKnIrU
         WnnXRA7G04rnxLe+J5vCllC5fLr1Mi4gYBgtT0ADwWN4zyIQu/Uedr2oXwUop/WKaaMg
         WWNXqZi6W/tPcxxG7zwAs4AnS0hbOQvJUembAd9dX+kYzmm7fBdYuNfHfOUj+5eeHZvt
         4Iw1N+d1vBD14mJ4GozTAWfJvtDfE7MifSUkNKNFEtiKYxKX9AmQGk8NWgzpr2P89QtX
         HN7a1jiU9KLxzBiBkOxEepeWZwa/zwALjN4PsUIzJgWpR4VA+A566hrTqgdf+3s7uh6k
         bH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f04OdU6Fyk3m2zdZCMUEKpGzg4pA3Tu5ccwXrcxWMa0=;
        b=E1MGvBlMdWW5CwUCwhPLdUc4Dgw5RnJaQCCXQFSWGBsQd3MkRWlQxPtQI8vPxNBpLr
         Y36hihQJzMFuhhEDfasqwY/sqhb6Uf/qKlhVUBG/tRpyDnYjcvBIbjTqCytKtNY9WvsR
         CF9GmQT11jUMNOYVOMkC7hv5r6f9VF4fVknKJhKk9OQojj+LPq5PoiHFYaSgzgCPa+10
         aKtlXjgydRgZtNQ7SjgtA0Z73+9kE+ToKivCzLP9clnYk4FN95E9vKDcALdlrl4YngBH
         5+77sPYIw7YFHp7u9sOV2Fj1O5n2iYUmJi/Zcj6HkiX8u1QzAUXQ/Cu1YxDFaw4DuxpY
         t21Q==
X-Gm-Message-State: APjAAAVETSDkOBSWcznpfupuDcBr4HJBSwco/HpAnPrzSJtfnvl0rPKv
        wIQk+l4lRdAvgAazQZly8rhd2BI/
X-Google-Smtp-Source: APXvYqx5wbfdt6yNdn2U6rc1m53le8zF3t+PqSJO6cvPIxeB8MW6r9epDp1r+XLEuOcFdRv3aRzjVg==
X-Received: by 2002:a2e:880e:: with SMTP id x14mr1584844ljh.42.1570611138277;
        Wed, 09 Oct 2019 01:52:18 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id v1sm325809lfa.87.2019.10.09.01.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:52:17 -0700 (PDT)
Subject: Re: [PATCH v10 12/15] memory: tegra: Introduce Tegra30 EMC driver
To:     Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811210043.20122-1-digetx@gmail.com>
 <20190811210043.20122-13-digetx@gmail.com>
 <CAMdYzYqNL_KAYwsnWYuz9wf2xT_RM0cWA8jkKATWMX7yuVq7Hw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ebd9b2df-e4dd-1207-ad38-fc52cf4e86d4@gmail.com>
Date:   Wed, 9 Oct 2019 11:52:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYqNL_KAYwsnWYuz9wf2xT_RM0cWA8jkKATWMX7yuVq7Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.10.2019 19:28, Peter Geis пишет:
> Tested on the Ouya (tegra30).
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> 
> On Sun, Aug 11, 2019 at 5:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Introduce driver for the External Memory Controller (EMC) found on Tegra30
>> chips, it controls the external DRAM on the board. The purpose of this
>> driver is to program memory timing for external memory on the EMC clock
>> rate change.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---

Peter, thank you very much for the testing!

Thierry, could you please pick up this series and other relevant patches
for 5.5? Thanks in advance!
