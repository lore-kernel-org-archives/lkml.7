Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26890C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18E92184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbfEXHYn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:24:43 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:46880 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbfEXHYm (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Fri, 24 May 2019 03:24:42 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 24 May 2019 01:24:40 -0600
Message-Id: <5CE79C360200007800231E1D@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Fri, 24 May 2019 01:24:38 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Fredrik Noring" <noring@nocrew.org>
Cc:     <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        "Jessica Yu" <jeyu@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] sscanf: Fix integer overflow with sscanf field
 width
References: <20190523172758.GA54373@sx9>
In-Reply-To: <20190523172758.GA54373@sx9>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 23.05.19 at 19:27, <noring@nocrew.org> wrote:
> This fixes 53809751ac23 ("sscanf: don't ignore field widths for numeric
> conversions"). sscanf overflows integers with simple strings such as dates.
> As an example, consider
> 
> 	r = sscanf("20190523123456", "%4d%2d%2d%2d%2d%2d",
> 		&year, &month, &day,
> 		&hour, &minute, &second);
> 
> 	pr_info("%d %04d-%02d-%2d %02d:%02d:%02d\n",
> 		r,
> 		year, month, day,
> 		hour, minute, second);
> 
> On a 32-bit machine this prints
> 
> 	6 0000-05-23 12:34:56
> 
> where the year is zero, and not 2019 as expected. The reason is that sscanf
> attempts to read 20190523123456 as a whole integer and then divide it with
> 10^10 to obtain 2019, which obviously fails. Of course, 64-bit machines fail
> similarly on longer numerical strings.

Right, and that's also what that commit's description says remains as
non-conforming behavior.

> I'm offering a simple patch to correct this below. The idea is to have a
> variant of _parse_integer() called _parse_integer_end(), with the ability
> to stop consuming digits. The functions
> 
> 	simple_{strtol,strtoll,strtoul,strtoull}()
> 
> now have the corresponding
> 
> 	sscanf_{strtol,strtoll,strtoul,strtoull}()
> 
> taking a field width into account. There are some code duplication issues
> etc. so one might consider making more extensive changes than these.

I'm not the maintainer here, but to me it looks mostly okay.

> +static long sscanf_strtol(const char *cp, int field_width,
> +	char **endp, unsigned int base)
> +{
> +	if (*cp == '-')
> +		return -sscanf_strtoul(cp + 1, field_width - 1, endp, base);

I'm afraid you may neither convert a field width of zero to -1 here,
nor convert a field width of 1 to zero (unlimited).

I'd also like to note that the 'u' and 'x' format characters also accept
a sign as per the standard, but that's an orthogonal issue which you
may or may not want to address at the same time.

Jan


