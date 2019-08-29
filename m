Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E1FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqG2adsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfH2UAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:00:41 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44156 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfH2UAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:00:41 -0400
Received: by mail-pf1-f173.google.com with SMTP id c81so2788985pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkefRpHhPpQBjXysRY3mbOcTpi1NAYNRo0gZduV7DwA=;
        b=lqG2adsZN0rapMmSDiKsP6NsIFhyNun7jd2mSev2QM3rezIdaeO543noug9zilvKAK
         9LNwjMtNXgSJ/+4RPRyJsykl0p+gVNJ5oA2Z+D+JfAQrao9qJ6cveRSqH8vChabkAI1Q
         Te3VUXRjQbcuSTBJvdWCPXVIky6ILFQE1+rC6KyguE5GfKYFwzZ9MSITmo2TSAqPNHYs
         118bN3dimHj9VwZGYqoBD9ggfiCd/cA27TA2IH/9iONupjvNU+TshuACYt/qlwFo6EUY
         9gFCipC+75B0gmRW8kdkbJ2K/Em5lyKAvM4ouQZu+32uAcXWiziABbSEGNy2tV8XoYYr
         dAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkefRpHhPpQBjXysRY3mbOcTpi1NAYNRo0gZduV7DwA=;
        b=qH2Q1HFdvKcjHG0gfzALUujNsYkI0xiuuhVYdzcBXIBjZOIew4e7WThLgARONnsPZn
         AUWppvFUvpl6ZENe3iwjxJL+g+wa0CZGd9NmGjQdVcnRpKxZcHJJ8Rmqa23+Elmz7ygc
         NmnVRsk2BSMIqMOrcZUz4CCt0Zu9s4kuSF2pDQ3QaQ1CNUT3EpQ6krfI+w98yB1udnbE
         F4u63/hMX+pSXwYCdrbco4ktDk8JgxNeKFmxz7RdvGH6sx/8pcY9eLWWH5RiFC/HobKM
         uM/RbQjz6Y+HX2Lx9yuBYMzhCxBrhxQaD4cxXRoSdFxzNgPi5mE7B6NETyzTz9GfWYZ9
         Zstw==
X-Gm-Message-State: APjAAAUyvNsmt1vZU2eVWwC8Cxk87W7tVew1oTN7Z7jFEsfg38UlY4iq
        pTDmMdB/Kk3rd7znk27p/js=
X-Google-Smtp-Source: APXvYqxHkBqH634c/3hf+pqVAKDbpAVa43BLH29PFU+Tzvho0KkwDKz3GNAJMVp6lo910MkBK51LMw==
X-Received: by 2002:a65:6081:: with SMTP id t1mr10012365pgu.9.1567108840240;
        Thu, 29 Aug 2019 13:00:40 -0700 (PDT)
Received: from ?IPv6:2601:641:c100:83a0:7543:d89b:60ad:490f? ([2601:641:c100:83a0:7543:d89b:60ad:490f])
        by smtp.gmail.com with ESMTPSA id j9sm4130638pfi.128.2019.08.29.13.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 13:00:39 -0700 (PDT)
Subject: Re: [PATCH] ARC: unwind: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
References: <20190821012907.GA29165@embeddedor>
 <2c3ef09b-bd07-6caf-05a9-908700a60afd@embeddedor.com>
 <BY5PR12MB403422F37413E42066FCA9BEDEA20@BY5PR12MB4034.namprd12.prod.outlook.com>
 <1496d4b7-f07b-01e1-c33d-b2d4c501d9dc@embeddedor.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Message-ID: <a549a117-5ec6-85f5-a4b4-fdc1cc267763@gmail.com>
Date:   Thu, 29 Aug 2019 13:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1496d4b7-f07b-01e1-c33d-b2d4c501d9dc@embeddedor.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 8:05 AM, Gustavo A. R. Silva wrote:
> No. This is a different one. Notice that the subject lines differ by one
> letter.

Umm, indeed I thought I'd already merged it.
Now added, will show up in linux-next after rc7

-Vineet
