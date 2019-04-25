Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD43C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B406720717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfDYRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:19:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48938 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfDYRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:19:22 -0400
Received: from [10.200.156.146] (unknown [131.107.147.146])
        by linux.microsoft.com (Postfix) with ESMTPSA id 283A630549E3;
        Thu, 25 Apr 2019 10:19:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
References: <20190424001544.7188-1-prsriva02@gmail.com>
 <20190424001544.7188-2-prsriva02@gmail.com>
 <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
Date:   Thu, 25 Apr 2019 10:19:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-25 4:48 a.m., Nayna wrote:
> 
> 
> On 04/23/2019 08:15 PM, Prakhar Srivastava wrote:
>> From: Prakhar Srivastava <prsriva02@gmail.com>
>>
>> Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
>> ---
>>
>> Currently for soft reboot(kexec_file_load) the kernel file and
>> signature is measured by IMA. The cmdline args used to load the kernel
>> is not measured.
>> The boot aggregate that gets calculated will have no change since the
>> EFI loader has not been triggered.
>> Adding the kexec cmdline args measure and kernel version will add some
>> attestable criteria.
>>
> 
> Any reason for including the whole commit message after "---"
> 
> Anything after "---" is not included in the patch description when patch 
> is applied.
> 
> This comment applies to all the patches in this patchset.
I will fix the comments and send out the patchset with a cover letter. 
Thankyou for pointing this out.
> 
>> remove enums to control type of buffers entries, instead pass the 
>> event name to be used.
> 
> Is the last statement meant to be a Changelog from v1-> v2 ? Only the 
> changelog has to be after "---"
> 
> Also, If posting more than one patch, it is preferrable to add a 
> cover-letter.
I will add a cover letter alongside fixing the comments. Thankyou!
> 
> 
>>   include/linux/ima.h               | 10 ++--------
>>   kernel/kexec_file.c               |  3 +++
>>   security/integrity/ima/ima.h      |  2 +-
>>   security/integrity/ima/ima_main.c | 30 ++++++++++--------------------
>>   4 files changed, 16 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 733d0cb9dedc..5e41507c57e5 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -14,12 +14,6 @@
>>   #include <linux/kexec.h>
>>   struct linux_binprm;
>>
>> -enum __buffer_id {
>> -    KERNEL_VERSION,
>> -    KEXEC_CMDLINE,
>> -    MAX_BUFFER_ID = KEXEC_CMDLINE
>> -} buffer_id;
>> -
> 
> Is the v2 version created on top of the v1 version that was posted ?
> 
v2 is based off the HEAD of the repo.
> The v2 version has to be on top of the HEAD of the repository itself, 
> and not on the v1 version. Only the final reviewed and tested version 
> makes to the upstream.
> 
> Btw, which repository and its branch are you using ?
> 
I am basing my changes off IMA branch:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> Thanks & Regards,
>        - Nayna
> 
> 
> 
> 
>>   #ifdef CONFIG_IMA
>>   extern int ima_bprm_check(struct linux_binprm *bprm);
>>   extern int ima_file_check(struct file *file, int mask, int opened);
>> @@ -29,7 +23,7 @@ extern int ima_read_file(struct file *file, enum 
>> kernel_read_file_id id);
>>   extern int ima_post_read_file(struct file *file, void *buf, loff_t 
>> size,
>>                     enum kernel_read_file_id id);
>>   extern void ima_post_path_mknod(struct dentry *dentry);
>> -extern void ima_buffer_check(const void *buff, int size, enum 
>> buffer_id id);
>> +extern void ima_buffer_check(const void *buff, int size, char 
>> *eventname);
>>   #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>>   #endif
>> @@ -72,7 +66,7 @@ static inline void ima_post_path_mknod(struct dentry 
>> *dentry)
>>   }
>>
>>   static inline void ima_buffer_check(const void *buff, int size,
>> -            enum buffer_id id)
>> +            char *eventname)
>>   {
>>       return;
>>   }
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index b118735fea9d..2a5234eb4b28 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -182,6 +182,9 @@ kimage_file_prepare_segments(struct kimage *image, 
>> int kernel_fd, int initrd_fd,
>>               ret = -EINVAL;
>>               goto out;
>>           }
>> +
>> +        ima_buffer_check(image->cmdline_buf, cmdline_len - 1,
>> +                "kexec_cmdline");
>>       }
>>
>>       /* Call arch image load handlers */
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index b71f2f6f7421..fcade3c103ed 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -181,8 +181,8 @@ enum ima_hooks {
>>       FIRMWARE_CHECK,
>>       KEXEC_KERNEL_CHECK,
>>       KEXEC_INITRAMFS_CHECK,
>> -    BUFFER_CHECK,
>>       POLICY_CHECK,
>> +    BUFFER_CHECK,
>>       MAX_CHECK
>>   };
>>
>> diff --git a/security/integrity/ima/ima_main.c 
>> b/security/integrity/ima/ima_main.c
>> index 6408cadaadbb..da82c705a5ed 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -160,8 +160,7 @@ void ima_file_free(struct file *file)
>>    * (Instead of using the file hash the buffer hash is used).
>>    * @buff - The buffer that needs to be added to the log
>>    * @size - size of buffer(in bytes)
>> - * @id - buffer id, this is differentiator for the various buffers
>> - * that can be measured.
>> + * @id - eventname, event name to be used for buffer measurement.
>>    *
>>    * The buffer passed is added to the ima logs.
>>    * If the sig template is used, then the sig field contains the buffer.
>> @@ -170,7 +169,7 @@ void ima_file_free(struct file *file)
>>    * On error cases surface errors from ima calls.
>>    */
>>   static int process_buffer_measurement(const void *buff, int size,
>> -                enum buffer_id id)
>> +                char *eventname)
>>   {
>>       int ret = -EINVAL;
>>       struct ima_template_entry *entry = NULL;
>> @@ -185,23 +184,13 @@ static int process_buffer_measurement(const void 
>> *buff, int size,
>>       int violation = 0;
>>       int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>>
>> -    if (!buff || size ==  0)
>> +    if (!buff || size ==  0 || !eventname)
>>           goto err_out;
>>
>>       if (ima_get_action(NULL, 0, BUFFER_CHECK, &pcr) != IMA_MEASURE)
>>           goto err_out;
>>
>> -    switch (buffer_id) {
>> -    case KERNEL_VERSION:
>> -        name = "Kernel-version";
>> -        break;
>> -    case KEXEC_CMDLINE:
>> -        name = "Kexec-cmdline";
>> -        break;
>> -    default:
>> -        goto err_out;
>> -    }
>> -
>> +    name = eventname;
>>       memset(iint, 0, sizeof(*iint));
>>       memset(&hash, 0, sizeof(hash));
>>
>> @@ -452,15 +441,16 @@ int ima_read_file(struct file *file, enum 
>> kernel_read_file_id read_id)
>>    * ima_buffer_check - based on policy, collect & store buffer 
>> measurement
>>    * @buf: pointer to buffer
>>    * @size: size of buffer
>> - * @buffer_id: caller identifier
>> + * @eventname: caller identifier
>>    *
>>    * Buffers can only be measured, not appraised.  The buffer identifier
>> - * is used as the measurement list entry name (eg. boot_cmdline).
>> + * is used as the measurement list entry name (eg. boot_cmdline,
>> + * kernel_version).
>>    */
>> -void ima_buffer_check(const void *buf, int size, enum buffer_id id)
>> +void ima_buffer_check(const void *buf, int size, char *eventname)
>>   {
>> -    if (buf && size != 0)
>> -        process_buffer_measurement(buf, size, id);
>> +    if (buf && size != 0 && eventname)
>> +        process_buffer_measurement(buf, size, eventname);
>>
>>       return;
>>   }
