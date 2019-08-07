Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76CFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFB92229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TdBW40cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfHGQu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:50:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44920 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbfHGQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:50:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77Gotmx130524;
        Wed, 7 Aug 2019 11:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565196655;
        bh=403rFY141+ngslfVmPOcoEAaGGO5wWhTHo7yhw07SPc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TdBW40cd4WxBvmMMpoR5fQvlllMfy6scyNdWsz3gPHpjDreG3iVFJj7m6VsP8FF3s
         Ko4geLeQVmn7WGPKzbTKFDSHA3H6JFC52rBMZ/RwVPvdw9tE79LG5a5f3yV9aUwjnR
         qaad9+9In7iYYYE0TQnrOIqrgusEC0xPh7+3qHxg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77Gotfh094692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 11:50:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 11:50:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 11:50:55 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77GoscP123429;
        Wed, 7 Aug 2019 11:50:54 -0500
Subject: Re: [RESEND 1/2] remoteproc: replace bool from struct rproc by u8
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>
References: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
 <1565170879-3185-2-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <5ef3cb58-76cf-512b-4c39-08f5b9e2d67f@ti.com>
Date:   Wed, 7 Aug 2019 11:50:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1565170879-3185-2-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 8/7/19 4:41 AM, Loic Pallardy wrote:
> Post [1] and checkpatch tool indicate that usage of bool type
> in structure is now no more allowed/advised.
> This patch replaces bool by unsigned char (u8) and reorders
> struct rproc fields to avoid padding.
> 
> [1] https://lkml.org/lkml/2017/11/21/384

Btw, that checkpatch warning has been removed and documentation
clarified in commit 7967656ffbfa ("coding-style: Clarify the
expectations around bool") added in 5.1 kernel.

I have actually switched to using bitfields on some of my patches
downstream because of the same checkpatch message, since we seem to have
a number of these fields, but that also requires updating all the field
values in various drivers to use 0 or 1 instead of the boolean values.

regards
Suman

> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  include/linux/remoteproc.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..8cd22fecea61 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -472,15 +472,15 @@ struct rproc_dump_segment {
>   * @index: index of this rproc device
>   * @crash_handler: workqueue for handling a crash
>   * @crash_cnt: crash counter
> - * @recovery_disabled: flag that state if recovery was disabled
>   * @max_notifyid: largest allocated notify id.
>   * @table_ptr: pointer to the resource table in effect
>   * @cached_table: copy of the resource table
>   * @table_sz: size of @cached_table
> - * @has_iommu: flag to indicate if remote processor is behind an MMU
> - * @auto_boot: flag to indicate if remote processor should be auto-started
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
> + * @recovery_disabled: flag that state if recovery was disabled
> + * @has_iommu: flag to indicate if remote processor is behind an MMU
> + * @auto_boot: flag to indicate if remote processor should be auto-started
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -505,15 +505,15 @@ struct rproc {
>  	int index;
>  	struct work_struct crash_handler;
>  	unsigned int crash_cnt;
> -	bool recovery_disabled;
>  	int max_notifyid;
>  	struct resource_table *table_ptr;
>  	struct resource_table *cached_table;
>  	size_t table_sz;
> -	bool has_iommu;
> -	bool auto_boot;
>  	struct list_head dump_segments;
>  	int nb_vdev;
> +	u8 recovery_disabled;
> +	u8 has_iommu;
> +	u8 auto_boot;
>  };
>  
>  /**
> 

