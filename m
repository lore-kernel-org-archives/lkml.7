Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81305C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CC02053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfEHTI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:08:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:08:27 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hORvU-0002By-8Y
        for linux-kernel@vger.kernel.org; Wed, 08 May 2019 19:08:24 +0000
Received: by mail-pl1-f200.google.com with SMTP id 94so10305062plc.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u/gtimdpE5wVGQt8oZN/N6N0CKaogPVcjLKdVZGvG9E=;
        b=fXCWknfUs3Gb/J0oOB/MqZ3YM5BzCgLHUWPvZdCz3gaNOmEOrh3KeSIJWR3aAOld0w
         zuAB38bp1Ji0SXep1fY4miCLcH+chGIZo8VX83h08YvUAqmwCKD9Q3+PS4UDvdZnbFDm
         e26PZowrBvtEZ9KA/kI4B0bXN6KWdUUF8koea9sajs7esFY/HQOnDXlVOBjJpMkiDnGs
         bD5kd01rcIDSN22zOU7gG8upsZTeMQneYa42Zd9PiEMrLM+Sw9fFWbyMeABKKfcDEvf6
         a6cwWLUJZqABKzWqHZJk7TGPDVVQTM2RCFCSzfqvh0WsFbdK1FH18af9NwWa/v4I9G0Z
         sH+g==
X-Gm-Message-State: APjAAAVRDWxGrbFQqQC4VekAgoqCdL/A4dP7/S+weSCavVNFApChm01a
        KkwJ02RdzJSM+u6UTLeFn3hMr72dt9yZghmn0kS1vlMKWKiiWtiV22FY5WKFGR5Q+/OBtXkX4nn
        ths3huWQqi4Ev5coM5Y0/a9aL4kix4dNkjHFbBcLjIw==
X-Received: by 2002:a63:8c7:: with SMTP id 190mr48430406pgi.447.1557342502960;
        Wed, 08 May 2019 12:08:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybhQXIJdlYLGtbjf8SC7522IGPOdrLeEqwhZ5H8NJ8sWCH5gYWRVz6Hx2MyA9svIMhLccu+A==
X-Received: by 2002:a63:8c7:: with SMTP id 190mr48430360pgi.447.1557342502590;
        Wed, 08 May 2019 12:08:22 -0700 (PDT)
Received: from 2001-b011-380f-14b9-6c77-9209-16a5-cedd.dynamic-ip6.hinet.net (2001-b011-380f-14b9-6c77-9209-16a5-cedd.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:6c77:9209:16a5:cedd])
        by smtp.gmail.com with ESMTPSA id m11sm23260306pgd.12.2019.05.08.12.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:08:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2] cifs: fix strcat buffer overflow and reduce raciness
 in smb21_set_oplock_level()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAKywueQmjm3vhGZkLdB6J2rpjmKA6m0=N4A6bnsq3MW4acYHLQ@mail.gmail.com>
Date:   Thu, 9 May 2019 03:08:19 +0800
Cc:     Steve French <smfrench@gmail.com>,
        Christoph Probst <kernel@probst.it>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <01E2E7DE-526D-4AA2-9C88-7BED8DE4A8E9@canonical.com>
References: <1557242200-26194-1-git-send-email-kernel@probst.it>
 <CAH2r5mtqkHYbHJkf_LbAjhujnNRQP6Zmkmqhj1dUHomwsc3e=w@mail.gmail.com>
 <CAKywueSJCs2B2cGmZvGNfxDU7KNvkBOsuyuaOSV=3GWG80f+kw@mail.gmail.com>
 <A4165E00-AA20-4550-96FE-651271B7091B@canonical.com>
 <CAKywueQmjm3vhGZkLdB6J2rpjmKA6m0=N4A6bnsq3MW4acYHLQ@mail.gmail.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 02:42, Pavel Shilovsky <piastryyy@gmail.com> wrote:

