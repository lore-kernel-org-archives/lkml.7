Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB62C46477
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9507A21E70
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="VqhZZ2C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFQH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:57:25 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:44842 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:57:24 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 8FFB42DC007F;
        Mon, 17 Jun 2019 03:57:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1560758243;
        bh=rFbuhIFz/h0VCo487ij807TQPU9Ah/028l0pxfTo07M=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=VqhZZ2C9MXgQs4mWEU46L5rHGLqpnIRoTGpY24OzxvqlwI7dZXTTYB8Y5aUj0N7mi
         6yh2PHcCD4RfBeHo5jvQ47NUczbORBQk3PkDSmo0jUSECUTG14CVtDdBzTYggcARMs
         ov0YKiTLAO9aKWJjhBp9+yr2QFbljJZ+8UwThAaOO0lDNzeYbMHgWl7G+uH4KMs+R9
         6P+FvhFcIo9JRvwTFwUBGFHUqAqMYuaAVNL71EdG28Qfhl5nw+kdcbduv4/FvViN8a
         VPig2zlIymRNN+WfjFAG8fNGX2J5noMfMWQY1v7hZEThQ3EOebgS1hJMHT9TU6wleJ
         V63ouJV7+Kf8gM5pf+YXMm8lRQQJ8yHcRMdtsVuzkB/7rULa6In1JGZs9CFF9IKBA7
         rb8/aEtc1NIl36SEebXTOj/vqlZL/CnUsE+10n65b9mfGfkaThusbbMYO16F6wF5uW
         iUBE/dndXK+Qeu8nUEmyp3n65aao0p/EtXy5SrDrlWgfuy73yQi0kv0hG5U+z9/69Y
         Nkjsh+e7W9pQzI70dFHUMNZXX+c4L6DsME6TgMN8FOmM2JuYE3UUTOIt3P+m/xo4jY
         hWza4hDgNn56Xyq7292bmWLpXV9CpzI7TpkQAo107TJeWQMj0kaJFWM1/ddpmQhfkf
         nwLifMmxknexkWaFavoo+4Sw=
Received: from Hawking (ntp.lan [10.0.1.1])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5H7vGaN057238
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 17:57:16 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "'Michal Hocko'" <mhocko@kernel.org>,
        "'Alastair D'Silva'" <alastair@au1.ibm.com>
Cc:     "'Arun KS'" <arunks@codeaurora.org>,
        "'Mukesh Ojha'" <mojha@codeaurora.org>,
        "'Logan Gunthorpe'" <logang@deltatee.com>,
        "'Wei Yang'" <richard.weiyang@gmail.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@kernel.org>, <linux-mm@kvack.org>,
        "'Qian Cai'" <cai@lca.pw>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Mike Rapoport'" <rppt@linux.vnet.ibm.com>,
        "'Baoquan He'" <bhe@redhat.com>,
        "'David Hildenbrand'" <david@redhat.com>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        "'Pavel Tatashin'" <pasha.tatashin@soleen.com>,
        "'Juergen Gross'" <jgross@suse.com>,
        "'Oscar Salvador'" <osalvador@suse.com>,
        "'Jiri Kosina'" <jkosina@suse.cz>, <linux-kernel@vger.kernel.org>
References: <20190617043635.13201-1-alastair@au1.ibm.com> <20190617043635.13201-5-alastair@au1.ibm.com> <20190617074715.GE30420@dhcp22.suse.cz>
In-Reply-To: <20190617074715.GE30420@dhcp22.suse.cz>
Subject: RE: [PATCH 4/5] mm/hotplug: Avoid RCU stalls when removing large amounts of memory
Date:   Mon, 17 Jun 2019 17:57:16 +1000
Message-ID: <068b01d524e2$4a5f5c30$df1e1490$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKozGZqZYmaEl7M6DfiQR95qivs4QInXwcPAp6henSk0fuP8A==
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Mon, 17 Jun 2019 17:57:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michal Hocko <mhocko@kernel.org>
> Sent: Monday, 17 June 2019 5:47 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>
> Cc: alastair@d-silva.org; Arun KS <arunks@codeaurora.org>; Mukesh Ojha
> <mojha@codeaurora.org>; Logan Gunthorpe <logang@deltatee.com>; Wei
> Yang <richard.weiyang@gmail.com>; Peter Zijlstra <peterz@infradead.org>;
> Ingo Molnar <mingo@kernel.org>; linux-mm@kvack.org; Qian Cai
> <cai@lca.pw>; Thomas Gleixner <tglx@linutronix.de>; Andrew Morton
> <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.vnet.ibm.com>;
> Baoquan He <bhe@redhat.com>; David Hildenbrand <david@redhat.com>;
> Josh Poimboeuf <jpoimboe@redhat.com>; Pavel Tatashin
> <pasha.tatashin@soleen.com>; Juergen Gross <jgross@suse.com>; Oscar
> Salvador <osalvador@suse.com>; Jiri Kosina <jkosina@suse.cz>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 4/5] mm/hotplug: Avoid RCU stalls when removing large
> amounts of memory
> 
> On Mon 17-06-19 14:36:30,  Alastair D'Silva  wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > When removing sufficiently large amounts of memory, we trigger RCU
> > stall detection. By periodically calling cond_resched(), we avoid
> > bogus stall warnings.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  mm/memory_hotplug.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c index
> > e096c987d261..382b3a0c9333 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -578,6 +578,9 @@ void __remove_pages(struct zone *zone, unsigned
> long phys_start_pfn,
> >  		__remove_section(zone, __pfn_to_section(pfn),
> map_offset,
> >  				 altmap);
> >  		map_offset = 0;
> > +
> > +		if (!(i & 0x0FFF))
> > +			cond_resched();
> 
> We already do have cond_resched before __remove_section. Why is an
> additional needed?

I was getting stalls when removing ~1TB of memory.


-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece



