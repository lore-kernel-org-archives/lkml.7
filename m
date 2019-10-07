Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74AD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lJsltAwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfJGQue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:50:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfJGQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:50:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so7119734pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+w6HGwIeJz41HW0Pum9Qvdf3wavqkNbTaRf9Bcybxb4=;
        b=lJsltAwBXOB7dzBNHRpXWNUxozcGk6hPiEnSnYGI2AGONfo3Tz+aNwgBqtQj8Hwk/1
         AGAy6E+fMSLqf4xqAgfjfRQ0JJG1SD+7XAORxZzNsdSuFUVqP2Njj0W81UoVYxvKaoOi
         Ch3KQ+MtptGeBccMUkJD1OkVksmM2nIzJjk3YK46o79KJ2tqlbT9YWIQgWXHdXNCOzLv
         yWXkSTfWYSUqyMQCEQMWgBas7nGOZ+GURuYNGsOnD3j68YyyA+Qraj7xocqUO+ZfHwpT
         hMdSXfvr+tfcnP/ZXXnEogDA8CxA6I7a7fAaQCG6vp/aCtsYpkd1NRX90yOTPZawQ17U
         oYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+w6HGwIeJz41HW0Pum9Qvdf3wavqkNbTaRf9Bcybxb4=;
        b=iefXarsJzgExRaEOvTjThVj4HIYrhH1Lh5oe5XKnUAveGNf+gloFlre8dcEDX3SmkY
         vwGkFwkgl11jGiI670xq/w7fFP+aCyqWHaDnsWsyL+1fimLaHyVM1i9vA9YxXGBX6Yrs
         OKJ5L+iFMvvmEUp9ZyUqVXfALHiH3PWesoMmL+AZttXqfoqFPuXEGGZS5D83bge5vXW+
         e8IuvGG5M8eL6Otbx0u4jW0S0tliejrashMZewf/QVJusTfgM62lO9LzmEJZLq5BesBd
         Ec2BUKLfJbIsaZgECVg5oXT9sgGrbC+37j0qun069ok+Lk2dufo/+ln+rWOnsRshSznm
         1gNA==
X-Gm-Message-State: APjAAAXaN++VE1P06vAt6Ss2xH5pF4ACB1SIPtCt4AOOILXt0Cm22Zre
        oVkgtoo4TbrrzR2K3/ZnBmuy6/wk6RVbyQ==
X-Google-Smtp-Source: APXvYqyqhgEmYg2SNMgR0qFTRxWnC5C0Pd3FzJLguS6YtT9AKzecBtSMeeO78IlNFu5TcTfGadfDhg==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4mr31341979plp.189.1570467033479;
        Mon, 07 Oct 2019 09:50:33 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id w11sm880349pgl.82.2019.10.07.09.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:50:32 -0700 (PDT)
Subject: Re: [PATCH] mm: export cma alloc and release
To:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20191002212257.196849-1-salyzyn@android.com>
 <20191003085528.GB21629@arrakis.emea.arm.com> <20191005083753.GA14691@lst.de>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <aa1c5b2f-fa90-4390-edc6-33b87fab5e09@android.com>
Date:   Mon, 7 Oct 2019 09:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191005083753.GA14691@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/19 1:37 AM, Christoph Hellwig wrote:
> On Thu, Oct 03, 2019 at 09:55:28AM +0100, Catalin Marinas wrote:
>> Aren't drivers supposed to use the DMA API for such allocations rather
>> than invoking cma_*() directly?
> Yes, they are.

We have an engineer assigned to rewriting the ion memory driver to use 
dma_buf interfaces. Hopefully that effort will solve the problem of 
requiring these interfaces to be exported so that that driver (and 
others) can be modularized.

Thanks for the reviews, drop this patch from the list and we will 
regroup, and accept that standing code in the kernel can not be 
modularized for the moment.

Sincerely -- Mark Salyzyn

