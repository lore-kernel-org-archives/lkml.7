Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B09C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EC92070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2BFc4di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfHLJFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:05:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52978 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfHLJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:05:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so11441584wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AWJiL+7zg6Ima534bZuseIPwdWeNk9fdB/sixhxGumQ=;
        b=K2BFc4diF9MOIydBpGiljdW9VVNeZjGfd7Trdr70W1zmTCMm++cfT3I4Gs1DJf8Hq3
         62ci06FebJH+iG7T+nbdizfzyr5OfCrOPDvPxFEaumY09OdROikoGmdWal5qANtysrHj
         lOZxURyUC3Tgenf1MwcdW828jqGejbQAMrhSgRd8A06JVpaLH0ym7VZeHROEIFxIVyvI
         2YeU/Y1crAYUffJeliGjfHNo8pm+WQshMEogGKM5u9gkYrISTdt9S10iA3JQ1pS7kUVf
         rSn8UH7WzYItHdPpj4DJV7GXZDBZL6W8wg5JBlcx1m8ZdsJkRX49MofZm9FGVqSmGY1e
         /ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWJiL+7zg6Ima534bZuseIPwdWeNk9fdB/sixhxGumQ=;
        b=WN7y4fNKd8/SD44HjFJXkrHkP3TSH2s2euCt7QQw/KA56CGuT75vXVZHOBtQ72XsAn
         Qx7v9mLWjjBNWIvWbv7EpHNOU8w0i2iM4K6pbtfBOcUwoFG6AXBvgQfLkBQzHVZOWhR6
         n5c6WbUEVxDfuugfrSvac8bgZkC+E3wwTcj08iQXjtuxEXAj4cPMSIRIMj6kg/TZPOGV
         0sCDjcLAYPAO+a1eosx6xnu8LJB/m5IY4sDJ9gqPs9i+NYp2a/gKUXRd8rPZn9jyEFau
         i2qq8NH3eMRYg0E3geYoo99aRZYRtCkjmmGwpdJUzgNVISstE7uWpsLSayJkb5kw2ed7
         2dXg==
X-Gm-Message-State: APjAAAVf2sc6OnP1iEwzsWMG9uRuTeXFO2PtEzDxoU7/zAF3rH1Bj2fH
        7gzv+3N6p81PO47/o+l3wFKUrHo2lXw=
X-Google-Smtp-Source: APXvYqx3TsRhS9G0jmEqnE5mj/Efoz83lMVWBRL4X5b8foKuB4AOhkC5BGzEj3PchftN1c/+c42EqQ==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr2426303wme.130.1565600706659;
        Mon, 12 Aug 2019 02:05:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d69sm7205314wmd.4.2019.08.12.02.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 02:05:06 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] ASoC: codecs: add wsa881x amplifier support
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, vkoul@kernel.org, broonie@kernel.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190809133407.25918-5-srinivas.kandagatla@linaro.org>
 <201908121031.HBxXaLjU%lkp@intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a89e6a52-35da-15bf-6561-c58cb3453178@linaro.org>
Date:   Mon, 12 Aug 2019 10:05:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201908121031.HBxXaLjU%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting this,

On 12/08/2019 03:46, kbuild test robot wrote:
> Hi Srinivas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190809]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/ASoC-codecs-Add-WSA881x-Smart-Speaker-amplifier-support/20190812-080612
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 7.4.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.4.0 make.cross ARCH=m68k
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "sdw_unregister_driver" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "sdw_write" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "__sdw_register_driver" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "sdw_write" [drivers/base/regmap/regmap-sdw.ko] undefined!
>>> ERROR: "sdw_read" [drivers/base/regmap/regmap-sdw.ko] undefined!
> 


There are changes in SoundWire Kconfigs 
(https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/commit/?h=fixes&id=8676b3ca4673517650fd509d7fa586aff87b3c28) 
which are not available in linux/master yet so this error!

Once this patch lands then below errors should disappear.


thanks,
srini
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
