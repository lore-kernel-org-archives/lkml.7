Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB822176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poSS5t/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLQCMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:12:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42592 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfLQCMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:12:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so11596990otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 18:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QqW7udINDetruivo+istAhW9QTLGO+Ls7xMqBAmtxdo=;
        b=poSS5t/kIHnX1HzIS4v1cpUShVQdG5AHjWNhnHT9Uvk4CwxN57RGms6k/LP0Z+UmP2
         WvcH/pFVyMeJ56wS+2iTXxFNV5uZbymJkLe5gyASf0gPWQXh2IY4ZCSoGtLIjsj1XFZs
         8cexhPojA7xlU7ZLcUVsRWLEVSTPMhrmMa75wCvfcZU59kvM99pC/8VUzjo6fYC/Munx
         VsyjMbTWZ3jFUIAGrVz1cvM9pb5NHT1iwQEOeX9CupzHC46Jd+GxdA1Ql1DPPPYEgdgd
         krUIaGN4Q/ooQ9Mr4D4+3B6p3r2FSyWNB7NmoWRWYUnRdJ6UGBGmaShExaDml0UyFimb
         LFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqW7udINDetruivo+istAhW9QTLGO+Ls7xMqBAmtxdo=;
        b=EDFRbDGKshDSxKRfIrYmO98toclPluwwzxzP0/qJdL+yBgAB0Gtq25LVPMa9zP2YEG
         AgwFq5kzZp+I/Y6iJfUzEnbptW1Dhrur5aNCf/a3PNR1YAYQUGw3Qcud2XAkXXq7YpcX
         qpIJOcaQjI3YZC7o7Zb35tvuO3jZljSvyNwLoUhfR82+vs1XYu2YbfKB7cqFXgMbW9N0
         fPRB+szmgD5kvXsXq/snu5WGUhiVC27/lZDC8F51TznY6tY9jTq6p/UHxAstvsuCOo1+
         A8etEDlJiS3H9VNmUZpros0ni53EQjibwipvNFdHhNrrgdnXONXnbvy6ZbgylpzJMYz6
         7H5Q==
X-Gm-Message-State: APjAAAVsiN5hv8JwdzCvx+fpVCC261pywxzg9es40devsWiudUoXSjqR
        beewbGd7p5F90bScWgjN/LU=
X-Google-Smtp-Source: APXvYqxpfT8hEbGa76rfQ4oTWcdYQmlJLlx5TRrVSSgqQ9DJ5HdwnD5/yM7nLGuav53vQfm67tHsew==
X-Received: by 2002:a9d:708f:: with SMTP id l15mr36920205otj.286.1576548740491;
        Mon, 16 Dec 2019 18:12:20 -0800 (PST)
Received: from JosephdeMacBook-Pro.local ([205.204.117.6])
        by smtp.gmail.com with ESMTPSA id t3sm7478633otq.32.2019.12.16.18.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 18:12:19 -0800 (PST)
Subject: Re: [Ocfs2-devel] [PATCH v3] ocfs2: call journal flush to mark
 journal as empty after journal recovery when mount
