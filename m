Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E15C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC65E2465A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0p/oh+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfLLJlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:41:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728501AbfLLJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576143713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDuYeqaoTzZT3SuTC+CYOJrF1cewKTwItcdevSevcmk=;
        b=a0p/oh+ia019+CITmfL/tdfixFq/QL2wvJQbycUUw1IA7zBamByJa568fOMjbRZ4sIRFYm
        4BJ+5WLl++EKp9wR3VlFlQgq20Tj2MByrZesBWjKhBzS8nrJO8VjU+1XfnzD9QgOD5QZ1l
        ZVpzBtkgs0gSCHr11eyCP2+EdPgmUWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-8Wy0zXskNpaankkBGiS8-Q-1; Thu, 12 Dec 2019 04:41:51 -0500
X-MC-Unique: 8Wy0zXskNpaankkBGiS8-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC4D2107ACCD;
        Thu, 12 Dec 2019 09:41:49 +0000 (UTC)
Received: from krava (ovpn-204-197.brq.redhat.com [10.40.204.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 556456362E;
        Thu, 12 Dec 2019 09:41:45 +0000 (UTC)
Date:   Thu, 12 Dec 2019 10:41:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH 3/3] perf stat: Add --metric option
Message-ID: <20191212094140.GE22550@krava>
References: <20191211224800.9066-1-jolsa@kernel.org>
 <20191211224800.9066-4-jolsa@kernel.org>
 <20191211230223.GD862919@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211230223.GD862919@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:02:23PM -0800, Andi Kleen wrote:
> > Currently only one metric can be passed to perf stat command.
> 
> It's near certain that users will want more.

right, it was just convenient for the rfc ;-)

but I wonder we could keep it that way anyway and have:

current way of using pre-defined metrics:
  # perf stat -M m1,m2,m3

simple/fast way of checking on metric:
  # perf stat -m 'm4=....'

metric from user file:
  # perf stat -M m5,m6 --metric-file=path

thanks,
jirka

