Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B6D20675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCHBh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:37:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfCHBh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:37:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B7B3AEF7;
        Fri,  8 Mar 2019 01:37:54 +0000 (UTC)
Subject: Re: [PATCH v2] scsi:libiscsi: Hold back_lock when calling
 iscsi_complete_task
To:     Chris Leech <cleech@redhat.com>,
        Lee Duncan <leeman.duncan@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de
References: <20190225174130.29496-1-leeman.duncan@gmail.com>
 <20190306182349.GB68002@straylight.hirudinean.org>
From:   Lee Duncan <lduncan@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lduncan@suse.com; prefer-encrypt=mutual; keydata=
 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
 a7PzlXQ=
Organization: SUSE
Message-ID: <88c1457c-7831-3341-1c63-11eb82244c4b@suse.com>
Date:   Thu, 7 Mar 2019 17:37:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306182349.GB68002@straylight.hirudinean.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 10:23 AM, Chris Leech wrote:
> On Mon, Feb 25, 2019 at 09:41:30AM -0800, Lee Duncan wrote:
>> From: Lee Duncan <lduncan@suse.com>
>>
>> If there is an error queueing an iscsi command in
>> iscsi_queuecommand(), for example if the transport fails
>> to take the command in sessuin->tt->xmit_task(), then
>> the error path can call iscsi_complete_task() without
>> first aquiring the back_lock as required. This can
>> lead to things like ITT pool can get corrupt, resulting
>> in duplicate ITTs being sent out.
>>
>> The solution is to hold the back_lock around
>> iscsi_complete_task() calls, and to add a little commenting
>> to help others understand when back_lock must be held.
>>
>> Signed-off-by: Lee Duncan <lduncan@suse.com>
>> ---
> 
> Lee,
> 
> Quick question, can you confirm that you tested this with lockdep?
> 
> It seems right to me, it's just that we've been hit with lockdep
> problems dealing with these locks before.
> 
> - Chris

I'm glad you asked, to keep me honest -- I had not done it yet, because
it seemed obvious to me.

But I did check today, and did not find any deadlock nor leaks. I was
testing on a 5.0.0-1 kernel.

> 
>>  drivers/scsi/libiscsi.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
>> index b8d325ce8754..ef7871e8c6bd 100644
>> --- a/drivers/scsi/libiscsi.c
>> +++ b/drivers/scsi/libiscsi.c
>> @@ -838,7 +838,7 @@ EXPORT_SYMBOL_GPL(iscsi_conn_send_pdu);
>>   * @datalen: len of buffer
>>   *
>>   * iscsi_cmd_rsp sets up the scsi_cmnd fields based on the PDU and
>> - * then completes the command and task.
>> + * then completes the command and task. called under back_lock
>>   **/
>>  static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
>>  			       struct iscsi_task *task, char *data,
>> @@ -941,6 +941,9 @@ static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
>>   * @conn: iscsi connection
>>   * @hdr:  iscsi pdu
>>   * @task: scsi command task
>> + *
>> + * iscsi_data_in_rsp sets up the scsi_cmnd fields based on the data received
>> + * then completes the command and task. called under back_lock
>>   **/
>>  static void
>>  iscsi_data_in_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
>> @@ -1025,6 +1028,16 @@ static int iscsi_send_nopout(struct iscsi_conn *conn, struct iscsi_nopin *rhdr)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * iscsi_nop_out_rsp - SCSI NOP Response processing
>> + * @task: scsi command task
>> + * @nop: the nop structure
>> + * @data: where to put the data
>> + * @datalen: length of data
>> + *
>> + * iscsi_nop_out_rsp handles nop response from use or
>> + * from user space. called under back_lock
>> + **/
>>  static int iscsi_nop_out_rsp(struct iscsi_task *task,
>>  			     struct iscsi_nopin *nop, char *data, int datalen)
>>  {
>> @@ -1791,7 +1804,9 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc)
>>  	return 0;
>>  
>>  prepd_reject:
>> +	spin_lock_bh(&session->back_lock);
>>  	iscsi_complete_task(task, ISCSI_TASK_REQUEUE_SCSIQ);
>> +	spin_unlock_bh(&session->back_lock);
>>  reject:
>>  	spin_unlock_bh(&session->frwd_lock);
>>  	ISCSI_DBG_SESSION(session, "cmd 0x%x rejected (%d)\n",
>> @@ -1799,7 +1814,9 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc)
>>  	return SCSI_MLQUEUE_TARGET_BUSY;
>>  
>>  prepd_fault:
>> +	spin_lock_bh(&session->back_lock);
>>  	iscsi_complete_task(task, ISCSI_TASK_REQUEUE_SCSIQ);
>> +	spin_unlock_bh(&session->back_lock);
>>  fault:
>>  	spin_unlock_bh(&session->frwd_lock);
>>  	ISCSI_DBG_SESSION(session, "iscsi: cmd 0x%x is not queued (%d)\n",
>> @@ -3121,8 +3138,9 @@ fail_mgmt_tasks(struct iscsi_session *session, struct iscsi_conn *conn)
>>  		state = ISCSI_TASK_ABRT_SESS_RECOV;
>>  		if (task->state == ISCSI_TASK_PENDING)
>>  			state = ISCSI_TASK_COMPLETED;
>> +		spin_lock_bh(&session->back_lock);
>>  		iscsi_complete_task(task, state);
>> -
>> +		spin_unlock_bh(&session->back_lock);
>>  	}
>>  }
>>  
>> -- 
>> 2.16.4
>>
> 
