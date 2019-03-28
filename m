Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E98AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8CB2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JDZi8m6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfC1Plo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:41:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38304 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfC1Pln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:41:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so18913801qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSIK0NlB9kqC2VbxVE8Lqm6fkbIpXVRmd/x9heQilLI=;
        b=JDZi8m6ACT0foATFYmQ6ovzh0iDKHypwkpqBZs9kyJL7ichy99ptXM6U/fKrgcZYzL
         wmjsZlHhckKBj8vWlcbNFaAGAVE9/t7SwmiFiATM1po1utOEgf0S4x9oLDZDTt+fmpFq
         +3r0Caq6JFDqDhTqe61s9CTKH/azj0vIanSTdCO8lb477DU+xkb9m2il8hhej59lVdQ8
         uE3gMzsNK25/EqDNFkhttnrONv1vt+G7dNQvnItgoO2Py6tymhTJL7AlcqYPLDsBnVVH
         nUndYHgqz/ajLVfBx7sC/FM7t4LSUlqSvERdbkqgKjhFShrEbC20DDumx3UBXziLbZbr
         rMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSIK0NlB9kqC2VbxVE8Lqm6fkbIpXVRmd/x9heQilLI=;
        b=qMv4D8idixACpKT6YL4sfHZUE6Y5ZVI7mil7rJm5X0fbj4zst0lOC16GM9joROwzLW
         4yeuouN2iDNwV6yI2JZlsMdLmKoP6xJ1UqeZdjbhSfBfKwqW1T/hQVisKZVHoJXL3MPf
         WnlXqSCp5rWNYjGrantN3yjLqP+AwYH5OMwEdv2Ma1vxJGAcDW+y1t8NRYkBig50HPky
         GsYSSJUCJKHn463rmYMwaJ6fcRFD9omvQF8XknfBoOrb2oDbINYW35OIpKWSdJBXgYF5
         q25B0NE9SHky259X8/lDgmDV6ZWL7xgdRcAO0PAps9wz0IvUhs9PqwtFg56cYKl/YlTc
         ha7w==
X-Gm-Message-State: APjAAAUX2qS9Njj01bLwVGCtGLs1u79K9wikpKkjUtLVe5T7gLBq9qMn
        w52M3pRMrVw5z9VjmABwdwWIbA==
X-Google-Smtp-Source: APXvYqwOKXrnwuWYvmxRUfZxLNHbF5XUH/2O1kIju5c+oTYyHsaPHoHFiusJXvtbeVTZjrYnxW37Kw==
X-Received: by 2002:a0c:d6c9:: with SMTP id l9mr36061464qvi.58.1553787702607;
        Thu, 28 Mar 2019 08:41:42 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u3sm4236697qtk.97.2019.03.28.08.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:41:41 -0700 (PDT)
Message-ID: <1553787700.26196.28.camel@lca.pw>
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        cl@linux.com, willy@infradead.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Mar 2019 11:41:40 -0400
In-Reply-To: <20190328150555.GD10283@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
         <20190327084432.GA11927@dhcp22.suse.cz>
         <20190327172955.GB17247@arrakis.emea.arm.com>
         <49f77efc-8375-8fc8-aa89-9814bfbfe5bc@lca.pw>
         <20190328150555.GD10283@arrakis.emea.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 15:05 +0000, Catalin Marinas wrote:
> > It takes 2 runs of LTP oom01 tests to disable kmemleak.
> 
> What configuration are you using (number of CPUs, RAM)? I tried this on
> an arm64 guest under kvm with 4 CPUs and 512MB of RAM, together with
> fault injection on kmemleak_object cache and running oom01 several times
> without any failures.

Apparently, the CPUs are so fast and the disk is so slow (swapping). It ends up
taking a long time for OOM to kick in.

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  2
Core(s) per socket:  12
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Gold 6126T CPU @ 2.60GHz
Stepping:            4
CPU MHz:             3300.002
BogoMIPS:            5200.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
L3 cache:            19712K
NUMA node0 CPU(s):   0-11,24-35
NUMA node1 CPU(s):   12-23,36-47

# free -m
              total        used        free      shared  buff/cache   available
Mem:         166206       31737      134063          33         406      133584
Swap:          4095           0        4095

# lspci | grep -i sata
00:11.5 SATA controller: Intel Corporation C620 Series Chipset Family SSATA
Controller [AHCI mode] (rev 08)
00:17.0 SATA controller: Intel Corporation C620 Series Chipset Family SATA
Controller [AHCI mode] (rev 08)
