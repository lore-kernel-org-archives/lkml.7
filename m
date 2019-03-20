Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08331C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F882175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SBJeuqyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCTWMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:12:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35317 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:12:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so4542032qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nX5UkKgqpFczb3/+huvIPo48+SpqyuvBQVCHkeMfnt8=;
        b=SBJeuqywHpgOVahMOisoAa2/I9E8f2gQd+FLijWp7GI2RoJf5ZaxLc43sjOzJ/zvkG
         hsGzx63zS3AgqvbSCsWh6prJwzpOGqwORiomJ+qA3N4OpnagGzxk0E4c9+MVPT4elTnw
         dKLXo4OaWw2r7ZI6g3GEyRUM+k25eTxVeboELeWKtK27qeYZBX6m0Q0ZzLwHqK2qVHdP
         vle1DkkUd32xbCdUCUmzQrpYvk9K6JPnhG+DrScXCxDKlQJ7R73ULlMDHRDzANM6cUO4
         oFSNFjYtZ+WM/npYHyp7l10Vc9tIDvwGFfQ3dIjpOQfhEsXZG7clk98W4BJ8kDM04YW4
         Ya9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nX5UkKgqpFczb3/+huvIPo48+SpqyuvBQVCHkeMfnt8=;
        b=SsClPrFC+AOKJru8w1DNpB7KTpMHELUmUcc+9Gm26m7D0o9qo7hkKq7aGkDBYzCElG
         7/eKMRG2R9eRkj/9PHDeLPTm1Z1cE39+/dMAywM3H6nJwJjOZZN2f0RPKAccYV2OHKpd
         FojujPe/jh9uNuzR89Xf/rfYs576riOwGCEb4C6UvbEKmN6b34zGbtVT/p5MvtOObVHs
         yevhtRxykieU8f1PRZa15emuRof0n0mJrBKzV63i9Oir8A0hYoYpddeL56x+p+1QVgIT
         zdffdfl9xaZFpcLkbvDDzmhidsEc1cP/8gLXrr3np1/RQHZ5tpOeOkjmwKWlef6WLgeK
         Ngvg==
X-Gm-Message-State: APjAAAVC+ebLf8AJimC7Mfla08j63GumznKLYk+mufYpSTfix83ad1rR
        edLyrUycRYeXSd+gGpRO5Opb3/XuJhQ=
X-Google-Smtp-Source: APXvYqw+uT7JrioO/XZkOIfnQXrjn3qFSl531kmhwLmFIuuia9XLfo/TJ7ydD/byQLf6E0mngNQ8Aw==
X-Received: by 2002:ac8:3629:: with SMTP id m38mr144460qtb.369.1553119962395;
        Wed, 20 Mar 2019 15:12:42 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d205sm1775689qkg.66.2019.03.20.15.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:12:41 -0700 (PDT)
Subject: Re: [RESEND#2 PATCH] mm/compaction: fix an undefined behaviour
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190320203338.53367-1-cai@lca.pw>
 <20190320145826.9c647fe53bd999bbd2ee188d@linux-foundation.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <a82bdba4-530a-95fd-8a05-5fd2fd67e4b4@lca.pw>
Date:   Wed, 20 Mar 2019 18:12:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190320145826.9c647fe53bd999bbd2ee188d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/19 5:58 PM, Andrew Morton wrote:
>> ---
>>  mm/compaction.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index e1a08fc92353..0d1156578114 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1157,7 +1157,9 @@ static bool suitable_migration_target(struct compact_control *cc,
>>  static inline unsigned int
>>  freelist_scan_limit(struct compact_control *cc)
>>  {
>> -	return (COMPACT_CLUSTER_MAX >> cc->fast_search_fail) + 1;
>> +	return (COMPACT_CLUSTER_MAX >>
>> +		min((unsigned short)(BITS_PER_LONG - 1), cc->fast_search_fail))
>> +		+ 1;
>>  }
> 
> That's rather an eyesore.  How about
> 
> static inline unsigned int
> freelist_scan_limit(struct compact_control *cc)
> {
> 	unsigned short shift = BITS_PER_LONG - 1;
> 
> 	return (COMPACT_CLUSTER_MAX >> min(shift, cc->fast_search_fail)) + 1;
> }

Agree. It looks better.
