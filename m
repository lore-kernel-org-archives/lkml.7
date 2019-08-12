Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889DFC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5710C206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu0jbDcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfHLUTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:19:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfHLUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:19:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so31120114wru.10;
        Mon, 12 Aug 2019 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TleJskMU/Gs7nM1zv+YQ7RMru93ffoX4OLITCZ719gM=;
        b=qu0jbDcLH+TVuC2ZryTfR/GjZm1FEYmAkNFIKCdUprHw3+sD33RKG1D9ZxKyewy90T
         spt9orpnXMO1a6tZlyjxqhymOpeafvjMdndj/Z3Do2x2Rsdr6Z8CVBioJB+SOLdv1rMC
         QLuJSEC6Wx32JBx8Jm18nTqsNr67xvRRVfW3WCPWji1QZCHBajZ6HXrDBchQ3GyzkPcs
         GdTAdLE+h03t+veS6B8sgWRroz92czCyaLaCKh4yeYGqfXDm/0i9l96MVKEIFM2tVeSk
         B6lyFYX1KLgxiU3M6It2oSxEjg8Vm0qHtkGfvb9RvBBYG//z8KhiT+40Fa3RbiaF+bDc
         5JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TleJskMU/Gs7nM1zv+YQ7RMru93ffoX4OLITCZ719gM=;
        b=NeXXIGEfju8u649rs9D1fBAFCyLlFzka86y3AcxAd32vN+CLaeKTd7hBSCrFo6i+Jd
         yAS24l4yVhEhfgC9mO74YAJ4CLVyFRpYm11dbWodUYcS+TQ9f3WbtjZDZ+aXk2lqOWjA
         ec2glzPrvhfc3fsvLaU6H1C+136cBETcaAcN5TsBijcZm/zD5ibkOiRDuy2PLsJjDtOI
         CvRoZoFsNMDWx0f5+CxDVGG2ewK+KY9/OuXvXmnLE2MalLkYz3yWqwUphJnQdK3TJZoL
         iVkmtPJ5y+b561w0RDyHXt6JEFHttw+YtL4h5t2/8pPA0ZCBq0X/1bHe3eCTLeDjrrTD
         dkqw==
X-Gm-Message-State: APjAAAVHB9J7X+Cw78BTJ/wZ3mJVf2dtZcxNSEg+IFRyrktz/rI3tC+X
        IvXuJXRc4614KlB2RbyBEejn53NA
X-Google-Smtp-Source: APXvYqwp1WYOnR+9J3xlwSNKvUobQTKhy0sJVhMJnlMrRLU5ZDWCTb3jg1qp1/PJErHNSeTOGR6QtQ==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr14740887wrx.225.1565641192235;
        Mon, 12 Aug 2019 13:19:52 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id r16sm30202778wrc.81.2019.08.12.13.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 13:19:51 -0700 (PDT)
Subject: Re: [PATCH v10 09/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190811210043.20122-1-digetx@gmail.com>
 <20190811210043.20122-10-digetx@gmail.com>
 <CAL_JsqJNwMOMyDaB=zqbCLwfn+ro6RcvXFkRbN_t-mEeUi3rVQ@mail.gmail.com>
 <CAL_Jsq+bcqwRvYK=3d0Qu8K-psxLGOgCazmV55bA=vz+5f573w@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd3b1328-4d7b-c757-4939-62fee45becdf@gmail.com>
Date:   Mon, 12 Aug 2019 23:19:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+bcqwRvYK=3d0Qu8K-psxLGOgCazmV55bA=vz+5f573w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.08.2019 22:54, Rob Herring пишет:
> On Mon, Aug 12, 2019 at 1:53 PM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Sun, Aug 11, 2019 at 3:01 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
>>> particular the EMEM configuration description. Hence rename the binding
>>> to Tegra124 during of the conversion to YAML.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  .../nvidia,tegra124-mc.yaml                   | 152 ++++++++++++++++++
>>>  .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
>>>  2 files changed, 152 insertions(+), 123 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Wrong patch, but still R-by... :)
> 

Thanks!
