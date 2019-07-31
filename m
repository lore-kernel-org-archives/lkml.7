Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414F5206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="cm81+0tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfGaOGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:06:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42244 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfGaOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:06:46 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so3579944iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fZNwrkMVKiuAg2/EbekwczHzfWS9d7cPF07lILiSr04=;
        b=cm81+0ttyogzbawDNgloBP2d+3Ip1gbgDJvVFj/sKn9t+r2Vk1GFxwDPjDujxMP5Yl
         8D7ZG1PPbYCm2JTT9vPtkZWC8lWOBjQ3nPDeDQ5Oz2vMVTT1RU+bN8cDTddH7MYxu7W3
         RSrMb6/7HNe4GGgBQG5PK+VEgYJ5A01o7MsRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fZNwrkMVKiuAg2/EbekwczHzfWS9d7cPF07lILiSr04=;
        b=OGAI89uLX/Be0vFTTPFGURyXKh9SU6v+p0YFPMtp7VmNcjlmam4AaBcH30+RGE3tVd
         UHCYXFL74QvLQASFiuDmohQT+R9z/C+1jQyVhK5EfD1kWSYTCc4huNsUnLS3Nb1nxquf
         4AKqD/uE8djpohnQHXF+8x5UavyRqKMLyOSQjdV6cmFFHZNDhtSFZqXUhLO69Yr/e6Un
         +9lr4qgwmLIcIKgDN5TqwLzAsdCmejGNDaGeB+NivViP1KPUY/nWC2L8vj32zKPuBM5m
         MSphGunLPp/+CnS9qlWzT6rjLORMSZYA1jZeA3W1GmzU0HbUqG7Ig/KbnzqR5yJQwug8
         JUag==
X-Gm-Message-State: APjAAAW7HD/1uHl/3rYwUY/UE4QXQNbky1E3nFocpOj3sKu0IxiqmBK5
        b+o9YP2cuFI1Fb6jHP+dNT5jYw==
X-Google-Smtp-Source: APXvYqyKwTlHuovQ0FZC7YuS6LfPdubC/e5rhbCUEhGTHGwA6ez3AfRilCCRoa1fa+SPff50Myrvfg==
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr87307549iob.285.1564582005619;
        Wed, 31 Jul 2019 07:06:45 -0700 (PDT)
Received: from [10.10.6.48] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id v3sm12305025ioh.58.2019.07.31.07.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:06:44 -0700 (PDT)
Subject: Re: [PATCH] udf: prevent allocation beyond UDF partition
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Steve Magnani <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
References: <1564341552-129750-1-git-send-email-steve@digidescorp.com>
 <20190731095901.GC15806@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <0449d177-28f3-2da8-b893-940e9e0511ed@digidescorp.com>
Date:   Wed, 31 Jul 2019 09:06:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731095901.GC15806@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 4:59 AM, Jan Kara wrote:
> On Sun 28-07-19 14:19:12, Steve Magnani wrote:
>> The UDF bitmap allocation code assumes that a recorded
>> Unallocated Space Bitmap is compliant with ECMA-167 4/13,
>> which requires that pad bytes between the end of the bitmap
>> and the end of a logical block are all zero.
>>
>> When a recorded bitmap does not comply with this requirement,
>> for example one padded with FF to the block boundary instead
>> of 00, the allocator may "allocate" blocks that are outside
>> the UDF partition extent. This can result in UDF volume descriptors
>> being overwritten by file data or by partition-level descriptors,
>> and in extreme cases, even in scribbling on a subsequent disk partition.
>>
>> Add a check that the block selected by the allocator actually
>> resides within the UDF partition extent.
>>
>> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
> Thanks for the patch! Added to my tree. I've just slightly modified the
> patch to also output error message about filesystem corruption.
>
> 								Honza


Thanks Jan. Ror the record, it appears that Windows chkdsk has a bug in its
analysis of a space bitmaps. If the last block of a UDF partition falls
in the middle of a bitmap byte, chkdsk reports spurious errors if the bits
in that byte that _don't_ correspond to UDF partition blocks are zero.

To maximize interoperability it would appear that it's best to format such
that UDF partition sizes are always a multiple of 8 blocks.

Note to non-UDF wonks reading this, a UDF partition is a sub-extent of a
disk partition. So achieving the multiple-of-8-blocks involves a change to
mkudffs code.

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

