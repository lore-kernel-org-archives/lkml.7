Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D051C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AB220717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559798977;
	bh=lfy7XYZEqNVPl0M+Vu4rwTcIFUoArYGLzGD2CzlpLpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzYrtwb/pqZ1/QMGewrbImZe6v49xjUsw9xXdsKsSXm+srMYo8dvjUW1na/p3MVTR
	 CWLzx+lIRsnxzsQaHi2Fm4d7ZhMswYSGiFV94GKikBSMInrkPzEJJoCTz2G5tNRMAy
	 yUGSTmdEhSxHx2kbCW7Ca11WKSc0sZAtTmR+XCa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFFF3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:33424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfFFF3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:29:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4851AE04;
        Thu,  6 Jun 2019 05:29:34 +0000 (UTC)
Date:   Thu, 6 Jun 2019 07:29:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190606052933.GA8575@dhcp22.suse.cz>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
 <20190605070312.GB15685@dhcp22.suse.cz>
 <20190605130727.GA25529@bharath12345-Inspiron-5559>
 <20190605142246.GH15685@dhcp22.suse.cz>
 <20190605155501.GA5786@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605155501.GA5786@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-06-19 21:25:01, Bharath Vedartham wrote:
> IMO the reason why a lot of failures must not have occured in the past
> might be because the programs which use it use stuff like cpu_to_node or
> have checks for nid.
> If one day we do get a program which passes an invalid node id without
> VM_BUG_ON enabled, it might get weird.

It will blow up on a NULL NODE_DATA and it will be quite obvious what
that was so I wouldn't lose any sleep over that. I do not think we have
any directly user controlable way to provide a completely ad-hoc numa
node for an allocation.

-- 
Michal Hocko
SUSE Labs
