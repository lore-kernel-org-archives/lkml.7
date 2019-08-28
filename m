Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99275C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB12070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566998105;
	bh=L+I8dLseUtNd85ooOmhvIDWkFtsUxJU9ZMvZK+A2JIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NADnYbNUMmKU1C7WzKAwOalv2qzf8d8wWapGYK/jWO7H/euakHJmOrFYH8bVTBGvE
	 gAU0g6nt10oX8J6bSBADhrkaEthgHE+EPWX41NeyaCMk1y3KK7SIVY5faiUP1yt+2G
	 XJnQxc+3VIeaFZn6YyrZTR+gThjJUcby5+aWkqWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfH1NPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:15:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:53752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfH1NPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:15:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C991AFA4;
        Wed, 28 Aug 2019 13:15:02 +0000 (UTC)
Date:   Wed, 28 Aug 2019 15:15:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, mgorman@techsingularity.net,
        dan.j.williams@intel.com, osalvador@suse.de,
        richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190828131501.GK28313@dhcp22.suse.cz>
References: <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
 <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
 <20190815170215.GQ9477@dhcp22.suse.cz>
 <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
 <20190821140632.GI3111@dhcp22.suse.cz>
 <20190826204420.GA16800@bharath12345-Inspiron-5559>
 <20190827061606.GN7538@dhcp22.suse.cz>
 <20190828130922.GA10127@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828130922.GA10127@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 18:39:22, Bharath Vedartham wrote:
[...]
> > Therefore I would like to shift the discussion towards existing APIs and
> > whether they are suitable for such an advance auto-tuning. I haven't
> > heard any arguments about missing pieces.
> I understand your concern here. Just confirming, by APIs you are
> referring to sysctls, sysfs files and stuff like that right?

Yup

> > > If memory exhaustion
> > > occurs, we reclaim some more memory. kswapd stops reclaim when
> > > hwmark is reached. hwmark is usually set to a fairly low percentage of
> > > total memory, in my system for zone Normal hwmark is 13% of total pages.
> > > So there is scope for reclaiming more pages to make sure system does not
> > > suffer from a lack of pages. 
> > 
> > Yes and we have ways to control those watermarks that your monitoring
> > tool can use to alter the reclaim behavior.
> Just to confirm here, I am aware of one way which is to alter
> min_kfree_bytes values. What other ways are there to alter watermarks
> from user space? 

/proc/sys/vm/watermark_*factor
-- 
Michal Hocko
SUSE Labs
