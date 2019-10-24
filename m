Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CBCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C920650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439888AbfJXQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:29:05 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:39174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405586AbfJXQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:29:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 294A88384363;
        Thu, 24 Oct 2019 16:29:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slip23_4ee4cce0ad431
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:29:02 +0000 (UTC)
Message-ID: <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
Subject: Re: [PATCH 15/15] staging: exfat: Clean up return codes -
 FFS_SUCCESS
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:29:00 -0700
In-Reply-To: <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
         <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> Just replace FFS_SUCCESS with a literal 0.

[]

> diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
[]
> @@ -214,7 +214,7 @@ static u8 *FAT_getblk(struct super_block *sb, sector_t sec)
>  
>  	FAT_cache_insert_hash(sb, bp);
>  
> -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {

Probably nicer to just drop the != 0

> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
[]
> @@ -768,13 +768,13 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
>  
>  		if ((offset == 0) && (oneblkread == p_bd->sector_size)) {
>  			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
> -			    FFS_SUCCESS)
> +			    0)

especially for these split line tests


