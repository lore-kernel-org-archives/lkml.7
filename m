Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553593015;
	bh=ws5KiqITzrNgCkO9n7l1yTI19C9HFC8EbOpP54TPLjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KDs6nrK6xJi5c/FjF7b3f3ITx5NwdJjfWbjQvBIffuhuzPgOBZbCxODfSH/bugcZm
	 HSe7sOs5CgHbeuakpUEUkJYAsxYHvrKtZGpF2C2CwY730xpMrGXUUtXX69zmH8hwMB
	 TWQBqasHDs/h6WplvCz8fd3lcmoVAWKvjt9093k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfCZJgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:36:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfCZJgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:36:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93599AD3E;
        Tue, 26 Mar 2019 09:36:52 +0000 (UTC)
Date:   Tue, 26 Mar 2019 10:36:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
Message-ID: <20190326093651.GM28406@dhcp22.suse.cz>
References: <SG2PR02MB309841EA4764E675D4649139E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <56862fc0-3e4b-8d1e-ae15-0df32bf5e4c0@virtuozzo.com>
 <SG2PR02MB3098EEAF291BFD72F4163936E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <4c05dda3-9fdf-e357-75ed-6ee3f25c9e52@virtuozzo.com>
 <SG2PR02MB309869FC3A436C71B50FA57BE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <09b6ee71-0007-7f1d-ac80-7e05421e4ec6@virtuozzo.com>
 <SG2PR02MB309864258DBE630AD3AD2E10E8410@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309824F3FCD9B0D1DF689390E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190326090142.GH28406@dhcp22.suse.cz>
 <SG2PR02MB3098FAEA335228CFB56F1668E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB3098FAEA335228CFB56F1668E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 09:16:11, Pankaj Suryawanshi wrote:
> 
> ________________________________________
> From: Michal Hocko <mhocko@kernel.org>
> Sent: 26 March 2019 14:31
> To: Pankaj Suryawanshi
> Cc: Kirill Tkhai; Vlastimil Babka; aneesh.kumar@linux.ibm.com; linux-kernel@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; khandual@linux.vnet.ibm.com
> Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
> 
> [You were asked to use a reasonable quoting several times. This is
> really annoying because it turns the email thread into a complete mess]
> 
> [Already fix the email client, but dont know the reason for quoting Maybe account issue.]

You clearly haven't

> As i said earlier, i am using vanilla kernel 4.14.65.

This got lost in the quoting mess. Can you reproduce with 5.0?
-- 
Michal Hocko
SUSE Labs