> ср, 8 мая 2019 г. в 01:23, Kai-Heng Feng <kai.heng.feng@canonical.com>:
>> at 02:28, Pavel Shilovsky <piastryyy@gmail.com> wrote:
>>
>>> вт, 7 мая 2019 г. в 09:13, Steve French via samba-technical
>>> <samba-technical@lists.samba.org>:
>>>> merged into cifs-2.6.git for-next
>>>>
>>>> On Tue, May 7, 2019 at 10:17 AM Christoph Probst via samba-technical
>>>> <samba-technical@lists.samba.org> wrote:
>>>>> Change strcat to strncpy in the "None" case to fix a buffer overflow
>>>>> when cinode->oplock is reset to 0 by another thread accessing the same
>>>>> cinode. It is never valid to append "None" to any other message.
>>>>>
>>>>> Consolidate multiple writes to cinode->oplock to reduce raciness.
>>>>>
>>>>> Signed-off-by: Christoph Probst <kernel@probst.it>
>>>>> ---
>>>>>  fs/cifs/smb2ops.c | 14 ++++++++------
>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>> index c36ff0d..aa61dcf 100644
>>>>> --- a/fs/cifs/smb2ops.c
>>>>> +++ b/fs/cifs/smb2ops.c
>>>>> @@ -2917,26 +2917,28 @@ smb21_set_oplock_level(struct cifsInodeInfo
>>>>> *cinode, __u32 oplock,
>>>>>                        unsigned int epoch, bool *purge_cache)
>>>>>  {
>>>>>         char message[5] = {0};
>>>>> +       unsigned int new_oplock = 0;
>>>>>
>>>>>         oplock &= 0xFF;
>>>>>         if (oplock == SMB2_OPLOCK_LEVEL_NOCHANGE)
>>>>>                 return;
>>>>>
>>>>> -       cinode->oplock = 0;
>>>>>         if (oplock & SMB2_LEASE_READ_CACHING_HE) {
>>>>> -               cinode->oplock |= CIFS_CACHE_READ_FLG;
>>>>> +               new_oplock |= CIFS_CACHE_READ_FLG;
>>>>>                 strcat(message, "R");
>>>>>         }
>>>>>         if (oplock & SMB2_LEASE_HANDLE_CACHING_HE) {
>>>>> -               cinode->oplock |= CIFS_CACHE_HANDLE_FLG;
>>>>> +               new_oplock |= CIFS_CACHE_HANDLE_FLG;
>>>>>                 strcat(message, "H");
>>>>>         }
>>>>>         if (oplock & SMB2_LEASE_WRITE_CACHING_HE) {
>>>>> -               cinode->oplock |= CIFS_CACHE_WRITE_FLG;
>>>>> +               new_oplock |= CIFS_CACHE_WRITE_FLG;
>>>>>                 strcat(message, "W");
>>>>>         }
>>>>> -       if (!cinode->oplock)
>>>>> -               strcat(message, "None");
>>>>> +       if (!new_oplock)
>>>>> +               strncpy(message, "None", sizeof(message));
>>>>> +
>>>>> +       cinode->oplock = new_oplock;
>>>>>         cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
>>>>>                  &cinode->vfs_inode);
>>>>>  }
>>>>> --
>>>>> 2.1.4
>>
>> Doesn’t the race still happen, but implicitly here?
>> cinode->oplock = new_oplock;
>>
>> Is it possible to just introduce a lock to force its proper ordering?
>> e.g.
>>
>> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
>> index bf5b8264e119..a3c3c6156d17 100644
>> --- a/fs/cifs/cifsfs.c
>> +++ b/fs/cifs/cifsfs.c
>> @@ -267,6 +267,7 @@ cifs_alloc_inode(struct super_block *sb)
>>           * server, can not assume caching of file data or metadata.
>>           */
>>          cifs_set_oplock_level(cifs_inode, 0);
>> +       mutex_init(&cifs_inode->oplock_mutex);
>>          cifs_inode->flags = 0;
>>          spin_lock_init(&cifs_inode->writers_lock);
>>          cifs_inode->writers = 0;
>> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
>> index 37b5ddf27ff1..6dfd4ab16c4f 100644
>> --- a/fs/cifs/cifsglob.h
>> +++ b/fs/cifs/cifsglob.h
>> @@ -1214,6 +1214,7 @@ struct cifsInodeInfo {
>>          struct list_head openFileList;
>>          __u32 cifsAttrs; /* e.g. DOS archive bit, sparse, compressed, system */
>>          unsigned int oplock;            /* oplock/lease level we have */
>> +       struct mutex oplock_mutex;
>>          unsigned int epoch;             /* used to track lease state changes */
>>   #define CIFS_INODE_PENDING_OPLOCK_BREAK   (0) /* oplock break in progress */
>>   #define CIFS_INODE_PENDING_WRITERS       (1) /* Writes in progress */
>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>> index b20063cf774f..796b23712e71 100644
>> --- a/fs/cifs/smb2ops.c
>> +++ b/fs/cifs/smb2ops.c
>> @@ -1901,6 +1901,7 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode,
>> __u32 oplock,
>>          if (oplock == SMB2_OPLOCK_LEVEL_NOCHANGE)
>>                  return;
>>
>> +       mutex_lock(&cinode->oplock_mutex);
>>          cinode->oplock = 0;
>>          if (oplock & SMB2_LEASE_READ_CACHING_HE) {
>>                  cinode->oplock |= CIFS_CACHE_READ_FLG;
>> @@ -1916,6 +1917,8 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode,
>> __u32 oplock,
>>          }
>>          if (!cinode->oplock)
>>                  strcat(message, "None");
>> +       mutex_unlock(&cinode->oplock_mutex);
>> +
>>          cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
>>                   &cinode->vfs_inode);
>>   }
>>
>> Kai-Heng
>
> Unless you calculations on the oplock value or accessing it multiple
> times with some logic involved I don't think locking will help much.
> If two threads are assigning the same variable, you can end up with
> two possible outcomes regardless of whether locking is used or not.

Yes you are right, didn’t think of this case.

>
> Locking will be needed once we start to make proper decisions based on
> previous and new values of the oplock to purge a page cache or flush
> buffered data. This still needs to be done and is out of the scope of
> this patch which aims to fix the buffer overflow error.

Thanks for your explanation.

Kai-Heng

>
> --
> Best regards,
> Pavel Shilovsky


