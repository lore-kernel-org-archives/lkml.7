Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3256EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E24206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sDZ6WKNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDIIoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:44:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIIoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:44:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so19730516wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HM2Pcrp/PTYpJw1kiu/1UYLz8U5HkCrpn0W1FDR044U=;
        b=sDZ6WKNQ3iWBVO7Qg0zhC2aEDO7k5bJUf4Qw5bbSHMRZtL3wn6yCP5lzVTCechftWN
         5I+Ox6IfKzf4m92Lv+gX5zVloP+Qd5z30eS8IUnqI1Z3hEaBW9ueRO7EsOGw+Z4mLyVz
         SxcGDU/AY3GMWdsHW+ctl2qHXqw4VEBNmLdmWZbFqmK9A//APs5M8/qcExtK2XqTuCGz
         C/Zx1oFCAR91UfvrCgEHf3xaZYeOKWSsR89gf5UtEJ8vhD/mx27Sz81EVqD1/HK1wf0c
         xgSITbQtJpDLK68LXjnfJT8A2Dqa2JAEVyDtJwLQ3Za/47pRKkPekvbT796NpBHS+Vmv
         h8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HM2Pcrp/PTYpJw1kiu/1UYLz8U5HkCrpn0W1FDR044U=;
        b=cfYX8TcxsySnlZ+IlzBkwSyaWhIeGagMW+IXFVmgaEogFX85d7iKlu+qXT2kaMtt6H
         tZA2c33kl8POVuTtB01wfIr14mtlKYwKebDXDPZoTgN6mdhj+2ybe7xW01IC0GKrAqFi
         5d/0Th1Egy6CQyyWbgdQllJ3Ym8L7U4a66BgNe+VFOZ2w/CreRChE2w9b/Zj7XCaRVQE
         CjRZSvyhPd4NChEmtMJQNTpCzY98KXtJW47tbP35vxpTbbhSeGXfwKslTMLUO5JdyWcO
         RM05waUYfGThnrhdHXOXaEhoFV/GZFASkDk0h/PC1rXmR2cPAGRqqdNMnD5f61a4+kpb
         4/kA==
X-Gm-Message-State: APjAAAWlm+O1OLbZEb14ivMfyrpwAeBi8nX7Vvkn5JQacWohBK192233
        VP8q2Bizls5ATVll9mml6mzRlQ==
X-Google-Smtp-Source: APXvYqwXqgheZlxrHWUd/4S5AqcI7iPGv9V4Rz/MoCSy8r5nSUUKDf4gALgPcI74EQLW4t/72UFUuw==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr21764985wrr.230.1554799484462;
        Tue, 09 Apr 2019 01:44:44 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id y1sm94385738wrd.34.2019.04.09.01.44.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:44:43 -0700 (PDT)
Message-ID: <7dd2bfa45b97aedd64218f9489d1b1f3e477e134.camel@baylibre.com>
Subject: Re: [PATCH 08/11] drm/meson: Add G12A support for CVBS Encoer
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:44:42 +0200
In-Reply-To: <e5199bf4ff4a125414a8843ab4be0eb641ac5d91.camel@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
         <20190325141824.21259-9-narmstrong@baylibre.com>
         <e5199bf4ff4a125414a8843ab4be0eb641ac5d91.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 10:43 +0200, Jerome Brunet wrote:
> On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> > The Meson G12A SoCs uses the exact same CVBS encoder except a simple
> > CVBS DAC register offset and settings delta.
> > 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >   drivers/gpu/drm/meson/meson_venc.c      | 11 +++++++++--
> >   drivers/gpu/drm/meson/meson_venc_cvbs.c | 25 ++++++++++++++++++-------
> >   2 files changed, 27 insertions(+), 9 deletions(-)

... and there is a typo in the patch title. s/Encoer/Encoder

