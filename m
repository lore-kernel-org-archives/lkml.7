Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA21C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4150321900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vGpS2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfCVQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:42:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34416 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfCVQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:42:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so527234pfd.1;
        Fri, 22 Mar 2019 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3SNPYMhd5efjvfE1knENTnx0NSU3d1AwgqH80LgZz4=;
        b=A6vGpS2D2Up1hYiE0jHmb7hdCCCIz/DeUS1qnMkekl4GCICU1Q1OvujheFxfM3XqsH
         d3zehgLPcxaKyRL3cHushQ3O44R9UNl147UCoa2gJmDt9y6TVHxat6WQIs0E7YFRp8jm
         VumcVw6akeMq6tCQOvD5Fcf63FQAD7WPlnNIcESooSIgnS3Jq4tJUjGuwFmc/xdFD1yE
         zIEnGr7iwNfJnZp45yWLMdzeID0u2hKqq17tLij1g3jCqXJHHPyQLcnEhxMN6pAsZx+k
         sgKKTp4S5HkxwoR3k7VS5hcMaj8Zi6NDcRRqxTt1e2GNsadaIaonybKbVMkfqJ2Pmqq1
         JV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W3SNPYMhd5efjvfE1knENTnx0NSU3d1AwgqH80LgZz4=;
        b=aRRncrEgTAd8ESL0LbzbayjmkyviFkh1rRqHK0W50L1kFLoNX8EAQzfNBRM5meWEl0
         0JDLaAAC2ABR0pmLzVAwtPdi8cjQAxxqa0469UcP316CU6EaeMTeBK4QotBe7oDvwbT9
         K1n9KGgFrKC7cQoJ+46YxhggySfLxO33Tvf22d+qG2UevFpOjwSmO+lJoWFz7uWnV5+K
         +b+AP1OzYtrRpk0FL6STWBmELRw+VSckplWYlb/vqPUaMpnoaZk53TZq8bZVxduqjWtS
         hQnBAwlCYqBTXmchg8CJ/BKPtBcox9ndAViv6gevzJtUjuFbrT41xEAPWBCb6/pl/LFt
         HSXg==
X-Gm-Message-State: APjAAAX3wu6FPUx+ml2rSoDoeRCFnutaemJXH20OxrodOHUpRvH7Bja6
        kvDdVXEf0iT6TR7ns40tnjCoLA6W
X-Google-Smtp-Source: APXvYqzFUfTce0kUM1CI+6PYixQHACPQaHfamVWuyTOYSbmH4/sTw3JGGTrgQ1UELXqHcTFnjnKULw==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3mr10337586plb.166.1553272926090;
        Fri, 22 Mar 2019 09:42:06 -0700 (PDT)
Received: from [10.67.48.231] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l187sm9982262pgl.75.2019.03.22.09.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:42:04 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] Stingray USB PHY driver support
To:     Scott Branden <scott.branden@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
 <7490f894-3c0b-c7cd-5ff0-4eea6ea2c199@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <1f910861-7d3b-63ad-da79-9515eae2b230@gmail.com>
Date:   Fri, 22 Mar 2019 09:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7490f894-3c0b-c7cd-5ff0-4eea6ea2c199@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 11:38 AM, Scott Branden wrote:
> Thanks Srinath and Rob - patch series looks good now.
> 
> patch series,
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> 

Kishon, can you let me know when you apply patches 1 and 2 so I can
queue up patch 3 for inclusion the 5.2 ARM SoC pull request? Thanks!

> 
> On 2019-03-19 2:15 a.m., Srinath Mannam wrote:
>> These patches add Stingray USB PHY driver and its corresponding
>> DT nodes with documentation.
>>
>> This patch set is based on Linux-5.0-rc2.
>>
>> Changes from v5:
>>    - Removed redundant address and size cells in DT nodes.
>>
>> Changes from v4:
>>    - Addressed Rob Herring review comments
>>       - Removed child nodes and added #phy-cells 1
>>       - Added xlate function to get phy using phandle argument.
>>
>> Changes from v3:
>>    - Addressed Rob Herring review comments
>>       - Changed compatible strings.
>>       - updated driver based on new compatible strings.
>>
>> Changes from v2:
>>    - Addressed Kishon review comments
>>    - Updated patchset to Linux-5.0-rc2
>>
>> Changes from v1:
>>    - Addressed Kishon review comments
>>    - phy init call return value handle
>>    Srinath Mannam (3):
>>    dt-bindings: phy: Add Stingray USB PHY binding document
>>    phy: sr-usb: Add Stingray USB PHY driver
>>    arm64: dts: Add USB DT nodes for Stingray SoC
>>
>>   .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 ++
>>   .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  72 ++++
>>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
>>   drivers/phy/broadcom/Kconfig                       |  11 +
>>   drivers/phy/broadcom/Makefile                      |   1 +
>>   drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393
>> +++++++++++++++++++++
>>   6 files changed, 510 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
>>   create mode 100644
>> arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
>>   create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
>>


-- 
Florian
