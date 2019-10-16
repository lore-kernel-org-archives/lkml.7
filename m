Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF19FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54FD21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqycmVl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394194AbfJPR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:58:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33344 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJPR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:58:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so15216071pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O4neeP46Aj8j5ls4dZXm/jjSg5a94zuoaIAF6BtKDgY=;
        b=ZqycmVl+8d17eNUxTMRF7q7RJFdCpbcpcUAnhv2sxBWLCaEgaB8q4zpvkO4RzF1AF6
         S/wPPTIMV+lDmKnP+3FP2sLbPT1R825/ZPk7ObeH62eaN4rH7dR+12KD8fz7BHBtvvfb
         54S2A3LZnKOrjqzNwQCnRUZVhBahTgWPzqv392Eap26NqbgIeGOHXDLAKrENclxw1xch
         4isdhXkAVukgL7ulhVq9+iIZfRotAirHfxDgetpUcZ0oTMMxwrDwGinZSFktvh2meqZH
         xTXLuhdTa+OgiialtOXaGvrFgj8wQ7h+FOAP1lPkFlWWf8hNEE09X6w1U7fhvZgMn18D
         HoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O4neeP46Aj8j5ls4dZXm/jjSg5a94zuoaIAF6BtKDgY=;
        b=T+fs+JK+V6CcL4geypgieicUZYYtw1/fFxRbieSwpGdXRXAmfszDL8OlqOGFeUDN6k
         YHDyUVCo4vFoMz2qJl7tyWIOrUTtLk5ie+L8LcPrHEsg5MTU9iFPw6yK8YvY5mXnXr8k
         Ar2LL71K+p2Ni69QMYGItVux90D5TL4h73tjmqqlXwr2wJLHmDyvj1CeIiWaiHeVVu2t
         G1XVDvlBHluamjxpl785RbAa03wt4riy/45uC7++DNQ2JfPn5OsnoGhIWD4McuJTZoKD
         1ESpVavbmB4Qyw4tliMq4ywhsXYq4vqbCy1kzNqYfYre5BztsCj2VT8sjwXD/4Qa3J2z
         2Sqg==
X-Gm-Message-State: APjAAAUoGKV6ZP1Y4TwQZLYI5PNDCLkw35fnegt2EeXmauiIsB2aEoQ1
        omzTQBKHE8qJg4fZiWSHIk4=
X-Google-Smtp-Source: APXvYqy4/EL5IUYq4Ot0vpCK8X+Jb259afT8E1SFeYsIGBOEwUcSeFS27lREJ8hSRCuQbAelmCvuZQ==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr241267pjn.39.1571248731173;
        Wed, 16 Oct 2019 10:58:51 -0700 (PDT)
Received: from iclxps (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.gmail.com with ESMTPSA id d5sm39592753pfa.180.2019.10.16.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:58:50 -0700 (PDT)
Message-ID: <38f39e9e77cb4bc809a15da45d988f33cb0f7f00.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Wed, 16 Oct 2019 11:58:48 -0600
In-Reply-To: <20191016125615.GI16384@42.do-not-panic.com>
References: <20191014153344.8996-1-ztuowen@gmail.com>
         <201910150232.F7RTW83B%lkp@intel.com>
         <c4bcdf14e0a60a679429eebd439b2380d97dafe9.camel@gmail.com>
         <20191015074434.GU32742@smile.fi.intel.com>
         <20191016125615.GI16384@42.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 12:56 +0000, Luis Chamberlain wrote:
> Indeed, can you add that? If you are not comfortable the way to leave
> behind lazy architectures is the HAS_FOO feature and then have your
> driver require that or depend on the archs that support this. This
> allows non-lazy architecturess to move forward with life.
> 
>   Luis

Upon close examination, the issue seems easy to fix. Going to submit a
new set shortly.

sparc64 and hexagon don't have ioremap_uc defined. Hexagon also doesn't
have ioremap_wc but didn't report an issue before so devm_ioremap won't
have an problem.

Interestingly tho, majority of the archs include <asm-generic/io.h>,
thus having prototypes. These two archs and a few others don't. I'm
wondering if including the prototypes is actually the recommended
practice.

Tuowen

