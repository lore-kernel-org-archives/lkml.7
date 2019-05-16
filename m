Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A2C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54AD20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cENApoOz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ev9uBfYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEPM5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:57:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45057 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:57:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F455606CF; Thu, 16 May 2019 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558011474;
        bh=wNPWdSNFLowBHRWGc2iu547/48b9Xj6CKUNFA19mcuU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=cENApoOzXNBti6omO3W5/s3d0hfJTsLL/vGKAuMi7qeI14X+rw36bPY30gOivvRtY
         IVephdNgSG9ZXNdWBAQA8jMn1HxXv33Y5BGtVFiCA/X1NUWtNhGVPHtUHaLk3R4fnF
         RZq7gOpbqwUvejW42UL1Wb4KVX5u1ql/PAhcCpRQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B3843606CF;
        Thu, 16 May 2019 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558011473;
        bh=wNPWdSNFLowBHRWGc2iu547/48b9Xj6CKUNFA19mcuU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=ev9uBfYPnkJiIVUo6J3Y0XY7X+Jqx8INNORcoWg+csM1tdvjghMm6E07MzP5qmXsy
         DZ+7m5v/h4Dd0Khcn/3W2rv0v5bFQpkni+9ZDmdNFt3abtgdNu0d7g349WN91tBSfd
         nx2QM01mKw5D+r16lvhZubB8eVw8/T/pADhZJamQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 May 2019 18:27:53 +0530
From:   stummala@codeaurora.org
To:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
In-Reply-To: <20190131032011.GC7308@codeaurora.org>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org>
 <20190131032011.GC7308@codeaurora.org>
Message-ID: <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org>
X-Sender: stummala@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Al,

Can you please consider this patch for merging?

Thanks,
Sahitya.

On 2019-01-31 08:50, Sahitya Tummala wrote:
> Al,
> 
> Can we merge this patch, if there are no further comments?
> 
> Thanks,
> Sahitya.
> 
> On Thu, Jan 03, 2019 at 04:48:15PM +0530, Sahitya Tummala wrote:
>> In the vfs_statx() context, during path lookup, the dentry gets
>> added to sd->s_dentry via configfs_attach_attr(). In the end,
>> vfs_statx() kills the dentry by calling path_put(), which invokes
>> configfs_d_iput(). Ideally, this dentry must be removed from
>> sd->s_dentry but it doesn't if the sd->s_count >= 3. As a result,
>> sd->s_dentry is holding reference to a stale dentry pointer whose
>> memory is already freed up. This results in use-after-free issue,
>> when this stale sd->s_dentry is accessed later in
>> configfs_readdir() path.
>> 
>> This issue can be easily reproduced, by running the LTP test case -
>> sh fs_racer_file_list.sh /config
>> (https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/racer/fs_racer_file_list.sh)
>> 
>> Fixes: 76ae281f6307 ('configfs: fix race between dentry put and 
>> lookup')
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> ---
>> v2:
>> - update comments relevant to the code.
>> 
>>  fs/configfs/dir.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
>> index 39843fa..f113101 100644
>> --- a/fs/configfs/dir.c
>> +++ b/fs/configfs/dir.c
>> @@ -58,15 +58,14 @@ static void configfs_d_iput(struct dentry * 
>> dentry,
>>  	if (sd) {
>>  		/* Coordinate with configfs_readdir */
>>  		spin_lock(&configfs_dirent_lock);
>> -		/* Coordinate with configfs_attach_attr where will increase
>> -		 * sd->s_count and update sd->s_dentry to new allocated one.
>> -		 * Only set sd->dentry to null when this dentry is the only
>> -		 * sd owner.
>> +		/*
>> +		 * Set sd->s_dentry to null only when this dentry is the
>> +		 * one that is going to be killed.
>>  		 * If not do so, configfs_d_iput may run just after
>>  		 * configfs_attach_attr and set sd->s_dentry to null
>>  		 * even it's still in use.
>>  		 */
>> -		if (atomic_read(&sd->s_count) <= 2)
>> +		if (sd->s_dentry == dentry)
>>  			sd->s_dentry = NULL;
>> 
>>  		spin_unlock(&configfs_dirent_lock);
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation 
>> Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
