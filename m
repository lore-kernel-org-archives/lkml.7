Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05AAC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDBC2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFNRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfFNRI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CEA5C18B2D6;
        Fri, 14 Jun 2019 17:08:51 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 973FC54382;
        Fri, 14 Jun 2019 17:08:49 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
        <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
        <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
        <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
        <20190614153535.GA9900@linux>
        <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com>
        <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
        <24fcb721-5d50-2c34-f44b-69281c8dd760@linux.ibm.com>
        <CAPcyv4ixq6aRQLdiMAUzQ-eDoA-hGbJQ6+_-K-nZzhXX70m1+g@mail.gmail.com>
        <16108dac-a4ca-aa87-e3b0-a79aebdcfafd@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Jun 2019 13:08:48 -0400
In-Reply-To: <16108dac-a4ca-aa87-e3b0-a79aebdcfafd@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 14 Jun 2019 22:25:18 +0530")
Message-ID: <x49ef3wytzz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 14 Jun 2019 17:08:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 6/14/19 10:06 PM, Dan Williams wrote:
>> On Fri, Jun 14, 2019 at 9:26 AM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>
>>> Why not let the arch
>>> arch decide the SUBSECTION_SHIFT and default to one subsection per
>>> section if arch is not enabled to work with subsection.
>>
>> Because that keeps the implementation from ever reaching a point where
>> a namespace might be able to be moved from one arch to another. If we
>> can squash these arch differences then we can have a common tool to
>> initialize namespaces outside of the kernel. The one wrinkle is
>> device-dax that wants to enforce the mapping size,
>
> The fsdax have a much bigger issue right? The file system block size
> is the same as PAGE_SIZE and we can't make it portable across archs
> that support different PAGE_SIZE?

File system blocks are not tied to page size.  They can't be *bigger*
than the page size currently, but they can be smaller.

Still, I don't see that as an arugment against trying to make the
namespaces work across architectures.  Consider a user who only has
sector mode namespaces.  We'd like that to work if at all possible.

-Jeff
