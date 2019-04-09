Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF07C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF342133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pUSFrNwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDIH0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:26:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDIH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:26:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so697557wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s+tXDWipNKrAnsAwIIdsNlNNdHmKtLV/l7aa1f7zsu0=;
        b=pUSFrNwzClzRKI34n/HPkfRZ0QVpb9sVyglUfVWofb2P9fmHKvBC1yGRPlCG+48VI3
         nCAyAQFxgL16iMKvxvTjqssxz6MM79ifBpv4OnW7tYz9by/dj1a6XGKgCZaXCYkY3jde
         babNXfnetMFTl5Oxb4nyCg3Wpg8kg241f3VjMS5qARjDMLwdefxzTbXTWSYhSAJXxcGl
         dVb+1f+eAmlYGxQG+zvgX1f5Qs1Yp6blJHA/u+QC1t9rEJWo7YoDurpa2CB3ge8p6P/2
         +yRgc1c+C2bl7AIi6XKjAzR2rPBLZoW6k67KHuhANxddgW6TzzdHhVDTMDzK0sS85dWT
         wYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s+tXDWipNKrAnsAwIIdsNlNNdHmKtLV/l7aa1f7zsu0=;
        b=JDMOCqwVRXp6qEl+uQbrOgJYUqXhUD+h7fv82TzA9yee4Sl2LiOYtkKGAkxSO3KIgc
         KjOOqaSwX+pzx6Nglss2i408M1wMBhIpABYDNFiiSH4Vy7GpjnVU7h0SV1VVKlBVUR4a
         NAnlFKnGhpixQRFLTCX6qeO533Mqs1HYVCBM40TkoJZoZCChXWrAszkTeZgeJB9nhno0
         Ws6crNWZDJgy34V8d9DmbcoCI/YCwjDPux6fLdjmIwkEsM5gVByi4EFFzTWcE6WiM3ZX
         xpbNBHz5diMgtwXoVZRm6phojORdAc1PxcuaFhQ/6y5xuw57/ttmUoocyecDycoN9rjf
         rx8w==
X-Gm-Message-State: APjAAAVB1n8v623Orirp9UocTSy01Bxb6xkk+nmS6qo9aKpAbOvZ28Vd
        zYzYDggoTYrrZ6Ye94Tt2mqZ205a9KFe7Q==
X-Google-Smtp-Source: APXvYqwtXyHL6LvUFF6PWoi2sdw6VysuS/QpLYY4ya9JN7pPFFWJwtwitaxbJAZXVJ7wHzHXO5DQwA==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr21238306wmj.37.1554794757478;
        Tue, 09 Apr 2019 00:25:57 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j22sm99026552wrd.91.2019.04.09.00.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 00:25:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] media: platform: meson: Add Amlogic Meson G12A AO
 CEC Controller driver
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190408092358.25894-3-narmstrong@baylibre.com>
 <201904090252.BPKOeIGV%lkp@intel.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <efc79646-6eeb-1957-5ec1-f0f7531d4cf9@baylibre.com>
Date:   Tue, 9 Apr 2019 09:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904090252.BPKOeIGV%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 20:08, kbuild test robot wrote:
> Hi Neil,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linuxtv-media/master]
> [also build test ERROR on v5.1-rc4 next-20190408]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/media-dt-bindings-media-meson-ao-cec-Add-G12A-AO-CEC-B-Compatible/20190408-233912
> base:   git://linuxtv.org/media_tree.git master
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> drivers/media/platform/meson/ao-cec-g12a.c:206:16: error: field 'hw' has incomplete type
>      struct clk_hw hw;

Seems I'll need to add CONFIG_COMMON_CLK

Neil

