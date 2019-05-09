Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2819EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE111216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk8MMLe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIMXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:23:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36480 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:23:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so1855317edx.3;
        Thu, 09 May 2019 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kK0i9uM3pyYFcRAwxUAkFyXbwheiX8gFOss9me4xCFo=;
        b=Qk8MMLe0+SuyWjMgP91XatGFW2t4dggZxTtSGYKpznsJLPVr8BcONtuSS7vK2+gf7K
         AOz8f2Re+43WGH4w2gU97ZACFASGwvlJ9BsYZk/I6zKhqxZtdFYrjX/38dnU40HQkh1U
         G4tN2R4s9R9CwWJ/bmndCbeWVPryUwwLWlbwiPDwH/eQq8vJx/xuBrsY/S0DY47vftPl
         beRNHavogoku7ouurr5Qk28cy6CYq3fUoDbbB7XwFqW/xUFQkGf9jzXQyPoxzYSR02oS
         LuXCyGRPIx2GXpfe/NaXJcWMPc29xGk8RCsL4VkdyzOoOb94p8cK40z5g0o66s7TUtCa
         IGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kK0i9uM3pyYFcRAwxUAkFyXbwheiX8gFOss9me4xCFo=;
        b=gphytXu3nMoA3wHVO94KY1Hu2ucIJGUlmlHE5pBpK1Ixn7NMMEk02oPsGTuDOOwHkv
         yE9zsBNZ1SeFFGBA2J0x3otRfjvvC4qxGKOSXZu8Vg9yPPYN0FJ4Q7PevR+qbUfSL85+
         uqmIwBI7M7DicAqjXTJiStZ7usutx1L2GnXRENSVPbxUGb3j+Th3KfVeGd2C1N20Kwve
         VNyJR78zHafjPpTb/wZkIonC9K52oMr2SoVOok0EOdnC022a+hAN9UZCsGX6Cu4FB1w3
         j9ej9iFwyXd2/VFOtJSFK2ynGvEt1tMJYzv1Iz/ndWDjy6YLZyCRYEkzQsUTPErGUSDC
         eMhw==
X-Gm-Message-State: APjAAAWZ9nJusvDtsjPbSJcWxiAfESOyNvKYoBxM+YG70NSIG48tAtDT
        DZ5vkCuKnQMeqPPyaSeE91U=
X-Google-Smtp-Source: APXvYqx/LQ9p+oEzzHrZ1uIdWPZDCJZ5+WDWvbYvuz3X/C9E2PgZsOqljcdk3brSDSoy+FnXpjuuOw==
X-Received: by 2002:a17:906:5013:: with SMTP id s19mr2949960ejj.203.1557404586529;
        Thu, 09 May 2019 05:23:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c2sm299961eja.61.2019.05.09.05.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 05:23:05 -0700 (PDT)
Date:   Thu, 9 May 2019 12:23:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v2 1/8] mm/memory_hotplug: Simplify and fix
 check_hotplug_memory_range()
Message-ID: <20190509122304.haksywk3p2ks6gcg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190507183804.5512-1-david@redhat.com>
 <20190507183804.5512-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507183804.5512-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 08:37:57PM +0200, David Hildenbrand wrote:
>By converting start and size to page granularity, we actually ignore
>unaligned parts within a page instead of properly bailing out with an
>error.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Qian Cai <cai@lca.pw>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Arun KS <arunks@codeaurora.org>
>Cc: Mathieu Malaterre <malat@debian.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>


-- 
Wei Yang
Help you, Help me
