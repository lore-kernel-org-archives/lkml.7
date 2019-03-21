Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D112184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553146162;
	bh=zGKRBCLWhVLcIwhO2r7StdXaRln7kbP2M3D5e2nsTz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCT0oSA+V67Hk+HRmRgT9RnIMuinDOqk74sJWDdh0iEWiH8hTuYfhS+zd6fNSau2x
	 nwx/OdVEkMfwUg6u6oabsA0afu0ZvQ/zLZhVOxTFoTZUvPv04SJ+6GWdGlRcGueNdE
	 AqBrrdlGcyqAglUqeWiIxnWslm4KrGMX9RDNDirQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfCUF3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfCUF3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:29:19 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3763218AE;
        Thu, 21 Mar 2019 05:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553146158;
        bh=zGKRBCLWhVLcIwhO2r7StdXaRln7kbP2M3D5e2nsTz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7O9J5K6dTLd/nYaGhllnH8hw53YqiknHzLxYnQT2F/4+8OyW+tHtgs/cMHX0fuw1
         J6RRRPrb6sZbaG0v1xf1OFoAE2bQdVSsNanktbdhvorJT6Rh+z6VPcloYdAsgjfISq
         3ZTMnP8OqgMQxuYdNbTdvIIADxn8XLwUP3l2J09A=
Date:   Thu, 21 Mar 2019 06:29:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Bo Gan <ganb@vmware.com>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4.4.y] perf bench: Copy kernel files needed to build
 mem{cpy,set} x86_64 benchmarks
Message-ID: <20190321052916.GD21413@kroah.com>
References: <20190320211400.7128-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320211400.7128-1-daniel.diaz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:13:56PM -0600, Daniel Díaz wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> commit 7d7d1bf1d1dabe435ef50efb051724b8664749cb upstream.
> 
> We can't access kernel files directly from tools/, so copy the required
> bits, and make sure that we detect when the original files, in the
> kernel, gets modified.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: http://lkml.kernel.org/n/tip-z7e76274ch5j4nugv048qacb@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Now applied, thanks.

greg k-h
