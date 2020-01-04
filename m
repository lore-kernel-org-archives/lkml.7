Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67DC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA786222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Ay2ibw6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgADB5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:57:48 -0500
Received: from onstation.org ([52.200.56.107]:34448 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgADB5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 20:57:48 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3F5B03EE7A;
        Sat,  4 Jan 2020 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1578103067;
        bh=gVOohcLyYG5QMrVIrqr7DlRzMKsljT/YFEUQa5kCQT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay2ibw6fyoMPxDPVyUSYmuCFLjNrwhKMyBiPo7P4ZPrF2kMsZGp1hI/cSyf9CylzR
         EnyAJO51FQUaYpdEulXuv2a2auZLzsTSb4EgngxwIDYFKbntcW0fspPagfNvdV4EoG
         wNLr2o0K2e7M5fq4bWxPC5OtwpFAqz51PRNr4Liw=
Date:   Fri, 3 Jan 2020 20:57:47 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] firmware: scm: Add stubs for OCMEM and
 restore_sec_cfg_available
Message-ID: <20200104015747.GB30866@onstation.org>
References: <20200103220825.28710-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103220825.28710-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:08:25PM +0100, Krzysztof Kozlowski wrote:
> Add few more stubs (for OCMEM-related functions and
> qcom_scm_restore_sec_cfg_available()) in case of !CONFIG_QCOM_SCM.
> These are actually not necessary for builds but provide them for
> completeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>


> ---
>  include/linux/qcom_scm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index d05ddac9a57e..2c1d20312ce0 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -105,6 +105,11 @@ static inline bool qcom_scm_is_available(void) { return false; }
>  static inline bool qcom_scm_hdcp_available(void) { return false; }
>  static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  				    u32 *resp) { return -ENODEV; }
> +static inline bool qcom_scm_ocmem_lock_available(void) { return false; }
> +static inline int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
> +				      u32 size, u32 mode) { return -ENODEV; }
> +static inline int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset,
> +					u32 size) { return -ENODEV; }
>  static inline bool qcom_scm_pas_supported(u32 peripheral) { return false; }
>  static inline int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
>  					  size_t size) { return -ENODEV; }
> @@ -121,6 +126,7 @@ static inline void qcom_scm_cpu_power_down(u32 flags) {}
>  static inline u32 qcom_scm_get_version(void) { return 0; }
>  static inline u32
>  qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
> +static inline bool qcom_scm_restore_sec_cfg_available(void) { return false; }
>  static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
>  static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
>  static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
> -- 
> 2.17.1
