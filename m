Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E34C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73C218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaZ3w9v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:54:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727346AbfLTNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576850048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7d5/Dg1qphkKnk5wP6grMwrijICvNfIm/Vmd4UgEDEA=;
        b=gaZ3w9v2Obl1VmV7olbWFkn55+t/MHJqpl9FINrsuzWdwzi4p07JX6rOikEB/5ZrOHgISp
        mmxDMrZuZQfrWLl9ftI3oWLH6fZ6gUKn4F2myr079tT4h/GTMmUBtkgu5LpXWDj3AbCGp3
        cYpL7udtcIOpopoXSU0F+R50SQvnYvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-XxCnj0ShNcqc7wHr85ctiw-1; Fri, 20 Dec 2019 08:54:05 -0500
X-MC-Unique: XxCnj0ShNcqc7wHr85ctiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1662B1005502;
        Fri, 20 Dec 2019 13:54:04 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9908F6E51C;
        Fri, 20 Dec 2019 13:54:01 +0000 (UTC)
Date:   Fri, 20 Dec 2019 14:53:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 1/4] perf report: Fix incorrectly added dimensions as
 switch perf data file
Message-ID: <20191220135358.GE17348@krava>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220013722.20592-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 09:37:19AM +0800, Jin Yao wrote:
> We observed an issue that was some extra columns displayed after switching
> perf data file in browser. The steps to reproduce:
> 
> 1. perf record -a -e cycles,instructions -- sleep 3
> 2. perf report --group
> 3. In browser, we use hotkey 's' to switch to another perf.data
> 4. Now in browser, the extra columns 'Self' and 'Children' are displayed.
> 
> The issue is setup_sorting() executed again after repeat path, so dimensions
> are added again.
> 
> This patch checks the last key returned from __cmd_report(). If it's
> K_SWITCH_INPUT_DATA, skips the setup_sorting().
> 
>  v6:
>  ---
>  No change.
> 
>  v5:
>  ---
>  New patch in v5.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

for all 4 patches:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

