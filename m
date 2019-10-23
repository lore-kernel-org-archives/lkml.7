Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ECCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20866205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nh1OJ7aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404310AbfJWKNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404300AbfJWKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so20866612wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4qw8x64i4XFEDlSAFYgF2VhxflxKizeU9gCHhrw8jfw=;
        b=Nh1OJ7aJevO81JAtHvLk1Jt33aeKFq13ZRvSI/dwaK1Rc+O4hYrEMuF+LPjBPamW6M
         hvMt5QPNnt+EWAeF5CrbTlH+BijHNo1iF2S3CMUP37k+Ws3CXaXP5GAwos7SZl0dlzW4
         k3COkFO2cS3oNqQjKITOC7K5YlTDyZiEFKbQ+2FRpjI4DObXKJfO9f1da4yimF7Z4kMo
         Jb7YggxwHasNVvZMI3NxaDENzDhPwlmJdDBrk9pitYrOmCHoXvarBEAa5D8ROR7Qs66/
         Q+WYCzsYGqj2ohsB6DEqDwzKxh2pWPZl7eyjx9z1bIBKxlbsKeJhEZB9SSHYcrmE0kby
         4Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4qw8x64i4XFEDlSAFYgF2VhxflxKizeU9gCHhrw8jfw=;
        b=BVmOVB8Jv3O8jWZoSjd/vt05BFCWGY5m44e+ilz2neSpXqYIE4JT4Oekfh2Tkwg/6Q
         mMmDRGr3xhP+WY70tqBOUxEH72OiP0YbaTHqCsLoy2QVktvzgcx62Re4vk/MmeKnhWoj
         VRw1jSYLxE8qWX3hOSOOC1CbFaNziOIH2IyQX0K1Aaxfb4HIwIdyJO9eO3AinSqloiov
         xeKcQa56aylXRQMSfiDdm1c+7CowT76HXiDliTR8oVByC98kjvhur28Gg2waaTQ3Lpxk
         WpfEmm+tBZwTcQBzE/GuKRpEY/pRqiAXlKoq60At5Q7Zyl8FG5v6JrXfwZcKrxtLsDQO
         Xaaw==
X-Gm-Message-State: APjAAAX6gVIpBKQc1RihTqxCHttg7vmRRC6JZb5NlLEK/GXQoPXBt1GZ
        8O2VjRxjmIf6pICLsD9QVxScQg==
X-Google-Smtp-Source: APXvYqxFesDIFMVEfJ+rAMm9XZfz/W3E1o2L8swFcNttv6/59Hul897kno2oER77JLbHa0srULlycQ==
X-Received: by 2002:adf:e651:: with SMTP id b17mr7298903wrn.191.1571825621824;
        Wed, 23 Oct 2019 03:13:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id b186sm3144466wmb.21.2019.10.23.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:13:41 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:13:40 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3] scripts/nsdeps: use alternative sed delimiter
Message-ID: <20191023101340.GA27616@google.com>
References: <20191021160419.28270-1-jeyu@kernel.org>
 <20191022110403.29715-1-jeyu@kernel.org>
 <CAK7LNATzCA-+-9Mp6GZcBk1UZnUdgoYHLkX0wVSHyJcRefyWEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNATzCA-+-9Mp6GZcBk1UZnUdgoYHLkX0wVSHyJcRefyWEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:23:39AM +0900, Masahiro Yamada wrote:
>On Tue, Oct 22, 2019 at 8:04 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> When doing an out of tree build with O=, the nsdeps script constructs
>> the absolute pathname of the module source file so that it can insert
>> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
>> contains an unescaped path to the source tree, which, when used in a sed
>> substitution, makes sed complain:
>>
>> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
>> sed: -e expression #1, char 12: unknown option to `s'
>>
>> The sed substitution command 's' ends prematurely with the forward
>> slashes in the pathname, and sed errors out when it encounters the 'h',
>> which is an invalid sed substitution option. To avoid escaping forward
>> slashes ${srctree}, we can use '|' as an alternative delimiter for
>> sed instead to avoid this error.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> v3: don't need to escape '/' since we're using a different delimiter.
>>
>>  scripts/nsdeps | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index 3754dac13b31..dda6fbac016e 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -33,7 +33,7 @@ generate_deps() {
>>         if [ ! -f "$ns_deps_file" ]; then return; fi
>>         local mod_source_files=`cat $mod_file | sed -n 1p                      \
>>                                               | sed -e 's/\.o/\.c/g'           \
>> -                                             | sed "s/[^ ]* */${srctree}\/&/g"`
>> +                                             | sed "s|[^ ]* *|${srctree}/&|g"`
>>         for ns in `cat $ns_deps_file`; do
>>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>>                 generate_deps_for_ns $ns $mod_source_files
>> --
>> 2.16.4
>>
>
>Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>

Tested-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias
