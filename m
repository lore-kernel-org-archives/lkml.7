Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09EC20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439828AbfJXQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:23:37 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:49034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733261AbfJXQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:23:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AD6DC182CF665;
        Thu, 24 Oct 2019 16:23:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shade65_1f39141a68414
X-Filterd-Recvd-Size: 1838
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:23:34 +0000 (UTC)
Message-ID: <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
Subject: Re: [PATCH 04/15] staging: exfat: Clean up return codes -
 FFS_PERMISSIONERR
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:23:33 -0700
In-Reply-To: <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
         <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> Convert FFS_PERMISSIONERR to -EPERM
[]
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
[]
> @@ -2526,7 +2526,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
>  	if (err) {
> -		if (err == FFS_PERMISSIONERR)
> +		if (err == -EPERM)
>  			err = -EPERM;
>  		else
>  			err = -EIO;
[]
> @@ -2746,7 +2746,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
>  			  new_dentry);
>  	if (err) {
> -		if (err == FFS_PERMISSIONERR)
> +		if (err == -EPERM)
>  			err = -EPERM;
>  		else if (err == FFS_INVALIDPATH)
>  			err = -EINVAL;

These test and assign to same value blocks look kinda silly.