>                    ^~
>    In file included from include/linux/build_bug.h:5,
>                     from include/linux/bitfield.h:18,
>                     from drivers/media/platform/meson/ao-cec-g12a.c:10:
>    drivers/media/platform/meson/ao-cec-g12a.c: In function 'meson_ao_cec_g12a_dualdiv_clk_recalc_rate':
>    include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                                    ^~~~~~
>    include/linux/compiler.h:324:9: note: in definition of macro '__compiletime_assert'
>       if (!(condition))     \
>             ^~~~~~~~~
>    include/linux/compiler.h:344:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:979:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^~~~~~~~~~~~~~~~
>    include/linux/kernel.h:979:20: note: in expansion of macro '__same_type'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                        ^~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:211:2: note: in expansion of macro 'container_of'
>      container_of(_hw, struct meson_ao_cec_g12a_dualdiv_clk, hw) \
>      ^~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:218:3: note: in expansion of macro 'hw_to_meson_ao_cec_g12a_dualdiv_clk'
>       hw_to_meson_ao_cec_g12a_dualdiv_clk(hw);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c: At top level:
>>> drivers/media/platform/meson/ao-cec-g12a.c:317:21: error: variable 'meson_ao_cec_g12a_dualdiv_clk_ops' has initializer but incomplete type
>     static const struct clk_ops meson_ao_cec_g12a_dualdiv_clk_ops = {
>                         ^~~~~~~
>>> drivers/media/platform/meson/ao-cec-g12a.c:318:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
>      .recalc_rate = meson_ao_cec_g12a_dualdiv_clk_recalc_rate,
>       ^~~~~~~~~~~
>>> drivers/media/platform/meson/ao-cec-g12a.c:318:17: warning: excess elements in struct initializer
>      .recalc_rate = meson_ao_cec_g12a_dualdiv_clk_recalc_rate,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:318:17: note: (near initialization for 'meson_ao_cec_g12a_dualdiv_clk_ops')
>>> drivers/media/platform/meson/ao-cec-g12a.c:319:3: error: 'const struct clk_ops' has no member named 'is_enabled'
>      .is_enabled = meson_ao_cec_g12a_dualdiv_clk_is_enabled,
>       ^~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:319:16: warning: excess elements in struct initializer
>      .is_enabled = meson_ao_cec_g12a_dualdiv_clk_is_enabled,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:319:16: note: (near initialization for 'meson_ao_cec_g12a_dualdiv_clk_ops')
>>> drivers/media/platform/meson/ao-cec-g12a.c:320:3: error: 'const struct clk_ops' has no member named 'enable'
>      .enable  = meson_ao_cec_g12a_dualdiv_clk_enable,
>       ^~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:320:13: warning: excess elements in struct initializer
>      .enable  = meson_ao_cec_g12a_dualdiv_clk_enable,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:320:13: note: (near initialization for 'meson_ao_cec_g12a_dualdiv_clk_ops')
>>> drivers/media/platform/meson/ao-cec-g12a.c:321:3: error: 'const struct clk_ops' has no member named 'disable'
>      .disable = meson_ao_cec_g12a_dualdiv_clk_disable,
>       ^~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:321:13: warning: excess elements in struct initializer
>      .disable = meson_ao_cec_g12a_dualdiv_clk_disable,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/meson/ao-cec-g12a.c:321:13: note: (near initialization for 'meson_ao_cec_g12a_dualdiv_clk_ops')
>    drivers/media/platform/meson/ao-cec-g12a.c: In function 'meson_ao_cec_g12a_setup_clk':
>>> drivers/media/platform/meson/ao-cec-g12a.c:328:23: error: storage size of 'init' isn't known
>      struct clk_init_data init;
>                           ^~~~
>>> drivers/media/platform/meson/ao-cec-g12a.c:341:16: error: implicit declaration of function '__clk_get_name'; did you mean 'clk_get_rate'? [-Werror=implicit-function-declaration]
>      parent_name = __clk_get_name(ao_cec->oscin);
>                    ^~~~~~~~~~~~~~
>                    clk_get_rate
>>> drivers/media/platform/meson/ao-cec-g12a.c:341:14: warning: assignment to 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      parent_name = __clk_get_name(ao_cec->oscin);
>                  ^
>>> drivers/media/platform/meson/ao-cec-g12a.c:351:8: error: implicit declaration of function 'devm_clk_register'; did you mean 'device_register'? [-Werror=implicit-function-declaration]
>      clk = devm_clk_register(dev, &dualdiv_clk->hw);
>            ^~~~~~~~~~~~~~~~~
>            device_register
>    drivers/media/platform/meson/ao-cec-g12a.c:328:23: warning: unused variable 'init' [-Wunused-variable]
>      struct clk_init_data init;
>                           ^~~~
>    drivers/media/platform/meson/ao-cec-g12a.c: At top level:
>>> drivers/media/platform/meson/ao-cec-g12a.c:317:29: error: storage size of 'meson_ao_cec_g12a_dualdiv_clk_ops' isn't known
>     static const struct clk_ops meson_ao_cec_g12a_dualdiv_clk_ops = {
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/hw +206 drivers/media/platform/meson/ao-cec-g12a.c
> 
>    186	
>    187	/*
>    188	 * The AO-CECB embeds a dual/divider to generate a more precise
>    189	 * 32,768KHz clock for CEC core clock.
>    190	 *                      ______   ______
>    191	 *                     |      | |      |
>    192	 *         ______      | Div1 |-| Cnt1 |       ______
>    193	 *        |      |    /|______| |______|\     |      |
>    194	 * Xtal-->| Gate |---|  ______   ______  X-X--| Gate |-->
>    195	 *        |______| |  \|      | |      |/  |  |______|
>    196	 *                 |   | Div2 |-| Cnt2 |   |
>    197	 *                 |   |______| |______|   |
>    198	 *                 |_______________________|
>    199	 *
>    200	 * The dividing can be switched to single or dual, with a counter
>    201	 * for each divider to set when the switching is done.
>    202	 * The entire dividing mechanism can be also bypassed.
>    203	 */
>    204	
>    205	struct meson_ao_cec_g12a_dualdiv_clk {
>  > 206		struct clk_hw hw;
>    207		struct regmap *regmap;
>    208	};
>    209	
>    210	#define hw_to_meson_ao_cec_g12a_dualdiv_clk(_hw)			\
>  > 211		container_of(_hw, struct meson_ao_cec_g12a_dualdiv_clk, hw)	\
>    212	
>    213	static unsigned long
>    214	meson_ao_cec_g12a_dualdiv_clk_recalc_rate(struct clk_hw *hw,
>    215						  unsigned long parent_rate)
>    216	{
>    217		struct meson_ao_cec_g12a_dualdiv_clk *dualdiv_clk =
>  > 218			hw_to_meson_ao_cec_g12a_dualdiv_clk(hw);
>    219		unsigned long n1;
>    220		u32 reg0, reg1;
>    221	
>    222		regmap_read(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0, &reg0);
>    223		regmap_read(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0, &reg1);
>    224	
>    225		if (reg1 & CECB_CLK_CNTL_BYPASS_EN)
>    226			return parent_rate;
>    227	
>    228		if (reg0 & CECB_CLK_CNTL_DUAL_EN) {
>    229			unsigned long n2, m1, m2, f1, f2, p1, p2;
>    230	
>    231			n1 = FIELD_GET(CECB_CLK_CNTL_N1, reg0) + 1;
>    232			n2 = FIELD_GET(CECB_CLK_CNTL_N2, reg0) + 1;
>    233	
>    234			m1 = FIELD_GET(CECB_CLK_CNTL_M1, reg1) + 1;
>    235			m2 = FIELD_GET(CECB_CLK_CNTL_M1, reg1) + 1;
>    236	
>    237			f1 = DIV_ROUND_CLOSEST(parent_rate, n1);
>    238			f2 = DIV_ROUND_CLOSEST(parent_rate, n2);
>    239	
>    240			p1 = DIV_ROUND_CLOSEST(100000000 * m1, f1 * (m1 + m2));
>    241			p2 = DIV_ROUND_CLOSEST(100000000 * m2, f2 * (m1 + m2));
>    242	
>    243			return DIV_ROUND_UP(100000000, p1 + p2);
>    244		}
>    245	
>    246		n1 = FIELD_GET(CECB_CLK_CNTL_N1, reg0) + 1;
>    247	
>    248		return DIV_ROUND_CLOSEST(parent_rate, n1);
>    249	}
>    250	
>    251	static int meson_ao_cec_g12a_dualdiv_clk_enable(struct clk_hw *hw)
>    252	{
>    253		struct meson_ao_cec_g12a_dualdiv_clk *dualdiv_clk =
>    254			hw_to_meson_ao_cec_g12a_dualdiv_clk(hw);
>    255	
>    256	
>    257		/* Disable Input & Output */
>    258		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    259				   CECB_CLK_CNTL_INPUT_EN | CECB_CLK_CNTL_OUTPUT_EN,
>    260				   0);
>    261	
>    262		/* Set N1 & N2 */
>    263		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    264				   CECB_CLK_CNTL_N1,
>    265				   FIELD_PREP(CECB_CLK_CNTL_N1, 733 - 1));
>    266	
>    267		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    268				   CECB_CLK_CNTL_N2,
>    269				   FIELD_PREP(CECB_CLK_CNTL_N2, 732 - 1));
>    270	
>    271		/* Set M1 & M2 */
>    272		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG1,
>    273				   CECB_CLK_CNTL_M1,
>    274				   FIELD_PREP(CECB_CLK_CNTL_M1, 8 - 1));
>    275	
>    276		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG1,
>    277				   CECB_CLK_CNTL_M2,
>    278				   FIELD_PREP(CECB_CLK_CNTL_M2, 11 - 1));
>    279	
>    280		/* Enable Dual divisor */
>    281		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    282				   CECB_CLK_CNTL_DUAL_EN, CECB_CLK_CNTL_DUAL_EN);
>    283	
>    284		/* Disable divisor bypass */
>    285		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG1,
>    286				   CECB_CLK_CNTL_BYPASS_EN, 0);
>    287	
>    288		/* Enable Input & Output */
>    289		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    290				   CECB_CLK_CNTL_INPUT_EN | CECB_CLK_CNTL_OUTPUT_EN,
>    291				   CECB_CLK_CNTL_INPUT_EN | CECB_CLK_CNTL_OUTPUT_EN);
>    292	
>    293		return 0;
>    294	}
>    295	
>    296	static void meson_ao_cec_g12a_dualdiv_clk_disable(struct clk_hw *hw)
>    297	{
>    298		struct meson_ao_cec_g12a_dualdiv_clk *dualdiv_clk =
>    299			hw_to_meson_ao_cec_g12a_dualdiv_clk(hw);
>    300	
>    301		regmap_update_bits(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0,
>    302				   CECB_CLK_CNTL_INPUT_EN | CECB_CLK_CNTL_OUTPUT_EN,
>    303				   0);
>    304	}
>    305	
>    306	static int meson_ao_cec_g12a_dualdiv_clk_is_enabled(struct clk_hw *hw)
>    307	{
>    308		struct meson_ao_cec_g12a_dualdiv_clk *dualdiv_clk =
>    309			hw_to_meson_ao_cec_g12a_dualdiv_clk(hw);
>    310		int val;
>    311	
>    312		regmap_read(dualdiv_clk->regmap, CECB_CLK_CNTL_REG0, &val);
>    313	
>    314		return !!(val & (CECB_CLK_CNTL_INPUT_EN | CECB_CLK_CNTL_OUTPUT_EN));
>    315	}
>    316	
>  > 317	static const struct clk_ops meson_ao_cec_g12a_dualdiv_clk_ops = {
>  > 318		.recalc_rate	= meson_ao_cec_g12a_dualdiv_clk_recalc_rate,
>  > 319		.is_enabled	= meson_ao_cec_g12a_dualdiv_clk_is_enabled,
>  > 320		.enable		= meson_ao_cec_g12a_dualdiv_clk_enable,
>  > 321		.disable	= meson_ao_cec_g12a_dualdiv_clk_disable,
>    322	};
>    323	
>    324	static int meson_ao_cec_g12a_setup_clk(struct meson_ao_cec_g12a_device *ao_cec)
>    325	{
>    326		struct meson_ao_cec_g12a_dualdiv_clk *dualdiv_clk;
>    327		struct device *dev = &ao_cec->pdev->dev;
>  > 328		struct clk_init_data init;
>    329		const char *parent_name;
>    330		struct clk *clk;
>    331		char *name;
>    332	
>    333		dualdiv_clk = devm_kzalloc(dev, sizeof(*dualdiv_clk), GFP_KERNEL);
>    334		if (!dualdiv_clk)
>    335			return -ENOMEM;
>    336	
>    337		name = kasprintf(GFP_KERNEL, "%s#dualdiv_clk", dev_name(dev));
>    338		if (!name)
>    339			return -ENOMEM;
>    340	
>  > 341		parent_name = __clk_get_name(ao_cec->oscin);
>    342	
>    343		init.name = name;
>    344		init.ops = &meson_ao_cec_g12a_dualdiv_clk_ops;
>    345		init.flags = 0;
>    346		init.parent_names = &parent_name;
>    347		init.num_parents = 1;
>    348		dualdiv_clk->regmap = ao_cec->regmap;
>    349		dualdiv_clk->hw.init = &init;
>    350	
>  > 351		clk = devm_clk_register(dev, &dualdiv_clk->hw);
>    352		kfree(name);
>    353		if (IS_ERR(clk)) {
>    354			dev_err(dev, "failed to register clock\n");
>    355			return PTR_ERR(clk);
>    356		}
>    357	
>    358		ao_cec->core = clk;
>    359	
>    360		return 0;
>    361	}
>    362	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

