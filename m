Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4955C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="HYkuq8ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHSMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:10:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42298 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:10:26 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so3663267iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tod989bewvsh+ihp8Ytq66nz+m1s8UlnuaOcAgZNr9I=;
        b=HYkuq8ewGkngiYR7/rEWOG+x8/Qu0BhykyLbB+7rmgyN4+6VIMQX9uvy77d4jg0RZe
         QRP4tssOtnliZu+Rx8kkdgeB5copPf7SCFLPHBMAwzcsMA0JxWWZ8kgWd/ZOnzJn159X
         qAIfeK+C5PxkQFfW4t2R18w5ghIh8TWsgAIks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tod989bewvsh+ihp8Ytq66nz+m1s8UlnuaOcAgZNr9I=;
        b=W2soGVV2NVQ26vhHcDiq89iVSNADSjE5l3+RYg9Ec09azHZ2V1e/k6TI05Whg8tyPR
         QHiNZtI6W9GRHAHyQqLH0gQiNqKmz1oq6oEfvoVkoZzps4RkNHaIwT/micj9dRSgdAUX
         KkXU3GDzz77MZwqGQsWWoTV93X+a1rr5oq1nvmlvyS7EIzGgCoUs2gsmKdWr2Lr2VanX
         LzyiEzX0xJb+rPAEZ6ZIN/hAIRwMyCOu02zJlP1kstB2WKt6GMQIvDYT8zdfsZDnCNFz
         C/r9/ZoWbCPsGGxTiOI2s2fUsineqonkNSlpPOW9bf33lrHzf9vtGMxqGkt3hD6H3psc
         4OOA==
X-Gm-Message-State: APjAAAVWvsg6hMGRN3DL/nzAA5eb2s2r/sNpu1x0UwyxNoh43OZSj0S2
        YwoPL9E+ZfGL0kz17bE082moQtEDgIc=
X-Google-Smtp-Source: APXvYqzopqTHuIHVC1UXUHkwpRVr0BtAEJu7FpyXw7RIUOvmijsvs7CfxqySyc6M5pzWri7vi4OOvw==
X-Received: by 2002:a6b:d008:: with SMTP id x8mr23843587ioa.129.1566216625566;
        Mon, 19 Aug 2019 05:10:25 -0700 (PDT)
Received: from [10.10.6.134] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id n25sm1045818iop.3.2019.08.19.05.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:10:24 -0700 (PDT)
Subject: Re: [PATCH v2] udf: reduce leakage of blocks related to named streams
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190814125002.10869-1-steve@digidescorp.com>
 <20190815124218.GE14313@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <4169b326-a8ff-5fc4-0e5e-393569273267@digidescorp.com>
Date:   Mon, 19 Aug 2019 07:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815124218.GE14313@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan -


On 8/15/19 7:42 AM, Jan Kara wrote:
> On Wed 14-08-19 07:50:02,  Steven J. Magnani  wrote:
>> Windows is capable of creating UDF files having named streams.
>> One example is the "Zone.Identifier" stream attached automatically
>> to files downloaded from a network. See:
>>    https://msdn.microsoft.com/en-us/library/dn392609.aspx
>>
>> Modification of a file having one or more named streams in Linux causes
>> the stream directory to become detached from the file, essentially leaking
>> all blocks pertaining to the file's streams.
>>
>> Fix by saving off information about an inode's streams when reading it,
>> for later use when its on-disk data is updated.
>> <snip>
>>   	} else {
>>   		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
>>   		    (inode->i_sb->s_blocksize_bits - 9);
>> @@ -1498,6 +1502,16 @@ reread:
>>   		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
>>   		iinfo->i_lenAlloc = le32_to_cpu(efe->lengthAllocDescs);
>>   		iinfo->i_checkpoint = le32_to_cpu(efe->checkpoint);
>> +
>> +		/* Named streams */
>> +		iinfo->i_streamdir = (efe->streamDirectoryICB.extLength != 0);
>> +		iinfo->i_locStreamdir =
>> +			lelb_to_cpu(efe->streamDirectoryICB.extLocation);
>> +		iinfo->i_lenStreams = le64_to_cpu(efe->objectSize);
>> +		if (iinfo->i_lenStreams >= inode->i_size)
>> +			iinfo->i_lenStreams -= inode->i_size;
>> +		else
>> +			iinfo->i_lenStreams = 0;
> Hum, maybe you could just have i_objectSize instead of i_lenStreams? You
> use the field just to preserve objectSize anyway so there's no point in
> complicating it.
>

I started making this change and found that it actually complicates things more,
by forcing the driver to update i_objectSize everywhere that i_size is changed.
Are you sure this is what you want?

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>


