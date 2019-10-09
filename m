Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CEECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861992133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="CDmkwE3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfJIMEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:04:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34973 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfJIMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:04:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id v8so1792916eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtS4F7XkA7NXEFSiBUTN+MJJcDQu2q+vCfZUQy+bNyU=;
        b=CDmkwE3XsBkLPqd+Wrp3c0USAwAHa/YvwCcyPxnh8+CAwipOm4wQjmkbpZ+/BqnylE
         ZVT5hHUsooJLvkubHozfCmNaaH6ubAZeWDmdJYOzvabR+6G4izlomPDJ5zMIljcGzWAg
         SIpETtH1H3FDAlYKbQcgS6doZ4UAFwo/8t91MtelbAaqcX/cXXjus5Yu/uV63JPQJRfk
         JjujXHKVuRcZd9APQ2mmcMLMWNMde3X5twKaYMIXYe8XjndUxsdM9k/byyK9sbmmnKdo
         fCnwNfe/JqLclTl8RZCKuHCPdkRqG3NEs/VZeWS25+LX+bgdKQ1zVPDNDEgIcPXuWOwo
         78lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtS4F7XkA7NXEFSiBUTN+MJJcDQu2q+vCfZUQy+bNyU=;
        b=gYRmJst3MNDtCedmf+qSPyqOM/EeOLRJg0lKWasChyt0TbpUde81bmQTBxoZ7/KcJU
         NCFwu9iE7YHDIc22qdmCT9oMvxcK3MVW13PVx5ODAcXAyb2YfU+EuEOtwe0NggTFRU8g
         HcaYUHP45QSs+sU4N69NDWvkpEhLQRf1Uhg+Nj+/Qas/iJAjBLot7AG3Ep/iwS379U+N
         95liijInnxFN9dbNT5TzP5aRx/6J9RRiedHA4MvIw+PKiARXdcW0j9cYSy39Y+0OZ7Uz
         b3xA3mDVfctEnJyDYOy6tDeDJ04ueHo/3ahlwoy6dRLR2BeX0m++vs2VWcO8BWddFs1L
         5g2w==
X-Gm-Message-State: APjAAAVQV38rtT9EpjeX9cAbwtEL6dqw5vRvaACp25/I54EmlbqKny81
        MMfEdG82NWGtrpycY725RmbtPg==
X-Google-Smtp-Source: APXvYqy/cHafxasXGfjzrhEIC31Oa9jb1eFTW0NjlGUWRszBpxdMlJvnbukfkm5jV3+1Ea36Ces9CA==
X-Received: by 2002:a17:906:d964:: with SMTP id rp4mr2336654ejb.147.1570622654335;
        Wed, 09 Oct 2019 05:04:14 -0700 (PDT)
Received: from localhost (5ec1659c.skybroadband.com. [94.193.101.156])
        by smtp.gmail.com with ESMTPSA id k9sm329380edr.88.2019.10.09.05.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:04:13 -0700 (PDT)
Date:   Wed, 9 Oct 2019 13:04:12 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/2] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20191009120412.GA4065@codeblueprint.co.uk>
References: <20190808195301.13222-1-matt@codeblueprint.co.uk>
 <20190808195301.13222-3-matt@codeblueprint.co.uk>
 <20191007152816.GA10940@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007152816.GA10940@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct, at 08:28:16AM, Guenter Roeck wrote:
> 
> This patch causes build errors on systems where NUMA does not depend on SMP,
> for example MIPS and PPC. For example, building mips:ip27_defconfig with SMP
> disabled results in
> 
> mips-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
> page_alloc.c:(.text+0x5018): undefined reference to `node_reclaim_distance'
> mips-linux-ld: page_alloc.c:(.text+0x5020): undefined reference to `node_reclaim_distance'
> mips-linux-ld: page_alloc.c:(.text+0x5028): undefined reference to `node_reclaim_distance'
> mips-linux-ld: page_alloc.c:(.text+0x5040): undefined reference to `node_reclaim_distance'
> Makefile:1074: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> I have seen a similar problem with one of my PPC test builds.
> 
> powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x18): undefined reference to `node_reclaim_distance'

Thanks for this Guenter.

So, the way I've fixed this same issue for ia64 was to make NUMA
depend on SMP. Does that seem like a suitable solution for both PPC
and MIPS?
