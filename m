Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4604BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2196220659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439815AbfJXQX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:23:29 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:48995 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405586AbfJXQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:23:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EF6CC182CF66E;
        Thu, 24 Oct 2019 16:23:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest79_1df99958b091f
X-Filterd-Recvd-Size: 2247
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:23:25 +0000 (UTC)
Message-ID: <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
Subject: Re: [PATCH 00/15] staging: exfat: Clean up return codes
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:23:24 -0700
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> The code had its own non-standard FFS_FOO return codes. Go through
> and convert them all the kernel standard -EFOO codes.
> 
> Valdis Kletnieks (15):
>   staging: exfat: Clean up return codes - FFS_FULL
>   staging: exfat: Clean up return codes - FFS_NOTFOUND
>   staging: exfat: Clean up return codes - FFS_DIRBUSY
>   staging: exfat: Clean up return codes - FFS_PERMISSIONERR
>   staging: exfat: Clean up return codes - FFS_NAMETOOLONG
>   staging: exfat: Clean up return codes - FFS_FILEEXIST
>   staging: exfat: Clean up return codes - FFS_INVALIDPATH
>   staging: exfat: Clean up return code - FFS_MEMORYERR
>   staging: exfat: Clean up return codes - FFS_FORMATERR
>   staging: exfat: Clean up return codes - FFS_MEDIAERR
>   staging: exfat: Clean up return codes - FFS_EOF
>   staging: exfat: Clean up return codes - FFS_INVALIDFID
>   staging: exfat: Clean up return codes - FFS_ERROR
>   staging: exfat: Clean up return codes - remove unused codes
>   staging: exfat: Clean up return codes - FFS_SUCCESS

All well and good, but does converting the error code from
positive to negative have any impact on any of the code
paths that use these return values?

	if (error > 0)
vs
	if (error < 0)

?

If you've gone through all the return tests,
then it would be nice to say so.


