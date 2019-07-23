Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB462C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41ED21926
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bsrBTIGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbfGWSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:22:33 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41902 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733219AbfGWSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:22:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id u64so8849771vku.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2TuUDb+cbDlJb1CcmjRJgoW+PPf4FRjIQWj89hrcAI=;
        b=bsrBTIGwdheinL1kf92PRexRZFy2EFU93ZC/0biGWGKiSn3NfNGLvKJ11e57dBGbbI
         zs+v2qiU6SZAaCEJJrJLNrxK5JUcT7g+al+3r9rDCPIoCGFdj+qmanISatk4NkGr+sfw
         iMP2+IPYLxPPX2pXRHOdkFAjpzY0dioP53FaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2TuUDb+cbDlJb1CcmjRJgoW+PPf4FRjIQWj89hrcAI=;
        b=JF1gBpzIHbsotgPfxsbvhEWhk9GkuEQVQIwNRtKITamRKCXZHr4nMk0c9FE3ocfcBA
         4pCunPFnSuOV4aiJsy6yxSOghKwk+eWVuYjZpKojnQSvxEcHQ8/WnxYQHKZHoz7I/L2w
         SV7h3pBjpiUUsJZmv5xdfZLtGBn9u5LEw2YBvsjxZ97W79cCSQ1eU2DKY5gbtRM4VNdi
         EXsMQMTWAgNE+m4KO93ZTMzSh2ZJ79M/VYN2125r7RWU7Nja/C+1171wxPZlaGKPV1KA
         aLOIsbs6i3szr/PdzPoL8jbuxjULGgJS2pQMJX8zXu0pPeSZg9fUplIQwQ3Qi2So+smG
         Tz9Q==
X-Gm-Message-State: APjAAAUXQhLfrEm396UMa/SyudqpibLS1O1pef6vc1WrKzypAOoO44R3
        ihvbQX41GXNEk31WlXwTO9QAyjt/f4E6d/XQKV3/Ug==
X-Google-Smtp-Source: APXvYqzUCSg04pkSjhBLbI+JQpTMn9imHUAevkK2QEgI+jbWlmx9Y0F6xoBI3+IEn10ojveNqT1RgG/5O/nr/BoTNWM=
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr8150601vkl.28.1563906151394;
 Tue, 23 Jul 2019 11:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190723143450.33916-1-yuehaibing@huawei.com>
In-Reply-To: <20190723143450.33916-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 23 Jul 2019 23:52:19 +0530
Message-ID: <CAL2rwxph0kNT2Vwf90La_=5uDgcHgKo-RJ+vrsXVWSXeJRWd_A@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make some functions static
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

On Tue, Jul 23, 2019 at 8:05 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c:541:1: warning: symbol 'megasas_alloc_cmdlist_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:580:1: warning: symbol 'megasas_alloc_request_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:661:1: warning: symbol 'megasas_alloc_reply_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:738:1: warning: symbol 'megasas_alloc_rdpq_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:920:1: warning: symbol 'megasas_alloc_cmds_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:1740:1: warning: symbol 'megasas_init_adapter_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:1966:1: warning: symbol 'map_cmd_status' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:2379:1: warning: symbol 'megasas_set_pd_lba' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:2718:1: warning: symbol 'megasas_build_ldio_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3215:1: warning: symbol 'megasas_build_io_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3328:6: warning: symbol 'megasas_prepare_secondRaid1_IO' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a32b3f0..120e3c4 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -537,7 +537,7 @@ static int megasas_create_sg_sense_fusion(struct megasas_instance *instance)
>         return 0;
>  }
>
> -int
> +static int
>  megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
>  {
>         u32 max_mpt_cmd, i, j;
> @@ -576,7 +576,8 @@ megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
>
>         return 0;
>  }
> -int
> +
> +static int
>  megasas_alloc_request_fusion(struct megasas_instance *instance)
>  {
>         struct fusion_context *fusion;
> @@ -657,7 +658,7 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
>         return 0;
>  }
>
> -int
> +static int
>  megasas_alloc_reply_fusion(struct megasas_instance *instance)
>  {
>         int i, count;
> @@ -734,7 +735,7 @@ megasas_alloc_reply_fusion(struct megasas_instance *instance)
>         return 0;
>  }
>
> -int
> +static int
>  megasas_alloc_rdpq_fusion(struct megasas_instance *instance)
>  {
>         int i, j, k, msix_count;
> @@ -916,7 +917,7 @@ megasas_free_reply_fusion(struct megasas_instance *instance) {
>   * and is used as SMID of the cmd.
>   * SMID value range is from 1 to max_fw_cmds.
>   */
> -int
> +static int
>  megasas_alloc_cmds_fusion(struct megasas_instance *instance)
>  {
>         int i;
> @@ -1736,7 +1737,7 @@ static inline void megasas_free_ioc_init_cmd(struct megasas_instance *instance)
>   *
>   * This is the main function for initializing firmware.
>   */
> -u32
> +static u32
>  megasas_init_adapter_fusion(struct megasas_instance *instance)
>  {
>         struct fusion_context *fusion;
> @@ -1962,7 +1963,7 @@ megasas_fusion_stop_watchdog(struct megasas_instance *instance)
>   * @ext_status :       ext status of cmd returned by FW
>   */
>
> -void
> +static void
>  map_cmd_status(struct fusion_context *fusion,
>                 struct scsi_cmnd *scmd, u8 status, u8 ext_status,
>                 u32 data_length, u8 *sense)
> @@ -2375,7 +2376,7 @@ int megasas_make_sgl(struct megasas_instance *instance, struct scsi_cmnd *scp,
>   *
>   * Used to set the PD LBA in CDB for FP IOs
>   */
> -void
> +static void
>  megasas_set_pd_lba(struct MPI2_RAID_SCSI_IO_REQUEST *io_request, u8 cdb_len,
>                    struct IO_REQUEST_INFO *io_info, struct scsi_cmnd *scp,
>                    struct MR_DRV_RAID_MAP_ALL *local_map_ptr, u32 ref_tag)
> @@ -2714,7 +2715,7 @@ megasas_set_raidflag_cpu_affinity(struct fusion_context *fusion,
>   * Prepares the io_request and chain elements (sg_frame) for IO
>   * The IO can be for PD (Fast Path) or LD
>   */
> -void
> +static void
>  megasas_build_ldio_fusion(struct megasas_instance *instance,
>                           struct scsi_cmnd *scp,
>                           struct megasas_cmd_fusion *cmd)
> @@ -3211,7 +3212,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
>   * Invokes helper functions to prepare request frames
>   * and sets flags appropriate for IO/Non-IO cmd
>   */
> -int
> +static int
>  megasas_build_io_fusion(struct megasas_instance *instance,
>                         struct scsi_cmnd *scp,
>                         struct megasas_cmd_fusion *cmd)
> @@ -3325,9 +3326,9 @@ megasas_get_request_descriptor(struct megasas_instance *instance, u16 index)
>  /* megasas_prepate_secondRaid1_IO
>   *  It prepares the raid 1 second IO
>   */
> -void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
> -                           struct megasas_cmd_fusion *cmd,
> -                           struct megasas_cmd_fusion *r1_cmd)
> +static void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
> +                                          struct megasas_cmd_fusion *cmd,
> +                                          struct megasas_cmd_fusion *r1_cmd)
>  {
>         union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc, *req_desc2 = NULL;
>         struct fusion_context *fusion;
> --
> 2.7.4
>
>
