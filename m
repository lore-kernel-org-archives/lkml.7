Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB5AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF820B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfHFJZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbfHFJZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:25:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83305AE6F;
        Tue,  6 Aug 2019 09:25:19 +0000 (UTC)
Subject: Re: [PATCH] lpfc: Fix Buffer Overflow Error
To:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1562948135-5533-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <a8b38655-018e-4bc7-0dbf-792f72cbc8b6@suse.de>
Date:   Tue, 6 Aug 2019 11:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562948135-5533-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 6:15 PM, KyleMahlkuch wrote:
> Power and x86 have different page sizes so rather than allocate the
> buffer based on number of pages we should allocate space by using
> max_sectors. There is also code in lpfc_scsi.c to be sure we don't
> write past the end of this buffer.
> 
> Signed-off-by: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 41 +++++++----------------------------------
>  drivers/scsi/lpfc/lpfc_scsi.c | 14 ++++++++++++--
>  2 files changed, 19 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index eaaef68..59b52a0 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -39,6 +39,7 @@
>  #include <linux/msi.h>
>  #include <linux/irq.h>
>  #include <linux/bitops.h>
> +#include <linux/vmalloc.h>
>  
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_device.h>
> @@ -7549,7 +7550,6 @@ struct lpfc_rpi_hdr *
>  	uint32_t old_mask;
>  	uint32_t old_guard;
>  
> -	int pagecnt = 10;
>  	if (phba->cfg_prot_mask && phba->cfg_prot_guard) {
>  		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
>  				"1478 Registering BlockGuard with the "
> @@ -7588,23 +7588,9 @@ struct lpfc_rpi_hdr *
>  	}
>  
>  	if (!_dump_buf_data) {
> -		while (pagecnt) {
> -			spin_lock_init(&_dump_buf_lock);
> -			_dump_buf_data =
> -				(char *) __get_free_pages(GFP_KERNEL, pagecnt);
> -			if (_dump_buf_data) {
> -				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
> -					"9043 BLKGRD: allocated %d pages for "
> -				       "_dump_buf_data at 0x%p\n",
> -				       (1 << pagecnt), _dump_buf_data);
> -				_dump_buf_data_order = pagecnt;
> -				memset(_dump_buf_data, 0,
> -				       ((1 << PAGE_SHIFT) << pagecnt));
> -				break;
> -			} else
> -				--pagecnt;
> -		}
> -		if (!_dump_buf_data_order)
> +		_dump_buf_data = (char *) vmalloc(shost->hostt->max_sectors * 512);
> +		_dump_buf_data_order = get_order(shost->hostt->max_sectors * 512);
> +		if (!_dump_buf_data)
>  			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
>  				"9044 BLKGRD: ERROR unable to allocate "
>  			       "memory for hexdump\n");
> @@ -7613,22 +7599,9 @@ struct lpfc_rpi_hdr *
>  			"9045 BLKGRD: already allocated _dump_buf_data=0x%p"
>  		       "\n", _dump_buf_data);
>  	if (!_dump_buf_dif) {
> -		while (pagecnt) {
> -			_dump_buf_dif =
> -				(char *) __get_free_pages(GFP_KERNEL, pagecnt);
> -			if (_dump_buf_dif) {
> -				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
> -					"9046 BLKGRD: allocated %d pages for "
> -				       "_dump_buf_dif at 0x%p\n",
> -				       (1 << pagecnt), _dump_buf_dif);
> -				_dump_buf_dif_order = pagecnt;
> -				memset(_dump_buf_dif, 0,
> -				       ((1 << PAGE_SHIFT) << pagecnt));
> -				break;
> -			} else
> -				--pagecnt;
> -		}
> -		if (!_dump_buf_dif_order)
> +		_dump_buf_dif = (char *) vmalloc(shost->hostt->max_sectors * 512);
> +		_dump_buf_dif_order = get_order(shost->hostt->max_sectors * 512);
> +		if (!_dump_buf_dif)
>  			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
>  			"9047 BLKGRD: ERROR unable to allocate "
>  			       "memory for hexdump\n");
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
> index ba996fb..719612d 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -92,7 +92,7 @@ struct scsi_dif_tuple {
>  static void
>  lpfc_debug_save_data(struct lpfc_hba *phba, struct scsi_cmnd *cmnd)
>  {
> -	void *src, *dst;
> +	void *src, *dst, *end;
>  	struct scatterlist *sgde = scsi_sglist(cmnd);
>  
>  	if (!_dump_buf_data) {
> @@ -110,7 +110,12 @@ struct scsi_dif_tuple {
>  	}
>  
>  	dst = (void *) _dump_buf_data;
> +	end = ((char *) dst) + ((1 << PAGE_SHIFT) << _dump_buf_data_order);
>  	while (sgde) {
> +		if (dst + sgde->length >= end) {
> +			printk(KERN_ERR "overflow buffer\n");
> +			break;
> +		}
>  		src = sg_virt(sgde);
>  		memcpy(dst, src, sgde->length);
>  		dst += sgde->length;
> @@ -121,7 +126,7 @@ struct scsi_dif_tuple {
>  static void
>  lpfc_debug_save_dif(struct lpfc_hba *phba, struct scsi_cmnd *cmnd)
>  {
> -	void *src, *dst;
> +	void *src, *dst, *end;
>  	struct scatterlist *sgde = scsi_prot_sglist(cmnd);
>  
>  	if (!_dump_buf_dif) {
> @@ -138,7 +143,12 @@ struct scsi_dif_tuple {
>  	}
>  
>  	dst = _dump_buf_dif;
> +	end = ((char *) dst) + ((1 << PAGE_SHIFT) << _dump_buf_dif_order);
>  	while (sgde) {
> +		if (dst + sgde->length >= end) {
> +			printk(KERN_ERR "overflow buffer\n");
> +			break;
> +		}
>  		src = sg_virt(sgde);
>  		memcpy(dst, src, sgde->length);
>  		dst += sgde->length;
> 
Not sure this is correct.
vmalloc() is not equivalent to __get_pages().

I would rather start off with the fixed buffer size (say, 40k), and
calculate the values like pagecnt etc from there.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
