Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF3C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38A92184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558491053;
	bh=1ih48PI12kkUWV1gxUVEAlub4RsQgr7FS/vJ1I+lyVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0fKD3NeoOtLa25KgAVQbG2U1Xf1VUXhtIQhPfCRaZpTxIWBLrGeL02FjSMGl78NLC
	 qXLuMLWRz4T/4/dnAC5jrQlHDoYzKUd113/5cV9t6irn+aHdjoAiTyVZQAGQ+XNKIZ
	 mTueNuT0qnnjhFrUdGkFH45IGdDSflR4yrKpmfc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfEVCKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbfEVCKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:10:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157A6217D7;
        Wed, 22 May 2019 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558491051;
        bh=1ih48PI12kkUWV1gxUVEAlub4RsQgr7FS/vJ1I+lyVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KIGFNpsDdLIOqnE7XDF5rYo0tqQY9FfacESF9YLB4BPT4od6Lx5POSWD/pxhrNCaR
         BW4MvmqV471h3ck5LHF2z+9/OEZDNUkx7X+Q2qbEI2Dxl3wk+mxwFqhLm8KAZqf5ZB
         X6Z7JKA9ePiZfYMjNNaurLH1DEAuFC+nrdqNbKnc=
Date:   Tue, 21 May 2019 19:10:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Marco Elver <elver@google.com>, kbuild-all@01.org,
        aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] mm/kasan: Print frame description for stack bugs
Message-Id: <20190521191050.b8ddb9bb660d13330896529e@linux-foundation.org>
In-Reply-To: <201905190408.ieVAcUi7%lkp@intel.com>
References: <20190517131046.164100-1-elver@google.com>
        <201905190408.ieVAcUi7%lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2019 04:48:21 +0800 kbuild test robot <lkp@intel.com> wrote:

> Hi Marco,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.1 next-20190517]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Marco-Elver/mm-kasan-Print-frame-description-for-stack-bugs/20190519-040214
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 

This, I assume?

--- a/mm/kasan/report.c~mm-kasan-print-frame-description-for-stack-bugs-fix
+++ a/mm/kasan/report.c
@@ -230,7 +230,7 @@ static void print_decoded_frame_descr(co
 		return;
 
 	pr_err("\n");
-	pr_err("this frame has %zu %s:\n", num_objects,
+	pr_err("this frame has %lu %s:\n", num_objects,
 	       num_objects == 1 ? "object" : "objects");
 
 	while (num_objects--) {
@@ -257,7 +257,7 @@ static void print_decoded_frame_descr(co
 		strreplace(token, ':', '\0');
 
 		/* Finally, print object information. */
-		pr_err(" [%zu, %zu) '%s'", offset, offset + size, token);
+		pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
 	}
 }
 
_

