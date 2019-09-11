Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF76C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199BC207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfIKTQ1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 15:16:27 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:48777 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728600AbfIKTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:16:27 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i886I-0005Wf-Ge; Wed, 11 Sep 2019 21:16:22 +0200
Received: from [213.55.220.183] (helo=[100.66.136.169])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i886I-000Nta-AY; Wed, 11 Sep 2019 21:16:22 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] Staging: exfat: avoid use of strcpy
Date:   Wed, 11 Sep 2019 21:16:21 +0200
Message-Id: <27939F0F-4406-4CAE-9D88-CFDA58A76BA1@volery.com>
References: <20190911190355.GA18977@kadam>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
In-Reply-To: <20190911190355.GA18977@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 11 Sep 2019, at 21:06, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> ﻿On Wed, Sep 11, 2019 at 09:53:03PM +0200, Sandro Volery wrote:
>> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
>> index da8c58149c35..4336fee444ce 100644
>> --- a/drivers/staging/exfat/exfat_core.c
>> +++ b/drivers/staging/exfat/exfat_core.c
>> @@ -2960,18 +2960,15 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>>    struct super_block *sb = inode->i_sb;
>>    struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
>>    struct file_id_t *fid = &(EXFAT_I(inode)->fid);
>> -
>> -    if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
>> +    
> 
> You have added a tab here.
> 
>> +    if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
>>        return FFS_INVALIDPATH;
>> 
>> -    strcpy(name_buf, path);
>> -
>>    nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
>>    if (lossy)
>>        return FFS_INVALIDPATH;
>> 
>> -    fid->size = i_size_read(inode);
>> -
>> +fid->size = i_size_read(inode);
> 
> And you accidentally deleted some white space here.
> 
> I use vim, so I have it configured to highlight whitespace at the end of
> a line.  I don't remember how it's done now but I googled it for you.
> https://vim.fandom.com/wiki/Highlight_unwanted_spaces


Ugh I'm so sorry I make the most stupid mistakes today.. I was so sure 
this time I got it right!
I'll fix it tomorrow.

Thanks,
Sandro V
