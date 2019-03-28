Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7575EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226721855
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553810625;
	bh=vfOY0lf9ZLZ3FI/qa6DV/sFBzFDbWoJ+i4ykuOROp7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zWuhO6/WTZ5aR3AVm+l5+yiqBsmL2LmEXWwHj5LOhpjXNHtiGCxriVelk5wxcOk7y
	 KQd0zOkbU49HaRlOPE0yUCbtOgEDjkdSxOUVaip0ccuaESgLEqfRDzrFVfcJLzIpty
	 8C/Fuirur8zuzp4ub8CnirhE7GvfGvlvOHO4VE1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfC1WDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfC1WDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:03:44 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4399321855;
        Thu, 28 Mar 2019 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553810623;
        bh=vfOY0lf9ZLZ3FI/qa6DV/sFBzFDbWoJ+i4ykuOROp7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GucfSmL9lC9LnNk45dsDC68S/lwYXssr8KTnPL4dICgPSCLjheFMr1xKSu3tEcEmN
         HVBx3w4NWGdayR8IzRijdcm9ji+LjeF7q4DU4ZIfQJPtKZkbPirh5GGdiI37Bf/brZ
         T87H82SBLC43KbOAXr4UasA1me5nfS28HO4r99mM=
Received: by mail-ed1-f46.google.com with SMTP id x14so371333eds.1;
        Thu, 28 Mar 2019 15:03:43 -0700 (PDT)
X-Gm-Message-State: APjAAAV3MReZecAHOzBqI6ydmAmQ2njlwCyX17tbZ4BJdMIAeNA4Eclv
        OgMOF3x0iCh/FmHi1QaViqgx6qGEOrS6zLIuoYM=
X-Google-Smtp-Source: APXvYqx+/BmHA+NoXQM7LvHS1QrSc4jrDVRAeUxDvWkh+cpP4bpxPHOyx0VMRKloN/dyQcSbo4ZH4T9Te1ytEmuViV4=
X-Received: by 2002:a50:b65d:: with SMTP id c29mr4801969ede.184.1553810621813;
 Thu, 28 Mar 2019 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-7-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-7-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 28 Mar 2019 17:03:04 -0500
X-Gmail-Original-Message-ID: <CANk1AXQCSK-H4wTzXxbctO8-w4cpzyGSeND-hM3qHqvOaHBuKg@mail.gmail.com>
Message-ID: <CANk1AXQCSK-H4wTzXxbctO8-w4cpzyGSeND-hM3qHqvOaHBuKg@mail.gmail.com>
Subject: Re: [PATCH 06/17] fpga: dfl: pci: enable SRIOV support.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:
>
> This patch enables the standard sriov support. It allows user to
> enable SRIOV (and VFs), then user could pass through accelerators
> (VFs) into virtual machine or use VFs directly in host.
>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>
