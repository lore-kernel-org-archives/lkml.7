Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3E82075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l6zOdSS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCKIxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:53:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:53:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id i16so4058420wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KuK8hTEg2ZzXXFRR+sjPdWJhVvv0TG69oYXcIEBxte4=;
        b=l6zOdSS22HT9K/lTh3CYiiP6sylm2avEK48YeXxFw6G9AIHMJM7YRLqrkd8bwwyqC4
         s0PECGbpE739q78kXeEbQNz14HDGITMx8W5jrpxFxdbP96D734j6z8qS9lYXto7x3yVR
         uTrZ+aLIWeAcqFFDm3zak7HJOl7Re6ZAOSqgaYNijKVXJINNfD5wegfAuntHBR6Lvt8W
         2K1NR4LCphWp6WPc4Ur93k5pk6Dx+05785osmxY+ltEQ0YLB4kM8ZK8xdAUgcRlqR6CK
         ZnEPZffGGIr5dm05As9e5iB6asWwD3W1FOCe/5GotXyFKBbUHNyWs/SjA46AUQoBiJqk
         JE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KuK8hTEg2ZzXXFRR+sjPdWJhVvv0TG69oYXcIEBxte4=;
        b=h9KIjpoFtf4c9i9gs2ZTf07p169PIA2xi7iDGjJO9LgbHvKiNcttah+rY6yfCeLHY+
         +xW+zu1uozEahZQWv1tD5NNCeHLH8yCjDk0tYi1OPpvrF/ke1VfP+3qsH+1yRoZ8tWUg
         F20NObVWRKkwdY6p65wnwagAfZz0H4NEopM5n6ryta/iO+uSMdqqAG3PZ/CNqqnNmV/f
         I7eHHir8l2rq5ZNtlGR48OtvYIKaT/dH/JN2JA1/b/L3ZkPP9BkRH8Bq0uUuYc8Qog3T
         yhfzWIe85aDZOD/LzdJpCq3anN1SzGBUkbDktMav0bE0A+ijjxZGWJ8wEPyrPhCxG048
         TlUw==
X-Gm-Message-State: APjAAAXMREnN6WvdcFJAWl3BCb9Wh1DlmVDbdx/c9J6jhqnL0xh1XdzD
        JOeXGMFybUPtzu8J+Q6l+9EzqQ==
X-Google-Smtp-Source: APXvYqzChF6GfmfIaHYhr8zFrbajT6QSN5nQYtSPO6ZaB9bqr473mZ+tyL0ltonUcWP8GeqrVXN29A==
X-Received: by 2002:adf:f343:: with SMTP id e3mr18265295wrp.205.1552294389904;
        Mon, 11 Mar 2019 01:53:09 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i12sm402443wrs.66.2019.03.11.01.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 01:53:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling
 support
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
 <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
 <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
 <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com>
 <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com>
Date:   Mon, 11 Mar 2019 09:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 15:54, Rob Herring wrote:
> On Fri, Mar 8, 2019 at 2:05 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Rob,
>>
>> On 08/03/2019 00:13, Rob Herring wrote:
>>> On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
>>>> Scrambling when supported or mandatory.
>>>>
>>>> This patch also adds an helper to setup the control bit to support
>>>> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
>>>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
>>>>
>>>> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
>>>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
>>>> on the Rockchip 4.4 BSP kernel at [1]
>>>>
>>>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>>>>
>>>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
>>>> Cc: Huicong Xu <xhc@rock-chips.com>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>>>>  include/drm/bridge/dw_hdmi.h              |  1 +
>>>>  3 files changed, 85 insertions(+), 2 deletions(-)
>>>
>>> This commit in drm-misc-next is breaking booting on the Rock960. I
>>> have FB and fbcon enabled. The boot hangs after this message:
>>>
>>> [    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
>>> kvaddr=(____ptrval____) offset=0 size=8294400
>>
>> Could you give more details on the tree used ? did you bisect to find this commit ?
> 
> As I said above, drm-misc-next (from drm-misc tree) is the branch. I
> bisected between it and v5.0. Reverting it fixes booting.

Thanks, could you give more details on the environment ? Did you test over the latest linux-next ?

Can you share the EDID of your monitor ?

Can you check this patch :

----><----------------------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a63e5f0dae56..f33c2ac158c1 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1268,8 +1268,6 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)

        dw_hdmi_phy_power_off(hdmi);

-       dw_hdmi_set_high_tmds_clock_ratio(hdmi);
-
        /* Leave low power consumption mode by asserting SVSRET. */
        if (phy->has_svsret)
                dw_hdmi_phy_enable_svsret(hdmi, 1);


