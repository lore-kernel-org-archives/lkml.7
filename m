Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8314B2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4W0NpB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407321AbfHINtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:49:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46066 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436496AbfHINq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:46:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so89100996eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LyignUp7I1w3k1JhRB7hSSaZmUScIlvleAzqEtH71gA=;
        b=a4W0NpB7Ky7ZNvyTrbh1FeBLRkzD3aPh58RS1Yx4bs/BVTnp45+DINWMGfkbq8hq7Q
         Y3Z4bdj5hgCTeGW+PRshMaXOMxfFs+yMLbXwPTZLqJTcO/dIrpBRkUNMwIYuvyefgxLE
         ghaZnnGxRRWhYKHkI/uJzl52jBCmY6GTaX4J6IMtYXbQlVLgECyZntsud91yKcOGxjq1
         ATUWqTH0gQtzKxNRtGFOYFydwjEzo49N/C0g2sw3KGDcPT84ORGadNZJiyoF1tdgy86l
         pT+EYQrZCc/tezrHEA9IExUAHvjCjPlw9d1k0TydyGhC6W7edZj2zop9pkCTsz+j9sKa
         GMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LyignUp7I1w3k1JhRB7hSSaZmUScIlvleAzqEtH71gA=;
        b=E6/E093iNzfh1IkVjH+MGFmj3Za8JrapJa0hKg9DPmktU1mj/yynOBVXwppSEx3Dzz
         lmE78Pku1PFVernVEtbMNd0wSZc5YxxOny37Yb7dHlpQe9ZXZH/OM5fNW1ALW7bvlipK
         cnrBfxDhPQ2OK7R05WwgDxNANGv/GgaV76JAzkfBecyRRNcgNxQFyXopvce02q9Xf0aq
         Ge+1HhAsyjstofw2ESy0OO8zh+ruIeyOTu9Gbjb8qd569r/gHvhCl9QBknGoSKz0cW/F
         1eM+2eov9fFgnLRYzdSMeRDZB5/C1inCSjJMeYsoyMBR+gigV1prCwHUfnmFAk3vJPPs
         81xA==
X-Gm-Message-State: APjAAAWobaXrzhtelQFkQG2o+B4HIWIGA2/I8lr3wiSMz5Cle4WorVUX
        Q5Qyf3zSRM2pagJbckVLN0o=
X-Google-Smtp-Source: APXvYqxaz13nFHHrpZp/JtkeyPbtXPvJTVD23pHrWjqDjJb17ei5Rg0+DU4QM5tQfP2jLc7hWf/1lw==
X-Received: by 2002:aa7:ccd6:: with SMTP id y22mr21987171edt.274.1565358386098;
        Fri, 09 Aug 2019 06:46:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c15sm16018545ejs.17.2019.08.09.06.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 06:46:25 -0700 (PDT)
Date:   Fri, 9 Aug 2019 13:46:24 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        pasha.tatashin@oracle.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: use __nr_to_section(section_nr) to get
 mem_section
Message-ID: <20190809134624.htv6jws7hphs4tvz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190809010242.29797-1-richardw.yang@linux.intel.com>
 <e17278f0-94dc-e0c6-379b-b7694cec3247@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17278f0-94dc-e0c6-379b-b7694cec3247@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:39:59PM +0530, Anshuman Khandual wrote:
>
>
>On 08/09/2019 06:32 AM, Wei Yang wrote:
>> __pfn_to_section is defined as __nr_to_section(pfn_to_section_nr(pfn)).
>
>Right.
>
>> 
>> Since we already get section_nr, it is not necessary to get mem_section
>> from start_pfn. By doing so, we reduce one redundant operation.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Looks right.
>
>With this applied, memory hot add still works on arm64.

Thanks for your test.

>
>Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
>> ---
>>  mm/sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 72f010d9bff5..95158a148cd1 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -867,7 +867,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>  	 */
>>  	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>>  
>> -	ms = __pfn_to_section(start_pfn);
>> +	ms = __nr_to_section(section_nr);
>>  	set_section_nid(section_nr, nid);
>>  	section_mark_present(ms);
>>  
>> 

-- 
Wei Yang
Help you, Help me
