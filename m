Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B66C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808D8205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTN4evx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJGP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:28:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35071 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:28:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so6343817pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DgooQ7bjeUKsHrGM13Xp8ZmWYyC1LW+C7CinhAKEgc8=;
        b=DTN4evx5wOGGT46g/p17877+GjTOXHG6rTtt4mF/XNNIcwxMNHcTqILMqM5TSHRq5h
         NLcA0jcVaoZ9GcVsWzD77lD6bSEOPyX5tF+KeqOG6DTOCVLg+IkvYkqheGCfGhiwUpgT
         XastpEZWvGE1kOiRNkvhD5Lc6D2imJ/46oOu+j8V7GvuigBnsbGRgk2qLV1586ahfwaI
         LNLHOUon3gSVSnrOybCwUmcejcU/qSsDuHaJnpVD0w1jKc4JsqGRgpw72PKzrfrWMOxb
         oGhzxbsXrys9bUfdiZaJnbknZ98oPboeI1eaNlkKzb5HHdWBpBJGY6t/lBP96olm6P+o
         MSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgooQ7bjeUKsHrGM13Xp8ZmWYyC1LW+C7CinhAKEgc8=;
        b=jjMYJG2DBPiA6HvCWtmdDM4DALsprUsuA5GXPd1ZczZzdVQnd0NHChJ66vygVutNBn
         RfmQjhq5myXStmZeShhW9PSvAbPOG0SrBsOHqgAz9epq+J4N+YCDARB8Q5PIZtVcHWK5
         r99F7g+WXmO/4hDOASTeKjKGDxdqKo3tzOFJWl/Ph/ReExxa7PxUeyt/ZMhioxpjykHB
         Lm7jE1Ik4NXZYc+SIPaUVdmJUiL0GYiHtObIZRXvM2OI25QKDyHdaTWShT4egAFNN8il
         btZ2BqHwk0gdfVWbkoTO3XJfRRxzoqeoR+46EdqwCHQEW9QWXppA+fHCj0DlmBB2YFQM
         +Ztw==
X-Gm-Message-State: APjAAAU7W3B4eSAic2eOsxEuyhaybJAoANs9jPI2fnon/4YEge+ALK/s
        P+xGsPMixk5fuMvdc6enDsE=
X-Google-Smtp-Source: APXvYqxJzbXKe74fyAATky8/9dchZ82b1gpOQaMvA0qIJ4lEmQhKG2XmobWuzX7w9Xf5qVsdjFDxjA==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr33694536pfh.176.1570462099386;
        Mon, 07 Oct 2019 08:28:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w27sm17618286pfq.32.2019.10.07.08.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 08:28:17 -0700 (PDT)
Date:   Mon, 7 Oct 2019 08:28:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v4 2/2] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20191007152816.GA10940@roeck-us.net>
References: <20190808195301.13222-1-matt@codeblueprint.co.uk>
 <20190808195301.13222-3-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808195301.13222-3-matt@codeblueprint.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 08, 2019 at 08:53:01PM +0100, Matt Fleming wrote:
> SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
> for any sched domains with a NUMA distance greater than 2 hops
> (RECLAIM_DISTANCE). The idea being that it's expensive to balance
> across domains that far apart.
> 
> However, as is rather unfortunately explained in
> 
>   commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")
> 
> the value for RECLAIM_DISTANCE is based on node distance tables from
> 2011-era hardware.
> 
> Current AMD EPYC machines have the following NUMA node distances:
> 
> node distances:
> node   0   1   2   3   4   5   6   7
>   0:  10  16  16  16  32  32  32  32
>   1:  16  10  16  16  32  32  32  32
>   2:  16  16  10  16  32  32  32  32
>   3:  16  16  16  10  32  32  32  32
>   4:  32  32  32  32  10  16  16  16
>   5:  32  32  32  32  16  10  16  16
>   6:  32  32  32  32  16  16  10  16
>   7:  32  32  32  32  16  16  16  10
> 
> where 2 hops is 32.
> 
> The result is that the scheduler fails to load balance properly across
> NUMA nodes on different sockets -- 2 hops apart.
> 
> For example, pinning 16 busy threads to NUMA nodes 0 (CPUs 0-7) and 4
> (CPUs 32-39) like so,
> 
>   $ numactl -C 0-7,32-39 ./spinner 16
> 
> causes all threads to fork and remain on node 0 until the active
> balancer kicks in after a few seconds and forcibly moves some threads
> to node 4.
> 
> Override node_reclaim_distance for AMD Zen.
> 
> Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: Suravee.Suthikulpanit@amd.com
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas.Lendacky@amd.com

This patch causes build errors on systems where NUMA does not depend on SMP,
for example MIPS and PPC. For example, building mips:ip27_defconfig with SMP
disabled results in

mips-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
page_alloc.c:(.text+0x5018): undefined reference to `node_reclaim_distance'
mips-linux-ld: page_alloc.c:(.text+0x5020): undefined reference to `node_reclaim_distance'
mips-linux-ld: page_alloc.c:(.text+0x5028): undefined reference to `node_reclaim_distance'
mips-linux-ld: page_alloc.c:(.text+0x5040): undefined reference to `node_reclaim_distance'
Makefile:1074: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

I have seen a similar problem with one of my PPC test builds.

powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x18): undefined reference to `node_reclaim_distance'

Guenter
