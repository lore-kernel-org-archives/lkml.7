Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F636218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fDvhQF16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfCOKCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:02:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfCOKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:01:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h99so8861156wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aTIK0LCsOpjbqNnkr9WKIuo1B5wu5hVVeCjiOVmUEPU=;
        b=fDvhQF16DBxOGbX1QngOBDEMicHBX/Tg8D1582P6dCrI944PyR7qeT0BTjy2luR0aJ
         UKMOBoEMr9cc4EpcFe5Wl+FzXaqeJrOPW8a2CkWmMV2Vboy7LHqJ3WU3ZIxWG4TiRQts
         hgFvsE5wyQuq5BhLWZ64VCJaRIzk91hD2caBu9hGMdf4HXe4viPqR62k/ovtFpji7cTG
         pld1Vv3804R9qtnoQ5vmYc5DvEOyvjDX9KhlIvB0gkm8IKGxzCAApgfu0VoQ6eQQtIOC
         Rf6sQ1wghUjwQghEkGwg4RwIMYZ97ftDO76ZKTmuc4Z4BDf/RAGhW03SLB7AvxAN2JYm
         I3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aTIK0LCsOpjbqNnkr9WKIuo1B5wu5hVVeCjiOVmUEPU=;
        b=n8rAvugctiksq/MVcQHG3BT8fzIDrf9hcLo1KBSWtU4+buokSJnGXr5Yq4lfTqisWb
         91DHo58Smd5PAa/HJ3JoWiqRG0Usz8Gt+wN9f9ssnKYQZ1t2r3VMm1QULvAh1QP9D7oL
         1/PYL3M92pKDeCUj/zfnh1fW4tIDFAijyRMEjDdrxD5X6M/34QaI2jWiN8XcrwZ9UB4E
         Qfhg0+ml72Kb4cYDD0+Kd4sph7UGNerEjI2InV3r/Vs1iea7tJxjzvdhJSEyldFLU+rK
         LaYeSOfIf9u5k28ACS7yQOZTtH4geXGEOJGyd3FkDIOgBgsVWzVf0CL6azU4moZXqIMJ
         q/vg==
X-Gm-Message-State: APjAAAWZ+cFP3i6HpioUTNFqIFI4o2JW42Cxdg8ceXnAqw53aOisv3AK
        3DAe7Eiu1pglfVAUfx0icRY544lfJ30=
X-Google-Smtp-Source: APXvYqyX8dtN1a10Wf0OZkEc8xCBgs/sCpmU0yNr9Yiq5hi+JetTu2u6f0t8PeUWkKTdIdy42cfspQ==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr1866929wrt.27.1552644117002;
        Fri, 15 Mar 2019 03:01:57 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id v20sm7060865wmj.2.2019.03.15.03.01.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 03:01:55 -0700 (PDT)
Message-ID: <3e6aa4c392ccdd3bac76b556645139536e61e5e6.camel@baylibre.com>
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without
 string names
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 15 Mar 2019 11:01:53 +0100
In-Reply-To: <20190226223429.193873-7-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
         <20190226223429.193873-7-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 14:34 -0800, Stephen Boyd wrote:
