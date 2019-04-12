Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4989B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNcYB3xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDLTek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:34:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44390 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLTej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:34:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so9868849ljg.11;
        Fri, 12 Apr 2019 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UehPlKGt8PA5rBPsZJi5fUgjCQWFMytQP0IEcHEqyq8=;
        b=uNcYB3xMfPCVhg+8N/z9pRWjzpiNiYEg70I68LXIDjnuRUY3lbUUkOrxgbgJZaaDGs
         YTPnXGE5q5wxVpfMHp3EkpNHuOkoUeRAZBw5n4DfM/wjHG9DlJoiAWkm1FQNcy7fvVaO
         mCKEFud3/gC3uFLS2WtyQoCsWYXSuPXcJ5wg5s3/eCpz33PoDNcb5TEC6//ALvwfCYW0
         IIwhzwuoJ+YVNmOKOAq1dM9h3pPjjgHyHIuGBcCoIdTVuAo6WooeTGgHfkmK8P+r2skX
         gTjn7mfc8t+dchA2HE6iQzETvRTJaataHaYHCvnIEgYzIB693riLpovLZ8eqppVVc75k
         Pk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UehPlKGt8PA5rBPsZJi5fUgjCQWFMytQP0IEcHEqyq8=;
        b=PFK8h+lbrNu4zQJmoYLn/vLIe2+J58qIpFHfZWlXRoJ/TqAoANJHtalqz9HiO6kQtb
         vEbGy0ngxtOUYb2dFJ4PinfVj+TLQN/iR5lbsxp+YI5rf4yNcEnsRzZqii3Ln36ZIURi
         6C1trxMUtrfy0+uT+xGMfmn2M4ou/xbPehzb/PuaupHK8s7IBuPooBHj7sCbcw7cNaPw
         WRoK8CVpmy7ytufcx+MAgnDTr1yDbkVJB+cicfzJ+BWLfg85JV0iJ+qN13PbZt0mBsha
         tTYSBwQYp5+JKkRBsfavoRbxuPQE2lxkzNS0tfOfZ8waLw/vAknd7pWUnkLuAbAd7sfx
         YyBA==
X-Gm-Message-State: APjAAAX4QI5MEl0/w+LDzceP3R4RZ/i7/cR73J+UTTnN2foiKp4SSFdk
        W7nMA493xJ/QwSByaHgg8neelUU1
X-Google-Smtp-Source: APXvYqy3H4/Fx3rFPi/NPwJJ97ZfJQtzpIx00UjPHcvtaiS5P4jkhjfGHGfBQcZpNovYUh4VATrSKw==
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr30895609ljf.108.1555097676455;
        Fri, 12 Apr 2019 12:34:36 -0700 (PDT)
Received: from [192.168.1.19] (chg144.neoplus.adsl.tpnet.pl. [83.31.4.144])
        by smtp.gmail.com with ESMTPSA id t28sm9555414lje.9.2019.04.12.12.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 12:34:35 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     robh+dt@kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, pavel@ucw.cz, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190405142855.3969-1-dmurphy@ti.com>
 <20190405142855.3969-4-dmurphy@ti.com>
 <04e160da-a73e-d330-3df4-8f420b3612b4@gmail.com>
Message-ID: <1a1482f7-a683-49d5-69a3-aa73a641288e@gmail.com>
Date:   Fri, 12 Apr 2019 21:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04e160da-a73e-d330-3df4-8f420b3612b4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And one more:

[5] - LED naming patch set v3

On 4/11/19 9:48 PM, Jacek Anaszewski wrote:
> Hi Rob,
> 
> I've collected references to the DT patches we're waiting
> to be reviewed. This is just to make sure that none of them
> will be missed - recent traffic on the linux-leds list
> is a bit heavier.
> 
> [0] - draft of LED multi color class - we would especially like
>        to get a feedback on the proposed brightness-model DT design
> [1][2] - LM3697 backlight driver rework
> [3][4] - LM36274 backlight driver with regulator support
> 
> On 4/5/19 4:28 PM, Dan Murphy wrote:
>> The LM3697 is a single function LED driver. The single function LED
>> driver needs to reside in the LED directory as a dedicated LED driver
>> and not as a MFD device.  The device does have common brightness and ramp
>> features and those can be accomodated by a TI LMU framework.
>>
>> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a 
>> dedicated
>> LED dt binding needs to be added.  The new LM3697 LED dt binding will 
>> then
>> reside in the Documentation/devicetree/bindings/leds directory and 
>> follow the
>> current LED and general bindings guidelines.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
[...]
> [0] https://marc.info/?l=linux-kernel&m=155414072611538&w=2
> [1] https://marc.info/?l=devicetree&m=155447454524411&w=2
> [2] https://lore.kernel.org/patchwork/patch/1058762/
> [3] https://marc.info/?l=devicetree&m=155447624324995&w=2
> [4] https://lore.kernel.org/patchwork/patch/1058779/
> 

[5] - https://marc.info/?l=linux-kernel&m=155405492231039&w=2

-- 
Best regards,
Jacek Anaszewski
