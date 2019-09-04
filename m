Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D325C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8E52053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfIDQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:09:15 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43958 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbfIDQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:09:13 -0400
Received: by mail-pf1-f181.google.com with SMTP id d15so4026951pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XErXDQUXB06HtDTOiYRG9XmArU9bvhEptkEPoC0URcA=;
        b=JyYw4PHfiayDaITAV/QBm2/ef9+99NMsvZSXHuHM2u0slzTaz6BGwNQ3YQgDueFh6J
         ypuwcQmQlg9/yNSLetqHVSOA5fZKyaYEGcyHoqLpG2n0WiwrfwzlgDb6jY1ULC0G5ifq
         r02go+r+97mcHcMCBgEuA3Gdenja/6TEh9v8tz30VPqbP9XievN97vTWaUQnjFCR2CM6
         8kh7qV3RDEXZ7zNXDkBsvhS72pKMlWv0djVW5/ukPRIF0i35plO14mmn/RCgDUloprCT
         K1Ow+zXY5p5lOWQdSCoB3d2docwgrgPR7XWa5mp4vCIeYr4bYL9qdoFY0bYPpwm1tm3d
         5a5g==
X-Gm-Message-State: APjAAAVIzKy72HjJpn5ffUnzdw0Gs/N1JlwKPPIFllhU9nCf9OP6swaM
        /9++3jkUYdqNKbyUN33X4dH7TOaX
X-Google-Smtp-Source: APXvYqw0Ks9MUXGu/5Cf6iBSADywOoWtDQLLDbxBDQ8d9toYPzgTjAcQLLN0ef2hdNAfHtQzc/Ct/A==
X-Received: by 2002:a65:4546:: with SMTP id x6mr35120577pgr.266.1567613351999;
        Wed, 04 Sep 2019 09:09:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v12sm19059248pgr.86.2019.09.04.09.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 09:09:10 -0700 (PDT)
Subject: Re: lockdep warning while booting POWER9 PowerNV
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1567199630.5576.39.camel@lca.pw>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org>
Date:   Wed, 4 Sep 2019 09:09:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567199630.5576.39.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 2:13 PM, Qian Cai wrote:
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would generate
> a warning in lockdep_register_key() at,
> 
> if (WARN_ON_ONCE(static_obj(key)))
> 
> because
> 
> key = 0xc0000000019ad118
> &_stext = 0xc000000000000000
> &_end = 0xc0000000049d0000
> 
> i.e., it will cause static_obj() returns 1.

(back from a trip)

Hi Qian,

Does this mean that on POWER9 it can happen that a dynamically allocated 
object has an address that falls between &_stext and &_end? Since I am 
not familiar with POWER9 nor have access to such a system, can you 
propose a patch?

Thanks,

Bart.