> The common clk framework is lacking in ability to describe the clk
> topology without specifying strings for every possible parent-child
> link. There are a few drawbacks to the current approach:
> 
>  1) String comparisons are used for everything, including describing
>  topologies that are 'local' to a single clock controller.
> 
>  2) clk providers (e.g. i2c clk drivers) need to create globally unique
>  clk names to avoid collisions in the clk namespace, leading to awkward
>  name generation code in various clk drivers.
> 
>  3) DT bindings may not fully describe the clk topology and linkages
>  between clk controllers because drivers can easily rely on globally unique
>  strings to describe connections between clks.
> 
> This leads to confusing DT bindings, complicated clk name generation
> code, and inefficient string comparisons during clk registration just so
> that the clk framework can detect the topology of the clk tree.
> Furthermore, some drivers call clk_get() and then __clk_get_name() to
> extract the globally unique clk name just so they can specify the parent
> of the clk they're registering. We have of_clk_parent_fill() but that
> mostly only works for single clks registered from a DT node, which isn't
> the norm. Let's simplify this all by introducing two new ways of
> specifying clk parents.
> 
> The first method is an array of pointers to clk_hw structures
> corresponding to the parents at that index. This works for clks that are
> registered when we have access to all the clk_hw pointers for the
> parents.
> 
> The second method is a mix of clk_hw pointers and strings of local and
> global parent clk names. If the .name member of the map is set we'll
> look for that clk by performing a DT based lookup of the device the clk
> is registered with and the .name specified in the map. If that fails,
> we'll fallback to the .fallback member and perform a global clk name
> lookup like we've always done before.
> 
> Using either one of these new methods is entirely optional. Existing
> drivers will continue to work, and they can migrate to this new approach
> as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> array in struct clk_init_data and use one of these new methods instead.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c            | 260 ++++++++++++++++++++++++++---------
>  include/linux/clk-provider.h |  19 +++
>  2 files changed, 217 insertions(+), 62 deletions(-)

Sorry for the delay.

With the fix you sent to Jeffrey
Tested by porting the aoclk controller of Amlogic g12a SoC.
This allowed to test
 * hws only table
 * parent_data with a mix of hw pointers and fw_name (with different input
controllers and also an input that is optional and never provided)

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

With the small comment below

Reviewed-by Jerome Brunet <jbrunet@baylibre.com>


> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 937b8d092d17..3d01e8c56400 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -39,6 +39,13 @@ static LIST_HEAD(clk_notifier_list);
>  

[...]

>  
> +static int clk_cpy_name(const char *dst, const char *src, bool must_exist)
> +{
> +	if (!src) {
> +		if (must_exist)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	dst = kstrdup_const(src, GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int clk_core_populate_parent_map(struct clk_core *core)
> +{
> +	const struct clk_init_data *init = core->hw->init;
> +	u8 num_parents = init->num_parents;
> +	const char * const *parent_names = init->parent_names;
> +	const struct clk_hw **parent_hws = init->parent_hws;
> +	const struct clk_parent_data *parent_data = init->parent_data;
> +	int i, ret = 0;
> +	struct clk_parent_map *parents, *parent;
> +
> +	if (!num_parents)
> +		return 0;
> +
> +	/*
> +	 * Avoid unnecessary string look-ups of clk_core's possible parents by
> +	 * having a cache of names/clk_hw pointers to clk_core pointers.
> +	 */
> +	parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> +	core->parents = parents;
> +	if (!parents)
> +		return -ENOMEM;
> +
> +	/* Copy everything over because it might be __initdata */
> +	for (i = 0, parent = parents; i < num_parents; i++, parent++) {
> +		if (parent_names) {
> +			/* throw a WARN if any entries are NULL */
> +			WARN(!parent_names[i],
> +				"%s: invalid NULL in %s's .parent_names\n",
> +				__func__, core->name);
> +			ret = clk_cpy_name(parent->name, parent_names[i],
> +					   true);
> +		} else if (parent_data) {

While testing, I mistakenly left both parent_names and parent_data. I was
surprised that parent_data did not take precedence of parent_names.

Maybe it should ? (... but I understand we are not supposed to provide both)

> +			parent->hw = parent_data[i].hw;
> +			ret = clk_cpy_name(parent->fw_name,
> +					   parent_data[i].fw_name, false);
> +			if (!ret)
> +				ret = clk_cpy_name(parent->name,
> +						   parent_data[i].name,
> +						   false);
> +		} else if (parent_hws) {
> +			parent->hw = parent_hws[i];
> +		} else {

Maybe there should also some kinda of check to verify if more than one option
(among hws, parent_data and parent_names) was provided and throw a warn ?

Could be useful with drivers move away from parent_names ?

> +			ret = -EINVAL;
> +			WARN(1, "Must specify parents if num_parents > 0\n");
> +		}



> +
> +		if (ret) {
> +			do {
> +				kfree_const(parents[i].name);
> +				kfree_const(parents[i].fw_name);
> +			} while (--i >= 0);
> +			kfree(parents);
> +
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> 

