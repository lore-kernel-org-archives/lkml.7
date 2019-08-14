Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5656C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B12083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmBEKvAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfHNQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:09:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46126 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfHNQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:09:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id z51so22934043edz.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2U3tCMRw+IrarDDMVIjTPYayb14uQntySFIVIZlP+g=;
        b=cmBEKvAs4xYGs8yaTgaRBA2XTQfiEsuiKCcB8B37zwblaAew+JPAwUGqSniB5dfkTt
         FQCSy0lFtLfY6HrdTG86JfuNBJmsZWda/W4+re+hc+5AJABZfRyZnsZtSBiPJz3rlta4
         sn2crMRxKGBFCSOgOE+Ul4pNYaV1ThyXMOvRk/t8frSbV3OuGHRJhj/mWHZeEag9Xfft
         S0nLfbCm6/PkwNcRH+RXgwTd2YQtbi21KsLI+7t/Jzf/dyaiCX9vpLIPGeS2cvHPwFPd
         EEh37HNI8WkTVb7c+Cl0Q4+YlDXbzbrMa6xoJjB5H0qnaypokevUjYH/XHTkOo/OP0AB
         pn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2U3tCMRw+IrarDDMVIjTPYayb14uQntySFIVIZlP+g=;
        b=bhjtZhXWTuQ7/09+Eq8LqaoJHQ3WOYIcb1ftHSFN2+eUBFkHjSgYhCqXNt1LPl/lSu
         CoDOWOrFApTj1tstFjD152ODAqGMXUzP2LUAODRSEZcyM0SVWqInGPoRjnu6XWSnzzw8
         3vUIzxyEccDJwJUz4TMHyYEEpzYBBMvH3Gg7DiSgYlOH1oHcyMyNuf/pgRsmxA1bPppV
         EGaGrKX82RDeJfEC1kOhQ18Q5/ACNkcBbWLkBfON2PWrwFPY/mdUWn/5dL0Tk+5QGxG9
         YpZwDOE72G1lIzXDj0v14cu6NYWFW4+ZSI/iuZKDN8RxF4d74OSVZKnK1WL6gpw6gHRP
         touA==
X-Gm-Message-State: APjAAAXgYh9qSczQzMb5+qjBifEO4Wr7/v+e+QEogFjJmEnb3eaTMtgx
        vngXO76pQgPCI4XrsPfp+0o=
X-Google-Smtp-Source: APXvYqwZmksdyVS0vPV/57kM8jEAlq6WRk/6VGPeAVhy4ba622KhwezDTfs8HZyph26y8T/fohm4yQ==
X-Received: by 2002:a17:907:2091:: with SMTP id pv17mr308462ejb.157.1565798965848;
        Wed, 14 Aug 2019 09:09:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y48sm40007edc.66.2019.08.14.09.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 09:09:24 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:09:24 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190814160924.3iauvzsbukw4ghjv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
>On 8/14/19 8:57 AM, Wei Yang wrote:
>> On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
>>>Btw, is there any good reason we don't use a list_head for vma linkage?
>> 
>> Not sure, maybe there is some historical reason?
>
>Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
>list be doubly linked") and I guess it was just simpler to add the vm_prev link.
>
>Conversion to list_head might be an interesting project for some "advanced
>beginner" in the kernel :)

Seems it will touch many code ...

-- 
Wei Yang
Help you, Help me
