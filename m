Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CE62089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ8bBFjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfEORF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:05:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44724 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEORF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:05:58 -0400
Received: by mail-io1-f66.google.com with SMTP id f22so140002iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBe9dgFDsugBtLAz5/2Y+Npf9/m8OB2uVKobGZuK2I8=;
        b=VZ8bBFjFTaKZLPei1dxsswXl2ZcDu7lFvXXrKBdR9hclV5YIWD+PtUkNESd1aAZ5bb
         +f7auGB56mRRWTGiY02vb8MkNxvdk19aUD2qHZNDrHhAsQn7XjiqrClz4U8vesyxpP71
         iTadLIO1JK9aEms9wg0pR6y+PzImrwoVLc+c/mHydzaounTexbA2Yf243MrTPPZ4rJ8y
         CauwrWA34siNeB6mAOPUngmNc9E3U1xdIW+ymzLO5agLFDgIsApRAkW0RpEDAPsQm5s+
         XJ13IEw/S8OtXfvdhUQZr+B8utv2dSWa8d9nNaPRO5iQJmzYqr7GEYgtc48LTxs5ytTA
         n8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBe9dgFDsugBtLAz5/2Y+Npf9/m8OB2uVKobGZuK2I8=;
        b=Wu1QdGwG6+H03IPlWzuzCNQ154lzLRvs+7VJLO4rK+SkXPOrKdK11+8qsZUgSTa+QS
         MjhQkP2BGPZoix4kvwCEfU/ZxtyCDVzxoeVXZ+x4XocngMDs4Pr++UFMte7gnfXpHS4z
         PEdfwlLbZzN2bLfZTsfMDQ09G6r94KN0VJPPN3dKb3ZkB1rGSCl+aVuPN+KsmtbPOH5/
         imaov2OeNJQT99DKzqNNUykZvk4RLNAfRR7nrnQGkYObR3fLOEKbd5WW/6+TEmBZ2wAx
         ENw5lxCIvlhA72dbV+qErh6biyNW+iWvCaHz4dxA4QIUv7MnSjhvCeIKweeVTzQ6554c
         0Lwg==
X-Gm-Message-State: APjAAAUdcOy0DMnacr0mqddhbPHxyEc7SQ+v1GvPjvlPul9GfraQSYq5
        ItaN/T4YBS3dgFVGe5pI+Zwvd40fIAA=
X-Google-Smtp-Source: APXvYqzcSP6jADi8aHdPDR0G96LkLt2PxnWx2cAF+Oviy/OsTwzRETwoGg893A/AzTpWRmy8RZDCFw==
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr20232835ioo.0.1557939957859;
        Wed, 15 May 2019 10:05:57 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id x77sm271304ita.1.2019.05.15.10.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 10:05:57 -0700 (PDT)
Subject: Re: [PATCH 03/18] dt-bindings: soc: qcom: add IPA bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-4-elder@linaro.org>
 <CAK8P3a3KLj5x-5VS5eUQfNVhPL101Dg_rezEzra4GFY5Dva2Cg@mail.gmail.com>
 <fa75eb5e-90bc-b164-740f-4dbba8bccc46@linaro.org>
 <CAL_JsqLz_ALmzhV9ezjPCvbuBmZmzMCeowYJkHo7WfNvqruubA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <45b4e25e-b075-7a01-b423-e1768ebe38ff@linaro.org>
Date:   Wed, 15 May 2019 12:05:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLz_ALmzhV9ezjPCvbuBmZmzMCeowYJkHo7WfNvqruubA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 11:50 AM, Rob Herring wrote:
>> OK.  I didn't realize that was upstream yet.  I will convert.
> Not required yet, but it puts the maintainer in a good mood. :)
> 
> As does CCing the DT list.

I'll convert it to YAML *and* CC the DT list next time, to
avoid triggering a crabby maintainer.

					-Alex

