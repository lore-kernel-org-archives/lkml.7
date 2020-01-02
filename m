Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25AA21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="bh8Rm5/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgABUAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:00:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35696 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:00:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so6747990wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/zqVBJss9FeKefd7C+16Ae2FlqoKun4UIZaiQyERGc=;
        b=bh8Rm5/FVZosPDfz+Mw5ff9vf/2j572WpXz9+0Va/yBflPMsqI44Jg62X6+/AeFj3V
         EQOKao/TAmkbp7yJsDnHSorYgfsmsL56FykZIR9KD9Auh8Fsw8QNNDLcYKCVg/9crTl2
         LwAVJFQWG9hTjgUfWKh/qZiatAQDrsgMONkdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/zqVBJss9FeKefd7C+16Ae2FlqoKun4UIZaiQyERGc=;
        b=T/O7e0vn0Dk9V5r6aGwgdrDa6VPbUgcYYpWYgWmSHr0z1i5YOMxOwUS1Tihb69Rs3v
         PQqTf173w0L4FCPjTomsFfdA+z6bCbTTq64O2ILzXcp1E+5QUdtCU64QJsgQBigm0W31
         W9GZYzCEydx2uf0kFwwCFd51J4lh4uxHbEZeUUHoUVkKPyeLhu5TqTTP82pXeu45ELeu
         mPZLc8MCXCSak/bp5plsWxP447KXk+LVeykioV3RoVMzR3FcB1aBMYq+I2w08ZR4E9PI
         fJyxkuebaCelIegvHvOAb0jmmiyYg7dotpy/fcIGB8FPABwYok/rG7DjwGSjqvdV2Bxu
         KzQw==
X-Gm-Message-State: APjAAAXEWCiFsjoY+1VgMnoQVepLQ0wpn9bAuJjKITtXu6n8ORj88tub
        89lPXrtEaqEOR2swpP6iLBRIgw==
X-Google-Smtp-Source: APXvYqzbBWegsQESMIUakWIouetdLTOWbJmmDhnF1qFIOEZFCKKaMuyr8vQCuBQy7j9XFt+KfkRr9A==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr15283378wmi.45.1577995253252;
        Thu, 02 Jan 2020 12:00:53 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id n10sm56618651wrt.14.2020.01.02.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:00:52 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:00:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <20200102200052.GA1181932@chrisdown.name>
References: <cover.1577990599.git.chris@chrisdown.name>
 <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
 <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amir Goldstein writes:
>Wouldn't it be easier to check max_inodes instead of passing this
>use_sb_ino arg?
>Is there any case where they *need* to differ?

Hmm, I suppose probably not? In that case should I just check against 
SB_KERNMOUNT, since max_inodes can only be 0 in that case?

>> @@ -3378,6 +3411,8 @@ enum shmem_param {
>>         Opt_nr_inodes,
>>         Opt_size,
>>         Opt_uid,
>> +       Opt_inode32,
>> +       Opt_inode64,
>
>Does not belong to this patch..
>
>>  };
>>
>>  static const struct fs_parameter_spec shmem_param_specs[] = {
>> @@ -3389,6 +3424,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
>>         fsparam_string("nr_inodes",     Opt_nr_inodes),
>>         fsparam_string("size",          Opt_size),
>>         fsparam_u32   ("uid",           Opt_uid),
>> +       fsparam_flag  ("inode32",       Opt_inode32),
>> +       fsparam_flag  ("inode64",       Opt_inode64),
>
>Ditto

Bleh, I'll fix this and send v3.

>>         {}
>>  };
>>
>> @@ -3690,7 +3727,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>>  #endif
>>         uuid_gen(&sb->s_uuid);
>>
>> -       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
>> +       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0,
>> +                               VM_NORESERVE, true);
>
>Should usb_sb_ino be true for the kern_mount??
>In any case, it wouldn't matter if it was false, hence no need to pass
>an argument
>and can either check for sbinfo->max_inodes or the SB_KERNMOUNT flag in
>shmem_get_inode().

Ok, cool. I'll fix these up and send v3. Thanks!
