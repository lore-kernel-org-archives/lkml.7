Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D2CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5280A2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LrddelN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfJURZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:25:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47036 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:25:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id e66so13367242qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=puh0HaQp8tS+SKvTxBh5Bw6nNU6dCLvmCvb4xlqnNkw=;
        b=LrddelN7aA9bef4/eIB+Ib6Ci1IUqxOU9X753Gd1U5va+vzUk8JQzI0fxG5e1B801k
         91Wd41Xc7Yt1vZMyYhZWQs/i7eVtQJeTFBARPSEjqNgkAS1Dxn3TmLlE709SOG9G1v/l
         FxI9bWug0rv0uOn0SxqCwTsT/2LhPq6FGQiplND+N/7PTCt+2PBO7E75TpF6eUzqOyE6
         XMCCcaqqFdXulj0r2H2Z0RCXXyQXM6gbjY3dYqx6gYXcYSc0oHHfwEzzsiTEJu2kMhSB
         +rhSRmfU24K0ggMWP2gXgyc1bcxDm/ij6t6zsg33Oc+Wh2MaDpGBJyXlSNaleNQ/1rvz
         i01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=puh0HaQp8tS+SKvTxBh5Bw6nNU6dCLvmCvb4xlqnNkw=;
        b=OJZT05ekIzG3NmdMfqEQSrCzTcF8H5VChzgStb9T6tDdafHhy/hcd73XV3sjbOb5RC
         mx7Pk94hLxJMqZyrW4b6rdLDBuv3sboLRWOOK5iRa3FBzzosdzd5KINWKDI64w283mrN
         /GebNAnIEUwUsQG2LMBY5cwf/8sDTXmAihQ51Nvw0AevVyZRkjaFiocrwWqNjWCAKQpS
         w38J523IuzM3/+wheYdw8vo+9M7hXWp077TbBx7LqW5w95oes/j9Q48GFaF+8ecZbNAG
         da8oKMOeXSg7yr+hnvZvO3ugps1H2W+2LCn2bXGNEAhFPf4gqMd9HX8NMyOs6y3c8NAa
         oZXw==
X-Gm-Message-State: APjAAAW6Dcvhrb9hMZ/c6gtdybot2VXtw/PELja5gl/TYfwBwgMeQFUQ
        0mbuwJLXcyLG1hZOa2dOQcabOA==
X-Google-Smtp-Source: APXvYqx03r3bqCwmLO6I3HtMtCjp3zyZ2iq2xyxZmQ+mEjuUyp5Pl1acd32IMkr61SARy3aJNMX6ww==
X-Received: by 2002:a37:e503:: with SMTP id e3mr10804782qkg.491.1571678712851;
        Mon, 21 Oct 2019 10:25:12 -0700 (PDT)
Received: from [10.241.90.10] ([155.52.187.14])
        by smtp.gmail.com with ESMTPSA id z70sm4453608qkb.60.2019.10.21.10.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:25:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Date:   Mon, 21 Oct 2019 13:25:11 -0400
Message-Id: <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        will@kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mm@kvack.org, mbrugger@suse.com, wahrenst@gmx.net,
        phill@raspberrypi.org, Robin Murphy <Robin.Murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
In-Reply-To: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2019, at 1:01 PM, Nicolas Saenz Julienne <nsaenzjulienne@suse.d=
e> wrote:
>=20
> Could you enable CMA debugging to see if anything interesting comes out of=
 it.

I did but nothing interesting came out. Did you use the same config I gave? A=
lso, it has those cmdline.

page_poison=3Don page_owner=3Don numa_balancing=3Denable \
systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
page_alloc.shuffle=3D1=
