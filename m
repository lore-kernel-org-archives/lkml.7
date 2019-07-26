Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274E3C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E222CED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB1LOAuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGZJuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:50:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:50:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so24581608plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xIePdwlRsoSX5vOkckcAtTCmUBJ6y/4+xukjXHlBQs4=;
        b=KB1LOAuRl/m6/i7YzeiMqt2KribRmUYSZvq4z5XDwQ7lH9jwuCcJlNRrLStpKa5VIM
         FAZAdARlAytJAMcdtoogYC09Ajch5UFuZebGO/gZ+yzS5KqMGUy868mMhSgbmFKBxT8s
         DexT+CPvj7b160oYO7d4K6Ca2LosuLLZy7D7nag4K0H5WfV2o0oLRjRDAujL0QodqfW6
         je4QtObdbs7WUPNNWIa9iZyUVrBXjbezsN7G4xip4+9c9wlv1eCiONyooexivrEvby32
         2nn8tfBeA3lDbIwPNw3eRU74zVMztjVJyFcGz5Ly9XXTOylPVrA+L9NkEyM8zx8B+QuB
         rAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xIePdwlRsoSX5vOkckcAtTCmUBJ6y/4+xukjXHlBQs4=;
        b=PIcydFjZDbLumStA7AA6Iw2PGx2RE/WEI+XpggRL/6D5io7sfzGwOL72Sfm/kPskvz
         wpoBlnzce95Ku5haJehtgMS/so7G92Q75Hht1gpsNu/up+Yxm/nwVDpL3mpO7gM30U2q
         iPjFOufxBoE3+Pc7mb42DOToHaZQtYMiZMpEyVYsFgHcfeUfyzAkCU5EPlIqES6oBMP+
         EH7bp2+mcFp3OVb29j9CNekAD6RQivmgQPatE2heKWjTYCf9H1hf/NtiFbr88hhayZE5
         UQvLP9NJ1vnJ9D6ag7NgochtX7kyzMK0yLrm0uoP6PEjZvgnZPb1mgUEfCf3ynTUxY12
         AH0A==
X-Gm-Message-State: APjAAAWswQXetQkfHi4NOKl4nHHIlpi5k6mjGIT4OaxblMxn6mdlInX0
        OBpkXuZx8SZZdhOCDw5/pqfcS6eBJDY=
X-Google-Smtp-Source: APXvYqyrVk8RokQvlf4O+IFw1CepOANCqoG/M0MPTfmk+U2v5TpxBO6zfDTewGEkC3xYk2mU/NXDRg==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr8598049pla.34.1564134606688;
        Fri, 26 Jul 2019 02:50:06 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id s67sm53345975pjb.8.2019.07.26.02.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:50:06 -0700 (PDT)
Subject: Re: [PATCH 1/3] fs: ocfs2: Fix possible null-pointer dereferences in
 ocfs2_xa_prepare_entry()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190726033655.32253-1-baijiaju1990@gmail.com>
 <b6aef7d8-9884-7349-bcec-0c8654d1b062@linux.alibaba.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <620ac436-ffbc-8429-b952-278cd2a8aaba@gmail.com>
Date:   Fri, 26 Jul 2019 17:50:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b6aef7d8-9884-7349-bcec-0c8654d1b062@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/26 17:37, Joseph Qi wrote:
>
> On 19/7/26 11:36, Jia-Ju Bai wrote:
>> In ocfs2_xa_prepare_entry(), there is an if statement on line 2136 to
>> check whether loc->xl_entry is NULL:
>>      if (loc->xl_entry)
>>
>> When loc->xl_entry is NULL, it is used on line 2158:
>>      ocfs2_xa_add_entry(loc, name_hash);
>>          loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
>>          loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
>> and line 2164:
>> 	ocfs2_xa_add_namevalue(loc, xi);
>>          loc->xl_entry->xe_value_size = cpu_to_le64(xi->xi_value_len);
>>          loc->xl_entry->xe_name_len = xi->xi_name_len;
>>
>> Thus, possible null-pointer dereferences may occur.
>>
>> To fix these bugs, if loc-xl_entry is NULL, ocfs2_xa_prepare_entry()
>> abnormally returns with -EINVAL.
>>
>> These bugs are found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/ocfs2/xattr.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>> index 385f3aaa2448..f690502daf3c 100644
>> --- a/fs/ocfs2/xattr.c
>> +++ b/fs/ocfs2/xattr.c
>> @@ -2154,8 +2154,10 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
>>   			}
>>   		}
>>   		ocfs2_xa_wipe_namevalue(loc);
>> -	} else
>> -		ocfs2_xa_add_entry(loc, name_hash);
>> +	} else {
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
> Since entry not found, so there is nothing to do in
> ocfs2_xa_prepare_entry(). We may change it like:
>
> if (!loc->xl_entry) {
> 	rc = -EINVAL;
> 	goto out;
> }	
>
> if (ocfs2_xa_can_reuse_entry(loc, xi)) {
> 	......
> }
> .....
>

Okay, I will send a v2 patch.


Best wishes,
Jia-Ju Bai
