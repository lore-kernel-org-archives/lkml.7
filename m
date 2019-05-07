Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7994C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50DA2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfEGRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:53:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:62483 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEGRxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:53:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:53:00 -0700
Received: from unknown (HELO [10.232.112.171]) ([10.232.112.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 07 May 2019 10:52:59 -0700
Subject: Re: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>
Date:   Tue, 7 May 2019 11:52:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> Copy telemetry log page definisions from nvme-cli.
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - New patch in this version.
> 
>   include/linux/nvme.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c40720c..5217fe4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -396,6 +396,28 @@ enum {
>   	NVME_NIDT_UUID		= 0x03,
>   };
>   
> +/* Derived from 1.3a Figure 101: Get Log Page – Telemetry Host
> + * -Initiated Log (Log Identifier 07h)
> + */

Is this Host Initiated or Controller Initiated? The comment says host
initiated but everything else seems to indicated controller initiated.
Is controller initiated even the correct choice because the controller
would have sent an AER to indicate that the host should pull the
telemetry data.


> +struct nvme_telemetry_log_page_hdr {
> +	__u8    lpi; /* Log page identifier */
> +	__u8    rsvd[4];
> +	__u8    iee_oui[3];
> +	__le16  dalb1; /* Data area 1 last block */
> +	__le16  dalb2; /* Data area 2 last block */
> +	__le16  dalb3; /* Data area 3 last block */
> +	__u8    rsvd1[368]; /* TODO verify */
> +	__u8    ctrlavail; /* Controller initiated data avail?*/
> +	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> +	__u8    rsnident[128];
> +	/* We'll have to double fetch so we can get the header,
> +	 * parse dalb1->3 determine how much size we need for the
> +	 * log then alloc below. Or just do a secondary non-struct
> +	 * allocation.
> +	 */
> +	__u8    telemetry_dataarea[0];
> +};
> +
>   struct nvme_smart_log {
>   	__u8			critical_warning;
>   	__u8			temperature[2];
> @@ -832,6 +854,7 @@ enum {
>   	NVME_LOG_FW_SLOT	= 0x03,
>   	NVME_LOG_CHANGED_NS	= 0x04,
>   	NVME_LOG_CMD_EFFECTS	= 0x05,
> +	NVME_LOG_TELEMETRY_CTRL	= 0x08,
>   	NVME_LOG_ANA		= 0x0c,
>   	NVME_LOG_DISC		= 0x70,
>   	NVME_LOG_RESERVATION	= 0x80,
> 