To:     Kai Li <li.kai4@h3c.com>, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, chge@linux.alibaba.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20191217020140.2197-1-li.kai4@h3c.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <339c2bfc-fc40-77f1-3515-eb90e34854f6@gmail.com>
Date:   Tue, 17 Dec 2019 10:12:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217020140.2197-1-li.kai4@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/17 10:01, Kai Li wrote:
> If journal is dirty when mount, it will be replayed but jbd2 sb
> log tail cannot be updated to mark a new start because
> journal->j_flag has already been set with JBD2_ABORT first
> in journal_init_common. When a new transaction is committed, it
> will be recored in block 1 first(journal->j_tail is set to 1 in
> journal_reset).If emergency restart happens again before journal
> super block is updated unfortunately, the new recorded trans will
> not be replayed in the next mount.
> 
> The following steps describe this procedure in detail.
> 1. mount and touch some files
> 2. these transactions are committed to journal area but not checkpointed
> 3. emergency restart
> 4. mount again and its journals are replayed
> 5. journal super block's first s_start is 1, but its s_seq is not updated
> 6. touch a new file and its trans is committed but not checkpointed
> 7. emergency restart again
> 8. mount and journal is dirty, but trans committed in 6 will not be
> replayed.
> 
> This exception happens easily when this lun is used by only one node. If it
> is used by multi-nodes, other node will replay its journal and its
> journal super block will be updated after recovery like what this patch
> does.
> 
> ocfs2_recover_node->ocfs2_replay_journal.
> 
> The following jbd2 journal can be generated by touching a new file after
> journal is replayed, and seq 15 is the first valid commit, but first seq
> is 13 in journal super block.
> logdump:
> Block 0: Journal Superblock
> Seq: 0   Type: 4 (JBD2_SUPERBLOCK_V2)
> Blocksize: 4096   Total Blocks: 32768   First Block: 1
> First Commit ID: 13   Start Log Blknum: 1
> Error: 0
> Feature Compat: 0
> Feature Incompat: 2 block64
> Feature RO compat: 0
> Journal UUID: 4ED3822C54294467A4F8E87D2BA4BC36
> FS Share Cnt: 1   Dynamic Superblk Blknum: 0
> Per Txn Block Limit    Journal: 0    Data: 0
> 
> Block 1: Journal Commit Block
> Seq: 14   Type: 2 (JBD2_COMMIT_BLOCK)
> 
> Block 2: Journal Descriptor
> Seq: 15   Type: 1 (JBD2_DESCRIPTOR_BLOCK)
> No. Blocknum        Flags
>  0. 587             none
> UUID: 00000000000000000000000000000000
>  1. 8257792         JBD2_FLAG_SAME_UUID
>  2. 619             JBD2_FLAG_SAME_UUID
>  3. 24772864        JBD2_FLAG_SAME_UUID
>  4. 8257802         JBD2_FLAG_SAME_UUID
>  5. 513             JBD2_FLAG_SAME_UUID JBD2_FLAG_LAST_TAG
> ...
> Block 7: Inode
> Inode: 8257802   Mode: 0640   Generation: 57157641 (0x3682809)
> FS Generation: 2839773110 (0xa9437fb6)
> CRC32: 00000000   ECC: 0000
> Type: Regular   Attr: 0x0   Flags: Valid
> Dynamic Features: (0x1) InlineData
> User: 0 (root)   Group: 0 (root)   Size: 7
> Links: 1   Clusters: 0
> ctime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
> atime: 0x5de5d870 0x113181a1 -- Tue Dec  3 11:37:20.288457121 2019
> mtime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
> dtime: 0x0 -- Thu Jan  1 08:00:00 1970
> ...
> Block 9: Journal Commit Block
> Seq: 15   Type: 2 (JBD2_COMMIT_BLOCK)
> 
> The following is jouranl recovery log when recovering the upper jbd2
> journal when mount again.
> syslog:
> [ 2265.648622] ocfs2: File system on device (252,1) was not unmounted cleanly, recovering it.
> [ 2265.649695] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 0
> [ 2265.650407] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 1
> [ 2265.650409] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 2
> [ 2265.650410] fs/jbd2/recovery.c:(jbd2_journal_recover, 278): JBD2: recovery, exit status 0, recovered transactions 13 to 13
> 
> Due to first commit seq 13 recorded in journal super is not consistent
> with the value recorded in block 1(seq is 14), journal recovery will be
> terminated before seq 15 even though it is an unbroken commit, inode
> 8257802 is a new file and it will be lost.
> 
> Signed-off-by: Kai Li <li.kai4@h3c.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/journal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 1afe57f425a0..68ba354cf361 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1066,6 +1066,14 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
>  
>  	ocfs2_clear_journal_error(osb->sb, journal->j_journal, osb->slot_num);
>  
> +	if (replayed) {
> +		jbd2_journal_lock_updates(journal->j_journal);
> +		status = jbd2_journal_flush(journal->j_journal);
> +		jbd2_journal_unlock_updates(journal->j_journal);
> +		if (status < 0)
> +			mlog_errno(status);
> +	}
> +
>  	status = ocfs2_journal_toggle_dirty(osb, 1, replayed);
>  	if (status < 0) {
>  		mlog_errno(status);
> 
