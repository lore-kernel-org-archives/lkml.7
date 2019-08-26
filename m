Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E88221872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg5LfXDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfHZUof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46807 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHZUoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so11268189pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Fse6KfUwQK5pIfL54PeFWHLZR7X3tE0GyhbPlYXq/0=;
        b=eg5LfXDwuRDQSPuSCfWN0+tMFtzeJMtHuaG+vg7hSeaFFi8e6uT5NZjXWhEbElNCIm
         wQoMIFey3azHElIyf1v5hUZ8vDABYzU0+csFOrfao1YDcNwxazAuK1ne8XoZr9BVu+jC
         LK+ArB2snj9xb9Da862ypDop4sCG1nfUpVXRUfq9hiLj6M8s8El4KfzHP+btClnTEOSE
         3dy3vZa8fUTD55e2BSnv4dafcrYUcmNbQOlkfWdDZ5fwKh/BtoLeNmowCU8q+zk2Zy+q
         e6/7InzJiwBJ4Prto1OonGBcGRd4aK6orEwmlsMPg63DcMIVNIkI0PA8DflKwjE4DAoK
         /w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Fse6KfUwQK5pIfL54PeFWHLZR7X3tE0GyhbPlYXq/0=;
        b=MziWe7TFV0xn/XUI2/KQ5HifQHZ/xkf/ja1sp+hsxzmjJTM2ctZXiE9bX9CPT1BZsl
         m8oNqJaGvTr4VcnP73uSVPm1nwfQSBsWmT+1Zg+5lkiOrX4LMhvgdQNBOuRiPyEbXrTI
         vJ9jo9wGvsUCu6k5E9Are5bMWiz+gpBwBPW8Xdn3gxM20NZUWClv8jwKM4Fz0GoxmK0S
         xOxxhFCxo37j2tVTHLUuL7TclIgwaa/knCSAkcFcIX6XVNbmZf8ouTYhLDMzx0DtjUBW
         W8CNZrfGJjnKHynRBHz9iCadxJBCYLgmGq0cvZa+IGWZngeELVNltiGm4dxEjISUT6IG
         JtQQ==
X-Gm-Message-State: APjAAAXIycMzNBr3iQobtXl1oqDXp0mRGklg+fn1Q+ODM74U7zJnms9R
        fGFZxnQ9YDqP2wr4woGcxMem60Kr
X-Google-Smtp-Source: APXvYqyqg1Cr8t/t/2dwRRT3RJlOMKVgUhiN1s9LLhrk6lpZXH2sa5lk2BO1JqnXcc2rDF58x1Q6mQ==
X-Received: by 2002:a63:9d8a:: with SMTP id i132mr7952728pgd.410.1566852273588;
        Mon, 26 Aug 2019 13:44:33 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id u7sm11140563pgr.94.2019.08.26.13.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 13:44:33 -0700 (PDT)
Date:   Tue, 27 Aug 2019 02:14:20 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, mgorman@techsingularity.net,
        dan.j.williams@intel.com, osalvador@suse.de,
        richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190826204420.GA16800@bharath12345-Inspiron-5559>
References: <20190813014012.30232-1-khalid.aziz@oracle.com>
 <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
 <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
 <20190815170215.GQ9477@dhcp22.suse.cz>
 <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
 <20190821140632.GI3111@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821140632.GI3111@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Here are some of my thoughts,
On Wed, Aug 21, 2019 at 04:06:32PM +0200, Michal Hocko wrote:
> On Thu 15-08-19 14:51:04, Khalid Aziz wrote:
> > Hi Michal,
> > 
> > The smarts for tuning these knobs can be implemented in userspace and
> > more knobs added to allow for what is missing today, but we get back to
> > the same issue as before. That does nothing to make kernel self-tuning
> > and adds possibly even more knobs to userspace. Something so fundamental
> > to kernel memory management as making free pages available when they are
> > needed really should be taken care of in the kernel itself. Moving it to
> > userspace just means the kernel is hobbled unless one installs and tunes
> > a userspace package correctly.
> 
> From my past experience the existing autotunig works mostly ok for a
> vast variety of workloads. A more clever tuning is possible and people
> are doing that already. Especially for cases when the machine is heavily
> overcommited. There are different ways to achieve that. Your new
> in-kernel auto tuning would have to be tested on a large variety of
> workloads to be proven and riskless. So I am quite skeptical to be
> honest.
Could you give some references to such works regarding tuning the kernel? 

Essentially, Our idea here is to foresee potential memory exhaustion.
This foreseeing is done by observing the workload, observing the memory
usage of the workload. Based on this observations, we make a prediction
whether or not memory exhaustion could occur. If memory exhaustion
occurs, we reclaim some more memory. kswapd stops reclaim when
hwmark is reached. hwmark is usually set to a fairly low percentage of
total memory, in my system for zone Normal hwmark is 13% of total pages.
So there is scope for reclaiming more pages to make sure system does not
suffer from a lack of pages. 

Since we are "predicting", there could be mistakes in our prediction.
The question is how bad are the mistakes? How much does a wrong
prediction cost? 

A right prediction would be a win. We rightfully predict that there could be
exhaustion, this would lead to us reclaiming more memory(than hwmark)/compacting
memory beforehand(unlike kcompactd which does it on demand).

A wrong prediction on the other hand can be categorized into 2
situations: 
(i) We foresee memory exhaustion but there is no memory exhaustion in
the future. In this case, we would be reclaiming more memory for not a lot
of use. This situation is not entirely bad but we definitly waste a few
clock cycles.
(ii) We don't foresee memory exhaustion but there is memory exhaustion
in the future. This is a bad case where we may end up going into direct
compaction/reclaim. But it could be the case that the memory exhaustion
is far in the future and even though we didnt see it, kswapd could have
reclaimed that memory or drop_cache occured.

How often we hit wrong predictions of type (ii) would really determine our
efficiency. 

Coming to your situation of provisioning vms. A situation where our work
will come to good is when there is a cloud burst. When the demand for
vms is super high, our algorithm could adapt to the increase in demand
for these vms and reclaim more memory/compact more memory to reduce
allocation stalls and improve performance.
> Therefore I would really focus on discussing whether we have sufficient
> APIs to tune the kernel to do the right thing when needed. That requires
> to identify gaps in that area. 
One thing that comes to my mind is based on the issue Khalid mentioned
earlier on how his desktop took more than 30secs to boot up because of
the caches using up a lot of memory.
Rather than allowing any unused memory to be the page cache, would it be
a good idea to fix a size for the caches and elastically change the size
based on the workload?

Thank you
Bharath

> -- 
> Michal Hocko
> SUSE Labs
> 
