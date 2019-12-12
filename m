Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A38C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF424671
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdX1N4uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfLLRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:47:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40006 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730205AbfLLRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576172872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASYuMc+fUDlTjfvYIhv1Vh2nVmLhsT9gDD/FqNpAF6k=;
        b=XdX1N4uAafpEgYq+aWxFGCkV4FTUfe0sZxZxfxiPIhKw/PHz77GF0mUuO7SfWg81oUk3d3
        BKx+L/eeKM9t19HY4JmDHVbbEIJOztO5B62Y2MaeyhiWHMH4K60BZ9zXtIwNyreZ7me1YU
        OJ7d/M15JHXufBn34/kypyrK3yUjVIU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-BseCufqwO7S8DjN8iIaw9A-1; Thu, 12 Dec 2019 12:47:50 -0500
X-MC-Unique: BseCufqwO7S8DjN8iIaw9A-1
Received: by mail-qt1-f197.google.com with SMTP id p12so1896464qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASYuMc+fUDlTjfvYIhv1Vh2nVmLhsT9gDD/FqNpAF6k=;
        b=qe87XYUH1w7F25DWuyRInUMu3o0Lfi0KnFiTyYSsM/ZlGlu+AixibnkMe48TpaRaoY
         uBA+y15yZyBAqaGBQkhcJZN8Xs9xEG6KeHPpZzBivjibHeVMgS/6/GvYvc+ruUJUyM6I
         E2ItYj6IiJ8YasHkqL+pZatSQ0/iLwaiRPgEog87TBrAQBDJf92qGZiliRWEq744nheL
         RgPeLSF1mBzugptcoKjzsGFJk/Uv/45pAyMSPzK6vF+a+qOajiTfs0OJLEi8MYrmWjVC
         CBX8oCWoJ8Px4pQI+D0srzyS1HygG5jLYIYqapnPAycmW1xXT8SlWvpHD6Sj0O+Z1bly
         1PEQ==
X-Gm-Message-State: APjAAAVm8i+fBDev+EvT74KpXVU6xjG80/a66Q1B5Ana0hDxSvin6qsz
        nFZBv2innD9x62VueH8BpSYPWS+4PGchEHNQ0Zm38tIE4Bq7EVn8P/6reo+5dQ8hu9Hq9OlY5qg
        vJRL+uWp/aAPSU5zK0H4C3lxj
X-Received: by 2002:ac8:5486:: with SMTP id h6mr8682558qtq.17.1576172869663;
        Thu, 12 Dec 2019 09:47:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8cQXG4sfd4W+2HawtZfnusNe6YR3joXEoDhOEQpoYF8BGdk4GpmShFtI5vjEysZpsSySulw==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr8682540qtq.17.1576172869382;
        Thu, 12 Dec 2019 09:47:49 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id n129sm371776qkf.64.2019.12.12.09.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:47:48 -0800 (PST)
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191212145042.12694-1-labbott@redhat.com>
 <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
Date:   Thu, 12 Dec 2019 12:47:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 12:13 PM, Ilya Dryomov wrote:
> On Thu, Dec 12, 2019 at 3:51 PM Laura Abbott <labbott@redhat.com> wrote:
>>
>> The new mount API currently rejects unknown parameters if the
>> filesystem doesn't have doesn't take any arguments. This is
>> unfortunately a regression from the old API which silently
>> ignores extra arguments. This is easly seen with the squashfs
>> conversion (5a2be1288b51 ("vfs: Convert squashfs to use the new
>> mount API")) which now fails to mount with extra options. Just
>> get rid of the error.
>>
>> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
>> creation/configuration context")
>> Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
>> Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   fs/fs_context.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/fs_context.c b/fs/fs_context.c
>> index 138b5b4d621d..7ec20b1f8a53 100644
>> --- a/fs/fs_context.c
>> +++ b/fs/fs_context.c
>> @@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>>                  return 0;
>>          }
>>
>> -       return invalf(fc, "%s: Unknown parameter '%s'",
>> -                     fc->fs_type->name, param->key);
>> +       return 0;
>>   }
>>   EXPORT_SYMBOL(vfs_parse_fs_param);
> 
> Hi Laura,
> 
> I'm pretty sure this is a regression for all other filesystems
> that used to check for unknown tokens and return an error from their
> ->mount/fill_super/etc methods before the conversion.
> 
> All filesystems that provide ->parse_param expect that ENOPARAM is
> turned into an error with an error message.  I think we are going to
> need something a bit more involved in vfs_parse_fs_param(), or just
> a dummy ->parse_param for squashfs that would always return 0.
> 
> Thanks,
> 
>                  Ilya
> 

Good point, I think I missed how that code flow worked for printing
out the error. I debated putting in a dummy parse_param but I
figured that squashfs wouldn't be the only fs that didn't take
arguments (it's in the minority but certainly not the only one).
I'll see about reworking the flow unless Al/David want to
see the dummy parse_param or give a patch.

Thanks,
Laura

