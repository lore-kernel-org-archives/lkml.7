Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB4AC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581D12082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfFTKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfFTKa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:30:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 905F731628EF;
        Thu, 20 Jun 2019 10:30:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8AD19C71;
        Thu, 20 Jun 2019 10:30:20 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 525AB1806B0E;
        Thu, 20 Jun 2019 10:30:20 +0000 (UTC)
Date:   Thu, 20 Jun 2019 06:30:19 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Message-ID: <1700587723.36256070.1561026619938.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190620192939.139bf5c0@canb.auug.org.au>
References: <20190620192939.139bf5c0@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.130, 10.4.195.2]
Thread-Topic: linux-next: build failure after merge of the nvdimm tree
Thread-Index: ugQHflS9VnH/ecTW2oBJ451saINOCw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 10:30:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Dan,
> 
> After merging the nvdimm tree, today's linux-next build (i386 defconfig)
> failed like this:
> 
> drivers/md/dm-table.c: In function 'device_synchronous':
> drivers/md/dm-table.c:897:9: error: implicit declaration of function
> 'dax_synchronous'; did you mean 'device_synchronous'?
> [-Werror=implicit-function-declaration]
>   return dax_synchronous(dev->dax_dev);
>          ^~~~~~~~~~~~~~~
>          device_synchronous
> drivers/md/dm-table.c: In function 'dm_table_set_restrictions':
> drivers/md/dm-table.c:1925:4: error: implicit declaration of function
> 'set_dax_synchronous'; did you mean 'device_synchronous'?
> [-Werror=implicit-function-declaration]
>     set_dax_synchronous(t->md->dax_dev);
>     ^~~~~~~~~~~~~~~~~~~
>     device_synchronous
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   38887edec247 ("dm: enable synchronous dax")
> 
> CONFIG_DAX is not set for this build.

Moving 'dax_synchronous' & 'set_dax_synchronous' function declaration
out of CONFIG_DAX should fix this. This will make compiler aware about 
'device_synchronous' function for non DAX archs as well.

Thanks,
Pankaj
 
> 
> I have reverted that commit for today.
> --
> Cheers,
> Stephen Rothwell
> 
