Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D3CC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4909E21851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="DsrHWido"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfF0AwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:52:15 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:33608 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfF0AwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:52:14 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 84AB62DC005B;
        Wed, 26 Jun 2019 20:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561596733;
        bh=e3ADJwfA6t0sBRcoRZyK9kX07Ioi4er/mJ665+7Q8Ig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DsrHWidoX5Aqd+bpgeRHA0G0YHP7sXuAJiwPE5gJUOzci098HotAInkFcMjsT/YN7
         SI3UNuXoc/t4Y41zWiB3tADVwkwSgWSgSXaxeZ/6UiqXj6gDrAmx4UjO6sKqUx6cao
         bo9ienJHM/UiopRop7DgCsOV0MGLf2Y7t+pNLV58gHHYF9kXSdNP0gZOwaGUm4mg7r
         KXqFlTlusei4k8sjM1pjoCSIdHQ5gT538EhyOVQYYQZoTZQzpOS7H4weGYGUQ1uO0H
         Vhxc15wTIVtIevbbKezWLlSUiAclivCLNq3Y5M1jWPzhFtrFVnhKOkwFxpIEIwPUyo
         9NupOCJlOOKEbmrSbY7tKiasZTj20HEhskmhMcAkRVakCU+wJeAw5LIqXD21DJYuiF
         OqHLL1MNjSaDusclE56RkmfomCpU4u0Oj9fLMpX1/8L08yfDs3UGoDnzjz7pB9k64s
         aJHRqCStrFqIpvpl4LExXvc2lZ8e7RG5RSwTJVHHbAqgR3XWCBQ96lIpLEbJIz8v9T
         0pWInnqTsfc+r3dHBDXo8LcFF4jNdViyasxrQDjbxF5yLGZXqY42CHprL0NuaT3nbT
         8n6keTtnbViGAWerKi1H6eEnD/zn4abzzRmc64I9u4Ykf6wWvG03NgVPboVhLaWv4b
         8vJVIQbf9iWiOtLoFE9jtCZo=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5R0prWE037614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 10:52:09 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <ecf246b3b9c7069a04e0046e1aa906c7f6322960.camel@d-silva.org>
Subject: Re: [PATCH v2 0/3] mm: Cleanup & allow modules to hotplug memory
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 27 Jun 2019 10:51:53 +1000
In-Reply-To: <20190626075753.GA24711@infradead.org>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626075753.GA24711@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 27 Jun 2019 10:52:09 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 00:57 -0700, Christoph Hellwig wrote:
> On Wed, Jun 26, 2019 at 04:11:20PM +1000, Alastair D'Silva wrote:
> >   - Drop mm/hotplug: export try_online_node
> >         (not necessary)
> 
> With this the subject line of the cover letter seems incorrect now :)
> 

Indeed :)

I left it as I was unsure whether changing the series title would make
it harder to track revisions.


-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


