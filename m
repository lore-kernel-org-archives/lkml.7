Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0229C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aHNWAGSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfCZQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:28:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37962 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCZQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:28:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id g1so7996477qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/wpwKdMVG0oTQnXOWcN3I2M9b37/KAz7yPdS4OPMwQ=;
        b=aHNWAGSYHIFWV6wH602bIhuuhWG4H3Mq3O2ilDDUPsupq89kmcH1olHvnSMpKudKk9
         0SABcvyLgydmIATiCY2j6ReJSDWUrQjgmQV4QlX314dsMLp64ZeD/hQorkcs+3rHYFZZ
         7mjuhMM4sKqP7An2PUceO+DbEZ7nnlyLkeQ2Evhlzdw0eaufSAsXKgrfAdbd0Jd8vQxF
         1qt9mD6nNh2diI5WWkCPRKIVqrt+/OiZrkfmykws8GtGFYrxIYB3HqeOHo6QKq//qFY4
         6k9wvk9GWyUu5CwUB6VlbupyUNSn9kHQWpiMjlHsXrXrCwAVLqOGoGZnZK2nvelkRKzx
         4ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/wpwKdMVG0oTQnXOWcN3I2M9b37/KAz7yPdS4OPMwQ=;
        b=m99LnyQqSi8LbCpmPXgDHdW9Q/grZL096yPGygYyjWn1WAXgONVfk6/v2ie4xIzUg5
         M3SvCltBA72cCEvLR0S/aG9Mp/L189CO0X8llY2N4OgYCF7BIWa/V/CYbsDL1YHf2m9q
         ifOHXvWj05waMeCeS14ENEyNF2niFcLIOd22qNEcg84Uq0me4J5IUKpzthWYzaWFdYYz
         042Jb8s5lWy+jvLNy9m3bLhi8v/E0VeniwMk/Ombrz1PSWk5Nxw0zy1kclJ5yb1hMJXi
         Pt5z/Y/6K0IknLednkJZUVvz9pcsWliJE+n6O9OUlKrazMcNgr2JEElrsEEAI1mJrpw9
         KOmQ==
X-Gm-Message-State: APjAAAXjlix1/8oc84M083a1ez7VL4EAKrozzLt1Qlmn/mLke/VmXgHp
        qUWzDxlm8ukYRvRtvUarUwQ5vHal8CQ=
X-Google-Smtp-Source: APXvYqzNTgOCivPxOppSTk1fjSRUx7T9wxl9yba1lIORxq+vt5aG+dicMhJ5K4kqbQ2AjlfcolzCxg==
X-Received: by 2002:ae9:f509:: with SMTP id o9mr25059377qkg.133.1553617696254;
        Tue, 26 Mar 2019 09:28:16 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e4sm855103qkg.6.2019.03.26.09.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 09:28:15 -0700 (PDT)
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
To:     Christopher Lameter <cl@linux.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        mhocko@kernel.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190326154338.20594-1-cai@lca.pw>
 <01000169babb99b8-b583bf57-5104-45b7-a4d6-e7677c64ece2-000000@email.amazonses.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <20540be2-5961-ea86-1ad8-50fbb4d15c6e@lca.pw>
Date:   Tue, 26 Mar 2019 12:28:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <01000169babb99b8-b583bf57-5104-45b7-a4d6-e7677c64ece2-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 12:00 PM, Christopher Lameter wrote:
>> +		 */
>> +		gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC :
>> +		       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
>> +		object = kmem_cache_alloc(object_cache, gfp);
>> +	}
>> +
>>  	if (!object) {
> 
> If the alloc must succeed then this check is no longer necessary.

Well, GFP_ATOMIC could still fail. It looks like the only thing that will never
fail is (__GFP_DIRECT_RECLAIM | __GFP_NOFAIL) as it keeps retrying in
__alloc_pages_slowpath().
