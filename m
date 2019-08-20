Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 05:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF5214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 05:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="GJIUC5OK";
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="GJIUC5OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfHTFqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 01:46:44 -0400
Received: from fallback19.mail.ru ([185.5.136.251]:41978 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfHTFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=NDcqlUkB255+we0mmPQVQ21uehWPUdr9FWH8KdeYuoM=;
        b=GJIUC5OKNcyonl3A2r+FSh531xnZVzo/hZ4HsL9qMx68Wa+teksDzZtw6MQaO2zlY/etW+aS4RhLxqHIkEzVXvS1AzUIsreroLveRXGTBZTXH3ImUPVR03SszOiVRvsgRvi7+zfnFtw7n6BalCS4rp9D6E79hc5jw5uSNvlBIGc=;
Received: from [10.161.100.15] (port=60788 helo=smtpng3.m.smailru.net)
        by fallback19.m.smailru.net with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1hzwye-00021H-A8; Tue, 20 Aug 2019 08:46:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=NDcqlUkB255+we0mmPQVQ21uehWPUdr9FWH8KdeYuoM=;
        b=GJIUC5OKNcyonl3A2r+FSh531xnZVzo/hZ4HsL9qMx68Wa+teksDzZtw6MQaO2zlY/etW+aS4RhLxqHIkEzVXvS1AzUIsreroLveRXGTBZTXH3ImUPVR03SszOiVRvsgRvi7+zfnFtw7n6BalCS4rp9D6E79hc5jw5uSNvlBIGc=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1hzwyW-0000Gs-3h; Tue, 20 Aug 2019 08:46:32 +0300
Subject: Re: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     codekipper@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
Date:   Tue, 20 Aug 2019 08:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-77F55803: BBE463BEF7A60BD05A78504BD2AC2941C0825F4D866972283A121E2816E2D315B2A76064F0759C6C8577FA5B86FB3C7C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D4A169723F56FEDEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637861E0AC852D5F5A18638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC81DE712020495B8EBE0BA17992DA9D5BBBB102B42771252F389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE77FBF75EC45431A369FB946E88D3D303475ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF5797B92FCB1594A39500306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 689FA8AB762F739359CD701D0F70D3B1857278A1594B1D92F9FE63088107E8F2778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDCAB7A669EFE44543EE54B60EAC46452480AC6713BC43F20AF033953DDB60544F8
X-7FA49CB5: 0D63561A33F958A593734E3812778021CB74D03DCDE3739F786D43978C41D9648941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F93F060FBA3C93C613B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: A5480F10D64C90052060E016933BC0393B707D4C4AF95544593F848E208E2B3790719D9526D31DD030E0C387E5A547B11458020726E2BC9F3DCCAA514539E16D84263029B993B78B51B7A74EF4A1C2D70DA7A0AF5A3A8387
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Maxime,

On 8/19/19 10:25 PM, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The i2s controller supports TDM, for up to 8 slots. Let's support the TDM
> API.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>   sound/soc/sunxi/sun4i-i2s.c | 40 ++++++++++++++++++++++++++++++++------
>   1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 0dac09814b65..4f76daeaaed7 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -168,6 +168,8 @@ struct sun4i_i2s {
>   	struct reset_control *rst;
>   
>   	unsigned int	mclk_freq;
> +	unsigned int	slots;
> +	unsigned int	slot_width;
>   
>   	struct snd_dmaengine_dai_dma_data	capture_dma_data;
>   	struct snd_dmaengine_dai_dma_data	playback_dma_data;
> @@ -287,7 +289,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
>   
>   static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>   				  unsigned int rate,
> -				  unsigned int channels,
> +				  unsigned int slots,
>   				  unsigned int word_size)
>   {
>   	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> @@ -335,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>   
>   	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
>   	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
> -					  rate, channels, word_size);
> +					  rate, slots, word_size);
>   	if (bclk_div < 0) {
>   		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
>   		return -EINVAL;
> @@ -419,6 +421,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>   				  const struct snd_pcm_hw_params *params)
>   {
>   	unsigned int channels = params_channels(params);
> +	unsigned int slots = channels;
> +
> +	if (i2s->slots)
> +		slots = i2s->slots;
>   
>   	/* Map the channels for playback and capture */
>   	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
> @@ -428,7 +434,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>   	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>   			   SUN4I_I2S_CHAN_SEL_MASK,
>   			   SUN4I_I2S_CHAN_SEL(channels));
> -
>   	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
>   			   SUN4I_I2S_CHAN_SEL_MASK,
>   			   SUN4I_I2S_CHAN_SEL(channels));
> @@ -452,10 +457,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>   			       struct snd_soc_dai *dai)
>   {
>   	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	unsigned int word_size = params_width(params);
>   	unsigned int channels = params_channels(params);
> +	unsigned int slots = channels;
>   	int ret, sr, wss;
>   	u32 width;
>   
> +	if (i2s->slots)
> +		slots = i2s->slots;
> +
> +	if (i2s->slot_width)
> +		word_size = i2s->slot_width;
> +
>   	ret = i2s->variant->set_chan_cfg(i2s, params);
>   	if (ret < 0) {
>   		dev_err(dai->dev, "Invalid channel configuration\n");
> @@ -477,15 +490,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>   	if (sr < 0)
>   		return -EINVAL;
>   
> -	wss = i2s->variant->get_wss(i2s, params_width(params));
> +	wss = i2s->variant->get_wss(i2s, word_size);
>   	if (wss < 0)
>   		return -EINVAL;
>   
>   	regmap_field_write(i2s->field_fmt_wss, wss);
>   	regmap_field_write(i2s->field_fmt_sr, sr);
>   
> -	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> -				      channels, params_width(params));
> +	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
>   }
>   
>   static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> @@ -785,10 +797,26 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>   	return 0;
>   }
>   
> +static int sun4i_i2s_set_tdm_slot(struct snd_soc_dai *dai,
> +				  unsigned int tx_mask, unsigned int rx_mask,
> +				  int slots, int slot_width)
> +{
> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +	if (slots > 8)
> +		return -EINVAL;
> +
> +	i2s->slots = slots;
> +	i2s->slot_width = slot_width;
> +
> +	return 0;
> +}
> +
>   static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>   	.hw_params	= sun4i_i2s_hw_params,
>   	.set_fmt	= sun4i_i2s_set_fmt,
>   	.set_sysclk	= sun4i_i2s_set_sysclk,
> +	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
>   	.trigger	= sun4i_i2s_trigger,
>   };
>   


it seems like you forgot to implement sun4i_i2s_dai_ops.set_bclk_ratio 
because, as I far as I understand, it should alter tdm slots 
functionality indirectly.


Thank you,
SS


