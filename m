Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A6AC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B8213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558400438;
	bh=LtL+RB0agJD5F5VfJ4bfygn3RJeW/fkxnb28yT0PqCM=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=dUxPo+p4z2221LL1wsQy3s2sEQv6UWLF0chosJz4ziuwkNMgdF5/gyj7Szi3Uz21E
	 abmtMmam16vI2Rwq6JnKOLkZ+20e7+q00c1YXAIZAhERmFxlJOjIR0jgf3Rgj19zDe
	 s1maaO34mIvtowNVYKmkbqjGUHiRDCiUxpzE6ts8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfEUBAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 21:00:37 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:53262 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfEUBAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 21:00:37 -0400
Received: by mail-it1-f176.google.com with SMTP id m141so2147994ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HhJriDSImqAzyFl064+5lDvBxh/7qclB/5524Hfzl7o=;
        b=PxdyTJXsiHsx2BrvoKXcsFmkwADEqjhka5e/p8Hg+2Mo4e7YlbdVRrmPRjmluSrQQo
         PPi0iZZkihAzuwnAWa+xM+Xy+Dgsk+wuTeWe/htgUnVKSlKTWF1HbB0IAjKScctit3Wd
         ymolOmeJX7JDKidCIRunMbzqhTRg9iD36Rjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HhJriDSImqAzyFl064+5lDvBxh/7qclB/5524Hfzl7o=;
        b=FoiZVGcoMScipZhc+dpiHFYMGQXEz7BfedDLTb0tgEW/1LQJdp504yP6qQFkknHMdb
         48u8vLeBwhNu27KfTl7qAnYZUAF8+kFICjDCTB+ofLrKpZccQcJ4fFa0woF15SU/NNaa
         rJtHRwaydmsj/krkELbqvhvX+EKf6Y16axH8wHGTvVto3INLElaswIj1bEywbyL3NrPB
         AXyivT0wRjxBoWEvEbTm2lS2ulN/nLBNGL+UkWppT7A77LBDmdSqmAvhfIl50fuJnYU5
         HvbtQ2G+VRjGFWOjqTyHadGp+ktoaAlBd4EDrxKUO60ky3q9hb/9c6CJ3T45dkk0xm32
         Zpjw==
X-Gm-Message-State: APjAAAXnQ5TvglznjugfFIoS3P7JKkt4PfCmW1Q3cITDi9X95OVg5/9j
        EfGu7wYguerc5OiPhi2MPzjeCA==
X-Google-Smtp-Source: APXvYqyl06P+cfQr/ZyF/tpJLi0szl8RuZV0D0d5YEX460Xj751ihox8SG48hNXUrlprDnG2V3q++A==
X-Received: by 2002:a24:b048:: with SMTP id b8mr1671030itj.115.1558400436345;
        Mon, 20 May 2019 18:00:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x99sm624324ita.28.2019.05.20.18.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 18:00:35 -0700 (PDT)
To:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.2-rc1 - module name conflict
Message-ID: <a2fc0be9-22a7-cc0e-bdce-0a5ec7d31251@linuxfoundation.org>
Date:   Mon, 20 May 2019 19:00:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am seeing the following warning on Linux 5.2-rc1

warning: same basename if the following are built as modules:
   drivers/regulator/88pm800.ko
   drivers/mfd/88pm800.ko

My config has:

CONFIG_MFD_88PM800=m

CONFIG_REGULATOR_88PM800=m

I don't recall seeing this warning before.

Anyway just to let you know that there is a conflict in module naming.

thanks,
-- Shuah
