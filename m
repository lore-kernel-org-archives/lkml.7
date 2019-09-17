Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAA521897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8kgXk6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfIQIU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:20:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33639 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfIQIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:20:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so2141770wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooxyqxa7x/R7JS6kmUze9WDWeWOPEgPrBCXwkn2IMZI=;
        b=k8kgXk6miA9LFL04jUOPJRY9gQ0tvHTEeubW1Gws5kaXkJ9uy8FfzxgW1wKvcOkrcQ
         2uo//SwUScyEFSdaBIFlyMErhInJgUuWLgZx06Qm+GsSsU+rHh2Fya1F+2HTDiEjy5pv
         du+41GKWsBTJX6yTbE7lMuB1jmqa8yv5xBhc6Y7B3DMxJA4JGs4HNS6hxLDerwuxEkTk
         RoBXGQsa7TOfUeHs6ULwDH1lG5B8cmkFze+cQkoMj/B2htQ44SGPfyfFAvY6EpNNFbYq
         neSA1Hbu5fP18ezd1CKEscgJe5gaPZP7yXNVhW2eHJHEkLr6fI7UsSwMhLjAbVQ0Gats
         27wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooxyqxa7x/R7JS6kmUze9WDWeWOPEgPrBCXwkn2IMZI=;
        b=Za3GXQNpu39USwoOMISpxWk+lv6y5at/hNLtgmNLXvGNLrWF3jPcf0SBXMo54HQdnc
         QCYx7YOC6fBhEpmu64wn+bCorY+RQdGir6buw9D+SfNO/tmfVbbngPIo5iuj8x7LKmGx
         n0jLAJJf+mvM5oXwzuLgGKdussYQ2l0zhR926wZxWXD1hOBVJ/uvbMIfFNGp/G+egmkO
         aP2LDiGELveqHiJm+wZh9+bGZgA07ItR8Dho+Oh+wBAKGfg1EKsjsWqsPN6CTp1b/ObE
         XUFXN50R1wJ5a2kaZ4kE+y3l7T2r9NieCH4C0KoUcZrkuJQ9DbQemtADl5BKdgJ9fAdA
         a8xQ==
X-Gm-Message-State: APjAAAWWAGVFJKpVQI07wYjPNySxz7t21fBIOArh9oTJs+B2OmLc+Cd5
        aeSNaIBHunosAJvDGNeuPZj29FR9xAk=
X-Google-Smtp-Source: APXvYqyqRHSqbYS4dvcV9Y0J9l9E4ZpiKMjyeWESxLZ/5sPzZf+DLKDOdSgd0dePVEzA+pkPjkoHTg==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr1820298wrv.68.1568708454346;
        Tue, 17 Sep 2019 01:20:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x6sm2016910wmf.38.2019.09.17.01.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 01:20:53 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: fix nvmem_cell_write inline function
To:     Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild test robot <lkp@intel.com>,
        Han Nandor <nandor.han@vaisala.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190908121038.6877-1-sre@kernel.org>
 <CAK8P3a0rqeksffu4swv2BGzhd68Brb76VFUCyfqtFAu6QppVgA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b5e97c02-2fa5-17bc-bed3-851d7b58b1f5@linaro.org>
Date:   Tue, 17 Sep 2019 09:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0rqeksffu4swv2BGzhd68Brb76VFUCyfqtFAu6QppVgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/09/2019 08:57, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 3:45 PM Sebastian Reichel <sre@kernel.org> wrote:
>>
>> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>>
>> nvmem_cell_write's buf argument uses different types based on
>> the configuration of CONFIG_NVMEM. The function prototype for
>> enabled NVMEM uses 'void *' type, but the static dummy function
>> for disabled NVMEM uses 'const char *' instead. Fix the different
>> behaviour by always expecting a 'void *' typed buf argument.
>>
>> Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Han Nandor <nandor.han@vaisala.com>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I still see the issue in linux-next, did this get dropped by accident?
> 

I just pushed it to nvmem tree, should be fixed in next soon!

--srini
>        Arnd
> 
