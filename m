Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA34C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C5206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="02iwdyH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfG2Hmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:42:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfG2Hmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:42:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so10732221wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qcDHQ1YIyua0Lz0XKlvtzGchQOF/q8YhLFhQTQqfSnA=;
        b=02iwdyH22+odFMvWr/fUSOWV/YsZSHqKDJDdL3e/jHLksFamrMNdydoLixPsostjig
         yYzQEFDjoaLkJAPyPt/dX5djgi4pTpVW7k5O+EuK9vRV4b+kvVD3KdHyP+fHdAXOLJZw
         fs4K6etimfyGJgHmMkzEWYXpz0YXtnA5d3Ujv3pcGXoUovVU2fuxrFw2Zx9N+4HQJ2Xh
         6ZfZtL98PhcYOUCA0uf9O/gU8Ho3Ar5Xd5LTTZyfiGybMwcM7ykT0tlFaILBVDsfNIyn
         qOJAT7FJydgp4as6OIcwX3bPsXYJAYc4F7EkgbuacqIjLhJho48k5LzbAupoJo3tSI69
         B2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qcDHQ1YIyua0Lz0XKlvtzGchQOF/q8YhLFhQTQqfSnA=;
        b=KgwKc4gCmudkURlT26craxfRsAGCrBuPHW+oUpexPiOrKqmmgIFRaoBarhXK5qbF/o
         Eg0sC4o9G6fwolOHxsvqfVKAN5NvVSDVYL1rLKgr025+kzqrK7CN0YfTO2x/WzRroTwz
         Eg+YNJFB0NmbssGtJYkf7zBPTOLjnfDNFuOlQghp81oB3DrTPzAq0OijwGIxt4o9UByg
         afUoXvd2oDZuM0CMn/wQdujd19f6paBT494+tt2KR12wpZx7MLcQ6Il8m9SYuc38Kyr/
         Xn6sSZH2655AytHIiRQTXlDhdXB7B8t/beyS7L4V5Z1sYNUJraK1cKM4qg5KSJub/FlO
         +krA==
X-Gm-Message-State: APjAAAUBZuBdOFi3l2Ss+mDkv1ydec11ecNcLlWoL7nn2xjSxcRXHvtT
        soEjkqdxevIQ7wR5ji6CPYugBQ==
X-Google-Smtp-Source: APXvYqyu0KuT71WZYrYu+y1RASylJuxEoqAUq39HAC9JSxF3uZuROG3LU/D595xuazk7xstMkJnTUA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr69069194wrm.230.1564386159762;
        Mon, 29 Jul 2019 00:42:39 -0700 (PDT)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id m24sm37058830wmi.39.2019.07.29.00.42.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 00:42:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC/RFT v3 04/14] clk: meson: eeclk: add setup callback
In-Reply-To: <55ce9b5e-de2f-9da3-8eec-13b5ead23e6c@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-5-narmstrong@baylibre.com> <1jh8836w49.fsf@starbuckisacylon.baylibre.com> <55ce9b5e-de2f-9da3-8eec-13b5ead23e6c@baylibre.com>
Date:   Mon, 29 Jul 2019 09:42:37 +0200
Message-ID: <1j1ry9s2vm.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Jul 2019 at 16:50, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 03/07/2019 16:17, Jerome Brunet wrote:
>> On Mon 01 Jul 2019 at 11:12, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> 
>>> Add a setup() callback in the eeclk structure, to call an optional
>>> call() function at end of eeclk probe to setup clocks.
>>>
>>> It's used for the G12A clock controller to setup the CPU clock
>>> notifiers.
>> 
>> I'd prefer if you implement the probe function in the related controller
>> have this probe function call meson_eeclkc_probe() for the common part
>> 
>> In your case, I suppose it means implementing the g12a controller probe
>> to deal with the notifiers
>
> Sure, but with this eeclk setup callback I can provide a different setup() callback
> for g12a and g12b (and later sm1), without this means adding a top data struct
> containing a setup() callback pointer and the soc meson_eeclkc_data struct to be able
> to call a setup() for each family like done actually, but this will broke eeclk since
> the match_data data won't be a meson_eeclkc_data() struct anymore.

meson_eeclkc_probe is an helper we added to factorize common code out of the
clock controllers we had. I don't like the idea to now add callback in it
deal with the specifics of each SoCs. It feels like we are going in circles.

I think SoC/controller specific stuff should be dealt with in
related probe function of each clock controller which would then call
the 'common helper' if necessary.

If the common part interface needs to be reworked, maybe changing
the parameters, I'm ok with it.

>
> If you still prefer this, I can rework it like that.
>
> I'm rebasing all the stuff on v5.3-rc1 and plan to repost an updated version
> shortly, solving this would be easier.
>
> Neil
>
>> 
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/clk/meson/meson-eeclk.c | 6 ++++++
>>>  drivers/clk/meson/meson-eeclk.h | 1 +
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
>>> index 6ba2094be257..81fd2abcd173 100644
>>> --- a/drivers/clk/meson/meson-eeclk.c
>>> +++ b/drivers/clk/meson/meson-eeclk.c
>>> @@ -61,6 +61,12 @@ int meson_eeclkc_probe(struct platform_device *pdev)
>>>  		}
>>>  	}
>>>  
>>> +	if (data->setup) {
>>> +		ret = data->setup(pdev);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>>>  					   data->hw_onecell_data);
>>>  }
>>> diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
>>> index 9ab5d6fa7ccb..7fdf424f71a6 100644
>>> --- a/drivers/clk/meson/meson-eeclk.h
>>> +++ b/drivers/clk/meson/meson-eeclk.h
>>> @@ -20,6 +20,7 @@ struct meson_eeclkc_data {
>>>  	const struct reg_sequence	*init_regs;
>>>  	unsigned int			init_count;
>>>  	struct clk_hw_onecell_data	*hw_onecell_data;
>>> +	int				(*setup)(struct platform_device *pdev);
>>>  };
>>>  
>>>  int meson_eeclkc_probe(struct platform_device *pdev);
>>> -- 
>>> 2.21.0
