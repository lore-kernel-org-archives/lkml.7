Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F90C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD71A2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKHkRs0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAHK1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:27:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54604 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgAHK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCdLRbEXo/mLO/KI232Elg94jM5uidenpM5TwMdi2Mk=;
        b=JKHkRs0CQRgUhQTl6XznubxFFYDPsrIhgVZBSpE6vDaPg1Ec+hc8hGV6eo/tv5zH3/Odyo
        ntZtW8P6qbMdi9zk3kGmlwybohFwB1AUI+cbi/SHI8CM3l3YXIUUXjXwbAKRyVcZgv0Ue+
        x/6Pq7+XDhbkqzupfxxoregkVxnAoV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-zZRF13R_P-iIHrj97TadmQ-1; Wed, 08 Jan 2020 05:27:20 -0500
X-MC-Unique: zZRF13R_P-iIHrj97TadmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D10F25B37B;
        Wed,  8 Jan 2020 10:27:18 +0000 (UTC)
Received: from krava (ovpn-205-199.brq.redhat.com [10.40.205.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FA107C82C;
        Wed,  8 Jan 2020 10:27:15 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:27:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, tmricht@linux.ibm.com
Subject: Re: [PATCH] perf report: Fix no libunwind compiled warning break
 s390 issue
Message-ID: <20200108102708.GC360164@krava>
References: <20200107191745.18415-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107191745.18415-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 03:17:45AM +0800, Jin Yao wrote:
> Commit 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
> breaks the s390 platform. S390 uses libdw-dwarf-unwind for call chain
> unwinding and had no support for libunwind.
> 
> So the warning "Please install libunwind development packages during the perf build."
> caused the confusion even if the call-graph is displayed correctly.
> 
> This patch adds checking for HAVE_DWARF_SUPPORT, which is set when
> libdw-dwarf-unwind is compiled in.
> 
> Fixes: 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
> 
> Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

perfect, I have the same change prepared for sending, but it's
together with making libdw default dwarf unwinder, which I'm still
not sure we want to do, so it all got posponed ;-)

would you guys be ok with that? with having libdw picked up as default dwarf unwinder..

for the patch:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-report.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index de988589d99b..66cd97cc8b92 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -412,10 +412,10 @@ static int report__setup_sample_type(struct report *rep)
>  				PERF_SAMPLE_BRANCH_ANY))
>  		rep->nonany_branch_mode = true;
>  
> -#ifndef HAVE_LIBUNWIND_SUPPORT
> +#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_DWARF_SUPPORT)
>  	if (dwarf_callchain_users) {
> -		ui__warning("Please install libunwind development packages "
> -			    "during the perf build.\n");
> +		ui__warning("Please install libunwind or libdw "
> +			    "development packages during the perf build.\n");
>  	}
>  #endif
>  
> -- 
> 2.17.1
> 

