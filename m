Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164912070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L4bV7RoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfHFHLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:11:51 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40786 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbfHFHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:11:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id s16so17107330vke.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8Ci/8H9wUX2m10wfVRVtTIcb057+1T5ctq2J+f6Y+w=;
        b=L4bV7RoJjNCz5iprmtYNV/GYfL8PvHtlYPWeKdPrNLD1WPNHQPSokIzRc9q0QuyP2x
         WTEdX4UNSTmIg3O1jFWfRPvWZxiMqrEuxNk/1lj4DyEhApWJm27fI4oJnnCSzx3Wh3aU
         Cdpi3YNAd5TKzlYoW4sdPGS0XAkrTRgjqkjuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8Ci/8H9wUX2m10wfVRVtTIcb057+1T5ctq2J+f6Y+w=;
        b=L4FOO/3qeTwizHRQ1j2ekJZVLbjKEwvVQGnkitJR3QBLIp9Iw0pivjG2uWphQyyL81
         LPAvDQnHe6JucMAk2WfEIm7egKRB2KUIOMk9cDKdz3u9FHw1rUYI1s5wT8Wg5lIcI/YW
         XfNjFqbG5pvto1umiMHiqj863HqaNVC2tvKetjjSUexZX47DPpI0jc6M7cquFEoaqqxV
         u7k5RkUeYmPKd7mswt4jKXuWg5rEoIXpIn1vjQbrdrQsPZwcVUZftHYjwHxh4Bfg2ybJ
         t036LKqTSp+/vkeEYnUXHuAenPf2yXapkGT5ZnGYfKZ+sr6Sd5obee68PbC/Ez4G3VLq
         4vkw==
X-Gm-Message-State: APjAAAVmGNY8iOun2JTWQ6FOGtdq4FlkA8tEa+Bhmywx5v+yVS9OdnHZ
        gCP9F4fueCAwor6UKrqgddwBpx2X0WQrd5FDOQ5MJA==
X-Google-Smtp-Source: APXvYqzUbqSd2bMaWsSsiOkndLEKbbXAFec9haL6ZQufi/FgOn9IAPeJfXrOApEQgI56Y9cdOaAilurGG+b2JGKItk8=
X-Received: by 2002:a1f:8887:: with SMTP id k129mr621675vkd.3.1565075509481;
 Tue, 06 Aug 2019 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190726135540.48780-1-yuehaibing@huawei.com>
In-Reply-To: <20190726135540.48780-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 6 Aug 2019 12:41:37 +0530
Message-ID: <CAL2rwxpw_vz14Fwq+HPTnVYzc9xCrgC7OpCBSGsurZsVKZEdfw@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make a bunch of functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 7:26 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3369:1: warning: symbol 'complete_cmd_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3535:6: warning: symbol 'megasas_sync_irqs' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3554:1: warning: symbol 'megasas_complete_cmd_dpc_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3573:13: warning: symbol 'megasas_isr_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3604:1: warning: symbol 'build_mpt_mfi_pass_thru' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3661:40: warning: symbol 'build_mpt_cmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3688:1: warning: symbol 'megasas_issue_dcmd_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3881:5: warning: symbol 'megasas_wait_for_outstanding_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4005:6: warning: symbol 'megasas_refire_mgmt_cmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4525:25: warning: symbol 'megasas_get_peer_instance' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4825:7: warning: symbol 'megasas_fusion_crash_dump' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 120e3c4..10ef99e 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -3511,7 +3511,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
>   * @instance:                  Adapter soft state
>   * Completes all commands that is in reply descriptor queue
>   */
> -int
> +static int
>  complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
>                     struct megasas_irq_context *irq_context)
>  {
> @@ -3702,7 +3702,7 @@ static void megasas_enable_irq_poll(struct megasas_instance *instance)
>   * megasas_sync_irqs - Synchronizes all IRQs owned by adapter
>   * @instance:                  Adapter soft state
>   */
> -void megasas_sync_irqs(unsigned long instance_addr)
> +static void megasas_sync_irqs(unsigned long instance_addr)
>  {
>         u32 count, i;
>         struct megasas_instance *instance =
> @@ -3760,7 +3760,7 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
>   *
>   * Tasklet to complete cmds
>   */
> -void
> +static void
>  megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
>  {
>         struct megasas_instance *instance =
> @@ -3780,7 +3780,7 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
>  /**
>   * megasas_isr_fusion - isr entry point
>   */
> -irqreturn_t megasas_isr_fusion(int irq, void *devp)
> +static irqreturn_t megasas_isr_fusion(int irq, void *devp)
>  {
>         struct megasas_irq_context *irq_context = devp;
>         struct megasas_instance *instance = irq_context->instance;
> @@ -3816,7 +3816,7 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
>   * mfi_cmd:                    megasas_cmd pointer
>   *
>   */
> -void
> +static void
>  build_mpt_mfi_pass_thru(struct megasas_instance *instance,
>                         struct megasas_cmd *mfi_cmd)
>  {
> @@ -3874,7 +3874,7 @@ build_mpt_mfi_pass_thru(struct megasas_instance *instance,
>   * @cmd:                       mfi cmd to build
>   *
>   */
> -union MEGASAS_REQUEST_DESCRIPTOR_UNION *
> +static union MEGASAS_REQUEST_DESCRIPTOR_UNION *
>  build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
>  {
>         union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc = NULL;
> @@ -3900,7 +3900,7 @@ build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
>   * @cmd:                       mfi cmd pointer
>   *
>   */
> -void
> +static void
>  megasas_issue_dcmd_fusion(struct megasas_instance *instance,
>                           struct megasas_cmd *cmd)
>  {
> @@ -4096,8 +4096,9 @@ static inline void megasas_trigger_snap_dump(struct megasas_instance *instance)
>  }
>
>  /* This function waits for outstanding commands on fusion to complete */
> -int megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
> -                                       int reason, int *convert)
> +static int
> +megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
> +                                   int reason, int *convert)
>  {
>         int i, outstanding, retval = 0, hb_seconds_missed = 0;
>         u32 fw_state, abs_state;
> @@ -4221,7 +4222,7 @@ void  megasas_reset_reply_desc(struct megasas_instance *instance)
>   * megasas_refire_mgmt_cmd :   Re-fire management commands
>   * @instance:                          Controller's soft instance
>  */
> -void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
> +static void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
>  {
>         int j;
>         struct megasas_cmd_fusion *cmd_fusion;
> @@ -4747,7 +4748,8 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
>  }
>
>  /*SRIOV get other instance in cluster if any*/
> -struct megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
> +static struct
> +megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
>  {
>         int i;
>
> @@ -5053,7 +5055,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
>  }
>
>  /* Fusion Crash dump collection */
> -void  megasas_fusion_crash_dump(struct megasas_instance *instance)
> +static void  megasas_fusion_crash_dump(struct megasas_instance *instance)
>  {
>         u32 status_reg;
>         u8 partial_copy = 0;
> --
> 2.7.4
>
>
