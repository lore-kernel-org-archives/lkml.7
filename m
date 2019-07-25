Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B490C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB0322BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjm595ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfGYJtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:49:46 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36108 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:49:45 -0400
Received: by mail-pg1-f169.google.com with SMTP id l21so22764056pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=oZSwNDTQE6wHoAx64RntiWGx7Zw6F6VIIKSpa+cvjO0=;
        b=mjm595ixiYU7VCkkUMzNZckTFgvqQ34fOydYaMYAih1h0CCB+y7qZe2FPnEL+kfIzU
         ZslbsZ7YoFD72G2hwUBc5RGkiLQbe8Pw7APcZzjxE47CTrhF1HoN2dGPrZnuMCqEcfmh
         p45ehMUw3aNB5tAdBFQczsNpwpTKIBcaBu4BJ7oOKOBnItIxbLnJ+Ci1l/T86ATjPJIW
         2SdD6YN/oeYOj5QzhspJ14RGZ1k3an7xptG7Tw+nc8nD5WrskPe4cxAF4w+DNXA66Q1v
         ah4eQu1NBBd9vkDtzvPNFHDIdA03Tv/Kb23emvDtehG7BvtLdfKFAIr3JiRA1BxLFrxV
         MXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=oZSwNDTQE6wHoAx64RntiWGx7Zw6F6VIIKSpa+cvjO0=;
        b=OPn5plx15DaYjfFMghTuoJsv2qoF51wJuXiT115k2sv7Sj2d3qrFnwzw3p7uRyU513
         tvefZo7m/XtQ/KCohgCwY048AtG/1NqjxbZVel8WyBe5rEyg99FLCNmzpCsTD/xT2qQi
         LE+R+a40ZeOmCwXnY2soCgT2n/dDZYT/XNdIsNdLml24MIDefRi359PT2ysr1xeIYM8O
         X06iaXt26mvvgneKDTa6K7QkFqiRIFLdr8sUHFgaGRWpXGA3NpUP6NMrbXL/qML4cVoP
         zif/N8LY5aer6zEV7lZT1wJ0wHKGcuUZyvUagSdDytAf9rnSDgKdMEzo++28ff3mCUw+
         QEvw==
X-Gm-Message-State: APjAAAWg48Jni/mGlJbJ/O5+Wy1UtMfQ6YHZUXcHf3sBaICko8G5JchZ
        heDHDsJuRwOBO+twNJ9kggT0SWZmyY4=
X-Google-Smtp-Source: APXvYqy4/rOfkfiy1cFV1h646JsiLRHGm3LS2zm8tqb+EzXwDn56CYgbp9RigZdx42cX4n2gc40Lng==
X-Received: by 2002:a17:90a:376f:: with SMTP id u102mr92762286pjb.5.1564048184358;
        Thu, 25 Jul 2019 02:49:44 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id p13sm127488877pjb.30.2019.07.25.02.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 02:49:43 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: f2fs: Possible null-pointer dereferences in
 update_general_status()
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-ID: <f577be2f-fc2f-9ef8-2c6c-9c247123b1ad@gmail.com>
Date:   Thu, 25 Jul 2019 17:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In update_general_status(), there are two if statements to
check whether SM_I(sbi) is NULL:
LINE 70:     if (SM_I(sbi) && SM_I(sbi)->fcc_info)
LINE 78:     if (SM_I(sbi) && SM_I(sbi)->dcc_info)

When SM_I(sbi) is NULL, it is used at some places, such as:
LINE 88: reserved_segments(sbi)
                   return SM_I(sbi)->reserved_segments;
LINE 89: overprovision_segments(sbi)
                   return SM_I(sbi)->ovp_segments;
LINE 112: MAIN_SEGS(sbi)
                     (SM_I(sbi)->main_segments)

Thus, possible null-pointer dereferences may occur.

These bugs are found by a static analysis tool STCheck written by us.

I do not know how to correctly fix these bugs, so I only report them.


Best wishes,
Jia-Ju Bai
