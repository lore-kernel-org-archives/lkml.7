Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A342087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CkHHH4Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfDOWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:46:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42254 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfDOWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:46:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so9306759plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bG81ld+Ifo/Ibz8BPNzF6UdN7r62GWdQqkw2sfWxBIE=;
        b=CkHHH4NuB+CJi00KBtMI+2BVKiviKLnau6lg5Yv6TwUlwvwh6OUIKTqtu4CZlnbYkT
         OFWnzhoK0T0UqA9DmEUe6BvGdSUQEpzlg8CKY5J5BzaXnD9C+bc8JKfK0e9+F6j0AIHD
         3MGT0C9S69csNVqDT2UCs299JCg+upU3/5xV7J8TdCY+rQmenohIfsek84DdX/RBWjDM
         tb9u6YUy2Aeec1xqeHgN+cNfnnx3dkJJl1kalZTC6PEPhGbJXXYTTHOE3bnbfBDR+V2/
         w06nSLtMEbxHfoyGEv8LiMxcyevBH+GCqCaQo6geCIwFSSK54fCT0FXjGEGrxhGv3km+
         zibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bG81ld+Ifo/Ibz8BPNzF6UdN7r62GWdQqkw2sfWxBIE=;
        b=sdNrvXsIS3jarvnbq6NkwMXGZj4mhtwox3r9FjZe0iAVgyUmcb4479PXnNHb+CbC+0
         B3aTxQ7nqlSgT3ukcluz086kdYloAFUoDc3EUjRXpEYN+LasGf/9nnwkwhkXnDzcGcby
         DR4D+okBnIiJoFZPARwNLvNXTwv0N284JVVebqYAjHKUlHJgiIaRfiNqT+lyLDa1C6Pm
         MwRT45PsTrSOwhxioKLfBNlvGGYTLPEok8IWKO8XtbsH+573NBPSMMHF1Z/NGaTHTLkc
         Sj1zotq4ru30roWy8dpCVVMgP4Tvb4o7+3goCsuulD8kSUQwAekfn5Di3Ma4iiwlIEsN
         Webg==
X-Gm-Message-State: APjAAAUQyw7HBWIQrCERdZpmHg0CAYrrjh6ZtFDEB20+BgeWZisYFI53
        Rvq0IeLmDQpp1XdxkrPzeViGSA==
X-Google-Smtp-Source: APXvYqzO+U4ObfjyK28csaq2gUw4VrbmhMj98+DwzveBg/IggfpXO4gRQQCyro2DZBPX1uDGPVXhjA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr61503457pla.16.1555368391746;
        Mon, 15 Apr 2019 15:46:31 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id g64sm115360066pfg.13.2019.04.15.15.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 15:46:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: g12a: Add peripherals
In-Reply-To: <891b8b51-256f-0c31-6b16-1b70bddc73c2@baylibre.com>
References: <20190325100339.749-1-narmstrong@baylibre.com> <6b97b67a-3b00-81d5-1031-3a7c423f62ff@baylibre.com> <891b8b51-256f-0c31-6b16-1b70bddc73c2@baylibre.com>
Date:   Mon, 15 Apr 2019 15:46:29 -0700
Message-ID: <7hef62rinu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 01/04/2019 13:51, Neil Armstrong wrote:
>> On 25/03/2019 11:03, Neil Armstrong wrote:
>>> Add following peripherals :
>>> - SAR-ADC
>>> - USB
>>> - Mali GPU
>>>
>>> Dependencies :
>>> - ADC
>>>
>>> Depends on CLKID_AO_SAR_ADC_SEL, stable clk headers tags will be
>>> available after v5.1-rc4
>>>
>>> Bindings has been merged for 5.2-rc1
>>>
>>> - USB
>>>
>>> USB depends on the CLKID_PCIE_PLL, stable clk headers tags will be
>>> available after v5.1-rc4
>>>
>>> USB2 PHY depends on missing Reset bindings, have been applied to
>>> reset/fixes, waiting to be merge into master or immutable branch/tag
>>>
>>> Bindings has been Reviewed, waiting to be applied
>>>
>>> - Mali
>>>
>>> No Clk or Reset dependencies
>>>
>>> Mali GPU bindings are still in review.
>>>
>>> Changes since v2 :
>>> - dropped applied patches
>>> - collected review tags
>>>
>>> Changes since v1 :
>>> - dropped already applied "Add AO Secure node"
>>> - dropped meson-g12a-u200.dts uart_AO change
>>> - fixed includes overall to fix build for each patches
>>> - removed disabled status in dwc2 node
>>> - removed uart_ao_a_c pinctrl
>>> - fixed uart pinctrl node name
>>>
>>> Neil Armstrong (3):
>>>   arm64: dts: meson: g12a: Add SAR ADC node
>>>   arm64: dts: meson: g12a: Add G12A USB nodes
>>>   arm64: dts: meson: g12a: Add mali-g31 gpu node
>>>
>>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 117 ++++++++++++++++++++
>>>  1 file changed, 117 insertions(+)
>>>
>> 
>> Hi Kevin,
>> 
>> Clock headers bindings stable tag has been sent to the list,
>> USB PHY Bindings has been applied, USB Glue patches are
>> still pending.
>> The Mali Bifrost GPU bindings are still in review.
>> 
>> Neil
>> 
>
> The Mali bindings has been applied to drm-misc-next.
>
> The only remaining dependencies are the USB Glue & DWC2 bindings that has been
> reviewed, but not yet applied.

OK, those don't cause any build/boot time dependencies, so I'll queue up
this series for v5.2.

Thanks,

Kevin
