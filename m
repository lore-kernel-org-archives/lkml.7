Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D53206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553793231;
	bh=S+nIHJgi40PnYYaAEyihoH8X188erPbQbNZhA6so3nQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yrppduOXOde5FeQR0Kaq6Yk3z1pV7ISvs0YYUjaPODlC+5BEHfey//bvL8oQ1mOgr
	 oT4aohmOiT6t6dCetP2WaDG10mZaIO7JUzZHiKaE2TNzkIFTcmf9z6ODOnjeojrt0C
	 yLgsTmdZQIxPjGcqQODZledDPKZthPZRS+rybq0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfC1RNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfC1RNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:13:49 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3335206B6;
        Thu, 28 Mar 2019 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553793228;
        bh=S+nIHJgi40PnYYaAEyihoH8X188erPbQbNZhA6so3nQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HzokV5HOj3ynHMmPI7dJYwY3e6dOXmVB9VMQFqJ82QX85Ge6/N8PRzYJrU/rAm3cH
         06Y7iY3BGJ+um3n7SpGK1T/D6YrKyO97dAyqu1O9R6rJBDIds4Y0koUhRviWxxJiVy
         10QPEiJLwYxnOD5N7FWYMeePcbN2T/Fzh0kaIYDU=
Received: by mail-ed1-f54.google.com with SMTP id v21so17889901edq.4;
        Thu, 28 Mar 2019 10:13:48 -0700 (PDT)
X-Gm-Message-State: APjAAAW1USeeMAb6zudIqVpVZuOzKVEYKiFB1AMRrDN6GX/NdWF9Gnqb
        E3pI7/9AWXCrJiVGdCvboUIhtG4MaNKnlaT2pZQ=
X-Google-Smtp-Source: APXvYqxLQP0UfvDcU1mUDphbpeLgdLqT/s9cXWF8ZoZmVheWLV5MtGHk6UH8x90RnPtTWN2kh/h2RQoZStA9pNlpOXw=
X-Received: by 2002:a50:926e:: with SMTP id j43mr29967097eda.60.1553793227275;
 Thu, 28 Mar 2019 10:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-8-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-8-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 28 Mar 2019 12:13:10 -0500
X-Gmail-Original-Message-ID: <CANk1AXRsgZtfgtiB-JuaD+V-JH0vLNQL10EFP4uykJbZ2t5n_w@mail.gmail.com>
Message-ID: <CANk1AXRsgZtfgtiB-JuaD+V-JH0vLNQL10EFP4uykJbZ2t5n_w@mail.gmail.com>
Subject: Re: [PATCH 07/17] fpga: dfl: afu: add AFU state related sysfs interfaces
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

>
> This patch introduces more sysfs interfaces for Accelerated
> Function Unit (AFU). These interfaces allow users to read
> current AFU Power State (APx), read / clear AFU Power (APx)
> events which are sticky to identify transient APx state,
> and manage AFU's LTR (latency tolerance reporting).
>
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
