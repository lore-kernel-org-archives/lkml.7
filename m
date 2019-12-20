Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5915C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8930A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/r8EebM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:33:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35375 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfLTJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:33:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so7624946edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdRAcGLRRg8iKt3mImCAWyzVNXDNfr3GQXuYmx9xEBc=;
        b=c/r8EebMIT04qDRK32za4rw3kkCHqeJihYbC/JuIH5uKb2pINtIbYx1BMVb5HlGgrA
         rZ04UxrGuKKVmEhy/6vrlAkCcQLHFSPNVEZ+5fs5aBufrHW9sVug77pRH7b/+c3251/O
         NOxG9SzKAzUzdjhSCk7pugFRACejjYiHeq9Y3zgbR8M4LxtfdtAp7mQm77rqbw/Kg+YA
         +MYNSgLiJdU488X7zdi/Nz7EgIGIXOIcp+wtV2g9gFe5GtZnP4/Gl2hSJbnSWRJzb83k
         itY4K+L7MhblfKTmWCQ0CIDMs7g14Dyyt+q3QYPXGECwHgPyO0foPFqpY3icWZDVVpTS
         RPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdRAcGLRRg8iKt3mImCAWyzVNXDNfr3GQXuYmx9xEBc=;
        b=eM3AVjXDuxqija9Z3LnxBi3XbCJW7fxYs55TfGioZTCO1QIIQCeJOmyBgnJtPQtfCi
         X9PYdsGYTJw5JCHCWCC1TD4D2P6St85CvZ40sHxtVg7HGDRQKnC0LeX/blZ3/MRfSNt5
         TUYpiXzX9mXMwFsWD6+igunxCi3QjrwL8V8V6ViHmU6BZJeESE1sWfKdiwvDrJ12MtJp
         aa789TQvoQVninQph4HF5XBT+4vppRtmsV3c3AE7tYn0vhBRpjBTpx3SAsBYgL+r9/O1
         nr93kMhMOeC+Guj8Xl443UVpDu4FGLlbvPeR9xfsS5FjQfhLkPLKW293+dmZpNcxZ3cJ
         wqCw==
X-Gm-Message-State: APjAAAW3O2oyuMJwquqb7OHIW2WsL1jQoeeNdhRtyyAAucErT/vpFdfu
        4LAdkPEb0UwWIxAQpthh1AJzwQ==
X-Google-Smtp-Source: APXvYqzWCfqm8KGSdm+UnLUG2XwPn5sKlp0oZPiMWYuaTmOCE/DBPs/XpccD3F2EzBw03B9ho0xHAA==
X-Received: by 2002:a50:e108:: with SMTP id h8mr14849903edl.196.1576834421273;
        Fri, 20 Dec 2019 01:33:41 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id ay24sm856223edb.29.2019.12.20.01.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 01:33:40 -0800 (PST)
Subject: Re: [PATCH 3/3] venus: core: add sc7180 DT compatible and resource
 struct
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1576828760-13176-1-git-send-email-dikshita@codeaurora.org>
 <1576828760-13176-4-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b1b5ee06-bc39-cfc0-b2c8-8073f8857fde@linaro.org>
Date:   Fri, 20 Dec 2019 11:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576828760-13176-4-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Thanks for the patch!

On 12/20/19 9:59 AM, Dikshita Agarwal wrote:
> This add DT compatible string and resource structure for sc7180.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 58 +++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index c7525d9..e8c8b28 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -469,7 +469,7 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>  	{ 2073600, 3929000, 0, 5551000, 0 },	/* 4096x2160@60 */
>  	{ 1036800, 1987000, 0, 2797000, 0 },	/* 4096x2160@30 */
>  	{  489600, 1040000, 0, 1298000, 0 },	/* 1920x1080@60 */
> -	{  244800,  530000, 0,  659000, 0 },	/* 1920x1080@30 */
> +	{  244800,  442000, 0,  659000, 0 },	/* 1920x1080@30 */

unrelated change, please drop it

>  };
>  
>  static const struct venus_resources sdm845_res = {
> @@ -521,11 +521,67 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>  	.fwname = "qcom/venus-5.2/venus.mdt",
>  };
>  
> +static const struct freq_tbl sc7180_freq_table[] = {
> +	{  0, 380000000 },
> +	{  0, 340000000 },
> +	{  0, 270000000 },
> +	{  0, 150000000 },

why .load is zero?

> +};
> +
> +static struct codec_freq_data sc7180_codec_freq_data[] =  {
> +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
> +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
> +	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
> +	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200, 10 },
> +	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200, 10 },
> +	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200, 10 },
> +	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200, 10 },
> +	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10 },
> +};

the table is exactly the same as sdm845 one, please reuse it.

> +
> +static const struct bw_tbl sc7180_bw_table_enc[] = {
> +	{  972000,  750000, 0, 0, 0 },	/* 3840x2160@30 */
> +	{  489600,  451000, 0, 0, 0 },	/* 1920x1080@60 */
> +	{  244800,  234000, 0, 0, 0 },	/* 1920x1080@30 */
> +};
> +
> +static const struct bw_tbl sc7180_bw_table_dec[] = {
> +	{ 1036800, 1386000, 0, 1875000, 0 },	/* 4096x2160@30 */
> +	{  489600,  865000, 0, 1146000, 0 },	/* 1920x1080@60 */
> +	{  244800,  530000, 0,  583000, 0 },	/* 1920x1080@30 */
> +};
> +
> +static const struct venus_resources sc7180_res = {
> +	.freq_tbl = sc7180_freq_table,
> +	.freq_tbl_size = ARRAY_SIZE(sc7180_freq_table),
> +	.bw_tbl_enc = sc7180_bw_table_enc,
> +	.bw_tbl_enc_size = ARRAY_SIZE(sc7180_bw_table_enc),
> +	.bw_tbl_dec = sc7180_bw_table_dec,
> +	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
> +	.codec_freq_data = sc7180_codec_freq_data,
> +	.codec_freq_data_size = ARRAY_SIZE(sc7180_codec_freq_data),
> +	.clks = {"core", "iface", "bus" },
> +	.clks_num = 3,
> +	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
> +	.vcodec_clks_num = 2,
> +	.vcodec_pmdomains = { "venus", "vcodec0" },
> +	.vcodec_pmdomains_num = 2,
> +	.vcodec_num = 1,
> +	.max_load = 3110400,	/* 4096x2160@90 */

Looking into above bandwidth tables I can guess that the maximimum load
is reached at 4096x2160@30? If so you have to change it here.

<cut>

-- 
regards,
Stan
