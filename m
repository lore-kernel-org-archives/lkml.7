Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E92C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F77206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="uyy2S8G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLaAtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:49:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43034 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLaAtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:49:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so11929793oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cGITS8tRV+fFwH1Qa7Ng16oJctRF2u6XAUMtwq6rCrA=;
        b=uyy2S8G49RhmAXYlfJz0Ro/2wrb2Et3NpWXOih+IvhozMpJIlCEXlhCnp3HG3N7D9U
         AE3WrzvIwI9yR+U1YVal7Gm/Ia0/HVlcna09rdKcNX3/UA9PekSXlF3ypC/EIMeYNiqa
         bwTmlw9rs1JQTeenSJxnM+DwoF3OfF/AtwuXRB7CiEGMlrVgxYp2AiBt7pVx/EkMvsxN
         pHeuEpqFGqvw/rUbgnA4J09rlKk9zcIBOOlTNlMfSr8i/KkvreB5AruVrpb7PI04CJtf
         I5+NzsKQxag/OBAw0UX/yWOiNiwIuukJzHwAM5rPKIbdOdACMOEZ30a2qq1vk9SoJQdu
         lOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGITS8tRV+fFwH1Qa7Ng16oJctRF2u6XAUMtwq6rCrA=;
        b=Fd3/445/5mck78sdB10AO6JA66IYjPYbO0UgREtnGn0QPkCz6Gk3gYw3v/Epzq9112
         DT3OZcIeD03ZXbGAyfqnkvYXI7ewMBnF5V5Ojq/+37lDu3Lizzq4AIj8ShGufhISVR1B
         xXwXAJ3Gh/3UW6jYCL4WR0JgFBVua4+pFtwBdFT/ge6cGhbnlVGOtTLgPcIMRLVYj25w
         6dcphdrNvMU/sEtoliGngEVcLcsV+dWEc+R0bVzUT+rKS6AWgj/s8Ls59NFVHV59qiPi
         64GKGPxiZIwniV5u0pmjiomAyQ/akf7JShkrGKFqeWbfWpmXUFUjxkBXvlDU7aQs28LJ
         VMmQ==
X-Gm-Message-State: APjAAAVJmmIGzew6OkADJh23s3JnqQDzZPiJw02tMgKHmwBWhL490fdj
        zDALpcdP1aSzv94YG8rA+tlaDe/qU1c=
X-Google-Smtp-Source: APXvYqxisLV9EaScEub2wcnhCv7Ja7dRY0Nlw3R2Tr1K3X7d4vy5RGVVsO/iJ/1bteXe/n/PBvCifg==
X-Received: by 2002:a05:6830:114f:: with SMTP id x15mr75027236otq.291.1577753391278;
        Mon, 30 Dec 2019 16:49:51 -0800 (PST)
Received: from ?IPv6:2607:fb90:d7a:dfab:6680:99ff:fe6f:cb54? ([2607:fb90:d7a:dfab:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id a65sm16363253otb.68.2019.12.30.16.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 16:49:50 -0800 (PST)
Subject: Re: Why is CONFIG_VT forced on?
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
Date:   Mon, 30 Dec 2019 18:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/19 6:36 PM, Randy Dunlap wrote:
> On 12/30/19 4:30 PM, Rob Landley wrote:
>> On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
>> terminal), but the help doesn't mention a "selects", and I didn't spot anything
>> obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".
>>
>> Congratulations, you've reinvented "come from". I'm mostly familiar with the
>> kconfig plumbing from _before_ you made it turing complete: how do I navigate this?
>>
>> I'm guessing "stick printfs into the menuconfig binary" is the recommended next
>> step for investigating this? Or is there a trick I'm missing?
> 
> I've never had to resort to that trick.
> 
>> Rob
>>
> 
> config VT
> 	bool "Virtual terminal" if EXPERT
> 	depends on !UML
> 	select INPUT
> 	default y
> 	^^^^^^^^^^^^^^^^^^^
> 
> That's all it takes ^^^^^^^^^^^^^^^^.

Try to switch it off. It won't let you, it's forced on by something else. The
help doesn't say what. (That select means it's forcing CONFIG_INPUT on?)

> Does that explain it?  Maybe I don't understand the problem.

It's possible I don't either. I can disable it when when I start from
allnoconfig and then switch CONFIG_TTY on (at which point it defaults to y, but
can be disabled).

Rob
