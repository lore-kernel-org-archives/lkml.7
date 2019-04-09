Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F121473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfDIFWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:22:35 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:50536 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIFWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:22:35 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 01:22:34 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id DFD4E15CBFF;
        Tue,  9 Apr 2019 14:22:32 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x395MV3j012491
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 9 Apr 2019 14:22:32 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x395MVgG008354
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 9 Apr 2019 14:22:31 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x395MVYO008353;
        Tue, 9 Apr 2019 14:22:31 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Hou Tao <houtao1@huawei.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: issue flush after the writeback of FAT
References: <20190409030158.136316-1-houtao1@huawei.com>
        <20190409034100.GF1177@magnolia>
Date:   Tue, 09 Apr 2019 14:22:31 +0900
In-Reply-To: <20190409034100.GF1177@magnolia> (Darrick J. Wong's message of
        "Mon, 8 Apr 2019 20:41:00 -0700")
Message-ID: <87a7gzbvmw.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

>> +	err = __generic_file_fsync(filp, start, end, datasync);
>> +	if (err)
>> +		return err;
>>  
>> -	res = generic_file_fsync(filp, start, end, datasync);
>>  	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);
>
> Huh.  I would've thought that flushing the FAT would also be required
> at the end of a WB_SYNC_ALL (aka data integrity) writepages call?

In fatfs implement, FAT area is flushed by sync_mapping_buffers(fat_inode). 
(FAT buffer is dirtied only by using bh->b_assoc_map to fat_inode)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
