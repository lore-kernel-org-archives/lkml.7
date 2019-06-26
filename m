Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B30C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1831021783
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="Q21Tz7lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFZG1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:27:52 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:60516 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfFZG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:27:52 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 564052DC0076;
        Wed, 26 Jun 2019 02:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561530471;
        bh=OS25pYQAzwyq/F3INQW54JWjpNG6XHKsOQWiwDyVPqw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q21Tz7lR78e1eemh5m852Ojib2t93ty4XFBF7dCSVVis3DHkZzvrUOFHElfcxKdLv
         q/t/wHkAcJTNEW0HCTFTfr2/1bFZkpoEXTNoVWPzqKVYTCxmYHZMZrtrNAlVlAbKF/
         70JKnrt1+j9MfeFV605Z5onDRpjOz5nNq+BFQr5rekm48xyZnlOnaIkbEXEpwCBl+k
         Epz3Vjzb8AjDIU/bLCG8ruewcAhawikBevodxWFoCUuERO64y09eYCcjOndShCmIgT
         SjqcBms2oRSr9wG6P2VS7YBLXdMpADrF4xeismseo+DV1As/fdHSyXJ07QRxVB7bF1
         h09ETdy6rxazcdLd090RnGVi1a9GVlTeG8Ui2qRxCv4/HkoGO6COIFM8ZM7BIrCUmc
         nfzMMShBzd4ZyBHhQJLFTSkb+zPFzWoDkF8OeE5rQW5u0ISLKXuMtBSWVoCSLSIHMl
         fmfRiW2EtlIbZOY4ccuXdCY1XQPUYCqfvJoFvko5OXXrCRzwTIX1JUWy4vrDb5p6V/
         aN+ixIv4VdyliDdu4t/TRSRV2T8SkMh3WuZv57BpOsjKJ36e5cCJZZHJJ95uJWZGxl
         LENT0oVU7VEkN+q3p7xwugpmcPhWPxmOCpFOwgNvjmpHVbsZTz+qnatEKr0PQ6fb7D
         G86MLOLS5xE4BFdAZ040YlAQ=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5Q6RUtW031358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 16:27:45 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 26 Jun 2019 16:27:30 +1000
In-Reply-To: <20190626062113.GF17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-2-alastair@au1.ibm.com>
         <20190626062113.GF17798@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Wed, 26 Jun 2019 16:27:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 08:21 +0200, Michal Hocko wrote:
> On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > If a memory section comes in where the physical address is greater
> > than
> > that which is managed by the kernel, this function would not
> > trigger the
> > bug and instead return a bogus section number.
> > 
> > This patch tracks whether the section was actually found, and
> > triggers the
> > bug if not.
> 
> Why do we want/need that? In other words the changelog should contina
> WHY and WHAT. This one contains only the later one.
>  

Thanks, I'll update the comment.

During driver development, I tried adding peristent memory at a memory
address that exceeded the maximum permissable address for the platform.

This caused __section_nr to silently return bogus section numbers,
rather than complaining.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


