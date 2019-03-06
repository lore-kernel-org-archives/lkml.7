Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70C205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCFSXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFSXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:23:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4BA680B55;
        Wed,  6 Mar 2019 18:23:52 +0000 (UTC)
Received: from straylight.hirudinean.org (ovpn-123-76.rdu2.redhat.com [10.10.123.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9FD860E3D;
        Wed,  6 Mar 2019 18:23:51 +0000 (UTC)
Date:   Wed, 6 Mar 2019 10:23:49 -0800
From:   Chris Leech <cleech@redhat.com>
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de, Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH v2] scsi:libiscsi: Hold back_lock when calling
 iscsi_complete_task
Message-ID: <20190306182349.GB68002@straylight.hirudinean.org>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        Lee Duncan <lduncan@suse.com>
References: <20190225174130.29496-1-leeman.duncan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225174130.29496-1-leeman.duncan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 06 Mar 2019 18:23:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:41:30AM -0800, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> If there is an error queueing an iscsi command in
> iscsi_queuecommand(), for example if the transport fails
> to take the command in sessuin->tt->xmit_task(), then
> the error path can call iscsi_complete_task() without
> first aquiring the back_lock as required. This can
> lead to things like ITT pool can get corrupt, resulting
> in duplicate ITTs being sent out.
> 
> The solution is to hold the back_lock around
> iscsi_complete_task() calls, and to add a little commenting
> to help others understand when back_lock must be held.
> 
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---

Lee,

Quick question, can you confirm that you tested this with lockdep?

It seems right to me, it's just that we've been hit with lockdep
problems dealing with these locks before.

- Chris

>  drivers/scsi/libiscsi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index b8d325ce8754..ef7871e8c6bd 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -838,7 +838,7 @@ EXPORT_SYMBOL_GPL(iscsi_conn_send_pdu);
>   * @datalen: len of buffer
>   *
>   * iscsi_cmd_rsp sets up the scsi_cmnd fields based on the PDU and
> - * then completes the command and task.
> + * then completes the command and task. called under back_lock
>   **/
>  static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
>  			       struct iscsi_task *task, char *data,
> @@ -941,6 +941,9 @@ static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
>   * @conn: iscsi connection
>   * @hdr:  iscsi pdu
>   * @task: scsi command task
> + *
> + * iscsi_data_in_rsp sets up the scsi_cmnd fields based on the data received
> + * then completes the command and task. called under back_lock
>   **/
>  static void
>  iscsi_data_in_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
> @@ -1025,6 +1028,16 @@ static int iscsi_send_nopout(struct iscsi_conn *conn, struct iscsi_nopin *rhdr)
>  	return 0;
>  }
>  
> +/**
> + * iscsi_nop_out_rsp - SCSI NOP Response processing
> + * @task: scsi command task
> + * @nop: the nop structure
> + * @data: where to put the data
> + * @datalen: length of data
> + *
> + * iscsi_nop_out_rsp handles nop response from use or
> + * from user space. called under back_lock
> + **/
>  static int iscsi_nop_out_rsp(struct iscsi_task *task,
>  			     struct iscsi_nopin *nop, char *data, int datalen)
>  {
> @@ -1791,7 +1804,9 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc)
>  	return 0;
>  
>  prepd_reject:
> +	spin_lock_bh(&session->back_lock);
>  	iscsi_complete_task(task, ISCSI_TASK_REQUEUE_SCSIQ);
> +	spin_unlock_bh(&session->back_lock);
>  reject:
>  	spin_unlock_bh(&session->frwd_lock);
>  	ISCSI_DBG_SESSION(session, "cmd 0x%x rejected (%d)\n",
> @@ -1799,7 +1814,9 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc)
>  	return SCSI_MLQUEUE_TARGET_BUSY;
>  
>  prepd_fault:
> +	spin_lock_bh(&session->back_lock);
>  	iscsi_complete_task(task, ISCSI_TASK_REQUEUE_SCSIQ);
> +	spin_unlock_bh(&session->back_lock);
>  fault:
>  	spin_unlock_bh(&session->frwd_lock);
>  	ISCSI_DBG_SESSION(session, "iscsi: cmd 0x%x is not queued (%d)\n",
> @@ -3121,8 +3138,9 @@ fail_mgmt_tasks(struct iscsi_session *session, struct iscsi_conn *conn)
>  		state = ISCSI_TASK_ABRT_SESS_RECOV;
>  		if (task->state == ISCSI_TASK_PENDING)
>  			state = ISCSI_TASK_COMPLETED;
> +		spin_lock_bh(&session->back_lock);
>  		iscsi_complete_task(task, state);
> -
> +		spin_unlock_bh(&session->back_lock);
>  	}
>  }
>  
> -- 
> 2.16.4
> 
