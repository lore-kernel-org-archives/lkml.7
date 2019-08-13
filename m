Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31EAC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD420843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0rkni/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfHME1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:27:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46235 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHME1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:27:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so2546513pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GEFPODmOwtpyol0jKJkyySLW8YzPjzzTstkF4DAIU60=;
        b=l0rkni/t5bJRUPWIxOO8pVWKUqfD0fcWxT9WIqZd1EmFotYbaua9tGlb0goy1db0pZ
         zwjCQLB03DloiA9HKHM/fWQ7K/Zdu0Egwp1eMWhVGz4BXLJjCbv1tzgz1fEH++X6UlvF
         7yW+VV0NXRr1gldz/wAwqH0y5R0fccqpdtiScsxRFFL9RfYHEk8uGpGKc8qtYu+paqEA
         oe0EOfL/zhMEMC9Qb926bwpXZZ1ThYyWLBqwuEtjdyiHtNQ/b95+jfqvamIr0DwQU6mP
         a/yHwmACTBgHUH00oMOzaz43CYnrNMq+WgO5X4wAjz9ly1tL1+sDMnxLror456lwU8ru
         cxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEFPODmOwtpyol0jKJkyySLW8YzPjzzTstkF4DAIU60=;
        b=ndCDfH8FDOFyMdIRkYYjla2vQbIkTHS+vROgzUoljyGKyZ6HxlBvoWc2qybnIp4g5F
         VXkOwo9Fp7GEjkqyi1kCWK1PZTwUHhSdTleJDjkEULOfHp+y162NS08xmyD1a0xNHQTw
         ycQQi2Uy0nTL6otaJ0Fvq6h+9HU9uIYbWIi4BCysoIxixt61XIk3Wjz4+mLjY2NVxYfj
         IecmRbxAyY7QeH1Od/qP8UyaPKT41QH5MwsKo9MMFz5ZTpzU9lE/alAYHkoqkjpo5pgs
         5R+DsryOlUOqoYZPKYyLGjShxSrn8tm6kSNhrmwZQKmIR+RuLib32RHuqiFNgOfVZ9zF
         XwFg==
X-Gm-Message-State: APjAAAWqIsOdGPoJF6YXGI06I5iDaT33gJW4IPeAqtwetBuarsLcVIhq
        z1jWS6LYiabcL8CU+5HOJZn9FWxr
X-Google-Smtp-Source: APXvYqz58t6lJ/02qNDLpTaCKkb3QA2zluFCFqqMgD/ftAEhBkijBFozd9OHgKjdmFye+ihUKt3a7A==
X-Received: by 2002:a17:90a:a013:: with SMTP id q19mr428309pjp.64.1565670473129;
        Mon, 12 Aug 2019 21:27:53 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id y16sm8383280pfc.36.2019.08.12.21.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 21:27:52 -0700 (PDT)
Subject: Re: [PATCH v2] regulator: core: Add of_node_put() before return
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190808070553.13097-1-nishkadg.linux@gmail.com>
 <20190808122740.GB3795@sirena.co.uk>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <106177ee-d6e0-5825-83f0-ca199b05ac20@gmail.com>
Date:   Tue, 13 Aug 2019 09:57:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808122740.GB3795@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 5:57 PM, Mark Brown wrote:
> On Thu, Aug 08, 2019 at 12:35:53PM +0530, Nishka Dasgupta wrote:
>> In function of_get_child_regulator(), the loop for_each_child_of_node()
>> contains two mid-loop return statements. Ordinarily the loop gets the
>> node child at the beginning of every iteration and automatically puts
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
> 
I am very sorry about this; I wasn't sure whether this particular commit 
had been applied. Should I split the commit and resend only the change 
to the old commit, or should I leave it as it is?

Thanking you,
Nishka
