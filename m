Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A273C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E593206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556282761;
	bh=ydMoE2lxrI6T7Lp8FQ7vaxTOP0crHdPE0/Pvavc1xig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hNoTjsA0l0En0UCC1FSGDii0U4XS6hV5b1C+UZ0Ii/8JRf/tRmoK4ykEsjmLEt8WJ
	 uf01yQzquse909dXsI04Mw4GeTfJmxks2BYUsmP6+OZyyRiBu8Jx89+EkrJM82GGCp
	 JCsFM/EN7F4MT+JuOA2U5Jw8l8l7lVCvkCwkYm6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfDZMqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:45:57 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A72206C1;
        Fri, 26 Apr 2019 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556282757;
        bh=ydMoE2lxrI6T7Lp8FQ7vaxTOP0crHdPE0/Pvavc1xig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4+MwCuKZi80NxAWVk7chnP02NuwecayAFdiOG7mb/zXxfop5+166celMECSOYOBE
         GTJakMg3B9ezWhFmK6b+nWmluePQufQg7Apmj+H+rXOKEjbZs4cRIJ8jB3RvCFHIxO
         7vb+jOeDOiidDRYiCUF7ox3Obh1iw4XbHpre8s14=
Date:   Fri, 26 Apr 2019 18:15:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [V3 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA
 Interface) support
Message-ID: <20190426124550.GE28103@vkoul-mobl>
References: <20190409072212.15860-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409072212.15860-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 15:22, Peng Ma wrote:

Subject missed PATCH tag!

> The MC exports the DPDMAI object as an interface to operate the DPAA2 QDMA

whats MC, DPDMAI, DPAA2

> Engine. The DPDMAI enables sending frame-based requests to QDMA and receiving
> back confirmation response on transaction completion, utilizing the DPAA2 QBMan
> infrastructure. DPDMAI object provides up to two priorities for processing QDMA
> requests.

> +int dpdmai_open(struct fsl_mc_io *mc_io,
> +		u32 cmd_flags,
> +		int dpdmai_id,
> +		u16 *token)

could be written as:

int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
                int dpdmai_id, u16 *token)

Looks neater, right? It would be to reread coding guidelines and run
checkpatch with --strict on this


> +{
> +	struct fsl_mc_command cmd = { 0 };

where is this defined?

> +	struct dpdmai_cmd_open *cmd_params;
> +	int err;
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_OPEN,
> +					  cmd_flags,
> +					  0);
> +
> +	cmd_params = (struct dpdmai_cmd_open *)cmd.params;

I dont like casts, can you explain

> +	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
> +
> +	/* send command to mc*/
> +	err = mc_send_command(mc_io, &cmd);
> +	if (err)
> +		return err;
> +
> +	/* retrieve response parameters */
> +	*token = mc_cmd_hdr_read_token(&cmd);
> +	return 0;
> +}

who will call this API?

> +int dpdmai_create(struct fsl_mc_io *mc_io,
> +		  u32 cmd_flags,
> +		  const struct dpdmai_cfg *cfg,
> +		  u16 *token)
> +{
> +	struct fsl_mc_command cmd = { 0 };
> +	int err;
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
> +					  cmd_flags,
> +					  0);

why waste a line, last arg can be in previous line!

> +int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io,
> +			u32 cmd_flags,
> +			u16 token,
> +			u8 priority,
> +			struct dpdmai_tx_queue_attr *attr)
> +{
> +	struct fsl_mc_command cmd = { 0 };
> +	struct dpdmai_cmd_queue *cmd_params;
> +	struct dpdmai_rsp_get_tx_queue *rsp_params;
> +	int err;
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_TX_QUEUE,
> +					  cmd_flags,
> +					  token);
> +
> +	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
> +	cmd_params->queue = priority;
> +
> +	/* send command to mc*/
> +	err = mc_send_command(mc_io, &cmd);
> +	if (err)
> +		return err;
> +
> +	/* retrieve response parameters */
> +
> +	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
> +	attr->fqid = le32_to_cpu(rsp_params->fqid);
> +
> +	return 0;
> +}

Okay this file does not use any of dmaengine apis, is this a dmaengine
driver?

> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> new file mode 100644
> index 0000000..c8a7b7f
> --- /dev/null
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> @@ -0,0 +1,524 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright 2014-2018 NXP */
> +
> +/*
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + * * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + * * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + * * Neither the name of the above-listed copyright holders nor the
> + * names of any contributors may be used to endorse or promote products
> + * derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */

we have SiPDX tag, why do you need ths here!

-- 
~Vinod
